#########################
# Refactored subroutines
#########################

sub apply_company_billing_affiliations
{
	my ($context, $company_hash) = @_;

	my $company_ids = [ keys %$company_hash ];

	return $company_hash unless scalar @$company_ids;

	my $billing_affiliations_map = _get_mapped_company_billing_affiliations(
		$context,
		{
			company_ids => $company_ids
		}
	);

	my $affiliation_company_hash = _build_affiliation_company_hash(
		$context,
		{
			existing_company_hash    => $company_hash,
			billing_affiliations_map => $billing_affiliations_map,
		},
	);

	return $affiliation_company_hash;
}

sub _get_mapped_company_billing_affiliations
{
	my ($context, $details) = @_;

	my $company_ids = $details->{company_ids};

	my $billing_affiliations = _get_company_billing_affiliations(
		$context,
		{
			company_ids => $company_ids
		}
	);

	my $mapped_affiliations = { map { $_->{company_id} => $_ } @$billing_affiliations };

	return $mapped_affiliations;
}

sub _get_company_billing_affiliations
{
	my ($context, $details) = @_;

	my $db          = $context->{db};
	my $company_ids = $details->{company_ids};

	require IRX::Utilities;
	my $placeholders = IRX::Utilities::make_placeholder($company_ids);

	my $query = qq{
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
	};

	my $billing_affiliations = $db->get_all_rows($query, @$company_ids);

	return $billing_affiliations;
}

sub _build_affiliation_company_hash
{
	my ($details) = @_;

	my $company_hash    = $details->{existing_company_hash};
	my $affiliation_map = $details->{billing_affiliations_map};

	foreach my $company_id (keys %$company_hash) {

		next unless $affiliation_map->{$company_id};

		my $default_recipients  = $affiliation_map->{$company_id};
		my $existing_recipients = $company_hash->{$company_id}->{recipients};

		foreach my $recipient_id (keys %$existing_recipients) {
			my @object_keys = grep { $_ !~ /^(affiliation_id|contact_email|contact_name)$/ } keys %{ $existing_recipients->{$recipient_id} };
			push @{ $default_recipients->{$_} }, @{ $existing_recipients->{$recipient_id}->{$_} } foreach @object_keys;
		}

		delete $company_hash->{$company_id}->{recipients};
		$company_hash->{$company_id}->{recipients}->{ $default_recipients->{contact_id} } = $default_recipients;
	}

	return $company_hash;
}

