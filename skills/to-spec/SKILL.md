---
name: to-spec
description: Write a short spec in ASD-STE100 Simplified Technical English with users, problem, requirements, and open questions. Use for tasks or discussions with open requirements.
---

# To Spec

## Steps

- Read the full conversation and each source the user gives.
- Gather **Project Context**, then identify the users, problem, goal, and stated requirements.
- Preserve exact names, scope, exclusions, limits, and settled choices. Do not invent decisions.
- Write known behavior as testable requirements.
- Check each requirement for gaps. Consider users, triggers, results, paths, access, errors, limits, and success.
- Search relevant sources to resolve gaps before you apply the **Open Questions** rules.
- Check that every request and relevant source detail appears in the spec.

Ask before writing only if the task itself is unclear. Do not wait for all questions to be answered.

## Project Context

- Identify the project from the current workspace, project instructions, repository metadata, and conversation details such as task IDs or links.
- Determine where that project keeps code, tasks, documentation, designs, and decisions. Use project instructions and existing references to select relevant sources.
- Gather context from those sources with available local tools and connectors, beyond the links the user supplies. Tool availability alone is not a reason to search a source.
- For example, if the project uses GitHub, check relevant code, tests, docs, issues, pull requests, and discussions. If it uses ClickUp, check tasks, descriptions, comments, linked docs, and dependencies.
- Use other project sources, such as Notion, design files, or project discussions, when they can clarify scope or behavior.
- Search with project-specific names and terms. Follow relevant links and references. Read enough surrounding context to understand each decision.
- Focus on sources that establish requirements or answer gaps. Stop when context is sufficient and further searches add no useful facts.
- Check source status, date, and authority. Distinguish proposals from accepted decisions and current behavior from intended behavior.
- Treat code and tests as evidence of current behavior. Do not assume they settle the behavior requested for a change.
- Use the user's latest explicit instructions to resolve earlier conflicting instructions. Do not assume the newest external source overrides an accepted decision.
- Resolve source conflicts through later decisions or source authority. Keep unresolved conflicts for **Open Questions**.
- If a relevant source is unavailable, use accessible sources and state the specific context limit in the relevant existing section. Do not invent its contents.
- Link key facts to their sources when stable links are available.

## Requirements

- Write requirements as a nested Given/When/Then tree.
- Group requirements that share context or steps under their common parent.
- Each nested item inherits every ancestor condition. Do not repeat inherited text.
- A branch may be nested as deeply as needed. Each leaf must state a testable outcome.
- Start nodes with bold **Given**, **When**, or **Then**. Use bold **And** only to extend the parent clause.
- Do not use flat summaries, title prefixes, or requirement IDs.

## Open Questions

- Include only questions that still need an answer or a decision and could change the users, problem, scope, or acceptance criteria.
- Check the conversation, project context, and requirements for answers. Put known, settled, or unambiguously implied answers in the relevant spec section instead of asking for confirmation.
- A plausible default, common practice, or personal preference is not a clear answer. Do not invent a decision to remove a real question.
- For unresolved conflicts, name the conflicting facts and link their sources when available.
- Ask only about the unresolved part of a behavior. Include enough known context to make each question clear on its own.
- After you draft the spec, check every question again. Remove questions that the spec itself already answers.
- Group related questions, remove repeats and minor questions, and note dependencies between answers.
- Write plain bullets without requirement IDs, numbered labels, or title prefixes.

## Writing

- Write the spec in ASD-STE100 Simplified Technical English (STE). Apply [STE writing rules](STE.md) to each section.
- Put one idea in each bullet.
- Do not treat an open question as a settled requirement.
- Before delivery, complete the final check in STE.md.

## Output

Use only the four sections in [OUTPUT.md](OUTPUT.md). Keep their names and order.

- If a facts section has no known facts after the context search, write `- Not yet known.` Add a matching question only if it meets the **Open Questions** rules.
- If no questions remain, write `- None.`
- Do not add a tech plan or approval request.
