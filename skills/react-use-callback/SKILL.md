---
name: react-use-callback
description: Decide when to use React useCallback. Use when callback identity affects memoized children, dependency arrays, custom hooks, event handlers passed through props, or unnecessary re-renders. Avoid defaulting to useCallback for every function. For state update correctness use react-use-state; for effect dependency alternatives use react-useeffect-avoid.
---

# React useCallback

## When to use

- Passing callbacks to memoized children.
- Returning functions from custom hooks.
- Keeping a function dependency stable for an effect.
- Debugging avoidable renders caused by changing function references.

## Goal

Use `useCallback` only for needed function identity stability.
Do not add it by default.

## Rules

- Use with `memo()` children when callback identity matters.
- Wrap functions returned from custom hooks.
- Prefer moving effect-only functions inside the effect.
- Use updater functions to remove state dependencies.
- Keep dependency arrays complete.
- Do not use inside loops.
- Do not use when the child is not memoized.
- Do not use for simple interactions without evidence.

## Good Uses

Memoized child:

```jsx
const handleClick = useCallback(() => {
  trackClick(productId);
}, [productId]);
```

Custom hook return value:

```jsx
const navigate = useCallback((url) => {
  dispatch({ type: "navigate", url });
}, [dispatch]);
```

Updater dependency reduction:

```jsx
const handleAddTodo = useCallback((text) => {
  setTodos((todos) => [...todos, { id: nextId++, text }]);
}, []);
```

## Prefer Restructure

- Move effect-only helpers inside the effect.
- Keep state local before memoizing props.
- Accept JSX as `children` when wrapper state should not rerender children.
- Extract loop items into components instead of calling hooks in loops.

## Debug

- Confirm child is wrapped in `memo()`.
- Log dependency arrays across renders.
- Check unstable object or array dependencies.
- Remove unnecessary lifted state before adding memoization.

## References

- [React Docs - useCallback](https://react.dev/reference/react/useCallback)
- [React Docs - memo](https://react.dev/reference/react/memo)
- [React Docs - useMemo](https://react.dev/reference/react/useMemo)

## Output

- Keep, add, or remove `useCallback`.
- Reason tied to identity stability.
- Complete dependency array.
- Simpler restructure when better than memoization.
