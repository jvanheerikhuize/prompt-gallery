#!/usr/bin/env bash
# =============================================================================
# ingest.sh — Role ingestion CLI walkthrough
# =============================================================================
# Collects all STEP-01 inputs interactively, saves them to
# .ingest-session.yaml, then hands off to Claude for STEP-02 onward.
#
# Usage:
#   ./src/ingest.sh              # interactive walkthrough
#   NO_COLOR=1 ./src/ingest.sh   # plain text, no colour or Unicode
# =============================================================================

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
SESSION_FILE="$REPO_ROOT/.ingest-session.yaml"

# ── Terminal capabilities ─────────────────────────────────────────────────────

COLS=$(tput cols 2>/dev/null || printf '72')
(( COLS > 80 )) && COLS=80

# Respect NO_COLOR (https://no-color.org) and non-interactive output
if [[ -n "${NO_COLOR:-}" ]] || [[ ! -t 1 ]]; then
  B='' D='' G='' Y='' R='' Z=''
  TICK='[ok]'  CROSS='[x]'  PROMPT_CHAR='>'
  HR=$(printf '%*s' "$COLS" '' | tr ' ' '-')
  THIN_HR=$(printf '%*s' "$COLS" '' | tr ' ' '-')
else
  B='\033[1m'     # bold
  D='\033[2m'     # dim
  G='\033[0;32m'  # green
  Y='\033[0;33m'  # yellow
  R='\033[0;31m'  # red
  Z='\033[0m'     # reset
  TICK='✓'  CROSS='✗'  PROMPT_CHAR='›'
  HR=$(printf '%*s' "$COLS" '' | tr ' ' '═')
  THIN_HR=$(printf '%*s' "$COLS" '' | tr ' ' '─')
fi

# ── Signal handling ───────────────────────────────────────────────────────────

trap 'printf "\n\n  Aborted.\n\n"; exit 130' INT TERM

# ── Layout primitives ─────────────────────────────────────────────────────────

_blank()   { printf '\n'; }
_rule()    { echo -e "${D}${THIN_HR}${Z}"; }
_hrule()   { echo -e "${D}${HR}${Z}"; }
_info()    { echo -e "  ${D}$*${Z}"; }
_hint()    { echo -e "  ${Y}e.g.${Z} ${D}$*${Z}"; }
_ok()      { echo -e "  ${G}${TICK}${Z}  $*"; }
_err()     { echo -e "  ${R}${CROSS}${Z}  $*"; }
_label()   { echo -e "  ${B}$*${Z}"; }

# Screen-level header (used at major transitions)
_screen_header() {
  _blank; _hrule
  printf '  %b%s%b\n' "$B" "$1" "$Z"
  _hrule
}

# Field-level header — shows the field name + progress counter
_field_header() {
  local name="$1" progress="$2"
  _blank; _rule
  printf '  %b%-*s%b  %b[%s]%b\n' \
    "$B" $(( COLS - ${#progress} - 6 )) "$name" "$Z" \
    "$D" "$progress" "$Z"
  _rule
}

# ── Collected values ──────────────────────────────────────────────────────────

CONCEPT='' CATEGORY='' TARGET_USER=''
PERSONA_TONE='' PERSONA_HUMOR='' PERSONA_VERBOSITY='' PERSONA_VOICE=''
GDPR='' MINORS='' CRISIS='' LANG_REQ='' SCOPE_LIMITS=''

TOTAL_STEPS=12  # 7 main fields + 5 constraint sub-fields

# ── Input collectors ──────────────────────────────────────────────────────────

# collect_text <var> <field-name> <step> <description> [hint]
collect_text() {
  local -n _v=$1
  local name="$2" step="$3" desc="$4" hint="${5:-}"

  _field_header "$name" "$step of $TOTAL_STEPS"
  _info "$desc"
  [[ -n "$hint" ]] && _hint "$hint"
  _blank

  while true; do
    printf '  %s ' "$PROMPT_CHAR"
    read -r _v
    if [[ -n "$_v" ]]; then
      _ok 'Got it.'
      return
    fi
    _err 'This field is required.'
  done
}

# collect_choice <var> <field-name> <step> <desc> <option> [option…]
collect_choice() {
  local -n _v=$1
  local name="$2" step="$3" desc="$4"
  shift 4
  local opts=("$@")

  _field_header "$name" "$step of $TOTAL_STEPS"
  [[ -n "$desc" ]] && _info "$desc"
  _blank

  local i=1
  for opt in "${opts[@]}"; do
    printf '  %b%d)%b  %s\n' "$D" "$i" "$Z" "$opt"
    (( i++ ))
  done
  _blank

  while true; do
    printf '  %s ' "$PROMPT_CHAR"
    read -r _v

    # Accept a number
    if [[ "$_v" =~ ^[0-9]+$ ]] && (( _v >= 1 && _v <= ${#opts[@]} )); then
      _v="${opts[$(( _v - 1 ))]}"
      _ok "Selected: ${_v}"
      return
    fi

    # Accept the option name directly
    for opt in "${opts[@]}"; do
      if [[ "$_v" == "$opt" ]]; then
        _ok "Selected: ${_v}"
        return
      fi
    done

    _err "Enter a number (1–${#opts[@]}) or the exact option name."
  done
}

# collect_bool <var> <field-name> <step> <description>
collect_bool() {
  local -n _v=$1
  local name="$2" step="$3" desc="$4"

  _field_header "$name" "$step of $TOTAL_STEPS"
  _info "$desc"
  _blank
  printf '  %b1)%b  true\n' "$D" "$Z"
  printf '  %b2)%b  false\n' "$D" "$Z"
  _blank

  while true; do
    printf '  %s ' "$PROMPT_CHAR"
    read -r _v
    case "$_v" in
      1|true)  _v=true;  _ok 'true';  return ;;
      2|false) _v=false; _ok 'false'; return ;;
      *) _err "Enter 'true', 'false', 1, or 2." ;;
    esac
  done
}

# collect_optional <var> <field-name> <step> <description> [hint]
collect_optional() {
  local -n _v=$1
  local name="$2" step="$3" desc="$4" hint="${5:-}"

  _field_header "${name}  ${D}(optional)${Z}" "$step of $TOTAL_STEPS"
  _info "$desc"
  [[ -n "$hint" ]] && _hint "$hint"
  _info 'Leave blank to skip.'
  _blank

  printf '  %s ' "$PROMPT_CHAR"
  read -r _v
  if [[ -n "$_v" ]]; then
    _ok 'Noted.'
  else
    echo -e "  ${D}Skipped.${Z}"
  fi
}

# ── Named field functions (called both during collection and from review) ─────

ask_concept()     { collect_text   CONCEPT       'concept'                         1  \
  'What does this role do? Describe its primary function and purpose.' \
  'A negotiation coach grounded in Harvard principled negotiation'; }

ask_category()    { collect_choice CATEGORY      'category'                        2  \
  'Which category does this role belong to?' \
  entertainment engineering health education utility productivity; }

ask_target_user() { collect_text   TARGET_USER   'target_user'                     3  \
  'Who will use this role, and in what context?' \
  'Product managers preparing for vendor negotiation sessions'; }

ask_tone()        { collect_choice PERSONA_TONE  'persona · tone'                  4  \
  'What tone should this persona have?' \
  formal casual warm direct clinical playful; }

ask_humor()       { collect_choice PERSONA_HUMOR 'persona · humor'                 5  \
  'What level of humor should this persona use?' \
  none dry sarcastic dark witty; }

ask_verbosity()   { collect_choice PERSONA_VERBOSITY 'persona · verbosity'         6  \
  'How verbose should responses be?' \
  concise balanced detailed; }

ask_voice()       { collect_text   PERSONA_VOICE 'persona · voice'                 7  \
  'What makes this persona distinctive? Describe its character and speaking style.' \
  'Measured and precise — speaks like a seasoned mediator, never reactive'; }

ask_gdpr()        { collect_bool   GDPR   'constraints · gdpr_special_category'    8  \
  'Does this role handle mental health, biometric, health, or political data? (GDPR Art. 9)'; }

ask_minors()      { collect_bool   MINORS 'constraints · minors_involved'          9  \
  'Might any target users be under 18?'; }

ask_crisis()      { collect_bool   CRISIS 'constraints · crisis_risk'              10 \
  'Might this role encounter crisis disclosures (suicidal ideation, DV, abuse)?'; }

ask_lang()        { collect_optional LANG_REQ    'constraints · language_requirements' 11 \
  'Non-English primary output required?' \
  'Dutch output for VWO students'; }

ask_scope()       { collect_optional SCOPE_LIMITS 'constraints · scope_limits'     12 \
  'Explicit boundaries this role must not cross.' \
  'Phase 1 stabilisation only — no trauma processing'; }

# ── Collect all fields ────────────────────────────────────────────────────────

run_collect() {
  _screen_header 'Role Ingestion  ·  STEP-01: COLLECT'
  _blank
  _label 'Answer each field one at a time.'
  _info  'Required fields must have a value. Optional fields can be left blank.'
  _info  'For choice fields, type the number or the exact option name.'
  _info  'Press Ctrl+C at any time to abort.'

  ask_concept
  ask_category
  ask_target_user

  _blank; _rule
  printf '  %bPersona%b  %b— tone, humor, verbosity, and voice%b\n' "$B" "$Z" "$D" "$Z"
  _rule

  ask_tone
  ask_humor
  ask_verbosity
  ask_voice

  _blank; _rule
  printf '  %bConstraints%b  %b— safety and compliance flags%b\n' "$B" "$Z" "$D" "$Z"
  _rule

  ask_gdpr
  ask_minors
  ask_crisis
  ask_lang
  ask_scope
}

# ── Review screen ─────────────────────────────────────────────────────────────

_print_summary() {
  _screen_header 'STEP-01 Complete  ·  Review Your Inputs'
  _blank

  printf '  %b%-25s%b  %s\n' "$B" 'concept'               "$Z" "$CONCEPT"
  printf '  %b%-25s%b  %s\n' "$B" 'category'              "$Z" "$CATEGORY"
  printf '  %b%-25s%b  %s\n' "$B" 'target_user'           "$Z" "$TARGET_USER"
  _blank
  printf '  %b%-25s%b  %s\n' "$B" 'persona.tone'          "$Z" "$PERSONA_TONE"
  printf '  %b%-25s%b  %s\n' "$B" 'persona.humor'         "$Z" "$PERSONA_HUMOR"
  printf '  %b%-25s%b  %s\n' "$B" 'persona.verbosity'     "$Z" "$PERSONA_VERBOSITY"
  printf '  %b%-25s%b  %s\n' "$B" 'persona.voice'         "$Z" "$PERSONA_VOICE"
  _blank
  printf '  %b%-25s%b  %s\n' "$B" 'gdpr_special_category' "$Z" "$GDPR"
  printf '  %b%-25s%b  %s\n' "$B" 'minors_involved'       "$Z" "$MINORS"
  printf '  %b%-25s%b  %s\n' "$B" 'crisis_risk'           "$Z" "$CRISIS"
  printf '  %b%-25s%b  %s\n' "$B" 'language_requirements' "$Z" "${LANG_REQ:-(none)}"
  printf '  %b%-25s%b  %s\n' "$B" 'scope_limits'          "$Z" "${SCOPE_LIMITS:-(none)}"
}

run_review() {
  while true; do
    _print_summary
    _blank
    _rule
    echo -e "  ${G}${TICK}${Z}  All fields collected."
    _blank
    _label 'What would you like to do?'
    _info  "  ${PROMPT_CHAR}  Press Enter (or Y) to confirm and continue to STEP-02."
    _info  "  ${PROMPT_CHAR}  Type a field name to edit it, then review again."
    _blank
    _info  'Fields: concept · category · target_user · tone · humor · verbosity · voice'
    _info  '        gdpr · minors · crisis · language · scope'
    _blank

    printf '  %s ' "$PROMPT_CHAR"
    read -r REPLY

    case "${REPLY,,}" in
      ''|y|yes)    return 0 ;;
      concept)     ask_concept ;;
      category)    ask_category ;;
      target_user) ask_target_user ;;
      tone)        ask_tone ;;
      humor)       ask_humor ;;
      verbosity)   ask_verbosity ;;
      voice)       ask_voice ;;
      gdpr)        ask_gdpr ;;
      minors)      ask_minors ;;
      crisis)      ask_crisis ;;
      language)    ask_lang ;;
      scope)       ask_scope ;;
      n|no|quit|exit|abort)
        _blank; echo '  Aborted.'; _blank; exit 0 ;;
      *)
        _err "Unknown field '${REPLY}'. Type a field name from the list above, or press Enter to confirm." ;;
    esac
  done
}

# ── YAML helpers ──────────────────────────────────────────────────────────────

yaml_str() {
  local val="$1"
  val="${val//\\/\\\\}"
  val="${val//\"/\\\"}"
  printf '"%s"' "$val"
}

yaml_nullable() {
  [[ -z "$1" ]] && printf 'null' || yaml_str "$1"
}

# ── Preflight checks ──────────────────────────────────────────────────────────

if ! git -C "$REPO_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
  echo "ERROR: not inside a git repository." >&2; exit 1
fi

if [[ ! -f "$SCRIPT_DIR/ingest.yaml" ]]; then
  echo "ERROR: ingest.yaml not found at $SCRIPT_DIR/ingest.yaml." >&2; exit 1
fi

if ! git -C "$REPO_ROOT" diff --quiet || ! git -C "$REPO_ROOT" diff --cached --quiet; then
  _blank
  echo -e "  ${Y}WARNING${Z}  You have uncommitted changes."
  _info   'They will not be included in the role commit at STEP-10.'
  _blank
fi

# ── Main ──────────────────────────────────────────────────────────────────────

run_collect
run_review

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

_blank
_ok "Session saved to .ingest-session.yaml"

# ── Hand off to Claude for STEP-02 onward ────────────────────────────────────

HANDOFF="Read src/ingest.yaml and execute the role ingestion process starting at STEP-02.
STEP-01 is complete. All collected inputs are in .ingest-session.yaml — use them directly; do not ask the user for anything already captured there.
Pause at STEP-09 (REVIEW) and wait for explicit approval before committing."

_blank

if command -v claude &>/dev/null; then
  _screen_header 'Handing off to Claude  ·  STEP-02 onward'
  _blank
  claude "$HANDOFF"
else
  _screen_header 'Next Step  ·  Continue from STEP-02'
  _blank
  _info 'Paste the following into your AI coding agent to continue:'
  _blank
  _rule
  echo "$HANDOFF"
  _rule
  _blank

  COPIED=false
  if   command -v pbcopy  &>/dev/null; then echo "$HANDOFF" | pbcopy;                    COPIED=true
  elif command -v xclip   &>/dev/null; then echo "$HANDOFF" | xclip -selection clipboard; COPIED=true
  elif command -v xsel    &>/dev/null; then echo "$HANDOFF" | xsel --clipboard --input;   COPIED=true
  elif command -v wl-copy &>/dev/null; then echo "$HANDOFF" | wl-copy;                   COPIED=true
  fi

  $COPIED && _ok 'Copied to clipboard.' || _info 'No clipboard utility found — copy the text above manually.'
fi
