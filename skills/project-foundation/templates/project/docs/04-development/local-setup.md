> **Audience:** engineers · **Status:** current · **Owner:** agents

# Local setup

Clone to running, with nothing assumed.

## On this page

- [Prerequisites](#prerequisites)
- [Getting it running](#getting-it-running)
- [Environment](#environment)
- [Commands](#commands)
- [When it does not work](#when-it-does-not-work)

## Prerequisites

| Tool | Version | Check with |
|---|---|---|
| {{tool}} | {{version}} | `{{command}}` |

Pin versions the project actually needs. "Recent Node" costs someone an afternoon.

## Getting it running

1. {{clone}}
2. {{install dependencies}}
3. {{copy the env template and fill it in — see below}}
4. {{database setup, if any}}
5. {{start}}

**You know it worked when:** {{the observable thing — a URL that loads, a command that prints
something specific}}. Without this line, "it started" and "it works" are the same sentence.

## Environment

Copy `{{ENV_EXAMPLE}}` to `{{ENV_FILE}}` and fill in:

| Variable | Where to get it | Required to boot |
|---|---|---|
| `{{VAR}}` | {{...}} | {{yes / no}} |

The full list, and what breaks when each is missing, is in
[Integrations](../02-architecture/integrations.md).

## Commands

| Command | What it does |
|---|---|
| `{{cmd}}` | {{...}} |

Only the commands with something to explain. The rest are in the package manifest, where they cannot
go out of date.

## When it does not work

{{The failures that have actually happened here, and their fixes. This section is worth more than
the rest of the page combined, and it can only be written by collecting real failures — add to it
every time someone loses an hour.}}

- **{{symptom}}** — {{cause}}. {{fix}}
