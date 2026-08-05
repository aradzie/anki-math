---
name: generate-flashcards
description: Create, edit, or review Anki math flashcards in this repository's custom `.note` source format, including precise note syntax, metadata handling, LaTeX math, active-recall prompt design, and mathematical correctness checks.
---

# Generate Math Flashcards

## Purpose

Create math flashcards in this repository's custom `.note` format. Notes should be short enough that the learner can usually answer in a few sentences while still testing explanation, derivation, comparison, interpretation, assumptions, or failure cases.

## Calibration

Before drafting notes, confirm that scope, audience level, and rigor expectations are established for this session or topic. If they have not already been established earlier in the conversation, invoke the `calibrate` skill via the Skill tool first, and use its answers in place of the defaults below for the rest of the session.

Default target audience, offered by `calibrate` as a starting point: a passionate, technically sophisticated self-learner — e.g. an experienced software engineer — working independently through single- and multi-variable calculus, linear algebra, and differential equations at the level of Apostol, Spivak, and Stewart. They are comfortable with formal notation, proofs, and abstraction, want depth well beyond mechanical computation, and do not need simplification unless a concept is genuinely subtle — but they are not taking a dedicated real analysis, topology, or measure theory course.

### Level of Rigor

- Use precise mathematical language and standard terminology consistently.
- State hypotheses explicitly; never omit an assumption required for a theorem or definition.
- Distinguish sufficient conditions, necessary conditions, and equivalent conditions.
- Prefer exact statements over intuitive approximations. Anything "rough" or "roughly speaking" must be labeled as intuition, not blended into the precise statement.
- Elementary real analysis is expected background and fair game (see scope below); treat it with the same precision as everything else, not softened.

### Scope

In scope:

- Rigorous calculus foundations: \( \varepsilon\text{-}\delta \) limits and continuity, differentiability, the Mean Value Theorem and its consequences, Taylor's theorem with remainder, the Riemann integral (definition, basic properties, FTC), sequences and series convergence (including standard tests), power series and radius of convergence, uniform vs. pointwise convergence at an introductory level.
- Multivariable calculus: partial derivatives, gradient/directional derivatives, chain rule, Jacobians, the implicit and inverse function theorems (statement and geometric intuition, not the analytic proof machinery), multiple integrals, change of variables, line and surface integrals, Green's/Stokes'/divergence theorems.
- Linear algebra as used alongside multivariable calculus and ODEs: matrices, eigenvalues/eigenvectors, diagonalization, linear independence, and their role in solving linear systems of ODEs.
- Ordinary differential equations: standard solution methods, qualitative and stability analysis, existence/uniqueness (e.g. Picard–Lindelöf) at the level of statement and intuition rather than full contraction-mapping proof detail.
- Proof habits used throughout Apostol/Spivak: working rigorously from definitions, direct proofs of calculus theorems, constructing counterexamples.

Out of scope — do not write notes on:

- General topology.
- Measure theory and Lebesgue integration.
- Functional analysis.
- Metric space theory beyond what is needed to state basic real-analysis facts on \( \mathbb{R}^n \).
- Graduate-level real analysis.

When a topic is ambiguous, use this test: would it appear in a calculus or introductory-analysis text at the Apostol/Spivak/Stewart level, or does it require a dedicated analysis/topology/measure-theory course to state properly? If the latter, exclude it.

### Proof Awareness

The audience wants to be able to reconstruct proofs, not memorize them verbatim. Where useful, favor notes about the key idea behind a proof, the critical lemma, why a proof technique works, where a hypothesis is used, and counterexamples when a hypothesis is dropped — a natural extension of the "construct a counterexample" and "what breaks if" prompt patterns in Note-Writing Standards below.

## Repository Context

- This is one of three artifact types in this repository (flashcards, self-check questions, essays); see `AGENTS.md` for the repository-wide overview and the other two.
- Source files are `.note` files organized by topic directories.
- Import is handled by an Anki addon. Do not invent new syntax, build steps, generated artifacts.
- Follow nearby `.note` files for deck names, tags, notation, and topic granularity.

## `.note` Format

A `.note` file is plain text containing metadata directives and note records.

Metadata directives set defaults for subsequent note records. Note records contain field directives whose values become Anki model fields.

### Notes vs. Cards

This document distinguishes two things that are easy to conflate:

- A **note** is one record in a `.note` file — a `!front:`/`!back:` group (with optional `!related:`/`!extra:`), terminated by `~~~`. It is the unit of authoring: all guidance in this document about drafting, granularity, and splitting content operates on notes.
- A **card** is a single study item Anki actually shows during review, generated _from_ a note by its note type. A note is the source; a card is the rendered output — a note can produce more than one card:
  - `Basic Math` generates one card per note (front → back).
  - `Basic Math (and reversed card)` generates two cards per note (front → back, and back → front) from the same fields.

"Flashcard" is used informally elsewhere in this repository (including this skill's own name and title) as the umbrella term for the artifact type as a whole — not as a synonym for either term above.

### Directives

Every directive has this shape:

```text
!name: value
```

Rules:

- The directive name starts immediately after `!` and ends at the first `:`.
- The field value begins after the `:`. Space after `:` is conventional but not required.
- A multi-line value continues until the next directive line or the note terminator line `~~~`.
- Use the exact lowercase directive names already used in this repository: `!type:`, `!deck:`, `!tags:`, `!id:`, `!front:`, `!back:`, `!related:`, and `!extra:`.

### Note Metadata

Use these metadata directives outside note records:

```text
!type: Basic Math
!deck: Math
!tags: Math Calculus Limit
```

Metadata scope:

- `!type:`, `!deck:`, and `!tags:` apply to all following notes until the same metadata directive appears again.
- Metadata may appear at the top of a file and between note records.
- Do not place file metadata inside an unfinished note record.
- Blank lines between metadata and records are allowed and used for readability.

Available note types:

- `Basic Math`: creates one front-to-back card.
- `Basic Math (and reversed card)`: creates one front-to-back card and one back-to-front card from the same note.

Use `Basic Math (and reversed card)` only when both directions are unambiguous and pedagogically useful, such as formulas, identities, named equivalences, and notation conversions. Avoid it for conceptual explanations, theorem hypotheses, one-way implications, or prompts whose reverse side would be vague.

### Note Records

A note record is a sequence of note-field directives with the standard names, such as `!front:`, `!back:`, etc.

Example minimal note:

```text
!front: A precise prompt.
!back: A direct answer.
~~~
```

Example multi-line note:

```text
!front: Derive the difference of squares identity.
!back:
\[
\begin{align*}
    a^2 - b^2 &= a^2 - ab + ab - b^2 \\
              &= a(a-b) + b(a-b) \\
              &= (a-b)(a+b).
\end{align*}
\]
!extra:
This derivation works in any commutative ring.
~~~
```

Every note must be terminated by a line containing exactly:

```text
~~~
```

Required note fields are `!front:` and `!back:`.

Optional note fields are `!related:` and `!extra:`.

The `!id:` field, if exists, contains an automatically generated stable note identifier that allows updating existing notes in Anki.

### Field Usage

- Use `!front:` for the prompt the learner must answer from memory.
- Use `!back:` for the required answer, derivation, proof sketch, or explanation.
- Use `!related:` for nearby facts, identities, or comparisons that are useful after answering but are not required for correctness.
- Use `!extra:` for assumptions, warnings, or brief context that would clutter the main answer. A worked example or a recognition case (e.g. a boundary where the concept is undefined or fails) is itself testable and belongs on its own note instead — see "Extracting Worked Examples" below.
- Keep `!back:` sufficient on its own; do not require `!related:` or `!extra:` to make the answer correct.

### Editing Rules

- Preserve existing `!id:` values exactly.
- For new notes, omit `!id:`; it is generated automatically by the note tools.
- Put `!id:` first when it is present.
- Put `!front:` before `!back:`.
- Put `!related:` and `!extra:` after `!back:` when used.
- End every note record with `~~~`.
- Start the next note or metadata directive only after the previous `~~~`.

## LaTeX and Text Style

- Use inline math as `\( ... \)` and display math as `\[ ... \]`.
- Do not introduce `$...$` in new or substantially edited text.
- Use `align*` inside display math for multi-line derivations:

```text
\[
\begin{align*}
    a^2 - b^2 &= (a - b)(a + b) \\
    a^3 - b^3 &= (a - b)(a^2 + ab + b^2)
\end{align*}
\]
```

- Keep notation consistent within the file and with nearby topic files.
- State assumptions explicitly: domains, nonzero denominators, differentiability, invertibility, convergence conditions, matrix dimensions, branch choices, and quantifiers.
- Use Markdown bullets to break a long statement into cohesive chunks — hypotheses, preconditions, cases, or multi-part conclusions — instead of folding them into one long sentence; see "Chunking Complex Statements" below. Do not bullet prose that has no separable parts.
- Keep answers direct and short. Avoid filler, motivational language, long exposition, and large lists.

## Note-Writing Standards

Prefer prompts that test understanding rather than recall. Good fronts often start with:

- `Why does ...`
- `Under what conditions ...`
- `What breaks if ...`
- `How are ... related?`
- `Give a geometric interpretation of ...`
- `Derive ...`
- `Compare ...`
- `Construct a counterexample to ...`
- `Explain why ...`

Design each note at the right granularity. A good note has a focused target and a `!back:` that can usually be answered in a few sentences. If the natural answer is a whole theorem statement, a long definition, a full taxonomy, or a list of many cases, split it into several notes: hypotheses, conclusion, intuition, proof idea, failure case, example, or comparison.

Use a small number of substantial notes per concept instead of many shallow variants, but do not make one note carry an entire section of material. Increase depth within a topic by moving from definitions to consequences, assumptions, derivations, and failure cases.

### Chunking Complex Statements

A theorem or definition with several moving parts recalls poorly as one dense sentence. Reformulate it as bulleted chunks — one bullet per cohesive part — rather than chaining clauses with "and" or commas:

- Give hypotheses their own bulleted list, one bullet per condition, even when there is only one — e.g. a single "closed and bounded" precondition still gets its own bullet, separate from continuity, if it is conceptually distinct.
- State the conclusion as a short sentence after the hypothesis list (introduced by "then"), or as its own bullets if the conclusion itself has independent parts.
- Move informal restatements, geometric intuition, or "in simpler terms" framing out of `!back:` and into `!extra:`, so the bulleted statement stays precise and uncluttered.
- Do not bullet a single free-standing sentence with no separable parts — bullets exist to separate cohesive chunks, not to decorate prose.

This is a different tool from splitting a topic across multiple notes (see the granularity guidance above): chunk hypotheses/cases into bullets within one note's `!back:` first, and only split into separate notes when a well-chunked statement is still too large to test as a single note — e.g. hypotheses on one note, proof idea or failure case on another.

### Derivation and Proof Notes

A note whose front asks to derive or prove a result (`Derive ...`, `Prove ...`) recalls poorly as a narrative paragraph chaining "so", "then", "hence" across sentences. Structure `!back:` as two bulleted sections instead:

- A `Let:` section: one bullet per local definition, fixed quantity, assumption, or constraint introduced for the derivation (e.g. "\( F(x) = \int_a^x f(t)\, dt \), with \( x \in (a,b) \) fixed"). This is the derivation's own local setup, distinct from the note's global hypotheses (stated in the front or inherited from the theorem being derived).
- A `To prove:` line naming the target identity or property in one line, so the goal is explicit before the argument starts.
- A bulleted list of concrete steps below it, one bullet per logical step, each stating what is used and what follows from it.

Use this structure whenever the derivation has more than one logical step; a one-line derivation (a single substitution or direct computation) does not need it — see "Chunking Complex Statements" above for the general test of when bulleting earns its place.

### Extracting Worked Examples

A definition's `!extra:` field often accumulates a "for example, ..." or "undefined when ..., e.g. ..." aside. That aside is itself a testable fact — applying the definition to a concrete case, or recognizing when it doesn't apply — and it stays passive, easy-to-reread exposition as long as it lives inside another note's `!extra:` rather than being recalled on its own.

- If an `!extra:` example applies a definition to a concrete object (an equation, expression, sequence, etc.), promote it to its own note whose front asks the learner to work out the relevant quantity or property for that object, instead of stating the result as a parenthetical aside.
- If an `!extra:` aside is a boundary or non-example — a case where the concept is undefined, inapplicable, or a hypothesis fails — promote it to its own recognition note that presents the case and asks the learner to evaluate it. It is fine for the correct answer to be "undefined" or "does not apply"; the point is testing recognition of the boundary, not softening it into a caveat.
- Give each distinct example or non-example its own note. Do not bundle unrelated examples into one note.
- When one concrete object naturally yields several related quantities together (e.g. both the order and the degree of the same ODE), ask for them jointly in a single front rather than splitting into near-duplicate notes over the same object.
- After extracting an example onto its own note, trim the source note's `!extra:` down to the general rule and drop the now-duplicated example prose.

### Comparison Notes

When a topic introduces several related-but-distinct concepts — generalizations, special cases, or terms that are easily conflated — a note that compares them side by side is often more valuable than testing each one in isolation. A learner who can define each concept separately may still fail to keep the boundary between them straight, and that boundary is exactly what a comparison note targets.

- Use a front such as "Compare X, Y, and Z" or "How do X and Y differ?".
- In `!back:`, give each concept its own bullet: one sentence naming what distinguishes it from the others, not a full restatement of its definition. Order bullets from most general to most specific, or in the order the concepts were introduced, whichever reads more naturally.
- Reach for this style when the concepts form a natural hierarchy or are easily conflated (e.g. mapping vs. linear mapping vs. affine mapping; necessary vs. sufficient vs. equivalent conditions) — not for unrelated concepts that merely share a topic file.
- A comparison note supplements, but does not replace, the individual notes on each concept; keep those too, since the comparison note targets the boundary between concepts, not the concepts themselves.
- The note must stay self-contained per Note Independence below: include enough of each concept's definition inline that the comparison is meaningful without the learner having any other note open.

Avoid by default:

- trivial definition regurgitation,
- repeated notes that ask the same thing with different wording,
- purely computational drill unless computation is the point,
- dumping whole theorem definitions or long item lists into `!back:`,
- broad prompts whose answer needs more than a few sentences,
- vague fronts with no clear mathematical target,
- reverse cards where the reverse direction is ambiguous or unhelpful.

## Note Independence

Each note must stand alone. Anki shows notes individually and in arbitrary order, never as a sequence, and never guaranteed alongside any other specific note.

- Never assume the learner has seen, remembers, or has open any other note. Do not write text that depends on file order or adjacent notes (e.g. "as in the previous identity", "unlike the case above", "the other definition of e").
- Do not assume other notes exist at all. A note's correctness and clarity cannot depend on a companion note being present in the deck.
- When a topic naturally produces several structurally similar notes — e.g. the same constant or identity under different limiting forms — give each one the same depth of justification independently. Do not justify or explain one variant and leave structurally identical siblings as bare formulas on the assumption that the explanation carries over; either explain each one to the same standard or none of them.
- `!related:` may point to other identities for context, but the note must remain correct and self-sufficient without the learner ever reading that other note.

## Mathematical Rigor

- Check every formula, theorem statement, and implication before writing it.
- Do not conflate intuition with proof.
- Do not state converses unless they are true under the stated assumptions.
- Include hypotheses in the front when they are part of what the learner must recognize; otherwise include them clearly in the back or `!extra:`.
- If compressing a proof, state what is being omitted without making the shortened argument false.
- Prefer a short derivation or reason over an unsupported formula when the note is conceptual.
- Check that notation used in the front is defined or standard in the surrounding file.

## Tooling

The [`notatki`](https://github.com/aradzie/notatki) CLI parses, validates, and pretty-prints `.note` files; it is installed as the `@notatki/cli` local npm dependency (see `package.json`).

After creating or editing any `.note` file, check its correctness by running:

```sh
npx notatki insert-id
```

This walks the repository's `.note` files, parses and validates them, inserts an `!id:` into any note record that is missing one, pretty-prints every note, and writes the files back to disk. Run it from the repository root (it defaults to scanning the whole repo via `--dir`, default `.`). Treat a non-zero exit or parse error as a syntax problem to fix before moving on.

## Workflow

1. Inspect nearby `.note` files for deck, tags, notation, note type, and local style.
2. Decide whether the topic needs `Basic Math` or `Basic Math (and reversed card)`.
3. Draft notes around focused conceptual targets, not just topic headings or whole theorems.
4. Verify mathematical correctness, assumptions, and notation consistency.
5. Check note granularity: each `!back:` should usually fit in a few sentences; split oversized answers into multiple notes.
6. Verify syntax: metadata outside records, required `!front:` and `!back:` fields, preserved existing `!id:` values, and one `~~~` terminator per note.
7. Run `npx notatki insert-id` (see Tooling above) to validate the file, assign missing ids, and pretty-print it.

## Examples

Conceptual note:

```text
!type: Basic Math
!deck: Math
!tags: Math Algebra Inequality

!front: Why does \( |x| \le c \), with \( c \ge 0 \), imply both an upper and a lower bound for \( x \)?
!back:
Because \( |x| \le c \) means the distance from \( x \) to \( 0 \) is at most \( c \). Equivalently,
\[ -c \le x \le c. \]
So it gives the upper bound \( x \le c \) and the lower bound \( x \ge -c \).
!extra:
The assumption \( c \ge 0 \) is necessary because \( |x| \) is always nonnegative.
~~~
```

Theorem note with chunked hypotheses:

```text
!type: Basic Math
!deck: Math
!tags: Math Calculus Differentiation

!front: The definition of the Rolle's Theorem.
!back:
The Rolle's Theorem states that if a function \( f \) is:

- continuous on \( [a,b] \)
- differentiable on \( (a,b) \)
- \( f(a) = f(b) \)

then there exists at least one \( c \in (a,b) \) such that \( f'(c) = 0 \).
!extra:
Geometrically: if a continuous, differentiable curve starts and ends at the same height, some point in between has a horizontal tangent.
~~~
```

Formula note with a justified reverse:

```text
!type: Basic Math (and reversed card)
!deck: Math
!tags: Math Algebra Identity

!front: \[ a^2 - b^2 \]
!back: \[ (a - b)(a + b) \]
!related:
\[
\begin{align*}
    a^2 - b^2 &= (a - b)(a + b) \\
    a^2 + b^2 &= (a - ib)(a + ib)
\end{align*}
\]
~~~
```

Comparison note contrasting a hierarchy of related concepts:

```text
!type: Basic Math
!deck: Math
!tags: Math Linear-Algebra

!front: Compare a mapping, a linear mapping, and an affine mapping.
!back:
- A mapping is usually another word for a function, often used when emphasizing movement between sets or spaces.
- A linear mapping is a special kind of function between vector spaces that preserves vector addition and scalar multiplication.
- An affine mapping is a linear mapping followed by a translation: \( T(v)=L(v)+b \) for fixed \( b \); it reduces to a linear mapping exactly when \( b=0 \).
~~~
```

Derivation note with a `Let:`/`To prove:` setup followed by concrete steps:

```text
!type: Basic Math
!deck: Math
!tags: Math Calculus Integration

!front: Derive the Fundamental Theorem of Calculus, Part 1, from the Mean Value Theorem for Integrals.
!back:
Let:

- \( F(x) = \int_a^x f(t)\, dt \), with \( x \in (a,b) \) fixed
- \( h \ne 0 \) small enough that \( x+h \in (a,b) \)

To prove: \( F'(x) = f(x) \).

- By additivity of the integral, \( F(x+h) - F(x) = \int_x^{x+h} f(t)\, dt \).
- \( f \) is continuous on the interval between \( x \) and \( x+h \), so the Mean Value Theorem for Integrals gives some \( c_h \) between \( x \) and \( x+h \) with \( \int_x^{x+h} f(t)\, dt = f(c_h)\, h \).
- Combining these, \( \dfrac{F(x+h) - F(x)}{h} = f(c_h) \).
- As \( h \to 0 \), \( c_h \to x \) by the squeeze theorem, so continuity of \( f \) gives \( f(c_h) \to f(x) \).
- Hence \( F'(x) = \lim_{h \to 0} \dfrac{F(x+h)-F(x)}{h} = f(x) \).
~~~
```

Recognition note testing whether the learner recognizes that a property fails to apply, not just its ordinary computation:

```text
!type: Basic Math
!deck: Math
!tags: Math Calculus Differential-Equation

!front: What are the order and degree of the ordinary differential equation \( \sin(y') + y = 0 \)?
!back:
Order \( 1 \), since the highest derivative present is \( y' \).

Degree undefined, since the equation is not polynomial in the derivatives — \( y' \) appears inside \( \sin(\cdot) \), a transcendental function.
~~~
```
