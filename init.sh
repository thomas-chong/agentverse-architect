#!/bin/bash

# --- Function for error handling ---
handle_error() {
  echo -e "\n\n*******************************************************"
  echo "Error: $1"
  echo "*******************************************************"
  exit 1
}

# --- Part 1: Find or Create Google Cloud Project ID ---
PROJECT_FILE="$HOME/project_id.txt"
PROJECT_ID_SET=false

# Helper: verify a project exists in GCP and, if so, adopt it for this session.
# Looks for a project ID from (in priority order):
#   1. $GOOGLE_CLOUD_PROJECT env var (e.g. an assigned/Qwiklabs project)
#   2. The currently active `gcloud config` project
#   3. ~/project_id.txt written by a previous run
# Only if none of those resolve to a valid project do we fall back to creating one.
resolve_project() {
    local candidate=""

    # 1. Environment variable (commonly set by Qwiklabs / event provisioning)
    if [[ -n "$GOOGLE_CLOUD_PROJECT" ]]; then
        candidate="$GOOGLE_CLOUD_PROJECT"
        echo "--- Found project ID in \$GOOGLE_CLOUD_PROJECT: $candidate ---"
    # 2. Currently active gcloud project
    elif ACTIVE_CONFIG_PROJECT=$(gcloud config get-value project 2>/dev/null) && [[ -n "$ACTIVE_CONFIG_PROJECT" && "$ACTIVE_CONFIG_PROJECT" != "(unset)" ]]; then
        candidate="$ACTIVE_CONFIG_PROJECT"
        echo "--- Found active project in gcloud config: $candidate ---"
    # 3. Previously saved project ID file
    elif [[ -s "$PROJECT_FILE" ]]; then
        candidate=$(cat "$PROJECT_FILE" | tr -d '[:space:]')
        echo "--- Found existing project ID in $PROJECT_FILE: $candidate ---"
    fi

    if [[ -z "$candidate" ]]; then
        return 1  # nothing to try; caller will create a new project
    fi

    echo "Verifying this project exists in Google Cloud..."
    if gcloud projects describe "$candidate" --quiet >/dev/null 2>&1; then
        echo "Project '$candidate' successfully verified."
        FINAL_PROJECT_ID=$candidate
        PROJECT_ID_SET=true
        gcloud config set project "$FINAL_PROJECT_ID" || handle_error "Failed to set active project to '$FINAL_PROJECT_ID'."
        echo "Set active gcloud project to '$FINAL_PROJECT_ID'."
        # Persist (or refresh) the file so subsequent runs reuse it directly.
        echo "$FINAL_PROJECT_ID" > "$PROJECT_FILE" || handle_error "Failed to save project ID to $PROJECT_FILE."
        # Qwiklabs/assigned projects come with billing pre-attached; record that hint for the billing script.
        if [[ "$FINAL_PROJECT_ID" == qwiklabs-gcp-* ]]; then
            echo "Detected a Qwiklabs-assigned project. Billing is typically already enabled."
        fi
        return 0
    else
        echo "Warning: Project '$candidate' does not exist or you lack permissions."
        # Only clear a stale file — never touch the env var / gcloud config.
        if [[ -s "$PROJECT_FILE" ]] && [[ "$(cat "$PROJECT_FILE" | tr -d '[:space:]')" == "$candidate" ]]; then
            echo "Removing invalid reference file and proceeding with new project creation."
            rm -f "$PROJECT_FILE"
        fi
        return 1
    fi
}

resolve_project

# If no valid existing project was found, start the interactive creation process
if [ "$PROJECT_ID_SET" = false ]; then
    echo "--- Creating and Setting New Google Cloud Project ID ---"
    CODELAB_PROJECT_PREFIX="agentverse-summoner"

    # Dynamic Length Calculation
    PREFIX_LEN=${#CODELAB_PROJECT_PREFIX}
    if (( PREFIX_LEN > 25 )); then
      handle_error "The project prefix '$CODELAB_PROJECT_PREFIX' is too long (${PREFIX_LEN} chars). Maximum is 25."
    fi
    MAX_SUFFIX_LEN=$(( 30 - PREFIX_LEN - 1 ))
    echo "Project prefix '${CODELAB_PROJECT_PREFIX}' is ${PREFIX_LEN} chars. Suffix will be ${MAX_SUFFIX_LEN} chars."

    # Loop until a project is successfully created.
    while true; do
      RANDOM_SUFFIX=$(LC_ALL=C tr -dc 'a-z0-9' < /dev/urandom | head -c "$MAX_SUFFIX_LEN")
      SUGGESTED_PROJECT_ID="${CODELAB_PROJECT_PREFIX}-${RANDOM_SUFFIX}"

      read -p "Enter project ID or press Enter to use default: " -e -i "$SUGGESTED_PROJECT_ID" FINAL_PROJECT_ID

      if [[ -z "$FINAL_PROJECT_ID" ]]; then
          echo "Project ID cannot be empty. Please try again."
          continue
      fi

      echo "Attempting to create project with ID: $FINAL_PROJECT_ID"
      ERROR_OUTPUT=$(gcloud projects create "$FINAL_PROJECT_ID" --quiet 2>&1)
      CREATE_STATUS=$?

      if [[ $CREATE_STATUS -eq 0 ]]; then
        echo "Successfully created project: $FINAL_PROJECT_ID"
        gcloud config set project "$FINAL_PROJECT_ID" || handle_error "Failed to set active project to $FINAL_PROJECT_ID."
        echo "Set active gcloud project to $FINAL_PROJECT_ID."
        echo "$FINAL_PROJECT_ID" > "$PROJECT_FILE" || handle_error "Failed to save project ID to $PROJECT_FILE."
        echo "Successfully saved project ID to $PROJECT_FILE."
        break
      else
        echo "Could not create project '$FINAL_PROJECT_ID'."
        echo "Reason from gcloud: $ERROR_OUTPUT"
        echo -e "This ID may be taken. Please try a different project ID.\n"
      fi
    done
fi

# --- Part 2: Install Dependencies and Run Billing Setup ---
# This part runs for both existing and newly created projects.
echo -e "\n--- Installing Python dependencies ---"
pip install --upgrade --user google-cloud-billing || handle_error "Failed to install Python libraries."

echo -e "\n--- Running the Billing Enablement Script ---"
python3 billing-enablement.py || handle_error "The billing enablement script failed. See the output above for details."

echo -e "\n--- Full Setup Complete ---"
exit 0