# Spec Driven Development

## Motivation

* Before  
  * Code used to be the king  
  * Specs were something buried deep in a wiki that nobody reads nor updates
  * Specs were often used in retrospective  
* Now  
  * Maintaining software means evolving specifications  
  * Specs, not the code, becomes the primary artifact  
  * Specs don't serve code, code serves specifications  
  * Specs are the source that generates implementation  
  * Code becomes its expression  in a particular language and framework  
  * The lingua franca of development moves to a higher level
  * Code reviews have evolved into spec reviews
  * Developers focus less on writing repetitive code and more on understanding edge cases, defining interactions, and validating system behavior 

## Core principles

* **Executable Specifications:** Specifications must be precise, complete, and unambiguous enough to generate working systems. This eliminates the gap between intent and implementation.  
* **Continuous Refinement:** Consistency validation happens continuously, not as a one-time gate. AI analyzes specifications for ambiguity, contradictions, and gaps as an ongoing process.  
* **Research-Driven Context:** Research agents gather critical context throughout the specification process, investigating technical options, performance implications, and organizational constraints.  
* **Bidirectional Feedback:** Production reality informs specification evolution. Metrics, incidents, and operational learnings become inputs for specification refinement.  
* **Branching for Exploration:** Generate multiple implementation approaches from the same specification to explore different optimization targets: performance, maintainability, user experience, cost, etc.

## What is a spec?

A spec is a structured, behavior-oriented artifact written in natural language that expresses software functionality. Each variant of spec-driven development defines their approach to a spec's structure, level of detail, and how these artifacts are organized within a project.