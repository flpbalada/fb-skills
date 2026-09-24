---
name: to-spec
description: Write a short spec with users, problem, requirements, and open questions. Use for tasks or discussions with open requirements.
---

# To Spec

Write down what is known. List what still needs a decision.

## Steps

- Read the full conversation and each source the user gives.
- Check code or docs for facts you can find. Do not ask the user for those facts.
- Use source facts that shape the users, problem, requirements, or questions.
- Keep exact names, limits, and settled choices from the sources.
- Link key facts to their sources when a stable link is available.
- If sources disagree, put the conflict in **Open Questions**. Do not guess.
- Find the users, problem, goal, and stated requirements.
- Keep known scope, exclusions, and limits. Do not invent decisions.
- Put known behavior in the requirements section. Make each result easy to test.
- Use **Given** / **When** / **Then** when the action and result are clear.
- Use plain bullets for other requirements.
- Check each requirement for gaps. Consider users, triggers, results, paths, access, errors, limits, and success.
- Put gaps that could change a requirement in **Open Questions**.
- Add questions for requirements that are too unclear to write as requirements.
- Check that every request and relevant source detail appears in the spec.
- Link each question to its requirement. Note when one answer depends on another.
- Group related questions. Remove repeats and minor questions.

Ask before writing only if the task itself is unclear. Do not wait for all questions to be answered.

## Writing

- Write the spec in simple English.
- Use short sentences and common words.
- Put one idea in each bullet.
- Do not treat an open question as a settled requirement.

## Output

Use only the four sections in [OUTPUT.md](OUTPUT.md). Keep their names and order.

- Leave out lines that do not fit.
- If a section has no known facts, write `- Not yet known.` Add a matching question.
- If no questions remain, write `- None.`
- Do not add a tech plan or approval request.
