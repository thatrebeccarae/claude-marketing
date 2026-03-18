# React Best Practices — Examples

## Example 1: Audit Component Performance

### Prompt

> Review this React component for performance issues:
> ```tsx
> import { icons } from "lucide-react"
> const Dashboard = async () => {
>   const user = await fetchUser()
>   const posts = await fetchPosts(user.id)
>   const comments = await fetchComments(user.id)
>   return <DashboardView user={user} posts={posts} comments={comments} />
> }
> ```

### What the skill identifies

1. **CRITICAL — Sequential awaits**: `fetchPosts` and `fetchComments` are independent but sequential. Fix: `Promise.all([fetchPosts(user.id), fetchComments(user.id)])`
2. **CRITICAL — Barrel import**: `import { icons } from "lucide-react"` loads the entire icon library. Fix: `import DashboardIcon from "lucide-react/dist/esm/icons/layout-dashboard"`
3. **HIGH — No Suspense boundary**: The entire component blocks until all data loads. Fix: Wrap independent sections in `<Suspense>` with fallbacks.

---

## Example 2: Optimize Data Fetching

### Prompt

> This page loads slowly because it fetches data sequentially. Help me parallelize it.

### What the skill does

1. Identifies the waterfall chain in the component tree
2. Restructures with `Promise.all()` for independent fetches
3. Adds `<Suspense>` boundaries to stream content progressively
4. Uses `React.cache()` for per-request deduplication

---

## Example 3: Reduce Bundle Size

### Prompt

> Our Next.js app has a 2MB initial bundle. Help me identify what is inflating it.

### What the skill does

1. Checks for barrel file imports (common 500KB+ waste)
2. Identifies heavy components that should be `dynamic()` imports
3. Finds third-party libraries loaded in the critical path
4. Suggests `next/dynamic` with `ssr: false` for client-only components
5. Recommends direct imports: `date-fns/format` instead of `date-fns`
