---
name: progressive-disclosure
description: Reveal complexity in stages so users see what they need when they need it. Use for onboarding, forms, settings, advanced options, dashboards, or dense interfaces; avoid when problem is simply too many choices, weak copy clarity, or overall task complexity.
---

# Progressive Disclosure

Show what user needs now.
Reveal more when needed.

## When to Use

- Complex onboarding
- Feature-rich interfaces
- Long forms or wizards
- Admin panels and settings
- Advanced options

## Goal

Reduce visible complexity without hiding essential work.

## Rules

- Keep primary actions visible.
- Hide only secondary or advanced options.
- Use clear reveal controls.
- Keep reveal patterns consistent.
- Remember user preference when useful.
- Provide search for deep settings.
- Test with new and experienced users.

## Levels

- Level 0: essential, always visible.
- Level 1: important, one action away.
- Level 2: useful but less common.
- Level 3: advanced, intentionally deeper.

## Patterns

- Expand section for extra fields.
- Tooltip for short help.
- Drawer or modal for sub-flow.
- Tabs for peer categories.
- More menu for secondary actions.
- Wizard for multi-step setup.

## Flow

1. Inventory visible elements.
2. Mark user need and frequency.
3. Keep essential frequent items visible.
4. Move contextual items one action away.
5. Move rare advanced items deeper.
6. Add clear trigger labels or icons.
7. Test task completion and findability.

## Resources

- [Progressive Disclosure - Nielsen Norman Group](https://www.nngroup.com/articles/progressive-disclosure/)
- [Designing Web Interfaces - Bill Scott](https://www.amazon.com/Designing-Web-Interfaces-Principles-Interactions/dp/0596516258)

## Output

```md
## Progressive Disclosure Plan

Interface: [name]

Level 0:
- [element]

Level 1:
- Trigger: [control]
- Reveals: [elements]

Level 2+:
- Trigger: [control]
- Reveals: [elements]

Metrics:
- Task completion: [target]
- Time to complete: [target]
- Support tickets/confusion: [target]
```

## Checks

- Primary task works without expansion.
- Advanced feature can be found.
- Reveal affordance is obvious.
