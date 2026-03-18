#!/usr/bin/env bash
# =============================================================================
# ingest.sh — Role ingestion launcher
# =============================================================================
# Starts a guided role ingestion session with an AI coding agent.
# The agent reads ingest.yaml and walks you through adding a new role,
# pausing at human gates (COLLECT and REVIEW) for your input.
#
# Usage:
#   ./ingest.sh              # uses Claude Code (claude CLI)
#   ./ingest.sh --dry-run    # print the agent prompt and exit
# =============================================================================

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)

PROMPT="Read src/ingest.yaml and execute the role ingestion process from STEP-01.
Guide me through each step, pause at COLLECT and REVIEW, and do not
proceed until I confirm."

# ── Dry run ───────────────────────────────────────────────────────────────────
if [[ "${1:-}" == "--dry-run" ]]; then
  echo "Agent prompt that would be sent:"
  echo "─────────────────────────────────────────────"
  echo "$PROMPT"
  echo "─────────────────────────────────────────────"
  exit 0
fi

# ── Preflight checks ──────────────────────────────────────────────────────────
ERRORS=0

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "ERROR: not inside a git repository." >&2
  ERRORS=$((ERRORS + 1))
fi

if [[ ! -f "$SCRIPT_DIR/ingest.yaml" ]]; then
  echo "ERROR: ingest.yaml not found alongside ingest.sh (expected at $SCRIPT_DIR/ingest.yaml)." >&2
  ERRORS=$((ERRORS + 1))
fi

if [[ "$ERRORS" -gt 0 ]]; then
  exit 1
fi

# Warn about uncommitted changes but don't block
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "WARNING: you have uncommitted changes. The agent will commit new role files"
  echo "         at STEP-11 — make sure your existing changes are staged separately."
  echo ""
fi

# ── Launch ────────────────────────────────────────────────────────────────────
if command -v claude &>/dev/null; then
  echo "Starting role ingestion with Claude Code..."
  echo ""
  cd "$REPO_ROOT"
  exec claude "$PROMPT"
else
  echo "Claude Code (claude) not found."
  echo ""
  echo "Install it with:  npm install -g @anthropic-ai/claude-code"
  echo ""
  echo "Or start the ingestion manually by pasting the following into your"
  echo "AI coding agent (Claude Code, Cursor, Copilot, etc.):"
  echo ""
  echo "─────────────────────────────────────────────"
  echo "$PROMPT"
  echo "─────────────────────────────────────────────"
  exit 1
fi
