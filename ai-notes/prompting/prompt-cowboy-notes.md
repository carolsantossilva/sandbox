# Prompt Cowboy Notes

[Prompt Cowboy](https://www.promptcowboy.ai/) is a prompt generation tool I use
to explore prompt structure, templates and agent instructions.

This file captures prompt-design patterns and lessons from reviewer-style
prompts, without storing the full prompts verbatim.

This is a reference for learning notes, not a required dependency for any
project in this repository.

## Useful Patterns

### Reviewer Role + Specific Domain

Use a precise reviewer identity instead of a generic assistant role.

Example:

```text
You are a technical documentation reviewer specializing in learning resources
and sandbox environments.
```

Why it helps:

- Sets the evaluation lens.
- Encourages domain-specific critique.
- Produces more structured feedback.

### Context Before Criteria

Define the project, audience and purpose before listing evaluation criteria.

Example:

```text
The sandbox serves dual purposes: personal learning and portfolio content.
```

Why it helps:

- Keeps feedback aligned with the real use case.
- Reduces generic advice that ignores the artifact's purpose.

### Audience Segmentation

Name the intended readers when the same artifact needs to work for different
use cases.

Example:

```text
Evaluate the portfolio for recruiters, potential clients and developer peers.
```

Why it helps:

- Makes tradeoffs easier to evaluate.
- Surfaces gaps that only matter to specific audiences.
- Avoids optimizing for one reader while ignoring another.

### Explicit Deliverable Format

Describe the expected structure of the answer instead of only asking for a
review.

Example:

```text
Provide section-by-section feedback with what works, what needs improvement and
specific recommendations.
```

Why it helps:

- Makes the output easier to scan.
- Reduces vague answers by telling the model what kind of response to produce.
- Encourages actionable recommendations instead of a general impression.

## What I Learned

### General Prompt Patterns

- Prompts get stronger when the audience is explicit.
- Asking for prioritized recommendations turns broad review feedback into a
  clearer action plan.
- Separating context, criteria and deliverable format improves consistency.
- Direct tone instructions help reduce overly polite or generic responses.

### Documentation Review Prompts

- Documentation reviews should consider navigation, not only content quality.
- Repositories with mixed content need clear status labels because not
  everything has the same maturity.
- Learning repositories benefit from explaining progression, not only listing
  folders.
