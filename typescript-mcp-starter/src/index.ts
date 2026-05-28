import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

const server = new McpServer({
  name: "typescript-mcp-starter",
  version: "0.1.0"
});

const issueSchema = {
  title: z.string().min(3),
  description: z.string().min(10),
  platform: z.enum(["ios", "android", "unknown"]).default("unknown")
};

server.tool(
  "summarize_mobile_issue",
  "Summarize a mobile issue and suggest a practical next step.",
  issueSchema,
  async ({ title, description, platform }) => {
    const normalizedText = `${title} ${description}`.toLowerCase();
    const severity = normalizedText.includes("crash") || normalizedText.includes("blocked")
      ? "high"
      : normalizedText.includes("slow") || normalizedText.includes("error")
        ? "medium"
        : "low";

    const inferredPlatform = platform !== "unknown"
      ? platform
      : normalizedText.includes("ios") || normalizedText.includes("iphone")
        ? "ios"
        : normalizedText.includes("android")
          ? "android"
          : "unknown";

    const response = {
      summary: title,
      platform: inferredPlatform,
      severity,
      nextAction: severity === "high"
        ? "Reproduce the issue, capture logs and identify the affected release."
        : "Confirm expected behavior and add the issue to the next triage pass."
    };

    return {
      content: [
        {
          type: "text",
          text: JSON.stringify(response, null, 2)
        }
      ]
    };
  }
);

const transport = new StdioServerTransport();
await server.connect(transport);
