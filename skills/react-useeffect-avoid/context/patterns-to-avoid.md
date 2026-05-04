# React useEffect Patterns to Always Avoid

Common anti-patterns with useEffect that should never be used.

## 1. useEffect for DOM Manipulation (without refs)

```jsx
// BAD
function Modal() {
  useEffect(() => {
    document.body.style.overflow = 'hidden';
    return () => { document.body.style.overflow = ''; };
  }, []);
}
```

**✅ Better:** Use refs or layout effects when needed.

## 2. useEffect for Logging

```jsx
// BAD
function App({ data }) {
  useEffect(() => {
    console.log('Data changed:', data);
  }, [data]);
}
```

**✅ Better:** Log in event handler or use `React DevTools` profiling.

## 3. useEffect for Component Initialization

```jsx
// BAD
function Widget() {
  const [initialized, setInitialized] = useState(false);

  useEffect(() => {
    someLibrary.init();
    setInitialized(true);
  }, []);
}
```

**✅ Better:** Initialize outside component effect:

```jsx
// GOOD
let initialized = false;

function Widget() {
  if (!initialized) {
    someLibrary.init();
    initialized = true;
  }
}
```

Or use library-specific initialization patterns.

## 4. `void` for Fire-and-Forget

Using `void` to suppress promise warnings should be intentional, not habitual:

```jsx
// BAD - suppressing without understanding why
useEffect(() => {
  void fetchData(); // Why void here?
}, []);

// GOOD - void is appropriate for preloading
function ProductList() {
  // Preload data for potential navigation - intentional fire-and-forget
  const prefetchProduct = (id: string) => {
    void queryClient.prefetchQuery(['product', id], () => fetchProduct(id));
  };

  return (
    <ul>
      {products.map(product => (
        <li 
          key={product.id} 
          onMouseEnter={() => prefetchProduct(product.id)}
        >
          {product.name}
        </li>
      ))}
    </ul>
  );
}
```

**When `void` is appropriate:**
- Preloading/prefetching data for anticipated navigation
- Fire-and-forget logging/analytics
- Voiding promises you intentionally don't want to await

**When `void` is NOT appropriate:**
- Suppressing promise errors in event handlers (handle errors properly)
- Masking bugs where you should be awaiting

## 5. `mutateAsync` Instead of `mutate` in React Query

In React Query, `mutateAsync` returns a promise and should rarely be used:

```jsx
// BAD - unnecessary async/await with mutateAsync
const handleSubmit = async () => {
  try {
    await createMutation.mutateAsync(formData);
    toast.success('Created!');
  } catch (error) {
    toast.error('Failed');
  }
};
```

**✅ Better:** Use `mutate` with callbacks:

```jsx
// GOOD - use mutate with onSuccess/onError
const { mutate } = useMutation({
  mutationFn: createItem,
  onSuccess: () => toast.success('Created!'),
  onError: (error) => toast.error(error.message),
});

const handleSubmit = () => {
  mutate(formData);
};
```

**Why `mutate` is preferred:**
- React Query handles the promise internally
- Callbacks are cleaner and more declarative
- Avoids async/await boilerplate in handlers
- Reference: [TKDodo - Mastering Mutations](https://tkdodo.eu/blog/mastering-mutations-in-react-query#mutate-or-mutateasync)