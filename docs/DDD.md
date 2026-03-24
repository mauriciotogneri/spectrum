# Documentation Driven Development (DDD)

DDD is a structured but flexible development framework where every code change begins with documentation — not code. A curated set of documents governs the full lifecycle of a change, from idea to shipped code, transforming chaotic software development into a systematic, repeatable methodology that consistently delivers results aligned with your vision.

## Problem

**Trapped knowledge.** Knowledge lives in people's heads and leaves when they do.
**Neglected documentation.** Documentation is written retrospectively (if at all), buried in a wiki nobody reads nor updates.
**Ambiguous requirements.** Requirements are interpreted differently by different developers.
**Superficial code reviews.** Reviews focus on style and patterns rather than intent and behavior.
**Silent technical debt.** Debt accumulates silently — nobody documents the trade-offs or constraints that justify it.
**Lost decisions.** Design decisions are debated in Slack threads and forgotten.
**Onboarding by archaeology.** New developers have to reverse-engineer intent from code.
**Missing validation contract.** Test cases are written after implementation, shaped by what the code does rather than what it should do — so tests pass even when behavior is wrong.

## Principles

### Foundation

**Documentation, not the code, becomes the primary artifact.** Documentation is the source that generates implementation. Code is an expression of that documentation in a particular language and framework — not the other way around. Documents are dual-audience: structured enough for machines to process, human-friendly enough for developers to actually maintain. This moves the lingua franca of development to a higher level, making the work accessible to anyone who can read the documents, not just those fluent in the codebase.

**Documents before code.** No code is written until the document set is reviewed and approved. Documents force the team to articulate what they want, why they want it, and how they will validate it — surfacing ambiguities during document review, not code review. This ensures that developers, testers, designers, and managers share the same understanding of what to build, preventing assumptions and misalignments before they reach code. Because the primary artifact is the document, not the code, migrating to a new stack means re-generating code from existing docs rather than a full rewrite.

**Single source of truth.** For any given concern, exactly one document is authoritative. No duplication, no drift between competing sources. Knowledge is externalized into documents, not trapped in individuals — a team member leaving doesn't create a knowledge vacuum, and new developers (human or AI) get up to speed by reading the document set rather than reverse-engineering code.

### Authoring

**Precise over vague.** Every requirement must be unambiguous, complete, consistent, and verifiable. The "two-developer test" is the bar: a requirement or plan step should be specific enough that two developers following it independently would produce the same result. This extends to AI agents — given the same document set, any competent agent should produce substantially similar output.

**Progressive detail.** Documents move from high-level (requirements) to low-level (implementation plans). Each layer adds precision without contradicting the layer above.

**Scope is a boundary, not a suggestion.** If it's not in the documents, it's not in scope. New ideas go through the document pipeline, not directly into code.

### Quality & Process

**Standards-enforced quality.** Document quality is checked mechanically, not left to human judgment alone. Every document type has a standards definition that specifies both common checks (shared across all documents) and file-specific checks (unique to that document type). AI-powered review skills systematically check every document and produce structured reports with numbered findings, severities, and recommendations — eliminating the "we should have caught that" problem. Because quality is enforced at the document level before code exists, the methodology helps ensure the software meets user needs and business goals, not just technical standards.

**Iterate cheaply.** The document pipeline is ordered so that the most expensive mistakes are caught at the cheapest phase. Problems caught in documents take minutes to fix; problems caught in code take hours to debug and refactor. If a design can't survive document review, it won't survive production — kill bad ideas before they become bad code. When a problem is found, the team revises the document and re-reviews — never jumping to code to "just fix it there."

**End-to-end traceability.** Every requirement traces forward to plan steps, validation scenarios, and acceptance criteria. Every implementation detail traces back to a requirement. Every decision, trade-off, and scope boundary is captured in the document trail — intent lives alongside implementation, capturing the why behind decisions, not just the what. When someone asks "why was it built this way?" months later, the answer is in the documents, not in someone's memory. Validation scenarios written upfront become a living test specification, not an afterthought.

### Collaboration

**Humans curate, collaborators execute.** Collaborators — whether AI agents or other developers — generate and review documents, but the team makes all approval decisions. Collaborators handle volume and consistency; the team handles intent and judgment. This shifts the developer's focus from writing repetitive code to understanding edge cases, defining interactions, and validating system behavior.

**Structured context produces better output.** Collaborators produce inconsistent results when given ad-hoc instructions — the same task described differently can yield fundamentally different implementations. The quality of output is directly proportional to the quality of the documents that inform it. When a collaborator receives detailed requirements, a phased implementation plan, and validation scenarios — all reviewed against project standards — it produces work that reflects the team's intent rather than its own assumptions.

## Characteristics

- Layered hierarchy
- Git-Native workflow
- Full traceability
- Technology agnostic
- No database
- No server
- No lock-in
