---
name: react-query-server-action-errors
description: Guides handling expected Next.js Server Action errors with TanStack React Query useMutation. Use when server actions, mutationFn, onError toasts, throwOnError, QueryBoundary, ActionResult discriminated unions, translated error codes, or production-safe client error messages are involved.
---

# React Query Server Action Errors

## Core Rule

Do not throw expected user-facing errors from Next.js Server Actions.

Return a typed result:

```ts
export type ActionResult<T, E> =
  | { success: true; data: T }
  | { success: false; error: E };
```

React sanitizes thrown Server Action error messages in production. Return expected errors as data, then unwrap them in the client mutation.

## Default Flow

1. Server Action returns `ActionResult<T, ErrorCode>`.
2. Server maps raw API/domain failures to typed error codes.
3. `mutationFn` calls action and checks `result.success`.
4. On `success: false`, `mutationFn` throws a normal client-side `Error`.
5. `useMutation({ onError })` shows toast or updates UI.
6. Use mutation-level `throwOnError: true` only when the error should reach a client `QueryBoundary`.

## Server Pattern

```ts
"use server";

export enum CartErrorCode {
  OutOfStock = "out_of_stock",
  InvalidCoupon = "invalid_coupon",
  Unknown = "unknown",
}

export async function updateCartAction(
  input: UpdateCartInput,
): Promise<ActionResult<Cart, CartErrorCode>> {
  const [error, cart] = await safeAwait(updateCart(input));

  if (!error) {
    return { success: true, data: cart };
  }

  return {
    success: false,
    error: getCartErrorCode(error),
  };
}
```

## Client Pattern

```tsx
const updateCartMutation = useMutation({
  mutationFn: async (input: UpdateCartInput) => {
    const result = await updateCartAction(input);

    if (result.success) {
      return result.data;
    }

    throw new Error(t(`cart.errors.${result.error}`));
  },
  onError: (error) => {
    toast.error(error.message);
  },
});
```

## Error Codes

Prefer stable error codes over raw messages.

- Define domain-specific enums, such as `CartErrorCode`.
- Translate codes in all supported locales.
- Keep raw API errors server-side.
- Map unknown raw failures to a generic safe code.
- Use exhaustive mapping when possible.

## React Query Config

- Do not set global mutation `throwOnError: true`.
- Do not rely on global React Query error toasts for mutations.
- Keep mutation error UX close to the mutation hook or UI workflow.
- Set `throwOnError: true` only on a specific mutation when a `QueryBoundary` should render fallback UI.

## Avoid

- Throwing expected Server Action errors for toast messages.
- Reading production Server Action `Error.message` on the client.
- Returning raw backend errors to the browser.
- Catching and exposing all thrown server errors.
- Duplicating message strings in actions and client UI.

## References

- https://joulev.dev/blogs/throwing-expected-errors-in-react-server-actions
