#!/usr/bin/env bash
# resolve.sh -- Lightweight role resolver for agent-roledefinitions-submodule
# Parses index.yaml using native bash/awk. Zero external dependencies.
# Usage: ./resolve.sh --list | --id <id> | --category <cat> | --tag <tag>

set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
INDEX="$BASE_DIR/index.yaml"

usage() {
    cat <<'EOF'
Usage: resolve.sh [OPTIONS]

Options:
  --list                 List all role IDs
  --id <id>              Print the prompt content for a role by ID
  --id <id> --path       Print the prompt file path instead of content
  --id <id> --semanticode  Print the semanticode variant instead
  --category <category>  List role IDs in a category
  --tag <tag>            List role IDs matching a tag
  --base-dir <path>      Override the base directory (default: script directory)
  --help                 Show this help message

Examples:
  ./resolve.sh --list
  ./resolve.sh --id forge
  ./resolve.sh --id tag --semanticode
  ./resolve.sh --category entertainment
  ./resolve.sh --tag stateful
  ./resolve.sh --base-dir lib/roles --id forge
EOF
    exit 0
}

# Parse arguments
ACTION=""
TARGET=""
VARIANT="prompt"
PATH_ONLY=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --list)         ACTION="list"; shift ;;
        --id)           ACTION="id"; TARGET="$2"; shift 2 ;;
        --category)     ACTION="category"; TARGET="$2"; shift 2 ;;
        --tag)          ACTION="tag"; TARGET="$2"; shift 2 ;;
        --base-dir)     BASE_DIR="$2"; INDEX="$BASE_DIR/index.yaml"; shift 2 ;;
        --semanticode)  VARIANT="semanticode"; shift ;;
        --path)         PATH_ONLY=true; shift ;;
        --help)         usage ;;
        *)              echo "Unknown option: $1" >&2; usage ;;
    esac
done

if [[ -z "$ACTION" ]]; then
    usage
fi

if [[ ! -f "$INDEX" ]]; then
    echo "Error: index.yaml not found at $INDEX" >&2
    exit 1
fi

# --- List all role IDs ---
list_ids() {
    awk '/^  - id:/ { gsub(/^  - id: */, ""); print }' "$INDEX"
}

# --- Get a field value for a specific role ID ---
# Extracts the block for a given role ID and finds a field within it.
get_role_field() {
    local role_id="$1"
    local field="$2"

    awk -v id="$role_id" -v field="$field" '
        /^  - id:/ {
            current_id = $NF
            in_block = (current_id == id)
            next
        }
        in_block && $0 ~ "^      " field ": " {
            val = $0
            sub("^[ ]*" field ": *", "", val)
            gsub(/"/, "", val)
            print val
            exit
        }
        # End of block: next role or end of file
        in_block && /^  - id:/ { exit }
    ' "$INDEX"
}

# --- Get prompt file path for a role ID ---
get_prompt_path() {
    local role_id="$1"
    local variant="$2"

    awk -v id="$role_id" -v variant="$variant" '
        /^  - id:/ {
            current_id = $NF
            in_block = (current_id == id)
            next
        }
        in_block && $0 ~ "^      " variant ": " {
            val = $0
            sub("^[ ]*" variant ": *", "", val)
            gsub(/"/, "", val)
            if (val == "null" || val == "") {
                print "NULL"
            } else {
                print val
            }
            exit
        }
        in_block && /^  - id:/ { exit }
    ' "$INDEX"
}

# --- List role IDs matching a category ---
list_by_category() {
    local category="$1"

    awk -v cat="$category" '
        /^  - id:/ {
            current_id = $NF
            next
        }
        /^    category:/ {
            current_cat = $NF
            if (current_cat == cat) {
                print current_id
            }
        }
    ' "$INDEX"
}

# --- List role IDs matching a tag ---
list_by_tag() {
    local tag="$1"

    awk -v tag="$tag" '
        /^  - id:/ {
            current_id = $NF
            in_tags = 0
            next
        }
        /^    tags:/ {
            in_tags = 1
            next
        }
        in_tags && /^      - / {
            t = $NF
            if (t == tag) {
                print current_id
            }
            next
        }
        in_tags && !/^      - / {
            in_tags = 0
        }
    ' "$INDEX"
}

# --- Execute ---
case "$ACTION" in
    list)
        list_ids
        ;;
    id)
        prompt_path=$(get_prompt_path "$TARGET" "$VARIANT")
        if [[ -z "$prompt_path" || "$prompt_path" == "NULL" ]]; then
            echo "Error: no $VARIANT file for role '$TARGET'" >&2
            exit 1
        fi
        full_path="$BASE_DIR/$prompt_path"
        if $PATH_ONLY; then
            echo "$full_path"
        else
            if [[ ! -f "$full_path" ]]; then
                echo "Error: file not found: $full_path" >&2
                exit 1
            fi
            cat "$full_path"
        fi
        ;;
    category)
        results=$(list_by_category "$TARGET")
        if [[ -z "$results" ]]; then
            echo "No roles found in category '$TARGET'" >&2
            exit 1
        fi
        echo "$results"
        ;;
    tag)
        results=$(list_by_tag "$TARGET")
        if [[ -z "$results" ]]; then
            echo "No roles found with tag '$TARGET'" >&2
            exit 1
        fi
        echo "$results"
        ;;
esac
