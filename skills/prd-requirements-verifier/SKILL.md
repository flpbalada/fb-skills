---
name: prd-requirements-verifier
description: Verify completed work against a PRD's Given/When/Then requirements.
---

# Requirement Verification

Verify every Given/When/Then requirement in the PRD against the completed work.

- Read the PRD and relevant implementation changes.
- Test each requirement independently.
- Use the strongest available evidence: automated tests, project checks, code inspection, or manual testing.
- Do not edit code, add requirements, or use implementation claims as proof.
- Mark a requirement `Blocked` when it is unclear or cannot be tested.
- Mark a requirement `Fail` when the expected result is not met.
- Mark a requirement `Pass` only when evidence confirms it is met.

Return the result:

```md
## Requirement Verification

| Requirement           | Result                | Evidence                          |
| --------------------- | --------------------- | --------------------------------- |
| Given … When … Then … | Pass / Fail / Blocked | Test, command, or observed result |

## Failures

- Requirement: [Given / When / Then]
- Expected: [expected result]
- Actual: [observed result]
- Reproduction: [steps or command]

## Blockers

- Requirement: [Given / When / Then]
- Blocker: [reason]

## Final Result

Pass | Fail | Blocked
```

Return `Pass` only when every requirement passes.
