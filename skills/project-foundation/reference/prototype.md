# Prototyping a step

A prototype is **throwaway code that answers one question**. The question decides its shape, and the
question is the current roadmap step's *"Question it answers"* line — copy it in verbatim before
writing anything. A prototype that answers a different question than the step asked is a pure loss,
and it is easy to drift there once code starts flowing.

## Pick the branch

- **"Does this logic hold up?"** — state models, business rules, data shape. Build a **single
  self-contained HTML file** someone can double-click. → *Logic*, below.
- **"What should this look like?"** — layout, hierarchy, affordances. Build **several structurally
  different variants** on one route, switchable by a URL parameter. → *Visual*, below.

The two produce completely different artifacts, so getting this wrong wastes the whole prototype. If
the step's question is genuinely both, it is two steps. If it is ambiguous and the operator is not
around, follow the surrounding code — a backend module means logic, a page means visual — and say
which you assumed at the top of the prototype.

## Rules for both

1. **Throwaway from the first line, and visibly labelled.** Put it next to the code it is
   prototyping for, so the context is obvious, and name it so nobody mistakes it for production.
2. **One action to run it.** A double-click, or one command in the project's existing task runner.
   Anything that needs a README to start does not get run.
3. **In-memory state.** Persistence is what the prototype is *checking*, not what it should rely on.
   If the question genuinely is about storage, point it at a scratch store named so it is obviously
   disposable.
4. **No polish.** No tests, no abstraction, no error handling past what makes it run. Every minute
   spent on quality here is spent on code you are about to delete.
5. **Show the whole state after every action.** The thing you are trying to notice is a state you
   did not expect, and you cannot notice what is not on screen.
6. **Non-developers must be able to drive it.** Label everything in domain language — the words in
   `CONTEXT.md`, not the words in the code.

## Logic prototypes

Keep the logic itself in **one pure module** with no DOM access — a reducer, a state machine, or a
set of pure functions over a plain data type, whichever the question actually needs. The page calls
into it; nothing flows back. That purity is what lets the validated logic lift straight into the
real codebase afterwards while the page around it is discarded.

The page, top to bottom:

1. **The question**, written out in plain language where the reader lands.
2. **Current state**, as labelled fields rather than a JSON dump, re-rendered after every action.
3. **Free-play buttons** — one per action, always enabled, so anyone can poke at it in any order.
   Letting an illegal action be *attempted* is often where the model breaks.
4. **Guided walkthroughs** — a few named scenarios, each resetting to a known start, each a short
   description plus an ordered set of buttons to press. Choose the awkward cases: the edge case, the
   thing that should be refused, the sequence nobody can reason about on paper.

Plain HTML, CSS, and JS in one file. No framework, no bundler, no server — the file has to survive
being emailed to someone.

## Visual prototypes

**Prefer prototyping inside a real page.** Variants judged in an empty route all look fine; variants
sitting against the real header, real density, and real data reveal their problems immediately. Only
create a throwaway route when the thing genuinely has no existing home, and then follow the
project's routing convention with `prototype` in the path.

- **Three variants** by default. Past five they stop being alternatives and become noise.
- **Structurally different** — different layout, different information hierarchy, different primary
  action. Three versions of the same card grid in different colours is wallpaper, not a prototype.
- **Switch via a URL parameter** plus a small floating bar that cycles variants and names the
  current one. Update the URL through the project's router so a variant is shareable and survives
  reload, and gate the bar out of production builds.
- **Read-only.** Point anything that would mutate at a stub. The question is what it should look
  like.

The most useful feedback is almost always *"the header from B with the sidebar from C"* — that
recombination is the actual design, and it only becomes sayable once all three exist side by side.

## Getting a verdict

Hand over the file or the URL and let the operator drive. The moments worth having are *"wait, that
should not be possible"* and *"I assumed this worked differently"* — those are bugs in the idea,
found for the price of an afternoon.

A description of a prototype is not a prototype. Do not accept a verdict on one.

## Capture, then throw away

1. **Write the answer down** — the question, the verdict, and the reasoning — into the roadmap step
   and, if it passes the three-part test, an ADR.
2. **Lift the validated part** into the real code, properly written. Prototype code was built under
   prototype rules; promoting it directly imports every shortcut.
3. **Keep the prototype off the main branch.** Commit it to a throwaway branch and reference that
   branch from the step. It is a primary source — the thing that shows *why* the decision was made —
   and left in main it rots and misleads the next reader.
4. **Log what it deferred.** A prototype skips things by design. Each skip that would matter in the
   real version is a ledger entry with a trigger.
