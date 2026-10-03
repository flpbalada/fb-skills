# STE writing rules

Use ASD-STE100 Simplified Technical English for the spec. This guide is a working summary. It does not replace the official specification or dictionary.

Use the edition and dictionary the user supplies. If no official reference is available, apply this guide without claiming verified ASD-STE100 compliance.

## Vocabulary

- Check words against the applicable dictionary when available. Use only their approved meanings and parts of speech; common or short words are not automatically approved.
- Use technical names and technical verbs under the rules for those terms. Do not use them to bypass dictionary restrictions for general words.
- Use one term for each concept. Do not change terms for variety. Define unfamiliar technical terms on first use.
- Keep exact product names, UI labels, code identifiers, paths, units, values, and quoted source text. Mark exact strings with quotation marks or code formatting; rewrite only the surrounding prose.
- If a word cannot be checked, do not describe it as approved. Do not invent dictionary entries or replace a precise term with an inaccurate word.

## Sentences

- Use a maximum of 25 words in a descriptive sentence. Use a maximum of 20 words in an instruction.
- Give one instruction per sentence, unless actions occur at the same time.
- Use active voice. Name the actor when the actor affects the requirement.
- Use simple verb forms. Avoid complex verb phrases and the `-ing` form unless the applicable rules permit that use.
- Use articles where needed. Do not remove `a`, `an`, or `the` to shorten a sentence.
- Keep noun clusters to a maximum of three words. Use prepositions or define a longer technical name when the rules permit it.
- Use explicit nouns when a pronoun could refer to more than one thing.
- Do not use idioms, jargon, or ambiguous abbreviations.

## Requirements and questions

- Given/When/Then clauses may be fragments; make each complete path clear.
- Treat acceptance criteria as descriptions of required behavior. Do not convert them to commands for an operator.
- Keep conditions, negation, obligations, permissions, limits, units, and outcomes from the sources. A language change must not change the requirement.
- Split long clauses into nested conditions or separate outcomes only if the logical meaning stays the same.
- Keep open questions as questions. Do not add an answer to make a sentence simpler.

For example, replace vague prose such as “The system should gracefully handle an expired session” with a testable result only when the sources establish that result:

- **Given** the user's session has expired
  - **When** the user opens a protected page
    - **Then** the application shows the sign-in page.

If the sources do not establish the result, add an open question:

- What must the application do when a user with an expired session opens a protected page?

These examples show structure and clarity. They are not a dictionary validation.

## Final check

- Check the applicable official rules and dictionary when available, including approved meanings and parts of speech.
- Check sentence length, active voice, verb forms, noun clusters, articles, and consistent technical terms.
- Read each requirement with all its ancestor conditions. Check that the rewrite preserves the source meaning.
