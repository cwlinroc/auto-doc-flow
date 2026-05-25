# review-with-doc

Review code quality and check alignment with any related ADR or doc.

1. Read skills docs-structure and project-docs-structure if available.
2. Default to current uncommitted changes unless the user says otherwise.
3. review the code, find any possible issue.
4. If an issue appears, ask before fixing and ask again before updating docs.
5. Support AI-, human-, or unknown-authored changes with the same review bar.
6. Keep the review grounded in the actual diff, not guesses about intent.
7. If fixes are approved, ask the user for permission to update docs if needed.
8. docs here are meant including files under docs/ , also README.md and AGENTS.md .
