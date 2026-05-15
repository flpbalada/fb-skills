# React Hook Form Patterns

Use these patterns after choosing React Hook Form for a real implementation.

## Contents

- Zod Resolver
- Controller
- FormProvider
- Field Arrays
- Loaded Defaults
- Watching Values
- Accessibility
- Verification

## Zod Resolver

Use schema validation when field-level rules become hard to read, when validation is shared with server code, or when form output needs parsing/coercion.

```tsx
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { z } from "zod";

const schema = z.object({
  username: z.string().min(3, "At least 3 characters"),
  email: z.string().email("Invalid email address"),
  age: z.coerce.number().min(18, "Must be 18 or older"),
});

type FormValues = z.infer<typeof schema>;

const form = useForm<FormValues>({
  resolver: zodResolver(schema),
  defaultValues: {
    username: "",
    email: "",
    age: 18,
  },
});
```

For transforms with different input and output types, force all generics:

```tsx
useForm<z.input<typeof schema>, unknown, z.output<typeof schema>>({
  resolver: zodResolver(schema),
});
```

## Controller

Use `Controller` for controlled components. Pass only the props required by the target component.

```tsx
import { Controller, useForm } from "react-hook-form";

type FormValues = {
  startDate: Date | null;
};

const { control } = useForm<FormValues>({
  defaultValues: {
    startDate: null,
  },
});

<Controller
  name="startDate"
  control={control}
  render={({ field, fieldState }) => (
    <DatePicker
      selected={field.value}
      onChange={field.onChange}
      onBlur={field.onBlur}
      aria-invalid={fieldState.invalid}
    />
  )}
/>;
```

Avoid double registration:

```tsx
// Bad
<Controller
  name="email"
  control={control}
  render={({ field }) => <input {...field} {...register("email")} />}
/>;
```

## FormProvider

Use `FormProvider` when passing form methods through many layers would couple layout components to form plumbing.

```tsx
import { FormProvider, useForm, useFormContext } from "react-hook-form";

type FormValues = {
  email: string;
};

function AccountForm() {
  const methods = useForm<FormValues>({
    defaultValues: { email: "" },
  });

  return (
    <FormProvider {...methods}>
      <form onSubmit={methods.handleSubmit(console.log)}>
        <EmailField />
      </form>
    </FormProvider>
  );
}

function EmailField() {
  const {
    register,
    formState: { errors },
  } = useFormContext<FormValues>();

  return (
    <>
      <input {...register("email", { required: "Email is required" })} />
      {errors.email?.message ? <p role="alert">{errors.email.message}</p> : null}
    </>
  );
}
```

## Field Arrays

Use `useFieldArray` for dynamic rows. Use `field.id` as key. Do not use array index as key.

```tsx
const { control, register } = useForm<FormValues>({
  defaultValues: {
    contacts: [{ email: "" }],
  },
});

const { fields, append, remove } = useFieldArray({
  control,
  name: "contacts",
});

return fields.map((field, index) => (
  <div key={field.id}>
    <input {...register(`contacts.${index}.email` as const)} />
    <button type="button" onClick={() => remove(index)}>
      Remove
    </button>
  </div>
));
```

## Loaded Defaults

Prefer setting `defaultValues` up front when data is known. When data arrives later and should become the form baseline, call `reset`.

```tsx
const form = useForm<FormValues>({
  defaultValues: {
    name: "",
  },
});

useEffect(() => {
  if (!profile) {
    return;
  }

  form.reset({
    name: profile.name,
  });
}, [form, profile]);
```

## Watching Values

Use `watch` for event handlers or simple top-level behavior. Use `useWatch` inside smaller components to avoid re-rendering the whole form.

```tsx
function CountryDependentField({ control }: { control: Control<FormValues> }) {
  const { register } = useFormContext<FormValues>();
  const country = useWatch({ control, name: "country" });

  if (country !== "CZ") {
    return null;
  }

  return <input {...register("vatId")} />;
}
```

## Accessibility

Pair fields with labels. Mark invalid fields and render errors in a way screen readers can announce.

```tsx
<label htmlFor="email">Email</label>
<input
  id="email"
  aria-invalid={errors.email ? "true" : "false"}
  aria-describedby={errors.email ? "email-error" : undefined}
  {...register("email", { required: "Email is required" })}
/>
{errors.email?.message ? (
  <p id="email-error" role="alert">
    {errors.email.message}
  </p>
) : null}
```

## Verification

After changes, run the project's lint/typecheck/build command. For user-facing forms, verify:

- valid submit path
- required field errors
- server error handling
- disabled/submitting state
- reset or cancel behavior
- keyboard and screen-reader labels
