#!/bin/bash

# This script sets various Google Cloud related environment variables.
# It must be SOURCED to make the variables available in your current shell.

# Example: source ./set_env.sh

# --- Configuration ---
PROJECT_FILE="~/project_id.txt"
# This base name is for other workshops; Summoner's variables are defined below.
export REPO_NAME="agentverse-repo"
# ---------------------


echo "--- Setting Google Cloud Environment Variables ---"

# --- Authentication Check ---
echo "Checking gcloud authentication status..."

# Run a command that requires authentication (like listing accounts or printing a token)
# Redirect stdout and stderr to /dev/null so we don't see output unless there's a real error

if gcloud auth print-access-token > /dev/null 2>&1; then
  echo "gcloud is authenticated."
else
  echo "Error: gcloud is not authenticated."
  echo "Please log in by running: gcloud auth login"
  return 1
fi
# --- --- --- --- --- ---



# 1. Check if project file exists
PROJECT_FILE_PATH=$(eval echo $PROJECT_FILE) # Expand potential ~
if [ ! -f "$PROJECT_FILE_PATH" ]; then
  echo "Error: Project file not found at $PROJECT_FILE_PATH"
  echo "Please create $PROJECT_FILE_PATH containing your Google Cloud project ID."
  return 1 # Return 1 as we are sourcing
fi

# 2. Set the default gcloud project configuration
PROJECT_ID_FROM_FILE=$(cat "$PROJECT_FILE_PATH")
echo "Setting gcloud config project to: $PROJECT_ID_FROM_FILE"

# Adding --quiet; set -e will handle failure if the project doesn't exist or access is denied
gcloud config set project "$PROJECT_ID_FROM_FILE" --quiet

# 3. Export PROJECT_ID (Get from config to confirm it was set correctly)
export PROJECT_ID=$(gcloud config get project)
echo "Exported PROJECT_ID=$PROJECT_ID"

# 4. Export PROJECT_NUMBER
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} --format="value(projectNumber)")
echo "Exported PROJECT_NUMBER=$PROJECT_NUMBER"

# 5. Export SERVICE_ACCOUNT_NAME (Default Compute Service Account)
export SERVICE_ACCOUNT_NAME=$(gcloud compute project-info describe --format="value(defaultServiceAccount)")
echo "Exported SERVICE_ACCOUNT_NAME=$SERVICE_ACCOUNT_NAME"


# 6. Export GOOGLE_CLOUD_PROJECT (Often used by client libraries)
# This is usually the same as PROJECT_ID
export GOOGLE_CLOUD_PROJECT="$PROJECT_ID"
echo "Exported GOOGLE_CLOUD_PROJECT=$GOOGLE_CLOUD_PROJECT"

# 9. Export GOOGLE_GENAI_USE_VERTEXAI
export GOOGLE_GENAI_USE_VERTEXAI="TRUE"
echo "Exported GOOGLE_GENAI_USE_VERTEXAI=$GOOGLE_GENAI_USE_VERTEXAI"

# 10. Export REGION and GOOGLE_CLOUD_LOCATION
# Resolve against the project's effective gcp.resourceLocations org policy — the
# source of truth for which regions Qwiklabs permits. We deliberately do NOT
# trust a previously-exported $REGION or gcloud compute/region blindly: an
# earlier run may have cached a region (e.g. us-east1 from the Cloud Shell zone)
# that the org policy rejects, which makes Artifact Registry / Cloud Run / Cloud
# SQL creation fail with "Location ... violates organization policy".

# Read the allowed-values list (e.g. "in:us-central1-,in:us-central2-").
_orgpolicy_regions() {
  gcloud org-policies describe gcp.resourceLocations \
    --project="$PROJECT_ID" --effective \
    --format='value(spec.values.allowedValues)' 2>/dev/null \
  || gcloud resource-manager org-policies describe gcp.resourceLocations \
    --effective --project="$PROJECT_ID" \
    --format='value(listPolicy.allowedValues)' 2>/dev/null
}

# Return 0 if region $1 is permitted by allowed-list $2.
_region_ok() {
  local r="$1" allowed="$2"
  [ -n "$allowed" ] || return 0   # empty/unreadable policy => treat as unrestricted
  echo "$allowed" | tr ',' '\n' | grep -qE "^in:${r}-$|^${r}$"
}

# Pick the best region purely from the org policy (prefer us-central1).
_pick_from_policy() {
  local allowed="$1" r=""
  if _region_ok us-central1 "$allowed"; then echo "us-central1"; return; fi
  r=$(echo "$allowed" | tr ',' '\n' \
        | grep -Eo 'in:[a-z]+-[a-z]+[0-9]-$' | head -1 | sed 's/^in://; s/-$//')
  [ -n "$r" ] && { echo "$r"; return; }
  r=$(echo "$allowed" | tr ',' '\n' | grep -Eo '^[a-z]+-[a-z]+[0-9]$' | head -1)
  echo "${r}"
}

ALLOWED=$(_orgpolicy_regions)

if [ -z "$ALLOWED" ]; then
  # Policy couldn't be read. Don't trust a possibly-stale $REGION/gcloud config;
  # fall back to the codelab's canonical region.
  if [ -n "$REGION" ]; then
    echo "Discarding previously-set REGION='$REGION' (could not verify against org policy)."
  fi
  REGION="us-central1"
  echo "WARNING: could not read gcp.resourceLocations; defaulting to us-central1."
  echo "If creation fails with 'violates organization policy', find your region:"
  echo "  gcloud org-policies describe gcp.resourceLocations \\"
  echo "    --project=\$PROJECT_ID --effective \\"
  echo "    --format='value(spec.values.allowedValues)'"
  echo "then: gcloud config set compute/region <ALLOWED_REGION> && . ./set_env.sh"
else
  # We have a policy. If the current REGION (env or gcloud config) isn't allowed,
  # discard it and pick a valid one.
  _CFG_REGION=$(gcloud config get-value compute/region 2>/dev/null)
  if [ -n "$REGION" ] && _region_ok "$REGION" "$ALLOWED"; then
    : # keep the explicit, policy-valid $REGION
  elif [ -n "$_CFG_REGION" ] && [ "$_CFG_REGION" != "(unset)" ] && _region_ok "$_CFG_REGION" "$ALLOWED"; then
    echo "Discarding stale REGION='$REGION'; resolved from gcloud compute/region: $_CFG_REGION"
    REGION="$_CFG_REGION"
  else
    if [ -n "$REGION" ]; then
      echo "Discarding stale REGION='$REGION' — not permitted by gcp.resourceLocations ($ALLOWED)."
    elif [ -n "$_CFG_REGION" ] && [ "$_CFG_REGION" != "(unset)" ]; then
      echo "Discarding stale gcloud compute/region='$_CFG_REGION' — not permitted by gcp.resourceLocations."
    fi
    REGION=$(_pick_from_policy "$ALLOWED")
    [ -n "$REGION" ] && echo "Resolved REGION from org policy gcp.resourceLocations: $REGION (allowed: $ALLOWED)"
  fi

  if [ -z "$REGION" ]; then
    REGION="us-central1"
    echo "WARNING: org policy listed no usable region; defaulting to us-central1."
  fi
fi

export REGION
export GOOGLE_CLOUD_LOCATION="$REGION"
# Persist the validated region into gcloud config so subsequent gcloud calls agree.
gcloud config set compute/region "$REGION" >/dev/null 2>&1 || true
echo "Exported REGION=$REGION"
echo "Exported GOOGLE_CLOUD_LOCATION=$GOOGLE_CLOUD_LOCATION"


export TOOLBOX_VERSION=0.10.0
echo "Exported TOOLBOX_VERSION=$TOOLBOX_VERSION"

# -- Cloud SQL (Librarium of Knowledge) --
export DB_INSTANCE_NAME="summoner-librarium-db"
export DB_NAME="familiar_grimoire"
export DB_USER="summoner"
export DB_PASSWORD="1234qwer"
echo "Exported DB_INSTANCE_NAME=$DB_INSTANCE_NAME"
echo "Exported DB_NAME=$DB_NAME"
echo "Exported DB_USER=$DB_USER"
echo "Exported DB_PASSWORD=$DB_PASSWORD"

export FAKE_API_SERVICE_NAME="nexus-of-whispers-api"
echo "Exported FAKE_API_SERVICE_NAME=$FAKE_API_SERVICE_NAME"

export API_SERVER_URL=$(gcloud run services describe $FAKE_API_SERVICE_NAME --format 'value(status.url)' --region $REGION 2>/dev/null || true)
echo "Exported API_SERVER_URL=$API_SERVER_URL"

export FIRE_URL=$(gcloud run services describe fire-familiar --platform managed --region $REGION --format 'value(status.url)' 2>/dev/null || true)
echo "Exported FIRE_URL=$FIRE_URL"

export WATER_URL=$(gcloud run services describe water-familiar --platform managed --region $REGION --format 'value(status.url)' 2>/dev/null || true)
echo "Exported WATER_URL=$WATER_URL"

export EARTH_URL=$(gcloud run services describe earth-familiar --platform managed --region $REGION --format 'value(status.url)' 2>/dev/null || true)
echo "Exported EARTH_URL=$EARTH_URL"

export DB_TOOLS_URL=$(gcloud run services describe toolbox --platform managed --region $REGION --format 'value(status.url)' 2>/dev/null || true)
echo "Exported DB_TOOLS_URL=$DB_TOOLS_URL"

# Note: If the following gcloud commands fail, the variable will be set to just "/sse".
export API_TOOLS_URL=$(gcloud run services describe api-tools-mcp --platform managed --region $REGION --format 'value(status.url)' 2>/dev/null || true)/sse
echo "Exported API_TOOLS_URL=$API_TOOLS_URL"

export FUNCTION_TOOLS_URL=$(gcloud run services describe general-tools-mcp --platform managed --region $REGION --format 'value(status.url)' 2>/dev/null || true)/sse
echo "Exported FUNCTION_TOOLS_URL=$FUNCTION_TOOLS_URL"

export A2A_BASE_URL="-${PROJECT_NUMBER}.${REGION}.run.app"
echo "Exported A2A_BASE_URL=$A2A_BASE_URL"

# ===================================================================

echo ""
echo "--- Environment setup complete ---"