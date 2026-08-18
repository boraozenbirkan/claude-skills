# Phase 1 — Frame and operator

Two questions, in this order, and nothing else. What are we building, and who is deciding.

The order matters. Ask the broad question first so you have something concrete to talk about, then
find out who you are talking to — because that answer rewrites how every later question should be
worded.

## 1.1 — What are we building

One open question, in plain language, no multiple choice:

> Tell me what you want to build — a paragraph is plenty. What is it, who is it for, and what does
> it do for them?

Let them ramble. A founder's unstructured description carries priorities in its ordering and
emphasis that a structured form would flatten.

Then read the ground again against what they said, and reflect back **one sentence**: *"So: a
{{what}} for {{whom}}, that {{does what}}."* Get that sentence agreed before moving on. It becomes
the project's one-liner in every doc, and a wrong one propagates everywhere.

## 1.2 — Classify the project type

Infer it; confirm only if genuinely ambiguous. The type decides which future needs are real for this
project and which pages ever get written — see [`../reference/project-types.md`](../reference/project-types.md).

## 1.3 — Profile the operator

**Operator** = whoever answers your questions and makes the calls. Ask in one `AskUserQuestion`
batch:

1. **Who decides?** Solo · small team (2–8) · larger org with defined roles
2. **How technical are you, for *this* project?** Non-technical · technical, different domain ·
   experienced in this exact domain
3. **How should I run the interview?** Recommend hard and move fast · lay out trade-offs and let me
   pick · explain the concepts as we go

Question 2 is not about seniority. A distributed-systems veteran building their first storefront is
"technical, different domain" — they need the retail vocabulary explained and the infrastructure
taken as read. Ask about *this* project, and take the answer at face value.

## 1.4 — Set the register

The profile picks a register. Hold it for the rest of the run.

| Operator | Vocabulary | Recommendations | Explain |
|---|---|---|---|
| Non-technical | Outcomes and screens. Trade off in money, time, and risk | Strong: one recommendation, with the consequence of the alternative in a clause | Only when a term is unavoidable, and then in one line |
| Technical, different domain | Technical terms freely; define the **domain** terms | Strong on domain shape, open on implementation | Domain concepts, not engineering ones |
| Domain-experienced | Full technical and domain vocabulary | Offer the trade-off; they will pick | Nothing by default |

Whatever the register: state your recommendation for every question. An operator who wants to
overrule you can do it in one word, and one who does not has been saved a decision.

## 1.5 — Personas

For a **team**, one persona per role that will read the docs or brief an agent — typically founder
or product owner, engineers, an operations or support role, and whoever handles marketing or
content. For each: what they decide, what they need from the docs, and what vocabulary they use.

For a **solo operator**, write one persona. It still earns its place: it is what a future agent
reads to know who it is talking to and how much to explain.

Write [`docs/00-meta/personas.md`](../templates/project/docs/00-meta/personas.md) now, before the
interview goes any deeper. Later phases read it, and so does every agent that works on this project
afterwards.

## 1.6 — Open the session file

Create `docs/00-meta/foundation-session.md` from
[the template](../templates/project/docs/00-meta/foundation-session.md) and record the one-sentence
frame, the project type, and the register. Append to it at the end of every phase — a foundation
interview often spans several sessions, and this file is what makes resuming cheaper than restarting.

## Done when

You can state in one sentence each: **what is being built**, **who decides**, and **the register you
will hold** — and `personas.md` and `foundation-session.md` both exist on disk with those answers in
them.
