---
name: react-query-server-action-errors
description: Guides handling expected Next.js Server Action errors with TanStack React Query useMutation. Use when server actions, mutationFn, onError toasts, throwOnError, QueryBoundary, ActionResult discriminated unions, translated error codes, or production-safe client error messages are involved.
---

# React Query Server Action Errors

## When to use

- Next.js Server Actions feed TanStack Query mutations.
- Expected action failures need toast or inline UI.
- Production error messages are sanitized.
- `throwOnError`, `QueryBoundary`, or error codes are involved.

## Goal

Do not throw expected user-facing errors from Server Actions.
Return typed failure data.
Throw only inside the client mutation when React Query needs an error.

## Rules

- Return `ActionResult<T, E>` from Server Actions.
- Map raw server or API failures to safe error codes.
- Keep raw backend errors server-side.
- Translate error codes on the client.
- Throw a normal client-side `Error` from `mutationFn` for expected failures.
- Handle mutation errors close to the mutation or workflow.
- Do not set global mutation `throwOnError: true`.
- Use mutation-level `throwOnError: true` only for boundary fallback UI.

## Result Type

```ts
export type ActionResult<T, E> =
  | { success: true; data: T }
  | { success: false; error: E };
```

## Flow

1. Server Action returns `ActionResult<T, ErrorCode>`.
2. Server maps raw failures to typed error codes.
3. `mutationFn` calls action.
4. If `success`, return `data`.
5. If failure, throw client-side translated `Error`.
6. `onError` shows toast or updates UI.
7. Use `throwOnError: true` only for boundary fallback.

## Pattern

```tsx
const mutation = useMutation({
  mutationFn: async (input: Input) => {
    const result = await action(input);

    if (result.success) return result.data;

    throw new Error(t(`errors.${result.error}`));
  },
  onError: (error) => toast.error(error.message),
});
```

## Avoid

- Throwing expected Server Action errors for toast messages.
- Reading production Server Action `Error.message` on the client.
- Returning raw backend errors to the browser.
- Catching and exposing all thrown server errors.
- Duplicating message strings across action and client.

## Output

- Typed action result.
- Safe error code enum or union.
- Client-side unwrap in `mutationFn`.
- Local `onError` handling.

## References

- https://joulev.dev/blogs/throwing-expected-errors-in-react-server-actions
