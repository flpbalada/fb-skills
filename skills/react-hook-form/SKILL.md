---
name: react-hook-form
description: Guides React Hook Form usage for React forms. Use this skill when creating or refactoring forms with useForm, register, handleSubmit, formState errors, validation rules, defaultValues, Controller, useController, FormProvider, useFieldArray, resolvers such as Zod, or TypeScript form types.
---

# React Hook Form

## When to use

- Creating or refactoring React forms.
- Using `useForm`, `register`, `handleSubmit`, or `formState`.
- Adding validation, schema resolvers, or typed form values.
- Integrating UI-library inputs with `Controller`.
- Building repeatable fields with `useFieldArray`.

## Goal

Use React Hook Form's uncontrolled-first model.
Prefer native inputs with `register`.
Use `Controller` only when a component cannot expose normal input props.

## Rules

- Use `useForm<FormValues>()` near the form boundary.
- Set `defaultValues` for every editable field.
- Use `register` for native inputs and ref-forwarding custom inputs.
- Use `Controller` for controlled third-party inputs.
- Use `useController` for reusable field components.
- Use `FormProvider` and `useFormContext` for large nested forms.
- Use `useFieldArray` for repeatable rows.
- Use a resolver for shared schema validation.
- Use `reset(newValues)` when loaded data becomes the clean baseline.
- Use `useWatch` only when one component needs another field value.
- Do not pass both `register` and `Controller` to one field.
- Do not mirror every input with local `useState`.

## Flow

1. Inspect existing form conventions.
2. Define or infer `FormValues`.
3. Add `useForm<FormValues>()` with defaults.
4. Register fields.
5. Add validation rules or resolver.
6. Render `formState.errors`.
7. Submit with `handleSubmit(onSubmit)`.

## Pattern

```tsx
type FormValues = { email: string };

const {
  register,
  handleSubmit,
  formState: { errors },
} = useForm<FormValues>({ defaultValues: { email: "" } });

return (
  <form onSubmit={handleSubmit(save)}>
    <input {...register("email", { required: "Email is required" })} />
    {errors.email?.message ? <p role="alert">{errors.email.message}</p> : null}
    <button type="submit">Save</button>
  </form>
);
```

## Controlled Inputs

Use `Controller` for MUI fields, React Select, date pickers, masked inputs, or custom controlled components.
Pass `field.value`, `field.onChange`, `field.onBlur`, and `field.ref`.
Use `fieldState` for field-level errors.

## Schema Validation

Prefer Zod or existing project schema tooling for complex forms.
Infer `FormValues` from the schema.
Use schema coercion or `valueAsNumber` for non-string values.

## Output

- Typed form values.
- Default values for each field.
- Field validation near rules or schema.
- User-safe validation messages.
- Clear submit path.

## Reference

Read `references/patterns.md` for controlled inputs, nested forms, repeatable fields, async defaults, resolvers, or typed reusable fields.
