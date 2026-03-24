# Documentation Driven Development (DDD)

DDD is a development framework where every code change (e.g. new feature, bug fix, infrastructure task, etc) begins with a curated set of documents.

These documents include requirements, implementation plans, validation scenarios, API contracts, etc. Together they form a comprehensive paper trail that governs the full lifecycle of a change, from idea to shipped code.

## Core Thesis

AI coding agents produce inconsistent results when given ad-hoc instructions. The same prompt phrased differently can yield fundamentally different implementations. DDD solves this by replacing ad-hoc prompting with a structured document pipeline.

The core thesis is simple: **the quality of AI-generated code is directly proportional to the quality of the documents it ingests**. By investing in well-structured, reviewed, and standards-compliant documents, the team controls the output rather than hoping for good results from vague prompts.

## Motivation

- Before
  - Knowledge lived in people's heads
  - Code used to be king
  - Documentation was written after the fact, if at all
  - Documentation was something buried deep in a wiki that nobody reads nor updates
  - Documentation was often written retrospectively
  - Onboarding was expensive and slow
  - Code reviews focused more on style and patterns rather than on intent and behavior
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

## Benefits

**Structured context produces better output.** When the AI agent receives detailed requirements, a phased implementation plan, and validation scenarios — all reviewed against project standards — it generates code that reflects the team's intent rather than its own assumptions.

**Shared understanding before code.** Documents force the team to articulate what they want, why they want it, and how they will validate it — before any code is written. Ambiguities surface during document review, not during code review.

**Automated enforcement.** Standards are not enforced by convention alone. AI-powered review skills systematically check every document. The review skill produces a structured report with numbered findings, severities, and recommendations — eliminating the "we should have caught that" problem.

**Cheap iteration.** Problems caught in documents take minutes to fix. Problems caught in code take hours to debug and refactor. DDD shifts iteration to the cheapest possible phase.

**Auditability.** Every decision, requirement, trade-off, and scope boundary is captured in documents. When someone asks "why was it built this way?" months later, the answer is in the document trail, not in someone's memory.

**Living memory.** The document set for each change serves as a permanent record. When the team revisits a feature, the full reasoning — not just the code — is preserved.

## Principles

**Documents before code.** No code is written until the document set is reviewed and approved. The investment in documents pays for itself by preventing rework.

**Precise over vague.** Every requirement must be unambiguous, complete, consistent, and verifiable. The "two-developer test" is the bar: a requirement or plan step should be specific enough that two developers following it independently would produce the same result.

**AI as collaborator, human as curator.** The AI agent generates and reviews documents, but the human team makes all approval decisions. The AI handles volume and consistency; the human handles intent and judgment.

**Iterate cheaply.** The document pipeline is ordered so that the most expensive mistakes are caught at the cheapest phase. When a problem is found, the team revises the document and re-reviews — never jumping to code to "just fix it there."

**End-to-end traceability.** Every requirement traces forward to plan steps, validation scenarios, and acceptance criteria. Every implementation detail traces back to a requirement. The review system checks these traces mechanically.

**Standards-enforced quality.** Document quality is checked mechanically, not left to human judgment alone. Every document type has a standards definition that specifies both common checks (shared across all documents) and file-specific checks (unique to that document type), ensuring a consistent quality bar.

**Separation of concerns.** Rules about documents (standards) are separate from rules about the application (technical reference). The framework itself can evolve independently from the application it governs.
