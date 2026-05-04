---
name: react-useeffect-avoid
description:
  Guides when NOT to use useEffect and suggests better alternatives. Use when reviewing React code, troubleshooting performance, or considering useEffect for derived state or form resets.
---

# React: When Not to Use useEffect

## Core Principle

**`useEffect` is an escape hatch for synchronizing with external systems, not a general-purpose tool for state management or event handling.**

Modern React patterns prioritize **one-way data flow** and **event-driven updates** over effect-based synchronization to avoid performance penalties and complex synchronization bugs.

## Decision Tree

```
Need to sync with external system?
├─ Yes (browser APIs, websockets, timers)
│  └─ Use useEffect
│
└─ No (pure React application logic)
   ├─ Derived state calculation?
   │  ├─ Yes → Calculate during render
   │  └─ No → Continue...
   │
   ├─ User action triggered?
   │  ├─ Yes → Use event handler
   │  └─ No → Continue...
   │
   ├─ State reset needed?
   │  ├─ Yes → Use key prop
   │  └─ No → Continue...
   │
   └─ Really need effect after re-think?
      └─ Yes → Use useState/useReducer/setState pattern
```

## Quick Reference

### ❌ Don't use useEffect for:

| Scenario | Problem | Alternative |
|----------|---------|-------------|
| **Derived state** | Double render | Calculate during render |
| **State resets** | Stale data | Use `key` prop |
| **User actions** | Lost intent | Event handlers |
| **List filtering** | Extra renders | Filter in render |
| **Browser APIs** | Tearing bugs (concurrent) | `useSyncExternalStore` |
| **Form submission** | Fragile flag pattern | Direct async handler |
| **Data fetching** | Manual cache management | React Query, SWR, Suspense |

### ✅ DO use useEffect for:

- Subscribing to external systems (websockets, browser APIs, etc.)
- Setting up timers with cleanup
- Managing third-party library integration
- Document title changes
- Analytics/telemetry when rendering completes

## React 19: New Alternatives

```jsx
// React 19+ - Direct resource reading
function UserProfile({ userId }) {
  const user = use(fetchUser(userId)); // Reads promise directly
  return <div>{user.name}</div>;
}
```

---

## Progressive Disclosure

| Topic | File | When to Use |
|-------|------|-------------|
| Anti-patterns with examples | [context/anti-patterns.md](context/anti-patterns.md) | Detailed code examples of useEffect mistakes |
| Patterns to always avoid | [context/patterns-to-avoid.md](context/patterns-to-avoid.md) | Common anti-patterns like logging, DOM manipulation |
| Decision tree & references | [context/decision-tree.md](context/decision-tree.md) | Quick lookup and further reading |

## References

- [React Docs: You Might Not Need an Effect](https://react.dev/learn/you-might-not-need-an-effect)
- [React Docs: Synchronizing with Effects](https://react.dev/learn/synchronizing-with-effects)