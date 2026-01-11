#!/usr/bin/env bash

# Automatically compile docker images information from docker-compose.yml files
# NixOS compatible script

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="${SCRIPT_DIR}/docker-images.json"

# Temporary file for collecting data
TEMP_JSON=$(mktemp)
trap "rm -f $TEMP_JSON" EXIT

# Function to extract tag from image string
# Input: "image:tag" or "registry/image:tag" or "image"
# Output: "tag" or "latest" if no tag
extract_tag() {
    local image="$1"
    if [[ "$image" == *:* ]]; then
        echo "${image##*:}"
    else
        echo "latest"
    fi
}

# Function to extract repo from image string
# Input: "image:tag" or "registry/image:tag" or "image"
# Output: "registry/image" or "image"
extract_repo() {
    local image="$1"
    echo "${image%:*}"
}

# Function to determine source registry
detect_source() {
    local repo="$1"
    if [[ "$repo" == "lscr.io"* ]]; then
        echo "LinuxServer"
    elif [[ "$repo" == *"/"* ]]; then
        echo "Docker Hub"
    else
        echo "Docker Hub"
    fi
}

# Function to sanitize registry prefix for repo output
# "lscr.io/linuxserver/overseerr" -> "linuxserver/overseerr"
sanitize_repo() {
    local repo="$1"
    repo="${repo#lscr.io/}"
    echo "$repo"
}

# Function to extract repo URL from repo.json
get_repo_info() {
    local compose_dir="$1"
    local repo_file="${compose_dir}/repo.json"
    
    if [[ -f "$repo_file" ]] && command -v jq &> /dev/null; then
        local owner=$(jq -r '.owner // empty' "$repo_file" 2>/dev/null)
        local repo=$(jq -r '.repo // empty' "$repo_file" 2>/dev/null)
        if [[ -n "$owner" && -n "$repo" ]]; then
            echo "$owner|$repo"
        fi
    fi
}

# Start JSON array
echo "[" > "$TEMP_JSON"

first=true

# Find all docker-compose files
while IFS= read -r compose_file; do
    # Skip if file doesn't exist
    [[ ! -f "$compose_file" ]] && continue
    
    # Get the directory containing the compose file
    compose_dir="$(dirname "$compose_file")"
    
    # Get repo info if available (owner|repo format)
    repo_info=$(get_repo_info "$compose_dir")
    
    # Extract service name and image for each service
    # Using grep to find image lines, then processing them
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" ]] && continue
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        
        # Look for "image:" lines
        if [[ "$line" =~ image:[[:space:]]*(.+)$ ]]; then
            image_spec="${BASH_REMATCH[1]}"
            # Remove quotes if present
            image_spec="${image_spec//\"/}"
            image_spec="${image_spec//\'/}"
            image_spec="$(echo "$image_spec" | xargs)"  # trim whitespace
            
            # Extract components
            tag=$(extract_tag "$image_spec")
            full_repo=$(extract_repo "$image_spec")
            source=$(detect_source "$full_repo")
            repo=$(sanitize_repo "$full_repo")
            
            # Extract friendly name from path and image
            dir_name=$(basename "$compose_dir")
            service_name=$(echo "$image_spec" | sed 's/.*\///' | sed 's/:.*//g' | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
            
            # Use directory name for better friendly names
            case "$dir_name" in
                java-minecraft) friendly_name="Minecraft Server" ;;
                uptime-kuma) friendly_name="Uptime Kuma" ;;
                homeassistant) friendly_name="Home Assistant" ;;
                *) friendly_name="$service_name" ;;
            esac
            
            # Add comma if not first entry
            if [ "$first" = false ]; then
                echo "," >> "$TEMP_JSON"
            fi
            first=false
            
            # Build JSON object
            cat >> "$TEMP_JSON" << EOF
  {
    "service": "$friendly_name",
    "image": "$image_spec",
    "source": "$source",
    "repo": "$repo",
    "tag": "$tag"$(if [[ -n "$repo_info" ]]; then IFS='|' read -r owner repo_name <<< "$repo_info"; echo ","; echo '    "owner": "'"$owner"'",'; echo '    "repository": "'"$repo_name"'"'; fi)
  }
EOF
        fi
    done < "$compose_file"
    
done < <(find "$SCRIPT_DIR" -name "docker-compose.yml" -type f)

# Close JSON array
echo "" >> "$TEMP_JSON"
echo "]" >> "$TEMP_JSON"

# Validate JSON and output
if command -v jq &> /dev/null; then
    jq '.' "$TEMP_JSON" > "$OUTPUT_FILE"
    echo "✓ Generated $OUTPUT_FILE (validated with jq)"
else
    mv "$TEMP_JSON" "$OUTPUT_FILE"
    echo "✓ Generated $OUTPUT_FILE (jq not available, skipping validation)"
fi

echo "Found $(grep -c '"service"' "$OUTPUT_FILE") services"
