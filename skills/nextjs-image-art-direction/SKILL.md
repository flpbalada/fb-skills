---
name: nextjs-image-art-direction
description: Implement Next.js image art direction with getImageProps(), picture, source, and img. Use when mobile, tablet, or desktop need different image assets, crops, focal points, compositions, or carousel media while keeping Next.js image optimization. Do not use for simple responsive sizing of the same image; use normal next/image sizes for that.
---

# Next.js Image Art Direction

Use art direction when viewport size needs different image content or crop.

## When to Use

- Mobile and desktop use different assets
- Crop, focal point, or content hierarchy changes by viewport
- Carousel has separate mobile and desktop images

## Goal

Render one correct image per viewport.
Keep Next.js image optimization.
Avoid loading unused images.

## Rules

- Use `<picture>` with `<source>` and final `<img>`.
- Use `getImageProps()` for each asset.
- Share `alt` and `sizes`.
- Make `alt` accurate for all variants.
- Order sources so first matching media query wins.
- Do not use `preload` or `loading="eager"`.
- Use `fetchPriority="high"` for LCP image when needed.
- Do not use `placeholder` with `getImageProps()`.

## Pattern

```tsx
import { getImageProps } from 'next/image'

export function HeroImage() {
  const common = { alt: 'Mountain landscape', sizes: '100vw' }
  const { props: { srcSet: desktop } } = getImageProps({
    ...common,
    src: '/hero-desktop.jpg',
    width: 1440,
    height: 875,
  })
  const { props: { srcSet: mobile, ...rest } } = getImageProps({
    ...common,
    src: '/hero-mobile.jpg',
    width: 750,
    height: 1334,
  })

  return (
    <picture>
      <source media="(min-width: 768px)" srcSet={desktop} />
      <img {...rest} style={{ width: '100%', height: 'auto' }} />
    </picture>
  )
}
```

## Flow

1. Confirm content changes, not only size.
2. Pick assets per breakpoint.
3. Define common props.
4. Generate `srcSet` per asset.
5. Put `<source>` before fallback `<img>`.
6. Test desktop, tablet, and mobile.
7. Confirm only matching image loads.

## References

- [Next.js Image Component Docs - Art Direction](https://nextjs.org/docs/pages/api-reference/components/image#art-direction)
- [MDN - Responsive Images: Art Direction](https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images#art_direction)
- [Next.js getImageProps() API](https://nextjs.org/docs/app/api-reference/components/image#getimageprops)

## Output

```md
## Art Direction Plan

Use case: [why different images are needed]
Breakpoints:
- [media query]: [asset], [width]x[height]
- fallback: [asset], [width]x[height]

Common props:
- alt: [text]
- sizes: [value]
- priority: [fetchPriority if LCP]
```
