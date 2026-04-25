---
marp: true
theme: uncover
class: invert
paginate: true
---

# DDD

### Documentation Driven Development

---

# What is DDD?

---

* `Structured` but `flexible` development framework

* Every code change begins with `documentation`, not code

* A curated set of `documents` governs the full lifecycle

* Transforms chaotic software development into a `systematic`, `repeatable` methodology

* Consistently delivers results aligned with your `vision`

---

# Motivation

---

### The knowledge problem

* Knowledge `lives` in people's heads and `leaves` when they do

* Documentation is written `after` the fact

* Often buried where nobody reads nor updates it, or scattered across wikis, issue trackers, and chat messages

* Requirements are interpreted `differently` by different developers

---

### The consequences

* New developers have to `reverse-engineer` intent from code <!-- onboarding by archeology -->

* Debt accumulates `silently` and nobody documents the trade-offs or constraints that justify it

* Test cases are written `after` implementation, shaped by what the code does rather than what it should do

---

# Principles

### Foundation

---

### Documentation, not the code, becomes the primary artifact

* Documentation is the source that generates implementation

* Code is an expression of that documentation in a particular language and framework <!-- not the other way around -->

* This moves the lingua franca of development to a higher level <!-- making the work accessible to anyone, not just those fluent in the codebase -->

---

### Documents before code

* No code is written until the document set is reviewed and approved

* Documents force the team to articulate what they want, why they want it, and how they will validate it <!-- surfacing ambiguities during document review, not code review -->

* This ensures that the team <!-- developers, testers, designers, and managers--> shares the same understanding of what to build <!--preventing assumptions and misalignments before they reach code.-->

---

### Single source of truth

For any given concern, exactly one document is authoritative. Knowledge is externalized into documents, not trapped in individuals — a team member leaving doesn't create a knowledge vacuum, and new developers get up to speed by reading the document set rather than reverse-engineering code.

---

# Principles

### Quality & Process

---

### Precise over vague

Every requirement must be unambiguous, complete, consistent, and verifiable. The "two-developer test" is the bar: a requirement or plan step should be specific enough that two developers working independently would each agree the other's implementation is correct. The goal isn't identical code — it's that the specification constrains the solution space so any valid implementation satisfies the requirements. This extends to AI agents — given the same document set, any competent agent should produce a valid implementation that satisfies all requirements.

---

### Standards-enforced quality

Document quality is checked mechanically, not left to human judgment alone. AI systematically checks every document — eliminating the "we should have caught that" problem. Because quality is enforced at the document level before code exists, the methodology helps ensure the software meets user needs and business goals, not just technical standards.

### Iterate cheaply

The document pipeline is ordered so that the most expensive mistakes are caught at the cheapest phase. Problems caught in documents take minutes to fix; problems caught in code take hours to debug and refactor. If a design can't survive document review, it won't survive production — kill bad ideas before they become bad code.

---

# Principles

### Collaboration

---

### Humans curate, AI execute

AI generates and reviews documents, but the team makes all approval decisions. AI handles volume and consistency; the team handles intent and judgment. This shifts the developer's focus from writing repetitive code to understanding edge cases, defining interactions, and validating system behavior.

---

### Structured context produces better output

AI produces inconsistent results when given ad-hoc instructions — the same task described differently can yield fundamentally different implementations. The quality of output is directly proportional to the quality of the documents that inform it. When an AI receives detailed requirements, a phased implementation plan, and validation scenarios — all reviewed against project standards — it produces work that reflects the team's intent rather than its own assumptions.

---

### Characteristics

* Layered hierarchy
* Git-Native workflow
* Full traceability
* Technology agnostic
* No database
* No server
* No lock-in

---

# Drawbacks

---

Works well for mid-large features but the process doesn’t justify small fixes (one line bug, quick UI tweak, etc). A one-line bug fix gets the same ceremony as a new feature. This will slow teams down and incentivize workarounds (batching unrelated changes, skipping the process for "quick fixes," etc.). Solution: small changes could get a fast track or a lightweight process.

---

No prototyping mechanism. The framework has no place for exploratory work. The framework assumes you already understand the problem well enough to specify it, which is often the hard part. Solution: Allow for spikes, which are a time-boxed investigation where the deliverable is knowledge, not code. The idea: you drive a narrow "spike" through the full stack or problem space, just enough to answer a specific question, not enough to build a feature. It prevents a common failure mode: teams spending days writing detailed requirements and plans for an approach that a 4-hour prototype would have revealed as unworkable. When to spike: If the team can't agree on the approach. When to specify: If the team knows what to build and is debating how to structure it.

---

Plan determinism doesn't survive contact with reality. Sometimes you realize about a missing thing or a bug after the implementation was done (and you are testing it manually). Solution: Allow for small adhoc prompting to update the code, but always remembering to keep the documentation in sync

---

As the project grows, the document set will grow with it. Navigation and cross-referencing become harder. Searching for "Where did we decide X?" across dozens of feature folders is cumbersome. The AI agent's ability to ingest all documents will diminish as the project’s documentation grows. A search-friendly format or cross-referencing tool would help.

---

AI dependency is a single point of fragility. The framework leans heavily on AI for generation, review, and implementation. If AI is unavailable, a developer can read the requirements and plan and implement manually — that's the whole point of making documents precise enough for the two-developer test. The framework's value is in the documents, not in the AI that generates them. Solution: use different models to counter for their availability and biases.

---

### Other frameworks

* OpenSpec
* Kiro
* Spec Ki
