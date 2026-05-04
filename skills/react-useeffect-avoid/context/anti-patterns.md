# React useEffect Anti-Patterns

Detailed examples of when NOT to use useEffect and better alternatives.

## 1. Calculating Derived State

**Problem:** Computing state from other state using `useEffect` causes unnecessary double-renders.

```jsx
// ❌ BAD: Double render cycle
function FilteredList({ items }) {
  const [query, setQuery] = useState('');
  const [filtered, setFiltered] = useState([]);

  useEffect(() => {
    setFiltered(items.filter(item => item.name.includes(query)));
  }, [items, query]); // Renders twice on every input

  return <ul>{filtered.map(item => <li key={item.id}>{item.name}</li>)}</ul>;
}
```

**✅ Solution:** Calculate during render.

```jsx
// ✅ GOOD: Single render, no effect needed
function FilteredList({ items }) {
  const [query, setQuery] = useState('');

  // Calculated every render - no state, no effect
  const filtered = items.filter(item => item.name.includes(query));

  return <ul>{filtered.map(item => <li key={item.id}>{item.name}</li>)}</ul>;
}
```

**Why it's better:**
- Immediate feedback UI updates (no double render pause)
- Simpler mental model: what you see is what you get
- No dependency array to manage
- React can optimize calculations via memoization when needed

## 2. Resetting State When a Prop Changes

**Problem:** Watching a prop change and manually resetting state causes stale data display and extra renders.

```jsx
// ❌ BAD: Shows old state briefly, then new
function UserForm({ userId }) {
  const [userName, setUserName] = useState('');
  const [email, setEmail] = useState('');

  useEffect(() => {
    setUserName('');  // First render shows old userName
    setEmail('');    // Then this effect runs to reset
  }, [userId]);      // Double render every userId change

  return (
    <form>
      <input value={userName} onChange={e => setUserName(e.target.value)} />
      <input value={email} onChange={e => setEmail(e.target.value)} />
    </form>
  );
}
```

**✅ Solution A: Key Prop (Preferred)**

```jsx
// ✅ GOOD: React tears down and rebuilds component
function App() {
  const [userId, setUserId] = useState(1);

  return (
    <div>
      <button onClick={() => setUserId(prev => prev + 1)}>Next User</button>
      {/* Different key = different component instance */}
      <UserForm key={userId} userId={userId} />
    </div>
  );
}
```

**✅ Solution B: Derived State (When you only need partial reset)**

```jsx
// ✅ GOOD: Only reset specific values, keep others
function UserForm({ userId }) {
  const [userName, setUserName] = useSyncExternalStore(
    () => ({ onSet: setUserName }), // Reset when userId changes
    { value: '' }
  );
  const [email, setEmail] = useState('');

  // Email persists, userName resets
  return <form>...</form>;
}
```

**⚠️ Caveat:** The `key` prop approach remounts the entire component. Use when you need a complete state reset. For partial resets, consider derived state patterns.

## 3. Waterfall of State Updates

**Problem:** Multiple effects triggering each other create cascading renders that are hard to debug.

```jsx
// ❌ BAD: Effects trigger effects
function OrderForm() {
  const [formData, setFormData] = useState({});
  const [validated, setValidated] = useState(false);
  const [error, setError] = useState(null);

  // Effect 1: Validate when formData changes
  useEffect(() => {
    setValidated(validateData(formData));
  }, [formData]);

  // Effect 2: Set error when validation changes
  useEffect(() => {
    setError(validated ? null : 'Invalid');
  }, [validated]);

  // Effect 3: Submit when no error
  useEffect(() => {
    if (!error && validated) submitOrder(formData);
  }, [error, validated, formData]);
}
```

**✅ Solution:** Handle all logic in event handler.

```jsx
// ✅ GOOD: One handler, one render, clear flow
function OrderForm() {
  const [formData, setFormData] = useState({});

  const handleSubmit = () => {
    // All logic happens atomically
    if (validateData(formData)) {
      submitOrder(formData);  // No intermediate states
    } else {
      setError('Invalid form');  // Set directly, no cascade
    }
  };

  return <button onClick={handleSubmit}>Submit</button>;
}
```

## 4. Fetching Data on User Action

**Problem:** Using a flag to trigger effects loses user intent and creates fragile code.

```jsx
// ❌ BAD: Intent is lost, hard to follow
function LoginForm() {
  const [username, setUsername] = useState('');
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = () => {
    setSubmitted(true);  // Just a flag, no actual logic
  };

  useEffect(() => {
    if (submitted) {
      login(username);  // What triggered this? Which submit was it?
    }
  }, [submitted, username]);
}
```

**✅ Solution:** Perform action directly in handler.

```jsx
// ✅ GOOD: Clear intent, direct action
function LoginForm() {
  const [username, setUsername] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();  // User action context preserved

    // Actual logic here, not delayed
    try {
      await login(username);
    } catch (error) {
      console.error('Login failed:', error);
    }
  };

  return <form onSubmit={handleSubmit}>...</form>;
}
```

## 5. Filtering/Transforming Lists

**Problem:** Creating filtered lists via effects causes extra renders.

```jsx
// ❌ BAD: Unnecessary effect
function ProductList({ products }) {
  const [visibleProducts, setVisibleProducts] = useState([]);

  useEffect(() => {
    setVisibleProducts(products.filter(p => p.inStock));
  }, [products]); // Runs twice whenever products change
}
```

**✅ Solution:** Filter directly during render.

```jsx
// ✅ GOOD: Immediate, single render
function ProductList({ products }) {
  const visibleProducts = products.filter(p => p.inStock);
}
```

## 6. Subscribing to Browser APIs (Without useSyncExternalStore)

**Problem:** Using `useState` + `useEffect` for external subscriptions causes "tearing" in concurrent rendering.

```jsx
// ❌ BAD: UI can show inconsistent state during concurrent updates
function WindowSize() {
  const [width, setWidth] = useState(window.innerWidth);

  useEffect(() => {
    const handleResize = () => setWidth(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);
}
```

**✅ Solution:** Use `useSyncExternalStore` for external state.

```jsx
// ✅ GOOD: Prevents tearing, single source of truth
function WindowSize() {
  const width = useSyncExternalStore(
    // Subscribe - return cleanup function
    (callback) => {
      window.addEventListener('resize', callback);
      return () => window.removeEventListener('resize', callback);
    },
    // Get snapshot
    () => window.innerWidth,
    // Server fallback
    () => 1200
  );
}
```

**Why it's better:**
- React can guarantee UI consistency even during concurrent rendering
- Single source of truth
- Built-in optimization - subscription fires only when needed

## 7. Initial Data Fetch Without Dependencies (Stale Data)

**Problem:** Empty dependency array with state inside effect causes stale bugs.

```jsx
// ❌ BAD: Id never updates, always fetches user 1
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetch(`/user/1`).then(res => res.json()).then(setUser);
  }, [ ]); // Missing userId dependency!
}
```

**✅ Solution:** Include all dependencies or use proper patterns.

```jsx
// ✅ GOOD: Correct dependencies
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetch(`/user/${userId}`).then(res => res.json()).then(setUser);
  }, [userId]); // Properly tracks changes
}
```

**Better:** Move to event-driven fetching or data libraries.

```jsx
// ✅ EVEN BETTER: No effect, just loader
function UserProfile({ userId }) {
  const user = use(userId); // React 19's use API
  // Or use React Query, SWR, etc.
}
```