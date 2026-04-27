---
marp: true
theme: uncover
class: invert
---

### Before we start

* Thanks for coming

* I don't want to sell this to anyone

* The goal is to get your thoughts and have a discussion around it

---

# DDD

---

# DDD

### Documentation Driven Development

---

# What is DDD?

---

* `Structured` but `flexible` development framework

* Every code change begins with `documentation`, not code

* Based on a curated set of `documents` that governs the full lifecycle

* Transforms chaotic software development into a `systematic`, `repeatable` methodology

* Consistently delivers results aligned with your `vision`

---

# Motivation

---

### The knowledge problem

* Knowledge `lives` in people's heads and `leaves` when they do

* Documentation is written `after` the fact
<!-- 2) If at all, and often buried where nobody reads nor updates it, or scattered across wikis, issue trackers, and chat messages
-->

* Requirements are interpreted `differently` by different developers

---

### The consequences

* New developers have to `reverse-engineer` intent from code
<!-- 1) Onboarding by archeology -->

* Debt accumulates `silently` and nobody documents the trade-offs or constraints that justify it

* Test cases are written `after` implementation, shaped by what the code does rather than what it should do
<!-- 3) Tests pass even when behavior is wrong -->

---

# Practical example

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

# Principles

### 1. Foundation

---

### Documentation, not the code, becomes the primary artifact

* Documentation is the `source` that generates implementation

* Code is an `expression` of that documentation in a particular language and framework
<!-- 2) Not the other way around -->

* This moves the lingua franca of development to a `higher` level
<!-- 3)
* Making the work accessible to anyone, not just those fluent in the codebase
* Document creation and review skills becomes a core competency
* It's like performing a code review before the code is written
-->

---

### Documents before code

* No code is written until the document set is `reviewed` and `approved`

* Documents force the team to articulate `what` they want, `why` they want it, and `how` they will validate it
<!-- 2) Surfacing ambiguities during document review, not code review -->

* This ensures that the team `shares` the same understanding of what to build
<!-- 3)
* Team: developers, testers, designers, managers, etc
* This prevents assumptions and misalignments before they reach code
* A perfect implementation of the wrong specification is worthless -->

---

### Single source of truth

* For any given concern, exactly one document is `authoritative`

* Knowledge is externalized into `documents`, not trapped in individuals
<!-- 2)
* A team member leaving doesn't create a knowledge vacuum
* The documentation has a compound effect that lasts over the lifetime of the project
-->

---

# Principles

### 2. Quality & Process

---

### Precise over vague

* Every requirement must be `unambiguous`, `complete`, `consistent`, and `verifiable`

* The "two-developer test" is the bar
<!-- 2)
* A requirement should be specific enough so that two developers working independently would each agree the other's implementation is correct
* The goal isn't identical code — it's that the specification constrains the solution space so any valid implementation satisfies the requirements
* This extends to AI agents — given the same document set, any competent agent should produce a valid implementation that satisfies all requirements
* LLMs are machines that satisfy constraints/conditions, so the more you provide, the more you narrow and restrain the space of what the LLM can generate, bringing it closer to what you actually want
--> 

---

### No prompt

![](img/chart1.png)

---

### Make me an app

![](img/chart2.png)

---

### Make me a finance app

![](img/chart3.png)

---

### More elaborate prompt

![](img/chart4.png)

---

### Using DDD

![](img/chart5.png)

---

### Standards-enforced quality

* Document `quality` is checked mechanically
<!-- 1)
* AI systematically checks every document
* Because quality is enforced at the document level before code exists, the methodology helps ensure the software meets user needs and business goals, not just technical standards
-->

---

### Iterate cheaply

* The document pipeline is ordered so that the most `expensive` mistakes are caught at the `cheapest` phase

* Problems caught in documents take `minutes` to fix; problems caught in code take `hours` to debug and refactor

* If a design can't survive document `review`, it won't survive `production`
<!-- 3) Kill bad ideas before they become bad code -->

---

# Principles

### 3. Collaboration

---

### Humans curate, AI executes

* AI `generates` and `reviews` documents, but the team makes all `approval` decisions

* AI handles `volume` and `consistency`; the team handles `intent` and `judgment`

* This shifts the developer's focus from `writing` repetitive code to `understanding` edge cases, `defining` interactions, and `validating` system behavior

---

### Structured context produces better output

* AI produces `inconsistent` results when given ad-hoc instructions <!-- 1) The same task described differently can yield fundamentally different implementations -->

* The quality of `output` is directly proportional to the quality of the documents that inform it
<!-- 2) When an AI receives detailed requirements, a phased implementation plan, and validation scenarios it produces work that reflects the team's intent rather than its own assumptions -->

---

# Drawbacks

---

### Process Overhead

* Works well for `mid-large` features but the process doesn't justify `small` fixes
<!-- 1) One line bug, quick UI tweak, etc, gets the same ceremony as a new feature -->

* This will `slow` teams down and incentivize workarounds
<!-- 2) Batching unrelated changes, skipping the process for quick fixes, etc -->

* `Solution`: small changes could get a fast track or a lightweight process

---

### No Room for Exploration

* The framework has no place for `exploratory` work or `prototyping`

* The framework `assumes` you already understand the problem well enough to specify it

* `Solution`: Allow for spikes, which are a time-boxed investigation where the deliverable is knowledge, not code
<!-- 3)
* The idea: you drive a narrow "spike" through the full stack or problem space, just enough to answer a specific question, not enough to build a feature
* It prevents a common failure mode: teams spending days writing detailed requirements and plans for an approach that a 4-hour prototype would have revealed as unworkable
* When to spike: If the team can't agree on the approach
* When to specify: If the team knows what to build and is debating how to structure it
-->

---

### Plans Meet Reality

* Plan determinism doesn't survive contact with `reality`
<!-- 1) Sometimes you discover something is missing or a bug after the implementation is done -->

* `Solution`: Allow for small adhoc prompting to update the code and the corresponding documentation

---

### Documentation Bloat

* As the project `grows`, the document set will grow with it

* Navigation and `cross-referencing` become harder
<!-- 2) Searching for "Where did we decide X?" across dozens of feature folders is cumbersome -->

* The agent's ability to ingest all documents will diminish as the project's documentation `grows`

* `Solution`: Add a search-friendly format or cross-referencing tool

---

### AI Dependency

* The framework leans heavily on AI for `generation`, `review`, and `implementation`

* If AI is unavailable, a developer can read the requirements and plan and implement `manually`
<!-- 2)
* That's the whole point of making documents precise enough for the two-developer test
* The framework's value is in the documents, not in the AI that generates them
-->

* `Solution`: Use different agents to counter for their availability and biases

---

### Other frameworks

* OpenSpec
* Kiro
* Spec Kit

---

# Thanks