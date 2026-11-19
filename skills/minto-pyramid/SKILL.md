---
name: minto-pyramid
description: Structure a message top-down with the Minto Pyramid, conclusion first, then key arguments, then supporting detail. Use when drafting or restructuring emails, Slack messages, status reports, recommendations, or research findings for busy readers; avoid for analysis without a conclusion yet, sensitive news, tutorials, or skills with a fixed output format.
---

# Minto Pyramid

Lead with the conclusion.
Let the reader stop as soon as they know enough.

## Goal

- State the conclusion, recommendation, or request first.
- Explain why with a few short key arguments.
- Back each argument with facts, numbers, or results.
- Keep every gap visible as an open question.

## Rules

- Bottom line up front: the first sentence carries the main message.
- One conclusion per message. Split messages that need two.
- Two to four key arguments. Do not pad to three.
- Key arguments are MECE: no overlap, and together they justify the conclusion.
- Each key argument is a one-line summary, not a topic label.
- Detail sits under the argument it supports.
- Drop detail when the key arguments already justify the conclusion for this reader.
- Keep caveats and uncertainty that change the decision.
- Never invent a conclusion, evidence, or numbers.
- Write in the language of the input.

## Open questions

- Mark each gap with 🤔 and write it as a question.
- Put the question next to the item it affects, not in a separate section.
- No clear conclusion in the input: put a 🤔 question in the conclusion's place.
- Argument without evidence: nest a 🤔 question under that argument.
- Offer options only when the input gives them.
- Ask only questions whose answer could change the conclusion or the reader's action.

## Does not apply well

- Bad or sensitive news that needs context first.
- Readers hostile to the conclusion who must follow the reasoning to accept it.
- Exploratory thinking where no conclusion exists yet. Use `hypothesis-tree` or `deep-thinker`.
- Teaching, narrative, or step-by-step instructions.
- Deliverables with their own format, such as `to-spec`, `to-prd`, or `weekly-project-update`.

## Flow

1. Read the draft or notes. Identify the reader and what they must decide or do.
2. Find the conclusion: the one thing the reader must remember or act on.
3. Group the remaining material into key arguments that answer "why?".
4. Check the arguments are MECE. Merge overlaps and cut arguments that do not support the conclusion.
5. Attach evidence under each argument. Cut detail the reader does not need.
6. Mark every missing conclusion or missing evidence as a 🤔 question at the affected item.
7. Read only the first sentence, then only the first two levels. Each must stand on its own.

## Resources

- [Minto Pyramid - Untools](https://untools.co/minto-pyramid/)
- [The Minto Pyramid Principle - Barbara Minto](https://www.goodreads.com/book/show/33206.The_Minto_Pyramid_Principle)
- [BLUF: The Military Standard That Can Make Your Writing More Powerful](https://www.animalz.co/blog/bottom-line-up-front/)

## Output

Return only the message. Do not add an outline, critique, or commentary.

```md
**[Conclusion, recommendation, or request in one sentence]**

- [Key argument: one-line reason why]
  - [Fact, number, or result]
  - [Fact, number, or result]
- [Key argument: one-line reason why]
  - [Fact, number, or result]
  - 🤔 [Open question about missing evidence?]
- [Key argument: one-line reason why]
```

When the conclusion is missing:

```md
**🤔 [Open question that the conclusion depends on?]**

- [Key argument or finding]
  - [Fact, number, or result]
```
