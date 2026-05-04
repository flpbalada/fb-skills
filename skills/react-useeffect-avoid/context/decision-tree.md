# useEffect Decision Tree and Quick Reference

## Decision Tree: useEffect vs Alternatives

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

## ❌ Don't use useEffect for:

| Scenario | Problem | Alternative |
|----------|---------|-------------|
| **Derived state** | Double render | Calculate during render |
| **State resets** | Stale data | Use `key` prop |
| **User actions** | Lost intent | Event handlers |
| **List filtering** | Extra renders | Filter in render |
| **Browser APIs** | Tearing bugs (concurrent) | `useSyncExternalStore` |
| **Form submission** | Fragile flag pattern | Direct async handler |
| **Data fetching** | Manual cache management | React Query, SWR, Suspense |

## ✅ DO use useEffect for:

- Subscribing to external systems (websockets, browser APIs, etc.)
- Setting up timers with cleanup
- Managing third-party library integration
- Document title changes
- Analytics/telemetry when rendering completes

## React 19: New Alternatives

React 19 introduces the `use` API for reading resources in render:

```jsx
// React 19+ - Direct resource reading
function UserProfile({ userId }) {
  const user = use(fetchUser(userId)); // Reads promise directly

  return <div>{user.name}</div>;
}
```

This eliminates many data-fetching useEffect patterns entirely.

## References and Further Reading

### Official Documentation
- [React Docs: You Might Not Need an Effect](https://react.dev/learn/you-might-not-need-an-effect)
- [React Docs: Synchronizing with Effects](https://react.dev/learn/synchronizing-with-effects)
- [React Docs: useSyncExternalStore](https://react.dev/reference/react/useSyncExternalStore)

### Articles from Senior Engineers
- [LogRocket: 15 Common useEffect Mistakes](https://blog.logrocket.com/15-common-useeffect-mistakes-react/) - Comprehensive anti-pattern catalog
- [Epic React: Myths About useEffect](https://www.epicreact.dev/myths-about-useeffect) - Kent Dodds on mental models
- [Kent Dodds: useSyncExternalStore Demystified](https://www.epicreact.dev/use-sync-external-store-demystified-for-practical-react-development-w5ac0)

### Key Principles
1. **Effects are escape hatches** - use only when stepping outside React
2. **Event-driven > Effect-driven** - prefer handlers for user actions
3. **Render-time > Effect-time** - calculate values during render
4. **Single source of truth** - avoid duplicating state in effects
5. **Concurrent-safe** - use specialized hooks for external subscriptions