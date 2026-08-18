> **Audience:** everyone · **Status:** current · **Owner:** humans

# Public documentation

Everything in this directory is published, or written to be published, on {{WHERE}}. It is the only
part of `docs/` that agents do not maintain.

## The rule

**These files change when a human asks for that change, in the conversation where they ask it.**

Working near them — as an agent, or as a person acting on an agent's suggestion — the move is:

1. Write the proposed change into chat, as the exact text you would put in the file.
2. Say which file and which section.
3. Wait for a person to say yes.

Editing a file here raises a permission prompt for a human, enforced by
`Edit(/docs/05-public/**)` in [`.claude/settings.json`](../../.claude/settings.json). That prompt is
the decision point. Seeing one appear means step 1 was skipped.

## Why this directory is different

Everywhere else in `docs/`, an agent updating a page as it changes the code is exactly what should
happen — the docs stay true by construction.

Public docs invert that. They are a **published artifact**: read by customers, quoted back in
support conversations, indexed by search engines, and occasionally relied on as a commitment. A
correction that is right about the code can still be wrong to publish — the wrong moment, the wrong
detail, a promise nobody agreed to make. Deciding to publish is a human's call, and it stays one.

## What belongs here

- {{public product documentation}}
- {{FAQs, guides, policies}}
- {{whatever else is customer-facing}}

## What does not

- Anything internal — that is [`../03-internal/`](../03-internal/)
- Anything technical — that is [`../02-architecture/`](../02-architecture/) and
  [`../04-development/`](../04-development/)
- Anything about the roadmap that has not been decided publicly

## Publishing

- **Source of truth:** {{these files | the CMS | somewhere else}}
- **How it reaches the site:** {{the process}}
- **Who approves:** {{who}}

<!-- Keep this file. It is what tells the next agent why this directory behaves differently, and it
sits where that agent will be reading. -->
