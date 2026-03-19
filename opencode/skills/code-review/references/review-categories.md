# Review Categories

Comprehensive checklists for each review category. Use this as a deep reference when reviewing complex code or when you need exhaustive coverage.

## Security

Security issues can lead to data breaches, unauthorized access, and compromised systems. Always prioritize security in reviews.

### Input Validation & Sanitization

**Check for:**
- [ ] All user input is validated before use
- [ ] Validation happens on server, not just client
- [ ] Input length limits are enforced
- [ ] Special characters are properly escaped
- [ ] File uploads validate type, size, and content
- [ ] SQL queries use parameterized statements (no string concatenation)
- [ ] Command injection is prevented (no shell execution with user input)

**Red flags:**
```typescript
// ❌ BAD: No validation
const { userId } = request.body;
await db.query(`SELECT * FROM users WHERE id = ${userId}`);

// ✅ GOOD: Parameterized query
const { userId } = z.object({ userId: z.string().uuid() }).parse(request.body);
await db.query('SELECT * FROM users WHERE id = $1', [userId]);
```

### Authentication & Authorization

**Check for:**
- [ ] Authentication checks on protected routes
- [ ] Authorization verifies user has permission for action
- [ ] Session tokens are secure (httpOnly, secure, sameSite)
- [ ] JWT tokens have expiration
- [ ] Password requirements meet security standards
- [ ] Failed login attempts are rate-limited
- [ ] Sensitive operations require re-authentication

**Red flags:**
```typescript
// ❌ BAD: No auth check
export async function DELETE(request: Request) {
  const { userId } = await request.json();
  await deleteUser(userId);
}

// ✅ GOOD: Verify auth and authorization
export async function DELETE(request: Request) {
  const session = await getSession(request);
  if (!session) throw new UnauthorizedError();
  
  const { userId } = await request.json();
  if (session.userId !== userId && !session.isAdmin) {
    throw new ForbiddenError();
  }
  
  await deleteUser(userId);
}
```

### Environment Variables & Secrets

**Check for:**
- [ ] No hardcoded credentials, API keys, or tokens
- [ ] Secrets use environment variables
- [ ] Client-side code doesn't access server-only secrets
- [ ] `NEXT_PUBLIC_` prefix only for truly public values
- [ ] `.env` files are gitignored
- [ ] Production uses secret management (not .env files)

**Red flags:**
```typescript
// ❌ BAD: Hardcoded API key
const apiKey = 'sk-1234567890abcdef';

// ❌ BAD: Server secret exposed to client
const openaiKey = process.env.NEXT_PUBLIC_OPENAI_KEY; // Will leak to browser!

// ✅ GOOD: Server-only environment variable
const openaiKey = process.env.OPENAI_API_KEY; // Not prefixed, server-only
```

### Data Exposure

**Check for:**
- [ ] Error messages don't leak implementation details
- [ ] Stack traces not exposed in production
- [ ] Database errors are sanitized before sending to client
- [ ] API responses don't include internal IDs unnecessarily
- [ ] Sensitive fields (passwords, tokens) are excluded from responses

**Red flags:**
```typescript
// ❌ BAD: Exposes internal error
catch (error) {
  return Response.json({ error: error.message }); // Might leak SQL, file paths, etc.
}

// ✅ GOOD: Sanitized error message
catch (error) {
  logger.error(error); // Log full error server-side
  return Response.json({ error: 'Failed to process request' }); // Generic message to client
}
```

### XSS & CSRF Protection

**Check for:**
- [ ] User-generated content is escaped before rendering
- [ ] `dangerouslySetInnerHTML` is avoided or sanitized (use DOMPurify)
- [ ] CSRF tokens for state-changing operations
- [ ] Content-Security-Policy headers set
- [ ] External links use `rel="noopener noreferrer"`

---

## Performance

Performance issues degrade user experience and can lead to lost revenue and poor SEO.

### React Rendering Optimization

**Check for:**
- [ ] Components that rerender unnecessarily
- [ ] Missing `React.memo` for expensive pure components
- [ ] `useCallback` for functions passed to child components
- [ ] `useMemo` for expensive calculations
- [ ] Proper dependency arrays (no missing or extra deps)
- [ ] Avoid creating functions/objects inside render

**Red flags:**
```typescript
// ❌ BAD: Creates new function on every render
function Parent() {
  return <Child onClick={() => console.log('clicked')} />;
}

// ✅ GOOD: Memoized callback
function Parent() {
  const handleClick = useCallback(() => {
    console.log('clicked');
  }, []);
  return <Child onClick={handleClick} />;
}
```

**Check for derived state issues:**
```typescript
// ❌ BAD: Using useEffect for derived state
const [items, setItems] = useState([]);
const [count, setCount] = useState(0);

useEffect(() => {
  setCount(items.length); // Causes extra render!
}, [items]);

// ✅ GOOD: Calculate during render
const [items, setItems] = useState([]);
const count = items.length; // No extra render
```

### Next.js Bundle Size

**Check for:**
- [ ] Large Client Components that should be Server Components
- [ ] Missing `'use client'` boundaries (entire tree becomes client)
- [ ] Heavy libraries imported in Client Components unnecessarily
- [ ] Missing dynamic imports for large components
- [ ] Images not using `next/image` optimization

**Red flags:**
```typescript
// ❌ BAD: Large library in Client Component
'use client';
import { Chart } from 'chart.js'; // 200kb bundle!

// ✅ GOOD: Dynamic import
'use client';
import dynamic from 'next/dynamic';
const Chart = dynamic(() => import('chart.js').then(mod => mod.Chart), {
  loading: () => <Spinner />
});
```

### Database & Data Fetching

**Check for:**
- [ ] N+1 query problems (use `include` or joins)
- [ ] Missing database indexes on queried fields
- [ ] Pagination for large result sets
- [ ] Caching strategy for frequently accessed data
- [ ] Avoid fetching more data than needed (select specific fields)
- [ ] Parallel fetches when possible (`Promise.all`)

**Red flags:**
```typescript
// ❌ BAD: N+1 query
const users = await db.user.findMany();
for (const user of users) {
  user.posts = await db.post.findMany({ where: { userId: user.id } }); // N queries!
}

// ✅ GOOD: Single query with include
const users = await db.user.findMany({
  include: { posts: true } // 1 query with join
});
```

**Check for missing pagination:**
```typescript
// ❌ BAD: Fetches all records
const posts = await db.post.findMany(); // Could be millions!

// ✅ GOOD: Paginated
const posts = await db.post.findMany({
  take: 20,
  skip: page * 20,
  orderBy: { createdAt: 'desc' }
});
```

### Memory Leaks

**Check for:**
- [ ] Event listeners are cleaned up in useEffect return
- [ ] Subscriptions are unsubscribed
- [ ] Timers (setTimeout, setInterval) are cleared
- [ ] AbortController used for fetch requests in effects
- [ ] WebSocket connections are closed

**Red flags:**
```typescript
// ❌ BAD: Event listener leak
useEffect(() => {
  window.addEventListener('resize', handleResize);
  // Missing cleanup!
}, []);

// ✅ GOOD: Cleanup
useEffect(() => {
  window.addEventListener('resize', handleResize);
  return () => window.removeEventListener('resize', handleResize);
}, [handleResize]);
```

---

## Maintainability

Code that's hard to maintain leads to bugs, slow feature development, and technical debt.

### Type Safety (TypeScript)

**Check for:**
- [ ] No `any` types (use `unknown` with type guards instead)
- [ ] Explicit return types on exported functions
- [ ] Proper null/undefined handling (optional chaining, nullish coalescing)
- [ ] Interfaces or types for complex objects
- [ ] Generic types are properly constrained
- [ ] No `@ts-ignore` or `@ts-expect-error` without explanation

**Red flags:**
```typescript
// ❌ BAD: Using any
function processData(data: any) {
  return data.map((item: any) => item.value);
}

// ✅ GOOD: Proper types
interface DataItem {
  value: string;
  id: number;
}

function processData(data: DataItem[]): string[] {
  return data.map(item => item.value);
}
```

### Test Coverage

**Check for:**
- [ ] New functionality has tests
- [ ] Edge cases are tested (empty arrays, null values, errors)
- [ ] Happy path AND error paths tested
- [ ] Integration tests for critical flows
- [ ] Tests are not testing implementation details
- [ ] Tests use accessible queries (getByRole, getByLabelText)

**Red flags:**
```typescript
// ❌ BAD: Testing implementation details
expect(component.state.count).toBe(5);

// ✅ GOOD: Testing behavior
expect(screen.getByText('Count: 5')).toBeInTheDocument();
```

### Code Clarity

**Check for:**
- [ ] Variable and function names are descriptive
- [ ] Functions do one thing (single responsibility)
- [ ] Complex logic has explanatory comments
- [ ] Magic numbers are extracted to named constants
- [ ] Functions are short (generally <50 lines)
- [ ] Deep nesting is avoided (early returns)

**Red flags:**
```typescript
// ❌ BAD: Unclear naming
function calc(x: number, y: number) {
  if (x > 0) {
    if (y > 0) {
      return x * y * 0.9;
    } else {
      return x * y * 0.8;
    }
  }
  return 0;
}

// ✅ GOOD: Clear naming and early returns
const DISCOUNT_RATE_BOTH_POSITIVE = 0.9;
const DISCOUNT_RATE_DEFAULT = 0.8;

function calculateDiscountedPrice(price: number, quantity: number): number {
  if (price <= 0) return 0;
  
  const subtotal = price * quantity;
  const discountRate = quantity > 0 
    ? DISCOUNT_RATE_BOTH_POSITIVE 
    : DISCOUNT_RATE_DEFAULT;
    
  return subtotal * discountRate;
}
```

### Error Handling

**Check for:**
- [ ] Try-catch blocks around fallible operations
- [ ] Errors are logged with context
- [ ] User-facing error messages are helpful
- [ ] Error boundaries for React components
- [ ] Async errors are handled (catch on promises)
- [ ] Errors include enough context for debugging

---

## Framework-Specific Patterns

### Next.js 14+ App Router

**Check for:**
- [ ] Server Components by default, Client Components only when needed
- [ ] Data fetching in Server Components (async components)
- [ ] No `getServerSideProps` or `getStaticProps` (Pages Router API)
- [ ] `'use client'` directive only where necessary
- [ ] Proper error boundaries (`error.tsx`, `not-found.tsx`)
- [ ] Loading states (`loading.tsx` or Suspense)
- [ ] Metadata API for SEO instead of `<Head>`

**When to use "use client":**
- Need React hooks (useState, useEffect, etc.)
- Need browser APIs (window, localStorage, etc.)
- Need event handlers (onClick, onChange, etc.)
- Need React Context consumers

**Server Component by default for:**
- Data fetching from database/API
- Accessing backend resources
- Keeping sensitive information on server
- Reducing JavaScript bundle size

### React Hooks

**Check for:**
- [ ] All hooks called at top level (not in conditions/loops)
- [ ] useEffect dependency arrays are correct
- [ ] No missing dependencies (ESLint rule: exhaustive-deps)
- [ ] Cleanup functions return from effects when needed
- [ ] Custom hooks start with "use" prefix
- [ ] useState initializer is function if expensive

**Red flags:**
```typescript
// ❌ BAD: Hook in condition
if (isLoggedIn) {
  const [user, setUser] = useState(null); // BREAKS REACT!
}

// ❌ BAD: Missing dependency
useEffect(() => {
  fetchData(userId); // userId not in deps!
}, []);

// ✅ GOOD: Correct dependencies
useEffect(() => {
  fetchData(userId);
}, [userId]);
```

### TypeScript Advanced

**Check for:**
- [ ] Discriminated unions for variants instead of optional props
- [ ] Type guards for narrowing types
- [ ] Utility types (Pick, Omit, Partial) used appropriately
- [ ] No function overloads when unions suffice
- [ ] Generic types have meaningful names (T → TUser, TPost)
- [ ] Unknown instead of any, with type guards

---

## Testing Patterns

### Test Structure (AAA Pattern)

**Check for:**
- [ ] Tests follow Arrange-Act-Assert pattern
- [ ] Each test has clear phases
- [ ] Test names describe behavior, not implementation
- [ ] One assertion per test (or closely related assertions)

**Good test structure:**
```typescript
it('displays error message when login fails', async () => {
  // Arrange
  const user = userEvent.setup();
  render(<LoginForm />);
  
  // Act
  await user.type(screen.getByLabelText('Email'), 'test@example.com');
  await user.type(screen.getByLabelText('Password'), 'wrong');
  await user.click(screen.getByRole('button', { name: 'Log in' }));
  
  // Assert
  expect(screen.getByText('Invalid credentials')).toBeInTheDocument();
});
```

### Mocking Strategy

**Check for:**
- [ ] Only mock external dependencies (APIs, libraries)
- [ ] Don't mock code you own (test the real thing)
- [ ] MSW (Mock Service Worker) for API mocking
- [ ] Mock at the boundary (network, not internal functions)

### Accessible Queries

**Check for:**
- [ ] Prefer `getByRole` over `getByTestId`
- [ ] Use `getByLabelText` for form fields
- [ ] Avoid `getByTestId` unless no accessible alternative
- [ ] Tests mirror how users interact with UI

**Query priority:**
1. `getByRole` (most accessible)
2. `getByLabelText` (for forms)
3. `getByPlaceholderText`
4. `getByText`
5. `getByTestId` (last resort)

---

## Monorepo Conventions

### Package Boundaries

**Check for:**
- [ ] Packages only import from their dependencies
- [ ] No circular dependencies between packages
- [ ] Internal imports use package name (not relative paths across packages)
- [ ] Shared code is properly extracted to common package

**Red flags:**
```typescript
// ❌ BAD: Relative import across package boundary
import { utils } from '../../../other-package/src/utils';

// ✅ GOOD: Package import
import { utils } from '@myorg/other-package';
```

### Dependency Management

**Check for:**
- [ ] Shared dependencies hoisted to root package.json
- [ ] Package-specific versions only when necessary
- [ ] Workspace protocol (`workspace:*`) for internal packages
- [ ] No duplicate versions of same package

**Check with:**
```bash
# Find duplicate dependencies
npm ls <package-name>
pnpm why <package-name>
```

### Workspace-Specific Patterns

**Check for:**
- [ ] Build order respects dependencies
- [ ] Scripts use turbo/nx for task orchestration
- [ ] Each package has its own tsconfig extending root
- [ ] Consistent naming convention across packages
