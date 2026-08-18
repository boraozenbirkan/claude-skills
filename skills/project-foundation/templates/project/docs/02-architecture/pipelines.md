> **Audience:** engineers · **Status:** current · **Owner:** agents

# Pipelines

What happens between a user acting and the result landing. This is the page to read to answer
**"where does my change go?"**

Written as stages and data, not as functions. Function names go stale in a week; stages survive a
rewrite.

## Main pipeline — {{name}}

The path the core loop takes.

| # | Stage | In | Out | Lives in | Notes |
|---|---|---|---|---|---|
| 1 | {{stage}} | {{what arrives}} | {{what leaves}} | `{{path}}` | {{constraint, or where it can fail}} |
| 2 | {{stage}} | {{...}} | {{...}} | `{{path}}` | {{...}} |
| 3 | {{stage}} | {{...}} | {{...}} | `{{path}}` | {{...}} |

**Where it can fail, and what the user sees:** {{per stage, briefly. The failure paths are the part
nobody documents and everybody needs.}}

**Where it is asynchronous:** {{which stages are queued, scheduled, or event-driven — and what
happens to the user while they wait.}}

## Sub-pipeline — {{name}}

{{Stage N of the main pipeline, expanded. Add one section per stage complex enough to have its own
internal steps.}}

**Entered from:** {{main pipeline stage N}}
**Returns:** {{what, to where}}

| # | Step | In | Out | Lives in |
|---|---|---|---|---|
| 1 | {{...}} | {{...}} | {{...}} | `{{path}}` |

## Sub-pipeline — {{name}}

{{...}}

## Not yet built

Stages that are designed and do not exist. Mark each `Status: pending` so nobody reads a plan as a
description of the code.

- **{{stage}}** — {{what it will do}} · planned for {{step N}}

<!--
Keep this page honest by keeping it coarse. A stage is worth a row when a reader needs to know it
exists to find their way; a row per function turns this into a second, worse copy of the codebase
that is wrong within a fortnight.

If a change adds a stage, reorders stages, or moves work into a queue or a job, this page is part of
that change.
-->
