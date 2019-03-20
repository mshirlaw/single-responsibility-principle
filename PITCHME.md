# Single Responsibility Principle (SRP)

---

## What is the SRP?

Every module, class, or function should have responsibility over a single part of a software system

--- 

> A class should have only one reason to change

---

## Why is it important?

* easier to read
* easier to maintain
* fewer unintended side effects & hopefully fewer bugs
* fewer dependencies which need to be updated when code changes
* less chance of "coupling" among software components

---

# How do we know if a function is doing more than one thing?

---?color=#1E1F21&title=Parameters As Clues

```perl
=head3 PARAMETERS
	$details : HashRef - Hash of function parameters
		$existing_hash: HashRef - Existing data structure that we are modifying
		[$should_return_as_array] : Bool - If truthy return an array, otherwise return HashRef
		[$should_update_existing] : Bool - If truthy update existing values in the database
=cut
```

---

* function accepts many arguments
* function accepts complicated data structure (specific to use case)
* flag(s) which determine how the function works
* function relies on if / else logic to control the flow of operation

---

## What is "highly coupled" code?

* the degree of interdependence between software modules
* not always at the module level but could also be at the function level

> if in order to use module A a developer must also be aware of the implementation of module B then module A & B are said to be highly (or tightly) coupled

---

## Disadvantages of highly coupled code 

* changes in one module usually require changes in other modules
* more effort and time due to the increased inter-module dependency
* harder to reuse & test because dependent modules must be included

---

## Refactoring

---?code=src/original.pm&lang=perl&color=#1E1F21&title=Original

---?code=src/refactor.pm&lang=perl&color=#1E1F21&title=Refactored

