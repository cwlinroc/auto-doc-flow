# temp note

## Temp thoughts (remove before it is merged in main)

put out a claude version first, and start iteration from this project.

first with files like `grill-with-docs.draft.md`

src/universal/commands/
src/universal/skills/

src/claude/commands/
src/claude/sills/
src/claude/package.sh 

update-all.sh
update.json ( `agents: [ "claude" , "codex"] , cleanup-commands: [ "outdated-with-doc" ] `)
update.user.json  (gitignored, override update.json)

### commands

all commands should reference skills for structure: "docs-structure" "project-docs-structure" 
check if exist.

1. grill-with-doc
    - keep asking if anything is unclear
    - with plan, or without plan
    - if user mention any source worth documented, ask them to update it or help them to generate it under reference

    - handles: CONTEXT.md, adr/ , (domain?)

    - reference skills for structure: "docs-structure" "project-docs-structure" 

    - after the implementation is done , suggest the user to run review-with-doc(another agent or another session) or sync-with-doc

2. review-with-doc
	- review my current uncommitted change, written by ai
	- review my current uncommitted change, written by human
	- review others uncommitted change, written by unknown
    
    - base on the uncommitted change if not mentioned 


    
    - basic code review
    - should align with the uncommitted adr (if exist), if not, ask
    - see problem, ask 
    - provide a fix, ask

    - fix done, ask permission to update docs

3. sync-with-doc
    - no code change, just sync/update docs
    - base on the uncommitted change if not mentioned 

4. trouble-shoot-with-doc
    - play around draft first ( draft/Problem-?????.md)
    - if there is a conclusion, ask the user to confirm,  add the record in incident first. and if this is a real fix, add more info append at the bottom (should work immutable like adr)
    - if this need a code change, generate md (draft/PLAN-????.md), ask user to grill-with-docs
    - divide incident level, while-dev , while-test , while-production

5. brain-storm-with-doc
    - play around draft first ( draft/Thoughts-????.md)
    - if user mention any source worth documented, ask them to update it or help them to generate it under reference
    - if there is something clear and the user agrees, export it to a markdown (draft/PLAN-????.md ), and ask the user to start this in a new session, using grill-with-docs



```
.
├── README.md           # entry point: docs index + brief onboarding
└── docs/
    ├── CONTEXT.md      # It is a glossary and nothing else.
    ├── adr/            # Architecture Decision Records
    ├── design/         # Design write-ups (alternatives, tradeoffs, open questions)
    ├── domain/         # Business context: customers, SLAs, domain, seasonality
    ├── incident/       # Blameless incident reviews (lightweight add-on; serious tracking lives elsewhere)
    ├── reference/      # Technical reference: APIs, schemas, third-party docs
    └── draft/          # gitignored. Personal scratch for brainstorming.
```

### scope

1. user scope commands
2. user scope file definition skills : a more broad way to interact with multi cases
    - docs-structure
    - contains a project-docs-structure skill, for recommending user to install if not exist
3. project scope file definition skills : focus on actually defining what should it be
    - project-docs-structure

### cross agent

1. a universal source for all skills and command
2. add agent tool specific while export

### cross language

1. create a basic english version first
2. a modified traditional chinese version

### other

1. adr md file name
    - YYYYMMDD-hhmm-xxxxxxxx.md

