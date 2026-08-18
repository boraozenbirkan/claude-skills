> **Audience:** operators · **Status:** current · **Owner:** agents

# Internal handbook

For everyone who runs {{PROJECT_NAME}} day to day — admins, support, operations, content. Written
for people who may never read the code, and never assuming they can.

If you are a developer: the engineering docs are in [`../02-architecture/`](../02-architecture/) and
[`../04-development/`](../04-development/). This section stays free of code on purpose.

## How do I…

The fastest route to an answer. Add a row the first time someone has to ask.

| I want to… | Go to |
|---|---|
| {{task}} | [{{page}}]({{page}}.md) |
| {{task}} | [{{page}}]({{page}}.md) |

## Who does what

| Role | Responsible for | Can also | Ask them about |
|---|---|---|---|
| {{role}} | {{...}} | {{...}} | {{...}} |

## When something looks wrong

1. {{first check — the thing that explains most reports}}
2. {{second check}}
3. **Escalate to {{who}}** with: what you were doing, what you expected, what happened, and the time
   it happened. The timestamp is what makes it findable in the logs.

{{Include the handful of known-confusing behaviours that are working as intended. Every one listed
here is a support message nobody has to send.}}

## Words used here

Plain-language versions of the terms in the product. The engineering glossary is
[`CONTEXT.md`](../../CONTEXT.md); definitions must agree, but this one is written for reading rather
than precision.

| Word | What it means here |
|---|---|
| {{term}} | {{plain explanation}} |

<!--
Writing rules for this section:

- Describe screens, fields, buttons, and outcomes. Never function or table names.
- Every procedure is a numbered list someone can follow while looking at the screen.
- No sentence whose ambiguity can only be resolved by reading the source.
- Say what happens after an action, including what other people will see. That is the part operators
  actually need and the part engineers forget to write.
- One page per real workflow, added when the workflow exists. An empty section of headings teaches
  people that this handbook has no answers.
-->
