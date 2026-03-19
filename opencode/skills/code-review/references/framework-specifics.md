# Framework-Specific Patterns

Expert knowledge of framework patterns, anti-patterns, and advanced techniques for Next.js, React, TypeScript, and testing.

## Next.js 14+ App Router

### Server Components vs Client Components

**Default: Server Components**

Server Components are the default in App Router. They run only on the server and don't ship JavaScript to the client.

**Use Server Components for:**
- Data fetching from databases or APIs
- Accessing backend resources (file system, environment variables)
- Keeping sensitive information on server (API keys, tokens)
- Large dependencies that don't need to be on client
- Static or mostly static content

**Benefits:**
- Zero JavaScript bundle size for the component
- Direct database/API access
- Can use server-only code
- Better performance for users

**Use Client Components only when you need:**
- React hooks (useState, useEffect, useReducer, etc.)
- Browser APIs (window, localStorage, navigator, etc.)
- Event handlers (onClick, onChange, onSubmit, etc.)
- React Context consumers (useContext)
- Custom hooks that use the above

**Common mistake:**
```typescript
// ❌ BAD: Unnecessary 'use client'
'use client';

export default function BlogPost({ post }: { post: Post }) {
  return (
    <article>
      <h1>{post.title}</h1>
      <p>{post.content}</p>
    </article>
  );
}
// This is purely presentational, no hooks or events - should be Server Component
```

**Correct approach:**
```typescript
// ✅ GOOD: Server Component (default)
export default function BlogPost({ post }: { post: Post }) {
  return (
    <article>
      <h1>{post.title}</h1>
      <p>{post.content}</p>
    </article>
  );
}

// ✅ GOOD: Extract interactive part to Client Component
'use client';

export function LikeButton({ postId }: { postId: string }) {
  const [liked, setLiked] = useState(false);
  
  return (
    <button onClick={() => setLiked(!liked)}>
      {liked ? 'Unlike' : 'Like'}
    </button>
  );
}
```

### Data Fetching Patterns

**Server Components (Preferred):**

```typescript
// ✅ GOOD: Async Server Component
export default async function PostsPage() {
  // Fetch directly in component
  const posts = await db.post.findMany();
  
  return (
    <div>
      {posts.map(post => (
        <PostCard key={post.id} post={post} />
      ))}
    </div>
  );
}
```

**Parallel Data Fetching:**
```typescript
// ✅ GOOD: Parallel requests
async function getUser(id: string) {
  return await db.user.findUnique({ where: { id } });
}

async function getPosts(userId: string) {
  return await db.post.findMany({ where: { userId } });
}

export default async function UserProfile({ params }: { params: { id: string } }) {
  // Fetch in parallel, not sequentially
  const [user, posts] = await Promise.all([
    getUser(params.id),
    getPosts(params.id)
  ]);
  
  return <div>...</div>;
}
```

**Route Handlers for API endpoints:**
```typescript
// app/api/posts/route.ts
export async function GET(request: Request) {
  const posts = await db.post.findMany();
  return Response.json(posts);
}

export async function POST(request: Request) {
  const body = await request.json();
  const post = await db.post.create({ data: body });
  return Response.json(post, { status: 201 });
}
```

**Server Actions for mutations:**
```typescript
// app/actions.ts
'use server';

export async function createPost(formData: FormData) {
  const title = formData.get('title');
  const content = formData.get('content');
  
  const post = await db.post.create({
    data: { title, content }
  });
  
  revalidatePath('/posts');
  return { success: true, post };
}
```

**Anti-patterns:**
```typescript
// ❌ BAD: Using Pages Router APIs in App Router
export async function getServerSideProps() {
  // This doesn't work in App Router!
}

export async function getStaticProps() {
  // This doesn't work in App Router!
}

// ❌ BAD: Fetching in Client Component
'use client';
export default function Posts() {
  const [posts, setPosts] = useState([]);
  
  useEffect(() => {
    fetch('/api/posts')
      .then(r => r.json())
      .then(setPosts);
  }, []);
  // Should use Server Component with direct database access instead
}
```

### Environment Variables

**Critical distinction:**

```typescript
// ❌ BAD: Server secret with NEXT_PUBLIC prefix
const apiKey = process.env.NEXT_PUBLIC_OPENAI_KEY; 
// This will be EXPOSED to browser! Anyone can see it in bundle.

// ✅ GOOD: Server-only secret (no prefix)
const apiKey = process.env.OPENAI_API_KEY;
// Only accessible on server, never sent to client.

// ✅ GOOD: Actually public value
const publicUrl = process.env.NEXT_PUBLIC_API_URL;
// Intentionally public, used in client-side code.
```

**Rule**: Only use `NEXT_PUBLIC_` prefix for values you want exposed to the browser.

### Metadata API

**Instead of `<Head>` from Pages Router:**

```typescript
// ✅ GOOD: Metadata API
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'My App',
  description: 'Description of my app',
  openGraph: {
    title: 'My App',
    description: 'Description',
    images: [{ url: '/og-image.jpg' }],
  },
};

export default function Page() {
  return <div>Content</div>;
}
```

**Dynamic metadata:**
```typescript
export async function generateMetadata(
  { params }: { params: { id: string } }
): Promise<Metadata> {
  const post = await db.post.findUnique({ where: { id: params.id } });
  
  return {
    title: post.title,
    description: post.excerpt,
  };
}
```

### Loading & Error States

**Loading UI:**
```typescript
// app/posts/loading.tsx
export default function Loading() {
  return <Spinner />;
}

// Or use Suspense boundaries
<Suspense fallback={<Spinner />}>
  <Posts />
</Suspense>
```

**Error handling:**
```typescript
// app/posts/error.tsx
'use client'; // Error boundaries must be Client Components

export default function Error({
  error,
  reset,
}: {
  error: Error;
  reset: () => void;
}) {
  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={reset}>Try again</button>
    </div>
  );
}
```

---

## React Best Practices

### Hook Dependency Arrays

**The rule:** Include ALL values from component scope that are used inside the effect.

**Common mistakes:**

```typescript
// ❌ BAD: Missing dependency
useEffect(() => {
  fetchData(userId); // userId is used but not in deps
}, []); // Will fetch with stale userId

// ✅ GOOD: Include all dependencies
useEffect(() => {
  fetchData(userId);
}, [userId]);

// ❌ BAD: Unnecessary dependency causes infinite loop
useEffect(() => {
  setData(computeExpensiveValue(input)); // setData causes rerender
}, [input, data]); // data changes, triggers effect, updates data, infinite loop

// ✅ GOOD: Only include input, not data
useEffect(() => {
  setData(computeExpensiveValue(input));
}, [input]);
```

**Functions as dependencies:**

```typescript
// ❌ BAD: Function recreated every render
function Component({ userId }) {
  const fetchUser = () => {
    return fetch(`/api/users/${userId}`);
  };
  
  useEffect(() => {
    fetchUser();
  }, [fetchUser]); // fetchUser is new every render, causes effect to run every render
}

// ✅ GOOD: Memoize function
function Component({ userId }) {
  const fetchUser = useCallback(() => {
    return fetch(`/api/users/${userId}`);
  }, [userId]);
  
  useEffect(() => {
    fetchUser();
  }, [fetchUser]); // Now stable
}

// ✅ BETTER: Include userId directly
function Component({ userId }) {
  useEffect(() => {
    fetch(`/api/users/${userId}`);
  }, [userId]); // No need for separate function
}
```

### Effect Cleanup

**Always cleanup subscriptions, timers, and listeners:**

```typescript
// ✅ GOOD: Cleanup pattern
useEffect(() => {
  const timer = setTimeout(() => {
    console.log('Delayed action');
  }, 1000);
  
  return () => clearTimeout(timer); // Cleanup
}, []);

// ✅ GOOD: Cleanup fetch with AbortController
useEffect(() => {
  const controller = new AbortController();
  
  fetch('/api/data', { signal: controller.signal })
    .then(r => r.json())
    .then(setData)
    .catch(error => {
      if (error.name !== 'AbortError') {
        console.error(error);
      }
    });
  
  return () => controller.abort(); // Cancel fetch on unmount
}, []);

// ✅ GOOD: Cleanup event listener
useEffect(() => {
  const handleResize = () => setWidth(window.innerWidth);
  
  window.addEventListener('resize', handleResize);
  return () => window.removeEventListener('resize', handleResize);
}, []);
```

### State Management Patterns

**Lifting state:**

```typescript
// ❌ BAD: Duplicated state in siblings
function Parent() {
  return (
    <>
      <ChildA /> {/* Has its own count state */}
      <ChildB /> {/* Has its own count state */}
    </>
  );
}

// ✅ GOOD: Lift state to parent
function Parent() {
  const [count, setCount] = useState(0);
  
  return (
    <>
      <ChildA count={count} setCount={setCount} />
      <ChildB count={count} setCount={setCount} />
    </>
  );
}
```

**Derived state (don't use useState for values you can calculate):**

```typescript
// ❌ BAD: Duplicating state
const [items, setItems] = useState([]);
const [itemCount, setItemCount] = useState(0);

// Need to update both! Easy to get out of sync.

// ✅ GOOD: Derive from single source
const [items, setItems] = useState([]);
const itemCount = items.length; // Always in sync
```

### Component Composition

**Prop drilling vs Context:**

```typescript
// ❌ BAD: Excessive prop drilling
<Layout user={user}>
  <Sidebar user={user}>
    <Menu user={user}>
      <UserAvatar user={user} />
    </Menu>
  </Sidebar>
</Layout>

// ✅ GOOD: Use Context for widely-used values
const UserContext = createContext<User | null>(null);

<UserContext.Provider value={user}>
  <Layout>
    <Sidebar>
      <Menu>
        <UserAvatar /> {/* Gets user from context */}
      </Menu>
    </Sidebar>
  </Layout>
</UserContext.Provider>
```

---

## TypeScript Advanced Patterns

### Never Use `any`

```typescript
// ❌ BAD: Defeats TypeScript
function process(data: any) {
  return data.map((item: any) => item.value);
}

// ✅ GOOD: Use unknown with type guards
function process(data: unknown) {
  if (!Array.isArray(data)) {
    throw new Error('Expected array');
  }
  
  return data.map(item => {
    if (typeof item === 'object' && item !== null && 'value' in item) {
      return item.value;
    }
    throw new Error('Invalid item shape');
  });
}

// ✅ BETTER: Define proper types
interface DataItem {
  value: string;
  id: number;
}

function process(data: DataItem[]): string[] {
  return data.map(item => item.value);
}
```

### Type Guards

```typescript
// ✅ GOOD: Type guard function
function isUser(value: unknown): value is User {
  return (
    typeof value === 'object' &&
    value !== null &&
    'id' in value &&
    'email' in value
  );
}

// Usage
function handleData(data: unknown) {
  if (isUser(data)) {
    // TypeScript knows data is User here
    console.log(data.email);
  }
}
```

### Discriminated Unions

```typescript
// ✅ GOOD: Discriminated union
type Result<T> =
  | { success: true; data: T }
  | { success: false; error: string };

function handleResult<T>(result: Result<T>) {
  if (result.success) {
    // TypeScript knows result.data exists
    console.log(result.data);
  } else {
    // TypeScript knows result.error exists
    console.error(result.error);
  }
}

// ❌ BAD: Optional props instead
type Result<T> = {
  success: boolean;
  data?: T;
  error?: string;
};
// Now both data and error could be undefined, less type safety
```

### Generic Constraints

```typescript
// ✅ GOOD: Constrained generic
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}

const user = { name: 'John', age: 30 };
const name = getProperty(user, 'name'); // Type: string
const age = getProperty(user, 'age');   // Type: number
// getProperty(user, 'invalid'); // TypeScript error!
```

### Utility Types

```typescript
// Pick: Select specific properties
type UserPreview = Pick<User, 'id' | 'name' | 'email'>;

// Omit: Remove specific properties
type UserWithoutPassword = Omit<User, 'password'>;

// Partial: Make all properties optional
type PartialUser = Partial<User>;

// Required: Make all properties required
type RequiredUser = Required<User>;

// Readonly: Make all properties readonly
type ImmutableUser = Readonly<User>;

// Record: Create object type with specific keys
type UserRoles = Record<string, 'admin' | 'user' | 'guest'>;
```

---

## Testing Best Practices

### Query Selection Priority

**Always prefer accessible queries:**

```typescript
// 1. getByRole (BEST - most accessible)
screen.getByRole('button', { name: 'Submit' });
screen.getByRole('textbox', { name: 'Email' });
screen.getByRole('heading', { level: 1 });

// 2. getByLabelText (for form fields)
screen.getByLabelText('Email address');

// 3. getByPlaceholderText
screen.getByPlaceholderText('Enter email...');

// 4. getByText
screen.getByText('Welcome back!');

// 5. getByTestId (LAST RESORT)
screen.getByTestId('submit-button');
```

### User-Event Over FireEvent

```typescript
// ❌ BAD: fireEvent
import { fireEvent } from '@testing-library/react';

fireEvent.click(button);
fireEvent.change(input, { target: { value: 'test' } });

// ✅ GOOD: user-event (simulates real user interactions)
import { userEvent } from '@testing-library/user-event';

const user = userEvent.setup();
await user.click(button);
await user.type(input, 'test');
```

### AAA Pattern

```typescript
it('submits form with valid data', async () => {
  // Arrange
  const user = userEvent.setup();
  const onSubmit = jest.fn();
  render(<Form onSubmit={onSubmit} />);
  
  // Act
  await user.type(screen.getByLabelText('Email'), 'test@example.com');
  await user.type(screen.getByLabelText('Password'), 'password123');
  await user.click(screen.getByRole('button', { name: 'Submit' }));
  
  // Assert
  expect(onSubmit).toHaveBeenCalledWith({
    email: 'test@example.com',
    password: 'password123',
  });
});
```

### Mock External Dependencies Only

```typescript
// ✅ GOOD: Mock external API
import { rest } from 'msw';
import { setupServer } from 'msw/node';

const server = setupServer(
  rest.get('/api/users', (req, res, ctx) => {
    return res(ctx.json([{ id: 1, name: 'John' }]));
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

// ❌ BAD: Mocking internal functions
jest.mock('./userService'); // Don't mock your own code, test it!
```

### Test Behavior, Not Implementation

```typescript
// ❌ BAD: Testing implementation details
expect(component.state.isLoading).toBe(false);
expect(mockFunction).toHaveBeenCalledTimes(1);

// ✅ GOOD: Testing user-visible behavior
expect(screen.queryByText('Loading...')).not.toBeInTheDocument();
expect(screen.getByText('Data loaded')).toBeInTheDocument();
```
