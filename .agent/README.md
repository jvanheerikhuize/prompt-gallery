# .agent/ — Tool-Agnostic Agent Configuration

This directory is the single source of truth for agent behaviour in this project.
It is tool- and model-agnostic: any AI coding assistant can read it.

## Contents

| File | Purpose |
| ---- | ------- |
| `settings.yaml` | Structured agent config — startup sequence, paths, rules, read-only boundaries |

## How It Works

```text
.agent/settings.yaml   ← machine-readable canonical config
AGENTS.md              ← human-readable entry point for all agents
```

Any agent reads `AGENTS.md` first. `settings.yaml` provides the same information in structured YAML for programmatic consumption.
