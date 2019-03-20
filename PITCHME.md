# The single responsibility principle

---

## What is the single responsibility principle

The concept that every module, class, or function should have responsibility over a single part of a given software system

--- 

> A class should have only one reason to change
> Robert C. Martin - Clean Code

---

## Why follow the single responsibility principle

* code is easier to read
* code is easier to maintain
* there are fewer unintended side effects & hopefully fewer bugs
* there will be fewer dependencies which need to be updated when code changes
* there is less chance of "coupling" among software components

---

How do we know if a function is doing more than one thing?

---

```perl
=head3 PARAMETERS
	$details : HashRef - Hash of function parameters
		$existing_hash: HashRef - Existing data structure that we are modifying
		[$should_return_as_array] : Bool - If truthy return an array, otherwise return HashRef
		[$should_update_existing] : Bool - If truthy update existing values in the database
=cut
```

---

* the function accepts many arguments
* the function accepts a complicated data structure that is not relevant elsewhere
* function accepts flag(s) which determine how it works
* the function contains a lot of if / else logic to control the flow of operation

---

## What does it mean when code is "highly coupled"?

* coupling is the degree of interdependence between software modules
* if in order to use module A a developer must also be aware of the implementation of module B then module A & B are said to be tightly coupled
* coupling does not always have to be at the module level but could also be at the function level
* example - company billing affiliations

---

## What are the disadvantages of highly coupled code 

* changes in one module usually require changes in other modules
* assembly of modules might require more effort and time due to the increased inter-module dependency
* a module might be harder to reuse or test because dependent modules must be included

---

## Refactoring a subroutine into it's component parts

---?code=src/original.pm&lang=perl

---?code=src/refactor.pm&lang=perl

