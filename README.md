# Sandbox

Learning lab for mobile engineering, TypeScript, MCP and AI tooling experiments.

This repository is intentionally experimental. It collects studies, prototypes,
course exercises and starter projects that document learning in public while
also serving as a portfolio of technical growth across mobile engineering,
backend fundamentals and AI developer tooling.

## Tracks

| Track | Status | Start Here |
| --- | --- | --- |
| TypeScript & MCP | Active starter | [`typescript-mcp-starter`](./typescript-mcp-starter) |
| Mobile Studies | Active foundation / study archive | [`mobile-studies`](./mobile-studies) |
| AI Notes | Planned | [`ai-notes`](./ai-notes) |
| Node & TypeScript | Legacy studies | [`node-typescript`](./node-typescript) |

## Getting Started

Most folders are independent. Start by choosing a track, then read that folder's
README for project-specific context.

For the active TypeScript MCP starter:

```bash
cd typescript-mcp-starter
npm install
npm run build
npm run dev
```

Archived mobile and Node.js studies may require older tooling or
project-specific setup.

## Prerequisites

| Area | Tools |
| --- | --- |
| TypeScript & MCP | Node.js, npm |
| iOS studies | macOS, Xcode |
| Kotlin studies | JDK, Kotlin and project-specific build tooling |
| Spring/backend studies | JDK and project-specific Gradle or Maven setup |

## Projects

### TypeScript & MCP

#### [`typescript-mcp-starter`](./typescript-mcp-starter)

Minimal TypeScript MCP server skeleton for experimenting with AI developer
tools.

- Status: Active starter.
- Purpose: Learn the shape of a small MCP developer-tooling server.
- Expected output: local MCP server starts with the `summarize_mobile_issue`
  example tool.
- Docs: [`typescript-mcp-starter/README.md`](./typescript-mcp-starter/README.md).

### Mobile Studies

#### [`mobile-studies/ios`](./mobile-studies/ios)

iOS study archive with ARKit, custom camera, gestures, macOS and toolbar
exercises.

- Status: Study archive.
- Purpose: Preserve hands-on iOS practice and mobile engineering references.
- Expected output: project-specific iOS or macOS exercises.
- Docs: [`mobile-studies/README.md`](./mobile-studies/README.md).

#### [`mobile-studies/kotlin`](./mobile-studies/kotlin)

Kotlin and mobile-adjacent backend studies, including fundamentals and a
Spring-based book marketplace study.

- Status: Study archive.
- Purpose: Document Kotlin fundamentals and backend practice connected to
  mobile engineering.
- Expected output: project-specific Kotlin or Spring exercises.
- Docs: [`mobile-studies/README.md`](./mobile-studies/README.md).

### AI Notes

#### [`ai-notes`](./ai-notes)

Reserved space for notes, prompts and small examples related to AI tooling, RAG
and LLM workflows.

- Status: Planned.
- Purpose: Collect AI engineering notes and examples that connect LLM workflows
  with mobile development.
- Expected output: notes and small examples as this track grows.
- Docs: [`ai-notes/README.md`](./ai-notes/README.md).

### Node & TypeScript

#### [`node-typescript/node-js`](./node-typescript/node-js)

Legacy Node.js and JavaScript studies, including chat server, weather app and
web server exercises.

- Status: Legacy studies.
- Purpose: Preserve earlier Node.js learning while selected examples are
  gradually modernized into TypeScript.
- Expected output: project-specific Node.js exercises.
- Docs: [`node-typescript/README.md`](./node-typescript/README.md).

## How To Read This Repo

- Start with `typescript-mcp-starter` for the current active direction.
- Browse `mobile-studies` for mobile engineering foundations and older iOS or
  Kotlin exercises.
- Use `node-typescript` as a legacy reference area for earlier Node.js studies.
- Check `ai-notes` as the AI tooling track grows.
- Projects marked as `study archive` are kept as learning references and may
  not have current setup instructions.

## Roadmap

Next:

- Expand `typescript-mcp-starter` with validation, examples and tests.
- Add setup notes to selected archived mobile and Node.js exercises.
- Collect RAG, MCP and LLM workflow notes under `ai-notes`.

Later:

- Add small mobile AI experiments under `mobile-studies`.
- Gradually modernize selected Node.js examples into TypeScript.
- Add new mobile-focused experiments so the repo reflects ongoing mobile
  practice, not only historical studies.
