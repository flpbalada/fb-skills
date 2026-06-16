---
name: react-use-client-boundary
description:
  Guides proper usage of "use client" directive in React/Next.js. Use this skill
  when adding client components, troubleshooting Server Component errors, or
  deciding where to place the client boundary.
---

# React "use client" Boundary

## When to use

- Adding a client component in Next.js or React Server Components.
- Fixing hook, event handler, browser API, or async component errors.
- Deciding where a client boundary belongs.
- Removing redundant `"use client"` directives.

## Goal

Place the smallest useful client boundary.
Keep server components as server components.

## Rules

- `"use client"` marks an import boundary.
- All components imported below that boundary become client components.
- Add it only to files imported by a server component and needing client features.
- Do not add it to child components already inside a client boundary.
- Do not add it to pure presentational components.
- Keep data fetching in server components when possible.
- Do not pass server functions as client event handlers.

## Add It When

Add the directive when ALL of these are true:

1. Component is imported by a server component.
2. Component needs hooks, event handlers, browser APIs, or client-only libraries.

## Do Not Add It When

- Parent/importer is already a client component.
- Component only renders props.
- Component only uses `children`.
- Component can stay shared between server and client.
- The reason is "just in case".

## Flow

1. Trace the import chain upward.
2. Find first server-to-client crossing.
3. Check whether that component needs client features.
4. Put `"use client"` there.
5. Remove redundant directives below it.
6. Move async data fetching above the boundary when possible.

## Pattern

```tsx
"use client";

import { FilterDropdown } from "./filter-dropdown";

export function SearchFilters() {
  const [filters, setFilters] = useState({});
  return (
    <FilterDropdown value={filters.category} onChange={setFilters} />
  );
}

// No directive needed.
export function FilterDropdown({ value, onChange }) {
  return <select value={value} onChange={(e) => onChange(e.target.value)} />;
}
```

## Common Errors

- Hook only works in Client Components: add boundary at the hook owner or move hook lower.
- Event handlers cannot be passed from server to client: move handler into client component.
- Async not supported in Client Components: keep async data component on server and pass data down.

## References

- [React Docs: "use client"](https://react.dev/reference/rsc/use-client)
- [Next.js Discussion: Client Component Boundaries](https://github.com/vercel/next.js/discussions/46795)

## Output

- Boundary location.
- Directives to add or remove.
- Data-fetching placement.
- Any server/client prop issues.
