---
name: react-key-prop
description: Choose correct React key props for lists and remounts. Use when mapping arrays, rendering dynamic lists, sorting/filtering/reordering items, debugging list state bugs, avoiding index keys, or intentionally resetting component state with a key. For general local state updates use react-use-state; for effect-based resets use react-useeffect-avoid.
---

# React Key Prop

## When to use

- Rendering arrays with `.map`.
- Debugging list state bugs.
- Adding, removing, sorting, or filtering list items.
- Rendering form rows or stateful child components.

## Goal

Give React stable item identity.
Use keys tied to data, not render position.

## Rules

- Always add `key` to rendered list items.
- Prefer unique, stable IDs from data.
- Generate missing IDs once when data is created or loaded.
- Use the same key while the same item exists.
- Do not generate keys during render.
- Do not use `Math.random()` or `Date.now()`.
- Do not use `useId()` for list keys.
- Avoid array index keys for dynamic lists.

## Good Pattern

```jsx
{todos.map((todo) => (
  <li key={todo.id}>{todo.text}</li>
))}
```

## Missing IDs

Create IDs once, before render:

```jsx
const itemsWithIds = data.map((item) => ({
  ...item,
  id: crypto.randomUUID(),
}));
```

## Index Exception

Index key is acceptable only when all are true:

- List is static.
- Items are never inserted or removed from the middle.
- Order never changes.
- Items have no internal state.

## Failure Mode

Index represents position.
When order changes, React reuses the wrong component.
Result: stale state, wrong input values, broken animations, or unexpected focus.

## References

- [React Docs - Rendering Lists](https://react.dev/learn/rendering-lists#keeping-list-items-in-order-with-key)
- [nanoid - Tiny ID generator](https://github.com/ai-cookie/nanoid)

## Output

- Stable key choice.
- Note when data lacks IDs.
- Fix for any index, random, date, or `useId` key.
