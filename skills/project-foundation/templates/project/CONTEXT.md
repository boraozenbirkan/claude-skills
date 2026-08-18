# {{PROJECT_NAME}}

{{ONE_OR_TWO_SENTENCES: what this project is and why it exists}}

This is the project's **ubiquitous language**: one canonical word per concept, so that a human and
an agent discussing "an order" picture the same thing. When a term here and the code disagree, one
of them is a bug — find out which before writing anything.

## Language

**{{Term}}**:
{{One or two sentences. Define what it IS, not what it does.}}
_Avoid_: {{rejected synonyms}}

**{{Term}}**:
{{Definition.}}
_Avoid_: {{rejected synonyms}}

<!--
Rules for this file:

- Be opinionated. Where several words exist for one concept, pick one and list the rest under
  _Avoid_. The point is to stop the drift, and that needs a decision.
- Keep definitions to one or two sentences.
- Only terms specific to this project. Timeouts, retries, and repositories are general programming
  concepts and do not belong here however much the project uses them. The test: would this term mean
  something different in another project? If not, leave it out.
- Group under subheadings when natural clusters appear. A flat list is fine while it is short.
- No implementation detail. This is a glossary, not a spec — table names, function signatures, and
  library choices belong in docs/02-architecture/.
-->
