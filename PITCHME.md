## The Single Responsibility Principle (SRP)

---

## What is the SRP?

Every module, class, or function should have responsibility over a single part of a software system

--- 

A class should have only one reason to change

\- Robert C. Martin, Clean Code.

---

## Why is it important?

* easier to read
* easier to maintain
* fewer unintended side effects, fewer bugs
* fewer dependencies to update when code changes
* less chance of "coupling" among software components

---

## How do we know if a function is doing more than one thing?

---

```perl
$details : HashRef - Hash of function parameters
	$existing_hash: HashRef - Existing data structure that we are modifying
	[$return_array] : Bool - If truthy return array, otherwise return HashRef
	[$update_existing] : Bool - If truthy update existing values in the database
```

---

## Indicators

* accepts many arguments
* accepts a complicated data structure
* flag(s) determine how the function works
* relies on if / else logic to control the flow of operation

---

## Highly coupled code?

If in order to use module A, the developer must also be aware of the implementation of module B, then module A & B are said to be highly (or tightly) coupled

---

* not always at the module level
* may also be at the function level
* the degree of interdependence between software modules

---

## Disadvantages 

* changes in one module usually require changes in other modules
* more time & effort due to increased inter-module dependency
* harder to reuse & test because dependent modules must be included

---

## Refactoring

---?code=src/original.pm&lang=perl&color=#1E1F21&title=Original

---?code=src/refactor.pm&lang=perl&color=#1E1F21&title=Refactored

