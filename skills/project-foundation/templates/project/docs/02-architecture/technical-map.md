> **Audience:** engineers · **Status:** current · **Owner:** agents

# Technical map

The orientation page. What the system is made of and where to find each part.

## Stack

| Layer | Choice | Why this one |
|---|---|---|
| {{Runtime}} | {{...}} | {{the reason, or the ADR that holds it}} |
| {{Framework}} | {{...}} | {{...}} |
| {{Data store}} | {{...}} | {{...}} |
| {{Auth}} | {{...}} | {{...}} |
| {{Hosting}} | {{...}} | {{...}} |

The "why" column is the point. Without it, every choice looks arbitrary to the next reader and gets
re-litigated.

## Where the code lives

    {{directory}}/        {{what belongs here, and what does not}}
    {{directory}}/        {{...}}

One line each, describing the *responsibility* rather than the contents. A listing of the contents
is something the reader can get from the filesystem, and it goes stale; a statement of what belongs
there does not.

## How a request flows

The short version. The full pipeline, stage by stage, is in [Pipelines](pipelines.md).

{{user action}} → {{...}} → {{...}} → {{result}}

## Environments

| Environment | Where | Data | Who can reach it |
|---|---|---|---|
| Local | {{...}} | {{...}} | {{...}} |
| {{Preview / staging}} | {{...}} | {{...}} | {{...}} |
| Production | {{...}} | {{...}} | {{...}} |

State plainly whether merging reaches production directly. It is the single fact most likely to
surprise someone at the worst moment.

## What we depend on and do not control

Named here, detailed in [Integrations](integrations.md).

- {{service}} — {{what breaks if it is down}}

## Current stage

**{{prototype | demo | private beta | public | production with paying customers}}**

This decides which deferred work is due. Crossing a stage line means sweeping
[the ledger](../00-meta/deferred-ledger.md) — stage transitions fire whole clusters of entries at
once, and it is the moment they are cheapest to clear.
