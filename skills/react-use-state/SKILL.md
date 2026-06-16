---
name: react-use-state
description: Use React useState for simple local component state. Use when adding UI state, inputs, counters, selected IDs, active tabs, local arrays or objects, updater functions, initializer functions, or debugging stale reads and mutation bugs. Prefer derived values, useRef, useReducer, context, or server-state libraries when state should not live in useState.
---

# React useState

## When to use

- Adding local component state.
- Handling simple UI state, form inputs, counters, and small local lists.
- Choosing between `useState`, `useReducer`, `useRef`, derived values, or shared state.
- Debugging stale updates or mutation bugs.

## Goal

Use `useState` for simple local state that should trigger re-render.
Avoid redundant state and direct mutation.

## Rules

- Call hooks at top level only.
- Keep state local when possible.
- Store only values that cannot be derived during render.
- Create new objects and arrays when updating.
- Use updater functions when next state depends on previous state.
- Use initializer functions for expensive initial values.
- Do not read state immediately after setting and expect the new value.
- Do not call `setState` unconditionally during render.

## Use When

- UI state: `isOpen`, `selectedId`, `activeTab`.
- Form state in simple forms.
- Local counters.
- Local arrays or objects with simple updates.

## Prefer Another Tool

- `useRef`: mutable value should not re-render.
- `useReducer`: multiple related values or complex transitions.
- Derived value: value can be computed from props or state.
- Context or external store: state is shared broadly.
- TanStack Query or similar: server data and async cache.

## Patterns

```jsx
const [count, setCount] = useState(0);
setCount((count) => count + 1);
```

```jsx
const [todos, setTodos] = useState(createInitialTodos);
```

```jsx
const fullName = `${firstName} ${lastName}`;
```

```jsx
setObj({ ...obj, x: 10 });
setArr([...arr, item]);
```

## Reset State

```jsx
<Form key={version} />
```

## Function Values

```jsx
const [fn, setFn] = useState(() => someFunction);
setFn(() => newFunction);
```

## References

- [React Docs - useState](https://react.dev/reference/react/useState)
- [React Docs - State as a Snapshot](https://react.dev/learn/state-as-a-snapshot)
- [React Docs - Choosing the State Structure](https://react.dev/learn/choosing-the-state-structure)

## Output

- State choice.
- Simpler alternative when `useState` is wrong.
- Immutable update path.
- Updater function when needed.
