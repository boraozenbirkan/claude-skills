> **Audience:** everyone · **Status:** current · **Owner:** agents

# Roadmap

An order of learning, not a list of features. Each step buys an answer, and the steps are ordered so
the answers that could invalidate the most work arrive first.

**Current step:** {{N — name}}
**Riskiest open assumption:** {{the thing that would hurt most to be wrong about}}

## How a step is worked

1. **Prototype** the uncertain part as throwaway code that answers the step's question and nothing
   more — `/prototype`.
2. **Get a verdict** from {{DECIDER}} on the prototype itself, not on a description of it.
3. **Build the real thing** — only the validated part, behind its seam.
4. **Update the docs the change routed to**, in the same change — `/doc-check`.
5. **Sweep the ledger** for triggers this step fired.
6. **Re-plan** the next step from what was actually learned — `/next-step`.

## Step 1 — {{name}}

**Question it answers:** {{the one thing we do not know yet}}
**Build:** {{the smallest thing that answers it}}
**Not building:** {{what a reasonable person would expect here, and why it waits}}
**Done when:** {{observable from outside — a demo someone can drive, a number, a working path}}
**Unlocks:** {{which steps this makes possible}}
**Deferred here:** {{ledger ids created}}

## Step 2 — {{name}}

**Question it answers:** {{...}}
**Build:** {{...}}
**Not building:** {{...}}
**Done when:** {{...}}
**Unlocks:** {{...}}
**Deferred here:** {{...}}

## Later — named only

Questions, not plans. Steps 1 and 2 will rewrite these, and detailing them now produces fiction that
later reads as commitment.

- **{{Step 3 name}}** — {{the question it would answer}}
- **{{Step 4 name}}** — {{the question}}

## Shipped

### Step 0 — {{name}} · {{date}}

**Answered:** {{what we learned, including the answers that were surprising}}
**Changed the plan how:** {{what this made us reorder, drop, or add}}

<!--
Rules for this page:

- Step 1 is a walking skeleton: end to end through the thinnest possible version of the main
  pipeline, every stage present and doing the least it can. Real subsystems replace fakes at their
  seams, one step at a time.
- "Not building" is the line that does the work. Without it, scope arrives silently.
- "Done when" must be observable from outside. "Auth is implemented" is not a criterion; "a new user
  can sign up, log out, and log back in" is.
- Two steps deep at full detail, no more. Everything beyond is a name and a question.
- A step whose failure would invalidate three earlier steps is in the wrong place. Move it earlier.
-->
