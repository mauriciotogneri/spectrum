# Documentation Driven Development (DDD)

## Workflow

The DDD workflow has five phases. Each phase has clear inputs, outputs, and quality gates.

### Phase A: Specification

1. **Create requirements** — The team drafts `requirements.md` for a new change, placing it in a new subdirectory under `changes/`. An AI skill can assist with structuring the document: defining intent, scope boundaries, functional requirements, and acceptance criteria.
2. **Review requirements** — The team uses a review skill to validate the requirements against the project's technical reference. The skill produces a structured report with findings by severity (Critical, Warning, Suggestion).
3. **Refine requirements** — The team iterates on the requirements based on review findings until satisfied.

### Phase B: Planning

4. **Generate plan and scenarios** — The team instructs the AI agent to generate `plan.md` and `scenarios.md` from the approved requirements. The agent reads the requirements and technical reference to produce implementation steps and validation scenarios.
5. **Review plan and scenarios** — The team uses the review skill on the full folder to check plan completeness (every requirement has implementation steps), scenario coverage (every requirement has validation scenarios), and cross-document consistency.
6. **Refine plan and scenarios** — The team iterates until the documents are consistent and complete.

### Phase C: Implementation

7. **Implement (test-first)** — The team instructs the AI agent to implement the change. The agent reads all documents in the change folder plus the technical reference and follows a test-first cycle:
   1. **Red** — Write tests derived from the scenarios in `scenarios.md`. Run them to confirm they fail, proving the behavior is not yet implemented.
   2. **Green** — Write the minimum implementation code to make the failing tests pass.
   3. **Refactor** — Clean up the implementation while keeping all tests green.

   After implementation, the agent generates `implementation.md` documenting what was built.

8. **Code review** — The team uses a code review skill to audit the changed files against the project's technical reference.

### Phase D: Validation

9. **Validate** — The team verifies that all scenarios in `scenarios.md` are covered by passing tests. The plan's testing phase maps each test file to the scenario IDs it covers along with the test layer, ensuring every scenario has appropriate coverage across the required layers and every test traces back to the validation contract. Tests that verify implementation details (e.g., schema parsing, migration logic) are marked as such rather than linked to scenarios. Since tests were written during implementation, this phase focuses on confirming completeness — not writing new tests.

### Phase E: Completion

10. **Complete** — When satisfied, the team moves the change folder from `changes/` to `product/`, updates status metadata, updates index files, and updates any existing `product/` documents affected by the change (e.g., a bug fix that alters behavior documented in a previously shipped feature).

## Standards

DDD enforces document quality through a two-tier review system. Common checks apply to every document regardless of type, ensuring baseline quality across the entire set. File-specific checks add validation rules tailored to each document type.

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
