# Documentation Driven Development (DDD)

DDD is a development framework where every code change (e.g. new feature, bug fix, infrastructure task) begins with a curated set of documents.
Together they form a comprehensive paper trail that governs the full lifecycle of a change, from idea to shipped code.

## Motivation

### Before

- Knowledge lived in people's heads and left when they did
- Code was king; documentation was an afterthought buried in a wiki nobody read
- Requirements were ambiguous and interpreted differently by different developers
- Code reviews focused on style and patterns rather than intent and behavior
- Technical debt accumulated silently — nobody documented the trade-offs that created it
- Design decisions were debated in Slack threads and lost forever

### Now

- Documentation, not the code, becomes the primary artifact
- The lingua franca of development moves to a higher level
- Developers focus less on writing repetitive code and more on understanding edge cases, defining interactions, and validating system behavior
- Documentation becomes versionable and diffable

## Principles

**Documentation is the primary artifact.** Documentation is the source that generates implementation. Code is an expression of that documentation in a particular language and framework — not the other way around. This moves the shared language of development to a higher level, making the work accessible to anyone who can read the documents, not just those fluent in the codebase.

**Structured context produces better output.** AI coding agents produce inconsistent results when given ad-hoc instructions — the same prompt phrased differently can yield fundamentally different implementations. The quality of AI-generated code is directly proportional to the quality of the documents it ingests. When the AI agent receives detailed requirements, a phased implementation plan, and validation scenarios — all reviewed against project standards — it generates code that reflects the team's intent rather than its own assumptions.

**Documents before code.** No code is written until the document set is reviewed and approved. Documents force the team to articulate what they want, why they want it, and how they will validate it — surfacing ambiguities during document review, not code review. Because the primary artifact is the document, not the code, migrating to a new stack means re-generating code from existing docs rather than a full rewrite.

**Precise over vague.** Every requirement must be unambiguous, complete, consistent, and verifiable. The "two-developer test" is the bar: a requirement or plan step should be specific enough that two developers following it independently would produce the same result. This extends to AI agents — given the same document set, any competent agent should produce substantially similar output.

**AI as collaborator, human as curator.** The AI agent generates and reviews documents, but the human team makes all approval decisions. The AI handles volume and consistency; the human handles intent and judgment. This shifts the developer's focus from writing repetitive code to understanding edge cases, defining interactions, and validating system behavior.

**Iterate cheaply.** The document pipeline is ordered so that the most expensive mistakes are caught at the cheapest phase. Problems caught in documents take minutes to fix; problems caught in code take hours to debug and refactor. If a design can't survive document review, it won't survive production — kill bad ideas before they become bad code. When a problem is found, the team revises the document and re-reviews — never jumping to code to "just fix it there."

**Standards-enforced quality.** Document quality is checked mechanically, not left to human judgment alone. Every document type has a standards definition that specifies both common checks (shared across all documents) and file-specific checks (unique to that document type). AI-powered review skills systematically check every document and produce structured reports with numbered findings, severities, and recommendations — eliminating the "we should have caught that" problem.

**End-to-end traceability.** Every requirement traces forward to plan steps, validation scenarios, and acceptance criteria. Every implementation detail traces back to a requirement. Every decision, trade-off, and scope boundary is captured in the document trail — when someone asks "why was it built this way?" months later, the answer is in the documents, not in someone's memory. Validation scenarios written upfront become a living test specification, not an afterthought.

**Single source of truth.** For any given concern, exactly one document is authoritative. No duplication, no drift between competing sources. Knowledge is externalized into documents, not trapped in individuals — a team member leaving doesn't create a knowledge vacuum, and new developers (human or AI) get up to speed by reading the document set rather than reverse-engineering code.

**Separation of concerns.** Rules about documents (standards) are separate from rules about the application (technical reference). The framework itself can evolve independently from the application it governs.

**Progressive detail.** Documents move from high-level (requirements) to low-level (implementation plans). Each layer adds precision without contradicting the layer above.

**Scope is a boundary, not a suggestion.** If it's not in the documents, it's not in scope. New ideas go through the document pipeline, not directly into code.
