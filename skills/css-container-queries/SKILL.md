---
name: css-container-queries
description: Apply CSS container queries for parent-size responsive components. Use when cards, widgets, panels, sidebars, forms, or component-library elements must adapt to their container width with @container, container-type, container-name, or Tailwind @container variants. Use media queries instead for page-level viewport layout, global breakpoints, or full-page composition.
---

# CSS Container Queries

Use container queries when a component should adapt to its parent size.
Use media queries for page layout.

## When to Use

- Reusable cards, widgets, forms, sidebars, or panels.
- Component appears in narrow and wide contexts.
- Internal component layout depends on available component width.
- Building component library behavior.

## Goal

Make responsive components portable.
Reduce coupling between component internals and page layout.

## Rules

- Define a container before using container variants.
- Prefer `inline-size` unless height also matters.
- Name containers when multiple containers are nearby.
- Keep container nesting shallow.
- Avoid fixed heights when content changes across breakpoints.
- Do not replace every media query with container queries.

## Examples

```css
.card-wrapper {
  container-type: inline-size;
  container-name: card;
}

@container card (min-width: 400px) {
  .card {
    display: grid;
  }
}
```

## Tailwind

```html
<div class="@container">
  <article class="grid @lg:grid-cols-2 @lg:gap-4">
    ...
  </article>
</div>
```

## Flow

1. Find component internals using viewport breakpoints.
2. Decide whether the component should adapt to parent size.
3. Add container to parent wrapper.
4. Replace internal viewport breakpoints with container variants.
5. Keep page-level media queries in layout files.
6. Test narrow, medium, and wide containers.

## Testing

- Component works in sidebar width.
- Component works in main content width.
- Component works inside grid cells.
- Content does not overflow.

## Resources

- [MDN: CSS Container Queries](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Container_Queries)
- [Tailwind: Container Queries](https://tailwindcss.com/docs/hover-focus-and-other-states#container-queries)
- [CSS Tricks: Container Queries Guide](https://css-tricks.com/a-primer-on-css-container-queries/)
- [Can I Use: Container Queries](https://caniuse.com/css-container-queries)

## Output

```md
## Container Query Review
- Component: [name]
- Use container query: [yes/no]
- Reason: [parent-size dependence]
- Changes: [container, variants, names]
- Verification: [narrow/medium/wide results]
```
