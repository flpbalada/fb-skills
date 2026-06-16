---
name: playwright-best-practices
description: Write, review, or fix resilient Playwright tests around user-visible behavior. Use for locators, web-first assertions, auto-waiting, fixtures, isolation, test data, mocks, projects, trace debugging, and flaky browser tests. For axe, WCAG, ARIA, keyboard, or accessibility-specific scans use playwright-accessibility-testing.
---

# Playwright Best Practices

Write tests around user-visible behavior.
Avoid implementation details.

## When to Use

- Writing Playwright tests
- Reviewing test changes
- Fixing flaky tests
- Choosing locators, assertions, fixtures, or projects
- Debugging browser test failures

## Goal

Create deterministic tests that act like users and fail for useful reasons.

## Rules

- Prefer user-facing locators.
- Use web-first assertions.
- Trust Playwright auto-waiting.
- Do not use fixed sleeps.
- Keep tests isolated and order-independent.
- Control test data and external services.
- Mock third-party dependencies.
- Add cross-browser projects only when risk justifies it.
- Prefer clear duplication over clever abstraction.

## Locator Order

1. `getByRole`
2. `getByLabel`
3. `getByPlaceholder`
4. `getByText`
5. `getByAltText`
6. `getByTestId`
7. Scoped `filter()` chains

Avoid CSS classes, DOM position selectors, XPath, component names, and internal state.

## Pattern

```ts
// Good
await page.getByRole('button', { name: 'Save for later' }).click()
await expect(page.getByRole('alert')).toHaveText('Saved')

// Bad
await page.locator('.buttonIcon').click()
await page.waitForTimeout(2000)
expect(await page.getByText('Saved').isVisible()).toBe(true)
```

## Flow

1. State user behavior under test.
2. Create fresh state.
3. Use user-facing locator.
4. Perform user action.
5. Assert visible result with `await expect`.
6. Debug with trace, screenshot, video, or UI mode.
7. Fix root cause.

## References

- [Playwright Best Practices](https://playwright.dev/docs/best-practices)

## Output

```md
## Playwright Test Review

Behavior tested: [user behavior]
Locator quality: [good/issues]
Assertions: [web-first / issue]
Isolation: [fresh state / shared state issue]
Flake risk:
- [risk]

Fixes:
- [change]
```
