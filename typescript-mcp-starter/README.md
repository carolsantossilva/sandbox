# TypeScript MCP Starter

Minimal starter for experimenting with Model Context Protocol servers in TypeScript.

The goal is to keep this small enough for learning while still showing the shape of
a real developer-tooling MCP server.

## Included

- TypeScript project setup.
- MCP SDK server entrypoint.
- One example tool: `summarize_mobile_issue`.
- Zod validation for tool input.

## Scripts

```bash
npm install
npm run build
npm run dev
```

## Example Tool

`summarize_mobile_issue` accepts a short mobile issue report and returns:

- likely platform,
- severity,
- short summary,
- suggested next action.

## Next Steps

- Add tests with Vitest.
- Add example crash logs and build logs.
- Add tools for release checklists, localization audits and regression test plans.
