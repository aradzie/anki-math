# Real Numbers Flashcard Plan

## Scope

This folder should cover the real numbers as the background structure used by
calculus: algebra, order, completeness, bounds, intervals, approximation, and
the basic consequences that make \(\mathbb{R}\) different from \(\mathbb{Q}\).

It should not become a full real analysis course. Keep these out unless a later
calculus note needs a very small bridge:

- construction of \(\mathbb{R}\) from Cauchy sequences or Dedekind cuts
- general metric spaces or topology
- compactness as a general theory
- measure theory
- detailed sequence and series theory, except for short references to
  completeness facts that calculus uses

## Proposed Progression

### 01. Ordered-Field Structure

Purpose: make explicit what algebraic and order assumptions are already present
before completeness enters.

Draft notes:

- What does it mean that \(\mathbb{R}\) is a field?
- Which field axioms justify cancellation, division by nonzero numbers, and
  sign manipulations?
- What does it mean that \(\mathbb{R}\) is ordered?
- State the compatibility of order with addition.
- State the compatibility of order with multiplication by positive and negative
  numbers.
- Why does multiplying an inequality by a negative number reverse the
  inequality?
- Compare the ordered-field properties of \(\mathbb{Q}\) and \(\mathbb{R}\).
- What part of the usual real-number system is not captured by the ordered-field
  axioms?

Keep this light. The goal is not to memorize every axiom as a list, but to know
which rules are structural assumptions and which are consequences.

### 02. Absolute Value, Distance, and Inequalities

Purpose: connect order to the language used in limits, neighborhoods, and
estimates.

Draft notes:

- Define \(|x|\) in terms of cases \(x \ge 0\) and \(x < 0\).
- Interpret \(|x-a|\) as distance on the real line.
- Convert \(|x-a| < r\), with \(r > 0\), into \(a-r < x < a+r\).
- Convert \(|x-a| \le r\), with \(r \ge 0\), into
  \(a-r \le x \le a+r\).
- Explain why \(|x| \le M\), with \(M \ge 0\), is equivalent to
  \(-M \le x \le M\).
- State and prove the triangle inequality for real numbers.
- State the reverse triangle inequality.
- Use absolute value to characterize bounded subsets of \(\mathbb{R}\).

This topic should be close to calculus usage: estimates, intervals centered at
a point, and bounding errors.

### 03. Bounds, Suprema, Infima, Maxima, and Minima

Purpose: organize the current bounds material around the hierarchy
"bound, least/greatest bound, attained bound."

Existing material:

- Most of `01-bounds.note` belongs here.

Draft or retain notes:

- Define upper bound, lower bound, bounded above, bounded below, and bounded.
- Define \(\sup A\) and \(\inf A\).
- Give the \(\varepsilon\)-characterization of \(\sup A\).
- Give the \(\varepsilon\)-characterization of \(\inf A\).
- Prove uniqueness of \(\sup A\) and \(\inf A\).
- Compare \(\max A\) with \(\sup A\).
- Compare \(\min A\) with \(\inf A\).
- Give examples where \(\sup A\) exists but \(\max A\) does not.
- Give examples where \(\inf A\) exists but \(\min A\) does not.
- Compute suprema and infima for basic intervals:
  \((a,b)\), \([a,b]\), \((a,b]\), \([a,b)\), \((a,\infty)\),
  and \((-\infty,b)\).
- Prove monotonicity: if \(A \subseteq B\), then
  \(\sup A \le \sup B\), assuming both suprema exist.
- Derive simple algebra of suprema, such as
  \(\sup(A+B)=\sup A+\sup B\), with precise hypotheses.

Avoid turning this into a catalogue of hard supremum computations. The useful
calculus skill is recognizing what the supremum means and how to use the
\(\varepsilon\)-characterization.

### 04. Completeness of \(\mathbb{R}\)

Purpose: isolate the least-upper-bound axiom and show why it is the defining
extra property of the real numbers.

Existing material:

- The completeness axiom note in `01-bounds.note` belongs here.
- The rational-gap example \(A=\{x\in\mathbb{Q}:x^2<2\}\) belongs here.

Draft notes:

- State the least-upper-bound axiom for \(\mathbb{R}\).
- Explain why nonempty and bounded above are necessary hypotheses.
- Derive the greatest-lower-bound property from the least-upper-bound axiom.
- Compare completeness of \(\mathbb{R}\) with failure of completeness in
  \(\mathbb{Q}\).
- Show why \(A=\{x\in\mathbb{Q}:x^2<2\}\) has no least upper bound in
  \(\mathbb{Q}\).
- Explain why completeness is not an algebraic field property.
- Use completeness to prove existence of \(\sqrt{2}\) as a real number, if this
  is not already covered elsewhere.

Do not include a full construction of \(\mathbb{R}\). Treat completeness as an
axiom or defining property.

### 05. Natural Numbers, Integers, and the Archimedean Property

Purpose: cover the "no infinitely large or infinitesimal real numbers" facts
used in estimates and approximation.

Existing material:

- `02-archimedean.note` belongs here.

Draft or retain notes:

- State and prove the Archimedean property:
  for every \(x \in \mathbb{R}\), some \(n \in \mathbb{N}\) satisfies
  \(n > x\).
- Derive the reciprocal form: for every \(\varepsilon > 0\), some
  \(n \in \mathbb{N}\) satisfies \(1/n < \varepsilon\).
- Explain why the Archimedean property rules out positive infinitesimals in
  \(\mathbb{R}\).
- Prove that for every \(x \in \mathbb{R}\), there is an integer \(m\) with
  \(m \le x < m+1\), if this floor-property proof is needed for density.
- State the floor and ceiling properties in the limited form needed for
  rational approximation.

Keep the natural-number foundations minimal. This folder only needs the facts
that support approximation and calculus estimates.

### 06. Density and Approximation

Purpose: explain why every real interval contains rational and irrational
points.

Existing material:

- `03-density.note` belongs here.

Draft or retain notes:

- Prove density of \(\mathbb{Q}\) in \(\mathbb{R}\): if \(a < b\), then some
  \(q \in \mathbb{Q}\) satisfies \(a < q < b\).
- Prove density of the irrationals in \(\mathbb{R}\).
- Explain why there is no "next" real number after a real number.
- Show that every nonempty open interval contains infinitely many rational
  numbers.
- Show that every nonempty open interval contains infinitely many irrational
  numbers.
- Use density to approximate a real number from above and below by rationals.

Avoid decimal-expansion theory unless a later calculus topic explicitly needs
it. Rational approximation is the main calculus-facing idea.

### 07. Intervals and Neighborhood Language

Purpose: make the real-line vocabulary used in calculus prompts self-contained.

Draft notes:

- Define open, closed, half-open, bounded, and unbounded intervals in
  \(\mathbb{R}\).
- Compare endpoint inclusion in \((a,b)\), \([a,b]\), \((a,b]\), and
  \([a,b)\).
- Define an open neighborhood of \(a\) in \(\mathbb{R}\).
- Define a punctured neighborhood of \(a\) in \(\mathbb{R}\).
- Express a neighborhood of \(a\) using absolute value:
  \((a-\delta,a+\delta)=\{x:|x-a|<\delta\}\).
- Explain why endpoints are boundary cases for interval statements.
- Compare local statements near \(a\) with global statements on an interval.

This topic is a bridge into limits and continuity. Keep the actual
\(\varepsilon\)-\(\delta\) definitions in the calculus folder.

### 08. Minimal Completeness Consequences for Calculus

Purpose: add only the real-number completeness facts that calculus repeatedly
uses as background.

Draft notes only if they are not already covered better in calculus files:

- State the nested-interval property for closed bounded intervals.
- State the monotone convergence property for bounded monotone real sequences.
- Explain, at a high level, that these are completeness consequences, not
  ordered-field consequences.
- Compare "bounded above set has a supremum" with "bounded increasing sequence
  has a limit."

This section should stay small. Detailed proofs and applications to sequences,
series, continuity, compactness, and the intermediate value theorem belong in
calculus or introductory analysis topic folders.

## Suggested File Organization

Eventually reorganize the folder into files like:

- `01-ordered-field.note`
- `02-absolute-value.note`
- `03-bounds-extrema.note`
- `04-completeness.note`
- `05-archimedean.note`
- `06-density.note`
- `07-intervals-neighborhoods.note`
- optionally `08-completeness-consequences.note`

The current files can be migrated gradually. Preserve existing note IDs when
moving or editing notes.

## Drafting Priorities

1. Add the missing ordered-field and absolute-value foundations.
2. Split the current `01-bounds.note` conceptually into bounds/extrema and
   completeness.
3. Add the greatest-lower-bound property as a consequence of completeness.
4. Add floor/ceiling notes only if they make the density proof clearer.
5. Add interval and neighborhood language as a small bridge to calculus.
6. Leave broad sequence and compactness material for the calculus or analysis
   folders unless a specific real-number prerequisite is missing.
