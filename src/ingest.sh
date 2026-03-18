#!/usr/bin/env bash
# =============================================================================
# ingest.sh — Role ingestion CLI walkthrough
# =============================================================================
# Interactively collects all STEP-01 inputs in the terminal, then hands off
# to Claude for STEP-02 onward with the pre-collected data.
#
# Usage:
#   ./src/ingest.sh
# =============================================================================

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
SESSION_FILE="$REPO_ROOT/.ingest-session.yaml"

# ── Colours ───────────────────────────────────────────────────────────────────

BOLD='\033[1m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

# ── Preflight checks ──────────────────────────────────────────────────────────

if ! git -C "$REPO_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
  echo "ERROR: not inside a git repository." >&2
  exit 1
fi

if [[ ! -f "$SCRIPT_DIR/ingest.yaml" ]]; then
  echo "ERROR: ingest.yaml not found at $SCRIPT_DIR/ingest.yaml." >&2
  exit 1
fi

if ! git -C "$REPO_ROOT" diff --quiet || ! git -C "$REPO_ROOT" diff --cached --quiet; then
  echo -e "${YELLOW}WARNING: you have uncommitted changes. They will not be included in the role commit at STEP-10.${RESET}"
  echo ""
fi

# ── Helpers ───────────────────────────────────────────────────────────────────

step_header() {
  local title="$1"
  echo ""
  echo -e "${BOLD}${CYAN}── $title ${RESET}"
}

ask() {
  # ask <var_name> <label> <description> [hint]
  local -n _out=$1
  local label="$2"
  local description="$3"
  local hint="${4:-}"

  echo ""
  echo -e "  ${BOLD}$label${RESET}"
  [[ -n "$description" ]] && echo "  $description"
  [[ -n "$hint"        ]] && echo -e "  ${YELLOW}e.g. $hint${RESET}"

  while true; do
    printf "  > "
    read -r _out
    [[ -n "$_out" ]] && return
    echo -e "  ${RED}Required — please enter a value.${RESET}"
  done
}

ask_choice() {
  # ask_choice <var_name> <label> <description> <allowed_csv>
  local -n _out=$1
  local label="$2"
  local description="$3"
  IFS=',' read -ra _allowed <<< "$4"

  echo ""
  echo -e "  ${BOLD}$label${RESET}"
  [[ -n "$description" ]] && echo "  $description"
  echo -e "  ${YELLOW}Options: ${_allowed[*]}${RESET}"

  while true; do
    printf "  > "
    read -r _out
    for opt in "${_allowed[@]}"; do
      [[ "$_out" == "$opt" ]] && return
    done
    echo -e "  ${RED}Must be one of: ${_allowed[*]}${RESET}"
  done
}

ask_bool() {
  # ask_bool <var_name> <label> <description>
  local -n _out=$1
  local label="$2"
  local description="$3"

  echo ""
  echo -e "  ${BOLD}$label${RESET}"
  [[ -n "$description" ]] && echo "  $description"
  echo -e "  ${YELLOW}Options: true / false${RESET}"

  while true; do
    printf "  > "
    read -r _out
    [[ "$_out" == "true" || "$_out" == "false" ]] && return
    echo -e "  ${RED}Must be 'true' or 'false'.${RESET}"
  done
}

ask_optional() {
  # ask_optional <var_name> <label> <description> [hint]
  local -n _out=$1
  local label="$2"
  local description="$3"
  local hint="${4:-}"

  echo ""
  echo -e "  ${BOLD}$label${RESET}"
  [[ -n "$description" ]] && echo "  $description"
  [[ -n "$hint"        ]] && echo -e "  ${YELLOW}e.g. $hint${RESET}"
  echo -e "  ${YELLOW}(leave blank to skip)${RESET}"
  printf "  > "
  read -r _out
}

yaml_str() {
  # Emit a YAML scalar — quoted, with internal quotes escaped
  local val="$1"
  val="${val//\\/\\\\}"
  val="${val//\"/\\\"}"
  printf '"%s"' "$val"
}

yaml_nullable() {
  local val="$1"
  [[ -z "$val" ]] && printf 'null' || yaml_str "$val"
}

# ── STEP-01: COLLECT ──────────────────────────────────────────────────────────

echo ""
echo -e "${BOLD}Role Ingestion — STEP-01: COLLECT${RESET}"
echo "Answer each field one at a time. All fields are required unless marked optional."

# 1. concept
step_header "1 / 8  concept"
ask CONCEPT \
  "What does this role do?" \
  "Describe its primary function and purpose." \
  "A negotiation coach grounded in Harvard principled negotiation"

# 2. category
step_header "2 / 8  category"
ask_choice CATEGORY \
  "Which category does this role belong to?" \
  "" \
  "entertainment,engineering,health,education,utility,productivity"

# 3. target_user
step_header "3 / 8  target_user"
ask TARGET_USER \
  "Who will use this role, and in what context?" \
  "Describe the intended user and their situation." \
  "Product managers preparing for vendor negotiation sessions"

# 4. persona.tone
step_header "4 / 8  persona.tone"
ask_choice PERSONA_TONE \
  "What tone should this persona have?" \
  "" \
  "formal,casual,warm,direct,clinical,playful"

# 5. persona.humor
step_header "5 / 8  persona.humor"
ask_choice PERSONA_HUMOR \
  "What level of humor should this persona use?" \
  "" \
  "none,dry,sarcastic,dark,witty"

# 6. persona.verbosity
step_header "6 / 8  persona.verbosity"
ask_choice PERSONA_VERBOSITY \
  "How verbose should responses be?" \
  "" \
  "concise,balanced,detailed"

# 7. persona.voice
step_header "7 / 8  persona.voice"
ask PERSONA_VOICE \
  "Describe the character and voice of this persona." \
  "What makes it distinctive? What is its speaking style?" \
  "Measured and precise — speaks like a seasoned mediator, never reactive"

# 8. constraints
step_header "8 / 8  constraints"
echo ""
echo "  Answer true/false for the first three, then provide text for the last two (optional)."

ask_bool GDPR \
  "gdpr_special_category" \
  "Does this role handle mental health, biometric, health, or political data? (GDPR Art. 9)"

ask_bool MINORS \
  "minors_involved" \
  "Might any target users be under 18?"

ask_bool CRISIS \
  "crisis_risk" \
  "Might this role encounter crisis disclosures (suicidal ideation, DV, abuse)?"

ask_optional LANG_REQ \
  "language_requirements" \
  "Non-English primary output required?" \
  "Dutch output for VWO students"

ask_optional SCOPE_LIMITS \
  "scope_limits" \
  "Explicit boundaries this role must not cross." \
  "Phase 1 stabilisation only — no trauma processing"

# ── Review ────────────────────────────────────────────────────────────────────

echo ""
echo ""
echo -e "${BOLD}${GREEN}STEP-01 complete — review collected inputs${RESET}"
echo "──────────────────────────────────────────────────"
echo "  concept:                 $CONCEPT"
echo "  category:                $CATEGORY"
echo "  target_user:             $TARGET_USER"
echo "  persona.tone:            $PERSONA_TONE"
echo "  persona.humor:           $PERSONA_HUMOR"
echo "  persona.verbosity:       $PERSONA_VERBOSITY"
echo "  persona.voice:           $PERSONA_VOICE"
echo "  constraints:"
echo "    gdpr_special_category: $GDPR"
echo "    minors_involved:       $MINORS"
echo "    crisis_risk:           $CRISIS"
[[ -n "$LANG_REQ"    ]] && echo "    language_requirements: $LANG_REQ"
[[ -n "$SCOPE_LIMITS" ]] && echo "    scope_limits:          $SCOPE_LIMITS"
echo ""
printf "  Confirm and proceed to STEP-02? [y/N] "
read -r CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "Aborted."
  exit 0
fi

# ── Write session file ────────────────────────────────────────────────────────

cat > "$SESSION_FILE" <<YAML
# Auto-generated by ingest.sh — STEP-01 output
# Do not edit by hand; re-run ./src/ingest.sh to regenerate.
concept: $(yaml_str "$CONCEPT")
category: $(yaml_str "$CATEGORY")
target_user: $(yaml_str "$TARGET_USER")
persona:
  tone: $(yaml_str "$PERSONA_TONE")
  humor: $(yaml_str "$PERSONA_HUMOR")
  verbosity: $(yaml_str "$PERSONA_VERBOSITY")
  voice: $(yaml_str "$PERSONA_VOICE")
constraints:
  gdpr_special_category: $GDPR
  minors_involved: $MINORS
  crisis_risk: $CRISIS
  language_requirements: $(yaml_nullable "$LANG_REQ")
  scope_limits: $(yaml_nullable "$SCOPE_LIMITS")
YAML

echo ""
echo -e "${GREEN}Session saved to .ingest-session.yaml${RESET}"

# ── Hand off to Claude for STEP-02 onward ────────────────────────────────────

HANDOFF="Read src/ingest.yaml and execute the role ingestion process starting at STEP-02.
STEP-01 is complete. All collected inputs are in .ingest-session.yaml — use them directly; do not ask the user for anything already captured there.
Pause at STEP-09 (REVIEW) and wait for explicit approval before committing."

echo ""

if command -v claude &>/dev/null; then
  echo -e "${BOLD}Handing off to Claude for STEP-02 onward…${RESET}"
  echo ""
  claude "$HANDOFF"
else
  echo "Paste the following into your AI coding agent to continue from STEP-02:"
  echo ""
  echo "─────────────────────────────────────────────"
  echo "$HANDOFF"
  echo "─────────────────────────────────────────────"
  echo ""

  if command -v pbcopy &>/dev/null; then
    echo "$HANDOFF" | pbcopy
    echo "Copied to clipboard (pbcopy)."
  elif command -v xclip &>/dev/null; then
    echo "$HANDOFF" | xclip -selection clipboard
    echo "Copied to clipboard (xclip)."
  elif command -v xsel &>/dev/null; then
    echo "$HANDOFF" | xsel --clipboard --input
    echo "Copied to clipboard (xsel)."
  elif command -v wl-copy &>/dev/null; then
    echo "$HANDOFF" | wl-copy
    echo "Copied to clipboard (wl-copy)."
  fi
fi
