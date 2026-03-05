# Testing

## Core principles

* Testing shows the presence of defects, not their absence
* Testing increases confidence in the fulfillment of the requirements
* Testing early saves resources (e.g. time, money, etc)

## Software testing

It's a systematic activity performed to verify that a software meets its requirements and performs its intended functions correctly. It involves executing the software in question to identify any discrepancies between expected and actual outcomes.

### Types of testing

* **Smoke Testing:** Quick checks to see if the basic functionality works.
* **Sanity Testing:** Quick checks to verify if a small change works without breaking anything.
* **Regression Testing:** Ensures changes don't break existing functionality.
* **Ad-hoc Testing:** Unstructured testing without test cases.* **Exploratory Testing:** Unscripted testing to find unexpected issues.
* **Performance Testing:** Evaluates speed, scalability, and stability under load.
* **Security Testing:** Identifies vulnerabilities and threats. 
* **Usability Testing:** Ensures the software is user-friendly.
* **Compatibility Testing:** Verifies functionality across different environments.
* **User Acceptance Testing:** The final validation by end users before release.
* **Accessibility Testing:** Ensures the software is usable by people with disabilities.

## Functional requirements

Verifies that the software functions as expected based on requirements. These define what the software **should do** (i.e. the specific behaviors, functions, and features it must provide).

* Business Requirements* User Requirements* Regulatory & Compliance Requirements* Constraints & External Interface Requirements

## Goals

* Ensure clarity: Developers, testers, designers and managers know what to build* Reduce misunderstandings: Prevents assumptions and misalignments* Improve quality: Helps ensure the software meets user needs and business goals* Facilitate testing: Testers use requirements to verify that the system works correctly

## Characteristics

* Unambiguous: No room for interpretation* Complete: Covers all necessary details* Consistent: No contradictions with other requirements* Verifiable: Testers can confirm if it's met

## Non functional requirements

* Load* Performance* Data volume* Stress* Security* Stability* Reliability* Robustness* Compatibility* Portability* Usability* Maintainability

## Requirement-based testing

It's a software testing approach where test cases are designed based on documented requirements. The goal is to ensure that the software meets all specified requirements.

## Behavior Driven Development (BDD)

It's a software development and testing approach that focuses on defining the system's behavior in a human-readable format. It encourages collaboration between developers, testers, and business stakeholders by using natural language specifications to describe expected system behavior.

## User Stories

A short, informal description of a feature from the user's perspective. Focuses on what the user needs, not the details of how the system works. Written in a simple template:*"As a \[user\], I want \[goal\] so that \[benefit\]."*

### Example

"As a customer, I want to reset my password so that I can regain access to my account."

This describes what the user wants but doesn't explain how it works in detail. The development team will refine it with tasks (e.g., "Add a 'Forgot password' link," "Send email with reset link").

## Use cases

A structured, detailed description of an interaction between a user and the system. Describes how the system behaves when the user takes an action. Often includes actors, preconditions, main flow, and alternative flows.

### Example

* Use Case: Reset Password* Actor: Customer* Precondition: The user has an account in the system* Main Flow:  * The user clicks "Forgot Password" on the login page  * The system asks for the user's email  * The user enters their email  * The system sends a reset link to the email  * The user clicks the link and sets a new password  * The system updates the password and confirms success* Alternative Flows:  * If the email is not registered, the system shows an error message  * If the reset link expires, the user must request a new one

## Specifications

Formalize the requirements into detailed descriptions that guide development. They often include precise definitions of system behavior, data structures, algorithms, UI designs, and interaction flows. Can be high-level (system specifications) or low-level (technical specifications). Often include diagrams, flowcharts, and pseudo-code.

### Example

Instead of saying "Users must be able to reset their passwords," a specification might define the exact API endpoint, the request/response format, and security considerations.

## Requirements gathering

* Use clear and concise language* Make requirements testable* Use the **Shall** or **Must** format for mandatory requirements

## Acceptance criteria

* Focus on what needs to be done, not how it should be implemented* Ensure test cases cover positive, negative, boundary, and edge cases  * Multiple locales  * Online/offline/bad network  * Multiple user roles  * Portrait/landscape  * Light/dark mode  * Multiple screen resolutions  * Responsive behaviors  * Large datasets