> **Audience:** engineers · **Status:** current · **Owner:** agents

# Integrations

Everything we depend on and do not control.

## Services

### {{Service}}

- **What we use it for:** {{...}}
- **What breaks without it:** {{the user-visible consequence, not "the integration fails"}}
- **Behind a seam?** {{yes, at `path` | no, and why that is acceptable}}
- **Env vars:** `{{VAR}}`, `{{VAR}}`
- **Where the credentials live:** {{...}}
- **Limits that matter:** {{rate limits, quotas, payload sizes, timeouts}}
- **Sandbox:** {{how to exercise it without touching production}}

## Environment variables

Every variable, what it is for, and what happens when it is missing. Missing-value behaviour is what
turns a broken deploy into a five-minute fix instead of an afternoon.

| Variable | Used by | Required | If absent |
|---|---|---|---|
| `{{VAR}}` | {{...}} | {{yes / no}} | {{fails at boot / feature silently off / crashes at first use}} |

A variable whose absence silently disables a feature deserves a note wherever that feature is
documented — it is the failure that gets discovered by a customer.

## Webhooks

| From | Endpoint | Verifies how | Idempotent | On failure |
|---|---|---|---|---|
| {{service}} | `{{path}}` | {{signature check}} | {{yes / no}} | {{retry policy, dead letter}} |

Two properties decide whether webhooks are a source of quiet corruption: the signature is verified
before the payload is trusted, and the handler is idempotent because every provider will eventually
deliver the same event twice.

## Outbound

{{Where the project calls out during a request, and what the user experiences while waiting. Any
third-party call in a request path is a candidate for the ledger: a user should never wait on a
service you do not control.}}
