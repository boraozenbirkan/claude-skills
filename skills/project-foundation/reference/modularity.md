# Modularity and scale

Shared vocabulary for designing modules, and the short list of scale decisions that are cheap now
and expensive later. Use these words exactly — in the docs, in commits, and in conversation with the
operator — so every discussion is about the same thing.

## Vocabulary

**Module** — anything with an interface and an implementation. Scale-agnostic on purpose: a
function, a class, a package, or a slice spanning several tiers. *Avoid:* unit, component, service.

**Interface** — everything a caller must know to use the module correctly. Not just the type
signature: also the invariants, the ordering constraints, the error modes, the required
configuration, and the performance characteristics. *Avoid:* API, signature — both are too narrow.

**Implementation** — what is inside.

**Seam** — a place where behaviour can be changed without editing in that place. Where a module's
interface lives. *Avoid:* boundary, which is overloaded with domain-driven design's bounded context.

**Adapter** — a concrete thing satisfying an interface at a seam. Names a role, not a substance: a
Postgres repository and an in-memory fake are both adapters.

**Depth** — how much behaviour a caller can reach per unit of interface they must learn. **Deep** =
a lot of behaviour behind a small interface. **Shallow** = an interface nearly as complex as the
implementation it hides.

**Leverage** — what callers get from depth: one implementation paying back across every call site.

**Locality** — what maintainers get from depth: changes, bugs, and verification concentrate in one
place. Fix once, fixed everywhere.

## Design deep

```
┌──────────────────────┐        ┌────────────────────────────────────┐
│    small interface   │        │        large interface             │
├──────────────────────┤        ├────────────────────────────────────┤
│                      │        │  thin implementation               │
│  deep implementation │        └────────────────────────────────────┘
│                      │                    shallow — avoid
└──────────────────────┘
        deep — aim here
```

When designing an interface: can it expose fewer operations? Can the parameters be simpler? Can more
of the complexity move inside?

## Four tests

**The deletion test.** Imagine deleting the module. If complexity vanishes with it, it was a
pass-through. If the same complexity reappears across every caller, it was earning its keep.

**Two adapters, or no seam.** One adapter is a hypothetical seam. Two is a real one. A seam built
for variation that never arrives is indirection paid for on every read, forever.

**The interface is the test surface.** Callers and tests cross the same seam. Wanting to test *past*
the interface means the module is the wrong shape.

**The pivot test.** Name the change you actually expect. If making it touches more than two or three
places, a seam is missing where that change lands. This is the test that connects modularity to the
roadmap: seams belong where phase 2 found uncertainty, not wherever a diagram looks tidy.

## Designing for testability

- **Accept dependencies rather than constructing them.** `processOrder(order, gateway)` is testable;
  a `processOrder` that news up a Stripe client is not.
- **Return results rather than mutating.** A function returning a `Discount` can be tested; one that
  silently adjusts a cart cannot, without inspecting the cart.
- **Keep the surface small.** Fewer operations means fewer tests; fewer parameters means simpler
  setup.

A module that is awkward to test is telling you about its shape, not about testing.

## Modularity is not file count

Splitting a file in half produces two shallow modules and one more import. What makes a codebase
easy to change is that **the change you expect is confined to one place** — which is a claim about
seams, not about file sizes.

Depth is a property of the interface, never of the implementation. A deep module can be internally
composed of small swappable parts; they simply are not part of what callers must learn.

## The scale decisions worth making before you need them

Everything else about scale is a ledger entry with a measured trigger. These few are cheap now and
expensive later:

**Index what you filter, sort, and join on.** Every foreign key, and every column in a `where` or
`order by` on a table that grows. Invisible at 100 rows, pathological at 100,000 — and the query
that falls over is the one on the busiest page. Composite indexes must match the query's column
order to be used at all.

**Never fetch inside a loop.** Per-item fetching turns one page render into N+1 round trips. Batch
it: one query with a join, or one query per level with an `in (...)`, stitched in memory. This is
the most common reason something is fine in development with three rows and slow in production with
three thousand.

**Paginate anything unbounded, in its first version.** Adding pagination later changes the API shape,
the client, and every caller at once.

**Decide caching per route, deliberately** — static, revalidated, or dynamic — and know what
invalidates each cached thing. A cached page whose invalidation path was never built serves stale
data indefinitely, and it presents as a data bug rather than a caching bug.

**Push slow work out of the request.** Email, third-party calls, image processing, report
generation. A user should never wait on a service you do not control.
