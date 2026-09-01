# How to Use AI and LLMs to Learn Mathematics

Used well, LLMs are not a replacement for textbooks or problem solving.
They are adaptive tutoring tools that can compress feedback loops. Their
main advantage is not that they "know mathematics", but that they can
explain the same concept in many different ways, generate unlimited
exercises, and respond immediately to questions.

For mathematics learning, an LLM is best treated as several different
tools:

- a tutor
- a Socratic examiner
- a proof critic
- a study-material generator

Each role has different strengths. The main skill is knowing which role
to ask for.

## 1. Use it as a tutor, not an oracle

Instead of asking

> Explain Jacobians.

ask something more specific:

> Explain Jacobians for a learner who already knows multivariable
> calculus. Use the viewpoint of linear maps and differentials. Avoid
> intuition until the formal definition is established.

The answer is usually better when the prompt specifies:

- the learner's background
- the desired rigor
- the preferred notation
- the ideas already understood
- the point of confusion

For example:

> Assume familiarity with partial derivatives and Taylor expansions.
> Show how the Jacobian naturally appears as the unique linear map in
> the multivariable derivative.

This lets the explanation begin close to the learner's current boundary
of understanding, instead of starting too early or too late.

## 2. Force active recall

Passive reading is inefficient.

Instead of

> Explain Taylor series.

ask

> Generate 30 self-check questions about Taylor series. Start with
> definitions, then derivations, then proofs, then applications.

Or:

> Ask one question at a time. Do not reveal the answer until an answer
> has been attempted.

This is closer to how an experienced tutor teaches: the learner has to
retrieve, predict, and explain rather than merely recognize.

## 3. Ask for derivations instead of results

Weak prompt:

> What is Green's theorem?

Better:

> Derive Green's theorem from the Fundamental Theorem of Calculus,
> showing every step.

Even better:

> Derive Green's theorem, but stop after each major step and ask for a
> prediction of the next step.

The goal is not just to obtain the theorem statement. The goal is to see
why the theorem has that form and how the assumptions enter.

## 4. Ask "why" repeatedly

Many textbooks optimize for brevity.

LLMs can recursively explain motivation.

For example:

> Why is differentiability defined using linear maps instead of
> directional derivatives?

After reading the answer:

> Why are directional derivatives not sufficient?

Then:

> Give a counterexample.

Then:

> Is there a more abstract formulation?

This recursive questioning is something textbooks cannot easily provide.

## 5. Ask for multiple viewpoints

One concept usually has several equivalent descriptions.

For example:

> Explain the differential as
>
> - a linear map
> - the first Taylor polynomial
> - the Fréchet derivative
> - a pushforward
> - the Jacobian matrix
>
> and show why these are equivalent.

This builds deeper understanding than memorizing one formulation.

## 6. Let it critique proofs

A proof attempt should usually come before the LLM's solution. Otherwise
the model does the cognitive work that the learner needs to practice.

For example:

> Here is a proof attempt.
>
> Identify every unjustified step. Do not rewrite the proof unless
> necessary.

Or

> Grade this like a university professor.

Or

> Where would a mathematician object?

This produces better feedback than simply asking for a polished
solution.

## 7. Do not ask for solutions immediately

Instead:

> Give only the first hint.

If needed:

> Give another hint.

If needed:

> Show only the next step.

Only after the learner's own ideas have been exhausted:

> Show the full proof.

This preserves the cognitive work while still providing a path out of
being stuck.

## 8. Use it to generate exercises

After finishing a chapter or section:

> Generate 40 original exercises covering every important idea.

Or

> Generate problems in increasing difficulty.

Or

> Generate problems that combine Taylor series and Jacobians.

This prevents overfitting to the exact exercises in a textbook and gives
extra practice on weak points.

## 9. Ask for dependency graphs

One of the best uses of AI is planning.

Example:

> What concepts must be understood before studying differential
> geometry?

Or:

> Draw the dependency graph from single-variable calculus to
> differential forms.

This helps organize learning into prerequisites, core ideas, and later
applications.

## 10. Use it to compare concepts

For example:

> Compare:
>
> - differential
> - derivative
> - Jacobian
> - gradient
> - Fréchet derivative
> - Gateaux derivative

Or:

> Compare the inverse function theorem, implicit function theorem, and
> Picard--Lindelöf theorem.

Comparison is one of the strongest capabilities of LLMs, especially when
the prompt asks for hypotheses, conclusions, examples, and boundary
cases.

## 11. Ask for historical motivation

Mathematics often becomes clearer once the motivating problems are
visible.

Example:

> What mathematical problem led to the invention of manifolds?

Or:

> Why was ordinary calculus insufficient?

Historical motivation should not replace formal definitions, but it can
explain why a definition was worth inventing.

## 12. Ask for increasingly abstract explanations

A progression might be:

1. computational
2. geometric
3. coordinate-free
4. functional analytic
5. categorical

For example:

> Explain divergence at each of these five levels.

This makes abstraction less mysterious. The lower-level versions show
what is being generalized, and the higher-level versions show which
features survive the generalization.

## 13. Generate spaced repetition material

LLMs are useful for producing:

- definition cards
- theorem cards
- proof outlines
- common misconceptions
- "why" questions
- comparison questions

For example:

> Produce 50 Anki cards on the inverse function theorem. Focus on
> conceptual understanding rather than memorizing statements.

The generated cards still need review. LLMs can easily create cards that
are too broad, subtly wrong, or phrased in a way that encourages passive
recognition instead of recall.

## 14. Use it to connect fields

One major advantage over textbooks is cross-domain integration.

Example:

> How does the Jacobian appear in
>
> - differential equations
> - optimization
> - probability
> - differential geometry
> - machine learning
> - numerical analysis

This builds a richer mental model by showing how the same structure
appears under different names and in different applications.

## 15. Build concept maps

Example:

> Build a concept graph connecting
>
> continuity differentiability Jacobian differential Taylor theorem
> inverse function theorem implicit function theorem manifolds

Then ask:

> Which edges represent logical implications?

Concept maps are most useful when the edges are labeled. Some edges mean
"is a prerequisite for"; others mean "implies," "generalizes,"
"motivates," or "is an example of."

## 16. Ask it to identify misconceptions

For example:

> List the ten most common misconceptions students have about
> differentials.

This often reveals misunderstandings before they become entrenched.

Misconception prompts are especially useful after solving problems,
because the model can compare a learner's written explanation against
typical wrong patterns.

## 17. Use it as a reading companion

While reading a textbook:

1. Read one section.
2. Close the book.
3. Explain the section from memory.
4. Ask the LLM to critique the explanation.

This is considerably more effective than simply asking for a summary.
The point is to test understanding before receiving more explanation.

## 18. Verify important mathematical claims

LLMs still make algebraic, analytical, and logical mistakes. For
anything important:

- check against the textbook,
- derive it directly,
- or verify it using another reliable source.

Treat the model as a knowledgeable collaborator, not a formal proof
system.

## A Practical Workflow

A generally effective workflow is:

1. Read a textbook section carefully.
2. Work through the examples without AI.
3. Solve the exercises independently.
4. Use the LLM to critique the solutions rather than provide them.
5. Generate additional exercises on the same topic.
6. Generate conceptual self-check questions and spaced repetition cards.
7. Ask the LLM to connect the topic to previously studied material, such
   as links between Taylor's theorem, differentials, Jacobians, and the
   inverse and implicit function theorems.

This keeps the textbook as the authoritative source while using the LLM
to provide immediate feedback, targeted practice, and conceptual
connections that would otherwise require access to an experienced tutor.
