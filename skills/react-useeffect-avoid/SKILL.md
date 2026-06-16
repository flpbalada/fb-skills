---
name: react-useeffect-avoid
description:
  Guides when NOT to use useEffect and suggests better alternatives. Use when reviewing React code, troubleshooting performance, or considering useEffect for derived state or form resets.
---

# React: Avoid useEffect

## When to use

- Reviewing React code with `useEffect`.
- Considering an effect for derived state, event handling, or resets.
- Debugging extra renders or stale synchronization.
- Choosing between render logic, event handlers, keys, stores, or effects.

## Goal

Use `useEffect` only to sync with external systems.
Keep pure React logic in render or event handlers.

## Rules

- Use effects for subscriptions, timers, browser APIs, third-party libraries, analytics, and document title updates.
- Calculate derived state during render.
- Handle user actions in event handlers.
- Reset child state with a `key`.
- Use `useSyncExternalStore` for external stores.
- Use query libraries for server data when available.
- Do not use effects as general state management.
- Do not use effects to copy props into state unless there is a real reset model.

## Flow

1. Ask: is there an external system?
2. If yes, use effect with cleanup.
3. If derived value, calculate during render.
4. If user-triggered, use event handler.
5. If reset needed, use `key`.
6. If shared external state, use `useSyncExternalStore`.
7. If async server data, prefer existing data library.

## Alternatives

- Derived state: compute during render.
- Expensive derived state: `useMemo`.
- Form submit: async submit handler.
- Prop-based reset: key remount.
- Event side effect: event handler.
- Server data: framework loader, TanStack Query, SWR, or Suspense.

## Pattern

```tsx
useEffect(() => {
  const connection = createConnection(roomId);
  connection.connect();
  return () => connection.disconnect();
}, [roomId]);
```

## References

- `context/anti-patterns.md`: detailed effect mistakes.
- `context/patterns-to-avoid.md`: common patterns to replace.
- `context/decision-tree.md`: expanded decision guide.
- [React Docs: You Might Not Need an Effect](https://react.dev/learn/you-might-not-need-an-effect)
- [React Docs: Synchronizing with Effects](https://react.dev/learn/synchronizing-with-effects)

## Output

- Keep, remove, or replace effect.
- External system named when effect remains.
- Replacement pattern when effect is unnecessary.
