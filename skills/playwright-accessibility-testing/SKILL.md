---
name: playwright-accessibility-testing
description: Write, review, or fix Playwright accessibility tests with @axe-core/playwright. Use for axe scans, WCAG A/AA tags, ARIA names, roles, labels, keyboard/focus checks, accessibility audit failures, exclusions, and critical page or flow a11y coverage. For general Playwright locator, assertion, fixture, or flake guidance use playwright-best-practices.
dependencies:
  - "@axe-core/playwright"
---

# Playwright Accessibility Testing

Use Playwright plus `@axe-core/playwright`.
Axe helps, but does not prove full WCAG compliance.

## When to Use

- Writing a11y tests
- Reviewing axe failures
- Checking WCAG A/AA tags
- Testing ARIA names and roles
- Auditing critical pages or flows

## Goal

Scan meaningful user states.
Fix root causes.
Document temporary exclusions.

## Rules

- Test critical flows, not only homepage.
- Scan after UI reaches real user state.
- Use `AxeBuilder`.
- Scope noisy scans with `include()`.
- Avoid `exclude()` and `disableRules()` unless justified.
- Snapshot fingerprints only.
- Pair with manual keyboard/focus checks.

## Pattern

```ts
import { test, expect } from '@playwright/test'
import AxeBuilder from '@axe-core/playwright'

test('home page has no detectable a11y violations', async ({ page }) => {
  await page.goto('/')
  const results = await new AxeBuilder({ page }).analyze()
  expect(results.violations).toEqual([])
})
```

WCAG tags:

```ts
const results = await new AxeBuilder({ page })
  .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])
  .analyze()
```

## Flow

1. Pick critical page or flow.
2. Navigate and interact to target state.
3. Run axe scan.
4. Inspect `id`, `impact`, `target`, `failureSummary`.
5. Fix label, contrast, ARIA, semantics, or duplicate ID.
6. Rerun test.
7. Report automated limits.

## References

- [Playwright Accessibility Testing](https://playwright.dev/docs/accessibility-testing)
- [axe-core rules](https://github.com/dequelabs/axe-core/blob/master/doc/rule-descriptions.md)

## Output

```md
## A11y Test Review

Scope: [page/flow]
Scan state: [when scan runs]
WCAG tags: [tags if used]

Findings:
- [rule id]: [impact], target [selector], fix [change]

Exclusions:
- [selector/rule]: [reason], follow-up [ticket]

Limitations:
- Manual keyboard/focus/screen-reader check still needed.
```
