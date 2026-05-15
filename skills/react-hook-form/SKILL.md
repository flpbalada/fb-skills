---
name: react-hook-form
description: Guides React Hook Form usage for React forms. Use this skill when creating or refactoring forms with useForm, register, handleSubmit, formState errors, validation rules, defaultValues, Controller, useController, FormProvider, useFieldArray, resolvers such as Zod, or TypeScript form types.
---

# React Hook Form

## Overview

Build forms around React Hook Form's uncontrolled-first model. Prefer native inputs with `register`; use `Controller` only when a component cannot expose a normal input ref/value pair.

## Default Path

1. Inspect existing form dependencies and conventions.
2. Use `useForm<FormValues>()` near the form boundary.
3. Set `defaultValues` for every editable field.
4. Use `register` for native inputs.
5. Read `formState.errors` for validation UI.
6. Submit with `handleSubmit(onSubmit)`.

## Choose Tool

- `register`: native inputs and simple custom inputs that forward refs.
- `Controller`: third-party controlled inputs such as selects, date pickers, masks, or UI-library fields.
- `useController`: reusable field components that need field state without render props.
- `FormProvider` and `useFormContext`: large forms split across nested components.
- `useFieldArray`: repeatable rows or nested collections.
- resolver: schema validation, shared validation, or complex cross-field rules.
- `reset`: loaded data should become the new clean baseline.
- `useWatch`: one component needs reactive access to another field value.

## Core Pattern

```tsx
import { type SubmitHandler, useForm } from "react-hook-form";

type FormValues = {
  firstName: string;
  lastName: string;
  age: number;
};

export function ProfileForm() {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<FormValues>({
    defaultValues: {
      firstName: "",
      lastName: "",
      age: 18,
    },
  });

  const onSubmit: SubmitHandler<FormValues> = async (values) => {
    await saveProfile(values);
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register("firstName", { required: "First name is required" })}
      />
      {errors.firstName?.message ? <p role="alert">{errors.firstName.message}</p> : null}

      <input {...register("lastName", { maxLength: 40 })} />

      <input
        type="number"
        {...register("age", {
          valueAsNumber: true,
          min: { value: 18, message: "Must be at least 18" },
        })}
      />
      {errors.age?.message ? <p role="alert">{errors.age.message}</p> : null}

      <button type="submit" disabled={isSubmitting}>
        Save
      </button>
    </form>
  );
}
```

## Rules

- Prefer `register` over local `useState` for form input state.
- Keep field names typed from `useForm<FormValues>()`.
- Put validation messages in rules or schema, then render `errors.field?.message`.
- Use `valueAsNumber`, `valueAsDate`, or schema coercion for non-string values.
- Do not pass both `register` and `Controller` to the same field.
- Do not create controlled React state for every input unless another library requires it.
- Call `reset(newValues)` when loaded data replaces the form's baseline values.
- Use stable `field.id` as the React `key` for `useFieldArray` rows.

## Controlled Components

Use `Controller` when integrating components such as MUI `TextField`, React Select, date pickers, masked inputs, or custom components that manage their own value.

```tsx
<Controller
  name="role"
  control={control}
  rules={{ required: "Role is required" }}
  render={({ field, fieldState }) => (
    <Select
      inputRef={field.ref}
      value={field.value}
      onChange={field.onChange}
      onBlur={field.onBlur}
      options={roleOptions}
      aria-invalid={fieldState.invalid}
    />
  )}
/>
```

Use `useController` inside reusable field components when render props would add noise.

## Schema Validation

Prefer Zod or existing project schema tooling for complex forms.

```tsx
const schema = z.object({
  email: z.string().email("Invalid email"),
  age: z.coerce.number().min(18, "Must be at least 18"),
});

type FormValues = z.infer<typeof schema>;

const form = useForm<FormValues>({
  resolver: zodResolver(schema),
});
```

## Reference

Read `references/patterns.md` when implementing controlled inputs, nested forms, repeatable fields, async defaults, schema resolvers, or typed reusable form components.
