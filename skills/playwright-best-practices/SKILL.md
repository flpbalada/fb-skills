---
name: playwright-best-practices
description: Guides resilient Playwright test design and review. Use when writing, reviewing, or fixing Playwright tests for reliable user-focused coverage.
---

# Playwright Best Practices

## Use When

- Writing new Playwright tests
- Reviewing Playwright test changes
- Fixing flaky Playwright tests
- Choosing locators, assertions, fixtures, projects, or debug settings
- Refactoring Playwright tests toward user-visible behavior

## Do Not Use When

- Testing non-browser unit logic better covered by unit tests
- Writing tests for third-party sites or services you do not control
- Adding sleeps, retries, or larger timeouts to hide nondeterministic behavior
- Building Page Object Models before duplication or intent problems exist

## Workflow

1. Start from user behavior: what user sees, clicks, types, or expects.
2. Pick resilient locators: `getByRole`, `getByLabel`, `getByText`, `getByPlaceholder`, `getByTestId`; avoid DOM/CSS/XPath unless no user-facing option exists.
3. Assert with web-first assertions: `await expect(locator).toBeVisible()` over manual boolean checks.
4. Rely on Playwright auto-waiting. Do not add `waitForTimeout`; wait for user-visible state, URL, request, or response.
5. Keep tests isolated: each test owns page state, storage, cookies, data, and setup.
6. Use `beforeEach` and fixtures for repeated setup, not shared mutable state between tests.
7. Mock third-party dependencies and control database/test data.
8. Run across browser/device projects when the behavior must work for broad users.
9. Use traces, screenshots, videos, UI mode, and debug mode to diagnose failures; fix root cause, not symptoms.
10. Keep tests focused. One meaningful user flow per test; prefer clear duplication over clever abstraction.

## Review Checklist

- [ ] Test validates user-visible behavior, not implementation details.
- [ ] Locators use roles, labels, text, placeholders, alt text, titles, or test ids.
- [ ] No brittle selectors such as CSS classes, DOM paths, or XPath without reason.
- [ ] Assertions are awaited web-first assertions.
- [ ] No fixed sleeps or broad hard-coded timeouts unless justified.
- [ ] Tests can run independently and in any order.
- [ ] `beforeEach`/fixtures create fresh state or authenticated storage safely.
- [ ] Test data is controlled and repeatable.
- [ ] External services are mocked or contract-controlled.
- [ ] Retries/traces/screenshots/videos support debugging only; test is deterministic without them.
- [ ] POMs expose user actions and page concepts without hiding important assertions.
- [ ] Cross-browser projects exist when compatibility matters.

## Locator Rules

Prefer, in order:

1. `page.getByRole('button', { name: 'Submit' })`
2. `page.getByLabel('Email')`
3. `page.getByPlaceholder('Search')`
4. `page.getByText('Welcome')`
5. `page.getByTestId('checkout-submit')` for explicit testing contracts
6. Chained/filtered locators for scope: `page.getByRole('listitem').filter({ hasText: 'Product 2' })`

Avoid:

- CSS classes tied to styling
- DOM position selectors
- XPath
- Component names, function names, internal state, framework internals

## Good vs Bad Patterns

### User-visible locators

```ts
// Bad: style/DOM implementation detail
await page.locator('button.buttonIcon.episode-actions-later').click();

// Good: user-facing role and name
await page.getByRole('button', { name: 'Save for later' }).click();
```

### Web-first assertions

```ts
// Bad: immediate boolean, no retry
expect(await page.getByText('Welcome').isVisible()).toBe(true);

// Good: retries until condition or timeout
await expect(page.getByText('Welcome')).toBeVisible();
```

### Auto-waiting over sleeps

```ts
// Bad: slow and flaky
await page.waitForTimeout(2000);
await expect(page.getByRole('alert')).toContainText('Saved');

// Good: waits for meaningful state
await expect(page.getByRole('alert')).toHaveText('Saved');
```

### Isolated setup

```ts
// Bad: second test depends on first test's login/cart state
test('logs in', async ({ page }) => { /* ... */ });
test('checks out', async ({ page }) => { /* assumes logged in */ });

// Good: each test starts from known state
test.beforeEach(async ({ page }) => {
  await page.goto('/login');
  await page.getByLabel('Email').fill('user@example.com');
  await page.getByLabel('Passphrase').fill('valid-test-credential');
  await page.getByRole('button', { name: 'Sign in' }).click();
});
```

### Fixtures without shared mutable state

```ts
// Bad: mutable module-level state leaks between tests
let createdUserId: string;

// Good: fixture creates and cleans isolated data per test
const test = base.extend<{ user: User }>({
  user: async ({}, use) => {
    const user = await createTestUser();
    await use(user);
    await deleteTestUser(user.id);
  },
});
```

### POM only when useful

```ts
// Bad: hides intent and assertion details
await checkoutPage.doEverything();

// Good: user-level action, assertion remains readable in test
await checkoutPage.submitOrder();
await expect(page.getByRole('heading', { name: 'Order confirmed' })).toBeVisible();
```

## Config Guidance

```ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  retries: process.env.CI ? 2 : 0,
  use: {
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'webkit', use: { ...devices['Desktop Safari'] } },
  ],
});
```

Use browser projects when product risk justifies cross-browser coverage. Keep Playwright current so tests run against current browser engines.

## Debugging Guidance

- Prefer trace viewer for CI failures; configure `trace: 'on-first-retry'`, not always-on traces.
- Use UI mode, VS Code extension, or `npx playwright test --debug` for local diagnosis.
- Use codegen to discover locators, then edit for readability and user intent.
- Use retries to expose flakiness signal, not to accept flaky tests.
- If a timeout feels necessary, first look for missing assertions, uncontrolled data, unmocked third-party calls, or hidden shared state.

## References

- [Playwright Best Practices](https://playwright.dev/docs/best-practices)
