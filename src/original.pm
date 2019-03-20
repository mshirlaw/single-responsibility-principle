##########################
# The original subroutine
##########################

sub apply_company_billing_affiliations
{
	my ($context, $company_hash) = @_;
	my $db = $context->{db};

	my @company_ids = keys %$company_hash;

	return $company_hash unless scalar @company_ids;
	my $placeholders = join ',', map { '?' } @company_ids;
	my $companies_billing_affiliations = $db->get_all_rows(
		qq{
		SELECT
		  company.id AS company_id,
		  contact.id AS contact_id,
		  affiliation.email AS contact_email,
		  affiliation.id AS affiliation_id,
		  CONCAT(contact.firstname,' ',contact.surname) AS contact_name
		FROM account_preference 
		JOIN company 
			ON account_preference.object_table = 'company' AND company.id = account_preference.object_id 
		JOIN affiliation 
			ON account_preference.default_billing_affiliation_id = affiliation.id 
		JOIN contact 
			ON affiliation.contact_id = contact.id
		WHERE company.id IN ($placeholders)
	}, @company_ids
	);

	my $company_billing_affiliations_mapping = { map { $_->{company_id} => $_ } @$companies_billing_affiliations };
	foreach my $company_id (keys %$company_hash) {
		next unless $company_billing_affiliations_mapping->{$company_id};
		my $default_recipients = $company_billing_affiliations_mapping->{$company_id};
		my $old_receipients    = $company_hash->{$company_id}->{recipients};
		foreach my $old_recipient_id (keys %$old_receipients) {
			my @object_keys = grep { $_ !~ /^(affiliation_id|contact_email|contact_name)$/ } keys %{ $old_receipients->{$old_recipient_id} };

			push @{ $default_recipients->{$_} }, @{ $old_receipients->{$old_recipient_id}->{$_} } foreach @object_keys;

		}
		delete $company_hash->{$company_id}->{recipients};
		$company_hash->{$company_id}->{recipients}->{ $default_recipients->{contact_id} } = $default_recipients;
	}

	return $company_hash;
}
