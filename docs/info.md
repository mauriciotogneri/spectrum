# Documentation Driven Development (DDD)

### Mechanical Enforcement

Standards are not enforced by convention alone. AI-powered review skills read the standards and systematically check every document against them. The review skill produces a structured report with numbered findings, severities, and recommendations — eliminating the "we should have caught that" problem.

## Principles

Seven principles guide the framework:

1. **Documents before code.** No code is written until the document set is reviewed and approved. The investment in documents pays for itself by preventing rework.

2. **Precise over vague.** Every requirement must be unambiguous, complete, consistent, and verifiable. The "two-developer test" is the bar: a requirement or plan step should be specific enough that two developers following it independently would produce the same result.

3. **AI as collaborator, human as curator.** The AI agent generates and reviews documents, but the human team makes all approval decisions. The AI handles volume and consistency; the human handles intent and judgment.

4. **Iterate cheaply.** Catch problems in documents (minutes to revise) rather than in code (hours to refactor). The document pipeline is designed so that the most expensive mistakes are caught at the cheapest phase.

5. **End-to-end traceability.** Every requirement traces forward to plan steps, validation scenarios, and acceptance criteria. Every implementation detail traces back to a requirement. The review system checks these traces mechanically.

6. **Standards-enforced quality.** Document quality is checked mechanically, not left to human judgment alone. Common checks plus file-specific checks ensure that every document meets a consistent quality bar.

7. **Separation of concerns.** Rules about documents (standards) are separate from rules about the application (technical reference). The framework itself can evolve independently from the application it governs.

## Tooling

DDD is tool-agnostic in principle but benefits greatly from AI-powered automation. The current implementation uses skills to automate the tedious parts of the process across four key functions:

- **Document creation** — An AI skill acts as a technical writer, helping the team draft and structure documents according to standards.
- **Document review** — A review skill spawns parallel sub-agents to check each document against common and file-specific standards, then performs cross-cutting checks for multi-document consistency.
- **Code review** — After implementation, a code review skill audits changed files against the project's technical reference across multiple specialized areas.
- **Index formatting** — An index formatting skill ensures that index files follow a consistent structure, staying in sync with the filesystem.

These skills can be implemented with any AI coding agent that supports custom commands or extensions. The key requirement is that the skills have access to both the document standards and the project's technical reference so they can perform mechanical enforcement.
