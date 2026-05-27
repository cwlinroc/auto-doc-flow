# Transition project-docs-structure to a Repository-Based Unified File

**Status:** Accepted
**Date:** 20260527-1559

## Context

Originally, the project-specific documentation rules (`project-docs-structure`) were designed to be packaged and installed as global agent skills (user-scope configurations) for Claude Code, Antigravity, Codex CLI, and GitHub Copilot. 

However, installing a project's documentation conventions globally in the developer's home directory causes several issues:
1. **Scope Pollution:** The rules leak into other, unrelated repositories where they conflict with different layouts or guidelines.
2. **Team Visibility:** Global configurations are invisible to other team members and cannot be easily version-controlled inside the repository itself.
3. **Packaging Complexity:** Packaging a global skill requires maintaining target-specific metadata JSON configs across four different agents.

During a brainstorming session, we realized that an agent-agnostic repository file `docs/project-docs-structure.md` would provide a cleaner, simpler, and more robust solution. All AI agents have standard file-reading tools and can read this file directly from the workspace.

## Decision

Transition the `project-docs-structure` skill from a global agent skill to a repository-based file, and refactor the global `docs-structure` skill as a router.

1. **Unified File Location**:
   Establish **`docs/project-docs-structure.md`** as the repository-local authority file. It contains the structure policy, naming conventions, and cross-cutting rules.

2. **Embedded Format Templates (Option A)**:
   Embed format templates (`ADR-FORMAT.md`, `CONTEXT-FORMAT.md`, and `INCIDENT-FORMAT.md`) directly in `docs/project-docs-structure.md` as code blocks. This minimizes tool calls and keeps all rules in a single file.

3. **Intelligent Routing & Bootstrapping**:
   Update the global `docs-structure` skill to:
   - Check if `docs/project-docs-structure.md` exists. If so, read it and defer to it as the absolute authority.
   - If missing, perform a fast scan of top-level folders/files (e.g. `docs/`, `doc/`) to detect any existing layout and suggest a custom layout, or print a copy-pasteable default configuration to bootstrap.

4. **Global Skill Deprecation**:
   Remove the global `project-docs-structure` skill from the build scripts (`build.sh`) of all 4 agents. Update installer scripts (`scripts/install-*.sh`) to automatically clean up previously installed global skill directories to ensure the new routing flow runs without legacy interference.

## Consequences

**Positive:**
- **Zero Pollution:** Other, unrelated repositories will not be subjected to ADF-specific rules.
- **Improved Version Control:** Rules are checked into Git and shared with all maintainers.
- **Reduced Tool Calls:** The agent can read all layout rules and templates in a single tool call to `project-docs-structure.md`.
- **Portability:** Works seamlessly across Claude Code, Antigravity, Codex CLI, and GitHub Copilot without specialized plugin configurations.

**Negative / trade-offs:**
- Repositories that want Auto Doc Flow rules must check in `docs/project-docs-structure.md` rather than receiving it ambiently as a global agent capability.

## Alternatives considered

- **Option B (Separate template files in repository):** Keep templates as separate files like `docs/ADR-FORMAT.md` instead of embedding them. Rejected because it adds folder clutter in `docs/` and requires more tool calls from the agent.
- **Deep scan bootstrapping:** Allow the agent to scan the entire workspace when the rules file is missing. Rejected due to high token/performance overhead in large workspaces; fast scans are preferred.
