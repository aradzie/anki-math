---
name: calibrate
description: Interactively interview the user to establish target audience level, topic scope, and mathematical rigor expectations before generating math flashcards. Invoked by generate-flashcards when a session's calibration parameters haven't been established yet; can also be run directly.
---

# Calibrate Flashcard Generation

## Purpose

Establish, with the user, the target audience level, topic scope, and rigor expectations before any flashcards are drafted. Generating cards against assumed or stale parameters wastes review time and can silently drift mathematical precision away from what the user actually wants.

The user is typically a student approaching the topic at hand without full knowledge of its landscape — they may know they want cards on, say, "eigenvalues" without knowing what surrounding subtopics, prerequisites, or natural extensions exist. Be proactive rather than passive: don't just collect a scope the student dictates unaided. Propose one.

## When to Run

Normally invoked automatically by `generate-flashcards`'s Calibration section, at the start of a flashcard-generation session or when starting a new topic whose calibration hasn't been established yet. Can also be invoked directly by the user before asking for cards.

Once established, calibration holds for the rest of the conversation — do not re-run the interview for every batch of cards on the same topic.

## Interview

Ask about the following, batched into as few turns as practical — do not interrogate the user with one question per message:

1. **Topic(s)/scope** for this session. Given the stated subject, propose a concrete breakdown: the subtopics it typically decomposes into, prerequisite concepts the student may need refreshed alongside it, and natural next/more-advanced topics that commonly follow. Present this as a suggestion for the student to confirm, trim, or extend — not as an open-ended "what topics do you want" question the student must answer unaided.
2. **Audience background/level.** Offer `generate-flashcards`'s existing default (a passionate, technically sophisticated self-learner working through calculus, linear algebra, and ODEs at the level of Apostol, Spivak, and Stewart) as a quick-confirm starting point, so the user can accept it outright rather than re-specifying from scratch.
3. **Rigor expectations** — proof-idea depth vs. full derivations, tolerance for computational drill, how formally hypotheses should be stated.
4. **Any other emphasis** — e.g. counterexample-heavy, application-focused, notation conventions to follow.

## Output

Summarize the answers as an explicit scope/rigor/audience statement in the conversation. This statement supersedes `generate-flashcards`'s defaults for the rest of the session — use it in place of the Calibration section's defaults when drafting cards. Do not write it to a file; it is conversation-scoped only.
