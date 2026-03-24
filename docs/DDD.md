# Documentation Driven Development (DDD)

It's a development framework where every code change (e.g. new feature, bug fix, infrastructure task, etc) begins with a curated set of documents.

These documents include requirements, implementation plans, validation scenarios, API contracts, etc. Together they form a comprehensive paper trail that governs the full lifecycle of a change, from idea to shipped code.

## Core Thesis

AI coding agents produce inconsistent results when given ad-hoc instructions. The same prompt phrased differently can yield fundamentally different implementations. DDD solves this by replacing ad-hoc prompting with a structured document pipeline.

The core thesis is simple: **the quality of AI-generated code is directly proportional to the quality of the documents it ingests**. By investing in well-structured, reviewed, and standards-compliant documents, the team controls the output rather than hoping for good results from vague prompts.

## Motivation

- Before
  - Knowledge lived in people's heads
  - Code used to be the king
  - Documentation was written after the fact, if at all
  - Documentation was something buried deep in a wiki that nobody reads nor updates
  - Documentation was often used in retrospective
  - Onboarding was expensive and slow
  - Code reviews focused more on style and patterns, not on intent and behavior
- Now
  - Maintaining software means evolving documentation
  - Documentation, not the code, becomes the primary artifact
  - Documentation is the source that generates implementation
  - Code becomes its expression in a particular language and framework
  - The lingua franca of development moves to a higher level
  - Code reviews have evolved into documentation reviews
  - Developers focus less on writing repetitive code and more on understanding edge cases, defining interactions, and validating system behavior
  - Intent is preserved alongside implementation
  - Documentation becomes versionable and diffable
  - Cross-team alignment happens through shared documents, not meetings
