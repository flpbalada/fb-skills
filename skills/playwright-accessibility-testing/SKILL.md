---
name: playwright-accessibility-testing
description: Guides Playwright accessibility tests with axe scans and WCAG checks. Use when writing, reviewing, or fixing automated a11y tests, ARIA tests, or page accessibility audits.
dependencies:
  - "@axe-core/playwright"
---

# Playwright Accessibility Testing

## Use When

- Playwright accessibility testing
- Axe scans with `@axe-core/playwright`
- Accessibility violations or failing axe output
- WCAG checks with axe tags
- ARIA testing and accessible-name coverage
- Automated a11y tests for critical flows
- Page accessibility audits

## Do Not Use When

- Manual keyboard, focus, or screen-reader behavior is the only concern
- Visual-only review is needed without automated checks
- Testing third-party pages the team does not control

## Workflow

1. Scope coverage by user flows and critical pages: auth, navigation, forms, checkout, dashboards, error states.
2. Check if `@axe-core/playwright` exists. If absent, install it: `npm install -D @axe-core/playwright`.
3. Add focused tests with `AxeBuilder`; scan the page state users actually reach.
4. Use `include()`, `exclude()`, or `withTags()` to narrow scope when full-page scans are noisy or too broad.
5. Verify known violations with targeted assertions or small fingerprints/snapshots when useful.
6. Avoid suppressing violations without a clear reason, owner, and follow-up.
7. Run relevant Playwright tests. Report automated-check limits: axe cannot prove full WCAG compliance or screen-reader quality.

## Patterns

### Basic page scan

```ts
import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test('home page has no automatically detectable a11y violations', async ({ page }) => {
  await page.goto('/');

  const results = await new AxeBuilder({ page }).analyze();

  expect(results.violations).toEqual([]);
});
```

### WCAG A/AA scan

```ts
const results = await new AxeBuilder({ page })
  .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])
  .analyze();

expect(results.violations).toEqual([]);
```

### Scoped scan after interaction

```ts
test('navigation menu has no detectable a11y violations', async ({ page }) => {
  await page.goto('/');
  await page.getByRole('button', { name: 'Navigation Menu' }).click();
  await page.locator('#navigation-menu-flyout').waitFor();

  const results = await new AxeBuilder({ page })
    .include('#navigation-menu-flyout')
    .analyze();

  expect(results.violations).toEqual([]);
});
```

### Exclude known problem area with justification

```ts
test('checkout has no new detectable a11y violations', async ({ page }) => {
  await page.goto('/checkout');

  const results = await new AxeBuilder({ page })
    // Excluded: vendor date picker has tracked issue A11Y-123.
    // Remove after component replacement lands.
    .exclude('[data-testid="vendor-date-picker"]')
    .analyze();

  expect(results.violations).toEqual([]);
});
```

Prefer fixing issues over `exclude()` or `disableRules()`. If disabling a rule, name the rule and reason:

```ts
const results = await new AxeBuilder({ page })
  // Known legacy duplicate IDs tracked in A11Y-456.
  .disableRules(['duplicate-id'])
  .analyze();
```

### Known violation fingerprint

```ts
function violationFingerprints(results: Awaited<ReturnType<AxeBuilder['analyze']>>) {
  return results.violations.map((violation) => ({
    rule: violation.id,
    targets: violation.nodes.map((node) => node.target),
  }));
}

expect(violationFingerprints(results)).toMatchSnapshot();
```

Do not snapshot full axe results. Full results include rendered HTML and break on unrelated markup changes.

### Failing output interpretation

When `expect(results.violations).toEqual([])` fails, inspect:

- `id`: axe rule, e.g. `color-contrast`, `label`, `duplicate-id`
- `impact`: severity signal, e.g. minor, moderate, serious, critical
- `help` and `helpUrl`: rule explanation
- `nodes[].target`: affected selector path
- `nodes[].failureSummary`: why it failed and what to fix

Fix root cause first: label controls, improve contrast, use valid ARIA, remove duplicate IDs, ensure semantic roles/names.

## Review Checklist

- [ ] Tests cover user flows and critical pages, not only broad homepage scans.
- [ ] Tests scan UI after required interactions and waits.
- [ ] `AxeBuilder` configuration is local or shared through a fixture when repeated.
- [ ] `withTags()` matches intended WCAG scope when used.
- [ ] `include()` narrows to meaningful regions; `exclude()` is rare and documented.
- [ ] Known exclusions or disabled rules include reason and follow-up.
- [ ] Tests use Playwright user-facing locators for setup actions.
- [ ] Failing output is interpreted and fixed, not blindly suppressed.
- [ ] Automated tests are complemented by manual keyboard, focus, and screen-reader checks.
- [ ] Test run command and limitations are reported.

## Run Guidance

Use the narrowest useful command first:

```bash
npx playwright test tests/accessibility.spec.ts
npx playwright test --grep "a11y|accessibility"
```

If failures are unclear, attach full scan results for debugging:

```ts
await testInfo.attach('accessibility-scan-results', {
  body: JSON.stringify(results, null, 2),
  contentType: 'application/json',
});
```

## References

- [Playwright Accessibility Testing](https://playwright.dev/docs/accessibility-testing)
- [axe-core rules](https://github.com/dequelabs/axe-core/blob/master/doc/rule-descriptions.md)
