# Behavior Driven Development (BDD)

It's a software development and testing approach that focuses on defining the system's behavior in a human-readable format. It encourages collaboration between developers, testers, and business stakeholders by using natural language specifications to describe expected system behavior.

## User Stories

A short, informal description of a feature from the user's perspective. Focuses on what the user needs, not the details of how the system works. Written in a simple template: *"As a \[user\], I want \[goal\] so that \[benefit\]."*

### Example

"As a customer, I want to reset my password so that I can regain access to my account."

This describes what the user wants but doesn't explain how it works in detail. The development team will refine it with tasks (e.g., "Add a 'Forgot password' link," "Send email with reset link").

## Use cases

A structured, detailed description of an interaction between a user and the system. Describes how the system behaves when the user takes an action. Often includes actors, preconditions, main flow, and alternative flows.

### Example

* Use Case: Reset Password
* Actor: Customer
* Precondition: The user has an account in the system
* Main Flow:
  * The user clicks "Forgot Password" on the login page
  * The system asks for the user's email
  * The user enters their email
  * The system sends a reset link to the email
  * The user clicks the link and sets a new password
  * The system updates the password and confirms success
* Alternative Flows:
  * If the email is not registered, the system shows an error message
  * If the reset link expires, the user must request a new one