---
name: generate-flashcards
description: Create, edit, or review Anki math flashcards in this repository's custom `.note` source format, including precise note syntax, metadata handling, LaTeX math, active-recall prompt design, and mathematical correctness checks.
---

# Generate Math Flashcards

## Purpose

Create math flashcards in this repository's custom `.note` format. Cards should be short enough that the learner can usually answer in a few sentences while still testing explanation, derivation, comparison, interpretation, assumptions, or failure cases.

## Calibration

Target audience: a passionate, technically sophisticated self-learner — e.g. an experienced software engineer — working independently through single- and multi-variable calculus, linear algebra, and differential equations at the level of Apostol, Spivak, and Stewart. They are comfortable with formal notation, proofs, and abstraction, want depth well beyond mechanical computation, and do not need simplification unless a concept is genuinely subtle — but they are not taking a dedicated real analysis, topology, or measure theory course.

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

Out of scope — do not write cards on:

- General topology.
- Measure theory and Lebesgue integration.
- Functional analysis.
- Metric space theory beyond what is needed to state basic real-analysis facts on \( \mathbb{R}^n \).
- Graduate-level real analysis.

When a topic is ambiguous, use this test: would it appear in a calculus or introductory-analysis text at the Apostol/Spivak/Stewart level, or does it require a dedicated analysis/topology/measure-theory course to state properly? If the latter, exclude it.

### Proof Awareness

The audience wants to be able to reconstruct proofs, not memorize them verbatim. Where useful, favor cards about the key idea behind a proof, the critical lemma, why a proof technique works, where a hypothesis is used, and counterexamples when a hypothesis is dropped — a natural extension of the "construct a counterexample" and "what breaks if" prompt patterns in Note-Writing Standards below.

## Repository Context

- This is one of three artifact types in this repository (flashcards, self-check questions, essays); see `AGENTS.md` for the repository-wide overview and the other two.
- Source files are `.note` files organized by topic directories.
- Import is handled by an Anki addon. Do not invent new syntax, build steps, generated artifacts.
- Follow nearby `.note` files for deck names, tags, notation, and topic granularity.

## `.note` Format

A `.note` file is plain text containing metadata directives and note records.

Metadata directives set defaults for subsequent note records. Note records contain field directives whose values become Anki model fields.

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
!deck: Math::Calculus::Limits
!tags: Math Calculus Limits Theory
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
- Use `!extra:` for assumptions, edge cases, examples, warnings, or context that would clutter the main answer.
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
- Use Markdown bullets only when they improve readability.
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

Design each card at the right granularity. A good card has a focused target and a `!back:` that can usually be answered in a few sentences. If the natural answer is a whole theorem statement, a long definition, a full taxonomy, or a list of many cases, split it into several cards: hypotheses, conclusion, intuition, proof idea, failure case, example, or comparison.

Use a small number of substantial notes per concept instead of many shallow variants, but do not make one card carry an entire section of material. Increase depth within a topic by moving from definitions to consequences, assumptions, derivations, and failure cases.

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
- Prefer a short derivation or reason over an unsupported formula when the card is conceptual.
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
5. Check card granularity: each `!back:` should usually fit in a few sentences; split oversized answers into multiple notes.
6. Verify syntax: metadata outside records, required `!front:` and `!back:` fields, preserved existing `!id:` values, and one `~~~` terminator per note.
7. Run `npx notatki insert-id` (see Tooling above) to validate the file, assign missing ids, and pretty-print it.

## Examples

Conceptual note:

```text
!type: Basic Math
!deck: Math::Algebra
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

Formula note with a justified reverse:

```text
!type: Basic Math (and reversed card)
!deck: Math::Algebra
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
