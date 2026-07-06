---
name: prd-loc-estimator
description: Estimate line additions and deletions from a PRD or spec by reading the requirements and inspecting the target repo. Use when the user asks for changed LOC, additions, deletions, diff size, PR size, or implementation size before building.
---

# PRD LOC Estimator

Estimate likely source changes before implementation.

## Flow

1. Read the PRD or spec.
2. Extract scope, non-goals, acceptance criteria, and unknowns.
3. Inspect likely touched repo areas.
4. List likely files, including expected new files.
5. Estimate additions and deletions per file.
6. Use ranges and separate additions from deletions.
7. Mark expected paths that do not exist as `new file`.
8. Exclude generated, build, and lockfile output unless the PRD requires it.
9. Recommend splitting when total changed lines likely exceed `400`.
10. Use [TEMPLATE.md](TEMPLATE.md) for output.
