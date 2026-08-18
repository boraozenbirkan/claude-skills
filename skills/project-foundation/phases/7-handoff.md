# Phase 7 — Hand off

The run is worth nothing if the operator does not know what now exists and what happens next. Report
in their register — a non-technical operator gets outcomes and next actions, not a file tree.

## Report

**What exists.** The docs tree, in one short list with what each section is for. Name
`docs/README.md` as the entry point for every future agent, and say what its two indexes do.

**What is enforced.** That agents must update the docs their changes route to, and that editing the
public docs raises a permission prompt for a human. Show what that prompt looks like so the first
one is not a surprise.

**What still needs them.** Every placeholder you could not fill, as a short list of questions. Be
specific — *"the roadmap has no launch date because you did not have one"* beats *"some sections are
incomplete."*

**What is deferred.** The ledger's size and its two or three nearest triggers. This is the operator's
first sight of the mechanism that will interrupt them later; explain it once, now.

**Where step 1 starts.** The question step 1 answers, and the command that begins it.

## Retrofits: say what is now wrong

On an existing project, pre-existing docs may describe behaviour the code no longer has. Say so
explicitly, page by page, and offer to bring them in sync as a separate piece of work.

Quietly leaving a stale page in a freshly built index is the worst outcome of this whole run: the
index makes it look authoritative.

## Kick off step 1

Offer to start it — `/next-step` from the project root. If the operator takes it, the first step
runs under the machinery just installed, which is also the fastest way to find out whether the
machinery works.

## Suggest what a foundation cannot decide

Two things are worth raising once, here, and then dropping:

- **Version control.** If the repo has no commit, offer one now. A foundation is a natural first
  commit and a natural rollback point.
- **A second pair of eyes on step 1's assumption.** If the riskiest assumption is one a real user
  could settle in a conversation, say so. A week of building to answer a question a phone call
  answers is the exact waste the roadmap is shaped to avoid.

## Done when

The operator can say what the docs are for, what agents will do to them without being asked, what
happens when something touches the public docs, and what step 1 is. Mark the run complete in
`docs/00-meta/foundation-session.md`.
