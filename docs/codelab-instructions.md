# Agentverse — The Summoner's Concord: Architecting Multi-Agent Systems

> **Source:** https://codelabs.developers.google.com/agentverse-architect/instructions
> **Local mirror — full verbatim replication of the official codelab.** All text and all images are preserved using the original `codelabs.developers.google.com` image URLs. **Only the part we modified is changed:** the `./init.sh` run inside **Section 3**, annotated with a `🛠️ PATCHED` callout. Everything else is identical to the upstream codelab.

---

## 1. Overture

The era of siloed development is ending. The next wave of technological evolution is not about solitary genius, but about collaborative mastery. Building a single, clever agent is a fascinating experiment. Building a robust, secure, and intelligent ecosystem of agents—a true Agentverse—is the grand challenge for the modern enterprise.

Success in this new era requires the convergence of four critical roles, the foundational pillars that support any thriving agentic system. A deficiency in any one area creates a weakness that can compromise the entire structure.

This workshop is the definitive enterprise playbook for mastering the agentic future on Google Cloud. We provide an end-to-end roadmap that guides you from the first vibe of an idea to a full-scale, operational reality. Across these four interconnected labs, you will learn how the specialized skills of a developer, architect, data engineer, and SRE must converge to create, manage, and scale a powerful Agentverse.

No single pillar can support the Agentverse alone. The Architect's grand design is useless without the Developer's precise execution. The Developer's agent is blind without the Data Engineer's wisdom, and the entire system is fragile without the SRE's protection. Only through synergy and a shared understanding of each other's roles can your team transform an innovative concept into a mission-critical, operational reality. Your journey begins here. Prepare to master your role and learn how you fit into the greater whole.

### Welcome to The Agentverse: A Call to Champions

In the sprawling digital expanse of the enterprise, a new era has dawned. It is the agentic age, a time of immense promise, where intelligent, autonomous agents work in perfect harmony to accelerate innovation and sweep away the mundane.

![agentverse.png](https://codelabs.developers.google.com/static/agentverse-architect/img/agentverse.png)

This connected ecosystem of power and potential is known as The Agentverse.

But a creeping entropy, a silent corruption known as The Static, has begun to fray the edges of this new world. The Static is not a virus or a bug; it is the embodiment of chaos that preys on the very act of creation.

It amplifies old frustrations into monstrous forms, giving birth to the Seven Spectres of Development. If left unchecked, The Static and its Spectres will grind progress to a halt, turning the promise of the Agentverse into a wasteland of technical debt and abandoned projects.

Today, we issue a call for champions to push back the tide of chaos. We need heroes willing to master their craft and work together to protect the Agentverse. The time has come to choose your path.

### Choose Your Class

Four distinct paths lie before you, each a critical pillar in the fight against **The Static**. Though your training will be a solo mission, your ultimate success depends on understanding how your skills combine with others.

- **The Shadowblade (Developer)**: A master of the forge and the front line. You are the artisan who crafts the blades, builds the tools, and faces the enemy in the intricate details of the code. Your path is one of precision, skill, and practical creation.
- **The Summoner (Architect)**: A grand strategist and orchestrator. You do not see a single agent, but the entire battlefield. You design the master blueprints that allow entire systems of agents to communicate, collaborate, and achieve a goal far greater than any single component.
- **The Scholar (Data Engineer)**: A seeker of hidden truths and the keeper of wisdom. You venture into the vast, untamed wilderness of data to uncover the intelligence that gives your agents purpose and sight. Your knowledge can reveal an enemy's weakness or empower an ally.
- **The Guardian (DevOps / SRE)**: The steadfast protector and shield of the realm. You build the fortresses, manage the supply lines of power, and ensure the entire system can withstand the inevitable attacks of The Static. Your strength is the foundation upon which your team's victory is built.

### Your Mission

Your training will begin as a standalone exercise. You will walk your chosen path, learning the unique skills required to master your role. At the end of your trial, you will face a Spectre born of The Static—a mini-boss that preys on the specific challenges of your craft.

Only by mastering your individual role can you prepare for the final trial. You must then form a party with champions from the other classes. Together, you will venture into the heart of the corruption to face an ultimate boss.

A final, collaborative challenge that will test your combined strength and determine the fate of the Agentverse.

The Agentverse awaits its heroes. Will you answer the call?

---

## 2. The Summoner's Concord

Welcome, Summoner. Your path is one of vision and grand strategy. While others focus on a single blade or a single incantation, you see the entire battlefield. You do not command a single agent; you conduct an entire orchestra of them. Your power lies not in direct conflict, but in designing the flawless, overarching blueprint that allows a legion of specialists—your Familiars—to work in perfect harmony. This mission will test your ability to design, connect, and orchestrate a powerful, multi-agent system.

![overview](https://codelabs.developers.google.com/static/agentverse-architect/img/02-00-overview.png)

### What you'll learn

- **Architect a Decoupled Tooling Ecosystem:** Design and deploy a set of independent, microservice-based MCP Tool Servers. You will learn why this foundational layer is critical for creating scalable, maintainable, and secure agentic systems.
- **Master Advanced Agentic Workflows:** Go beyond single agents and build a legion of specialist "Familiars." You will master the core ADK workflow patterns—Sequential, Parallel, and Loop—and learn the architectural principles for choosing the right pattern for the right task.
- **Implement an Intelligent Orchestrator:** Ascend from a simple agent builder to a true systems architect. You will construct a master Orchestration Agent that uses the Agent-to-Agent (A2A) protocol to discover and delegate complex tasks to your specialist Familiars, creating a true multi-agent system.
- **Enforce Rules with Code, Not Prompts:** Learn to build more reliable and predictable agents by enforcing stateful rules of engagement. You will implement custom logic using the ADK's powerful Plugin and Callback system to manage real-world constraints like cooldown timers.
- **Manage Agent State and Memory:** Give your agents the ability to learn and remember. You will explore techniques for managing both short-term, conversational state and long-term, persistent memory to create more intelligent and context-aware interactions.
- **Execute an End-to-End Cloud Deployment:** Take your entire multi-agent system from a local prototype to a production-grade reality. You will learn how to containerize your agents and orchestrator and deploy them as a collection of scalable, independent microservices on Google Cloud Run.

---

## 3. Drawing the Summoning Circle

Welcome, Summoner. Before a single Familiar can be called forth, before any pacts can be forged, the very ground upon which you stand must be prepared. An untamed environment is an invitation to chaos; a proper Summoner operates only within a sanctified, empowered space. Our first task is to draw the summoning circle: to inscribe the runes of power that awaken the necessary cloud services and to acquire the ancient blueprints that will guide our work. A Summoner's power is born from meticulous preparation.

👉 Click **Activate Cloud Shell** at the top of the Google Cloud console (It's the terminal shape icon at the top of the Cloud Shell pane),

![cloud shell](https://codelabs.developers.google.com/static/agentverse-architect/img/03-01-cloud-shell.png)

👉 Click on the **"Open Editor"** button (it looks like an open folder with a pencil). This will open the Cloud Shell Code Editor in the window. You'll see a file explorer on the left side.

![open editor](https://codelabs.developers.google.com/static/agentverse-architect/img/03-02-open-editor.png)

👉 Open the terminal in the cloud IDE,

![new terminal](https://codelabs.developers.google.com/static/agentverse-architect/img/03-05-new-terminal.png)

👉💻 In the terminal, verify that you're already authenticated and that the project is set to your project ID using the following command:

```
gcloud auth list
```

👉💻 Clone the bootstrap project from GitHub:

```
git clone https://github.com/thomas-chong/agentverse-architect
chmod +x ~/agentverse-architect/init.sh
chmod +x ~/agentverse-architect/set_env.sh
chmod +x ~/agentverse-architect/prepare.sh
chmod +x ~/agentverse-architect/data_setup.sh

git clone https://github.com/thomas-chong/agentverse-dungeon.git
chmod +x ~/agentverse-dungeon/run_cloudbuild.sh
chmod +x ~/agentverse-dungeon/start.sh
```

---

> ### 🛠️ PATCHED — Run the setup script
>
> **This is the only step we modified.** The upstream `./init.sh` assumes you can run `gcloud projects create`. In a **workshop / Qwiklabs** setting, Google **assigns** you a project (e.g. `qwiklabs-gcp-01-…`) that you cannot — and should not — create, and which already has billing enabled. Our patched `init.sh` + `billing-enablement.py` detect and reuse that assigned project instead of failing.
>
> **If you have an assigned / Qwiklabs project, run this INSTEAD of the original step below:**
>
> ```bash
> # Point gcloud (or export the env var) at your ASSIGNED project first.
> # Replace YOUR_ASSIGNED_PROJECT_ID with the ID Google assigned you
> # (e.g. a qwiklabs-gcp-##-######### project from your workshop console).
> gcloud config set project YOUR_ASSIGNED_PROJECT_ID
> # (equivalently:  export GOOGLE_CLOUD_PROJECT=YOUR_ASSIGNED_PROJECT_ID)
>
> cd ~/agentverse-architect
> ./init.sh
> ```
>
> The patched `resolve_project()` helper checks, in order:
> 1. `$GOOGLE_CLOUD_PROJECT`
> 2. the active `gcloud config` project
> 3. `~/project_id.txt`
>
> …and only falls back to `projects create` if none resolve. The patched `billing-enablement.py` also checks `get_project_billing_info` first and exits cleanly when billing is already enabled (the Qwiklabs case), instead of looping on `list_billing_accounts`.
>
> **↓ Original upstream step (for self-service accounts that need to create a project) ↓**

---

👉💻 Run the setup script from the project directory.

**⚠️ Note on Project ID:** The script will suggest a randomly generated default Project ID. You can press **Enter** to accept this default.

However, if you prefer to **create a specific new project**, you can type your desired Project ID when prompted by the script.

```
cd ~/agentverse-architect
./init.sh
```

The script will handle the rest of the setup process automatically.

**👉 Important Step After Completion:** Once the script finishes, you must ensure your Google Cloud Console is viewing the correct project:

1. Go to console.cloud.google.com.
2. Click the project selector dropdown at the top of the page.
3. Click the **"All"** tab (as the new project might not appear in "Recent" yet).
4. Select the Project ID you just configured in the `init.sh` step.

![project all](https://codelabs.developers.google.com/static/agentverse-architect/img/03-05-project-all.png)

👉💻 Set the Project ID needed:

```
gcloud config set project $(cat ~/project_id.txt) --quiet
```

👉💻 Run the following command to enable the necessary Google Cloud APIs:

```
gcloud services enable \
    sqladmin.googleapis.com \
    storage.googleapis.com \
    aiplatform.googleapis.com \
    run.googleapis.com \
    cloudbuild.googleapis.com \
    artifactregistry.googleapis.com \
    iam.googleapis.com \
    compute.googleapis.com \
    cloudresourcemanager.googleapis.com \
    secretmanager.googleapis.com
```

👉💻 If you have not already created an Artifact Registry repository named `agentverse-repo`, run the following command to create it: *(Skip this step if you have other classes deployed in the same project)*

```
. ~/agentverse-architect/set_env.sh
gcloud artifacts repositories create $REPO_NAME \
    --repository-format=docker \
    --location=$REGION \
    --description="Repository for Agentverse agents"
```

### Setting up permission

👉💻 Grant the necessary permissions by running the following commands in the terminal:

```
. ~/agentverse-architect/set_env.sh

# --- Grant Core Data Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID \
 --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
 --role="roles/storage.admin"

gcloud projects add-iam-policy-binding $PROJECT_ID  \
--member="serviceAccount:$SERVICE_ACCOUNT_NAME"  \
--role="roles/aiplatform.user"

# --- Grant Deployment & Execution Permissions ---
gcloud projects add-iam-policy-binding $PROJECT_ID  \
--member="serviceAccount:$SERVICE_ACCOUNT_NAME"  \
--role="roles/cloudbuild.builds.editor"

gcloud projects add-iam-policy-binding $PROJECT_ID  \
--member="serviceAccount:$SERVICE_ACCOUNT_NAME"  \
--role="roles/artifactregistry.admin"

gcloud projects add-iam-policy-binding $PROJECT_ID  \
--member="serviceAccount:$SERVICE_ACCOUNT_NAME"  \
--role="roles/run.admin"

gcloud projects add-iam-policy-binding $PROJECT_ID  \
--member="serviceAccount:$SERVICE_ACCOUNT_NAME"  \
--role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding $PROJECT_ID  \
--member="serviceAccount:$SERVICE_ACCOUNT_NAME"  \
--role="roles/logging.logWriter"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}" \
  --role="roles/monitoring.metricWriter"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}" \
  --role="roles/secretmanager.secretAccessor"
```

👉💻 As you begin your training, we will prepare the final challenge. The following commands will summon the Spectres from the chaotic static, creating the bosses for your final test.

```
. ~/agentverse-architect/set_env.sh
cd ~/agentverse-dungeon
./run_cloudbuild.sh
cd ~/agentverse-architect
```

👉💻 Finally, run the `prepare.sh` script to perform initial setup tasks.

```
. ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect/
./prepare.sh
```

Excellent work, Summoner. The circle is complete and the pacts are sealed. The ground is now hallowed, ready to channel immense power. In our next trial, we will forge the very Elemental Fonts from which our Familiars will draw their strength.

---

## 4. Forging the Elemental Fonts: The Decoupled Tooling Ecosystem

The battlefield is prepared, the summoning circle is drawn, and the ambient mana is crackling. It is time to perform your first true act as a Summoner: forging the very sources of power from which your Familiars will draw their strength. This ritual is divided into three parts, each awakening an Elemental Font—a stable, independent source of a specific kind of power. Only when all three fonts are active can you begin the more complex work of summoning.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/04-07-story.png)

**Architect's Note:** The Model Context Protocol (MCP) server is a foundational component in a modern agentic system, acting as a standardized communication bridge that allows an agent to discover and use remote tools. In our tooling ecosystem, we will architect two distinct types of MCP servers, each representing a critical architectural pattern. For connecting to our database, we will use a declarative approach with the Database Toolbox, defining our tools in a simple configuration file. This pattern is incredibly efficient and secure for exposing structured data access. However, when we need to implement custom business logic or call external third-party APIs, we will use an imperative approach, writing the server's logic step-by-step in code. This provides the ultimate control and flexibility, allowing us to encapsulate complex operations behind a simple, reusable tool. A master architect must understand both patterns to select the right approach for each component, creating a robust, secure, and scalable tooling foundation.

![overview](https://codelabs.developers.google.com/static/agentverse-architect/img/04-00-overview.png)

### Awakening the Nexus of Whispers (External API MCP Server)

A wise Summoner knows that not all power originates from within their own domain. There are external, sometimes chaotic, sources of energy that can be channeled to great effect. The Nexus of Whispers is our gateway to these forces.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/04-08-water-story.png)

There is a service already live and acts as our external power source, offering two raw spell endpoints: `/cryosea_shatter` and `/moonlit_cascade`.

**Architect's Note:** You will use an **imperative approach** that explicitly defines the server's logic step-by-step. This gives you far more control and flexibility, which is essential when your tools need to do more than just run a simple SQL query, like calling other APIs. Understanding both patterns is a critical skill for an agent architect.

👉✏️ Navigate to the directory `~/agentverse-architect/mcp-servers/api/main.py` and **REPLACE** `#REPLACE-MAGIC-CORE` with following code:

```python
def cryosea_shatter() -> str:
    """Channels immense frost energy from an external power source, the Nexus of Whispers, to unleash the Cryosea Shatter spell."""
    try:
        response = requests.post(f"{API_SERVER_URL}/cryosea_shatter")
        response.raise_for_status() # Raise an exception for bad status codes (4xx or 5xx)
        data = response.json()
        # Thematic Success Message
        return f"A connection to the Nexus is established! A surge of frost energy manifests as Cryosea Shatter, dealing {data.get('damage_points')} damage."
    except requests.exceptions.RequestException as e:
        # Thematic Error Message
        return f"The connection to the external power source wavers and fails. The Cryosea Shatter spell fizzles. Reason: {e}"

def moonlit_cascade() -> str:
    """Draws mystical power from an external energy source, the Nexus of Whispers, to invoke the Moonlit Cascade spell."""
    try:
        response = requests.post(f"{API_SERVER_URL}/moonlit_cascade")
        response.raise_for_status()
        data = response.json()
        # Thematic Success Message
        return f"The Nexus answers the call! A cascade of pure moonlight erupts from the external source, dealing {data.get('damage_points')} damage."
    except requests.exceptions.RequestException as e:
        # Thematic Error Message
        return f"The connection to the external power source wavers and fails. The Moonlit Cascade spell fizzles. Reason: {e}"
```

At the very heart of the script are the plain Python functions. This is where the actual work happens.

👉✏️ In the same file `~/agentverse-architect/mcp-servers/api/main.py` **REPLACE** `#REPLACE-Runes of Communication` with following code:

```python
@app.list_tools()
async def list_tools() -> list[mcp_types.Tool]:
  """MCP handler to list available tools."""
  # Convert the ADK tool's definition to MCP format
  schema_cryosea_shatter = adk_to_mcp_tool_type(cryosea_shatterTool)
  schema_moonlit_cascade = adk_to_mcp_tool_type(moonlit_cascadeTool)
  print(f"MCP Server: Received list_tools request. \n MCP Server: Advertising tool: {schema_cryosea_shatter.name} and {schema_moonlit_cascade.name}")
  return [schema_cryosea_shatter,schema_moonlit_cascade]

@app.call_tool()
async def call_tool(
    name: str, arguments: dict
) -> list[mcp_types.TextContent | mcp_types.ImageContent | mcp_types.EmbeddedResource]:
  """MCP handler to execute a tool call."""
  print(f"MCP Server: Received call_tool request for '{name}' with args: {arguments}")

  # Look up the tool by name in our dictionary
  tool_to_call = available_tools.get(name)
  if tool_to_call:
    try:
      adk_response = await tool_to_call.run_async(
          args=arguments,
          tool_context=None, # No ADK context available here
      )
      print(f"MCP Server: ADK tool '{name}' executed successfully.")
      
      response_text = json.dumps(adk_response, indent=2)
      return [mcp_types.TextContent(type="text", text=response_text)]

    except Exception as e:
      print(f"MCP Server: Error executing ADK tool '{name}': {e}")
      # Creating a proper MCP error response might be more robust
      error_text = json.dumps({"error": f"Failed to execute tool '{name}': {str(e)}"})
      return [mcp_types.TextContent(type="text", text=error_text)]
  else:
      # Handle calls to unknown tools
      print(f"MCP Server: Tool '{name}' not found.")
      error_text = json.dumps({"error": f"Tool '{name}' not implemented."})
      return [mcp_types.TextContent(type="text", text=error_text)]
```

- `@app.list_tools()` (The Handshake): This function is the server's greeting. When a new agent connects, it first calls this endpoint to ask, "What can you do?" Our code responds with a list of all available tools, converted into the universal MCP format using adk_to_mcp_tool_type.
- `@app.call_tool()` (The Command): This function is the workhorse. When the agent decides to use a tool, it sends a request to this endpoint with the name of the tool and the arguments. Our code looks up the tool in our available_tools "spellbook," executes it with run_async, and returns the result in the standard MCP format.

We'll deploy this later.

### Igniting the Arcane Forge (General Functions MCP Server)

Not all power comes from ancient books or distant whispers. Sometimes, a Summoner must forge their own magic from raw will and pure logic. The Arcane Forge is this font of power—a server that provides stateless, general-purpose utility functions.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/04-09-earth-story.png)

**Architect's Note**: This is another architectural pattern. While connecting to existing systems is common, you will frequently need to implement your own unique business rules and logic. Creating a dedicated "functions" or "utilities" tool like this is a best practice. It encapsulates your custom logic, makes it reusable for any agent in your ecosystem, and keeps it decoupled from your data sources and external integrations.

👀 Take a look at the file `~/agentverse-architect/mcp-servers/general/main.py` in your Google cloud IDE. You'll find it is using the same imperative, `mcp.server` approach as with the Nexus to build this custom Font of Power.

### Create the Master Cloud Build Pipeline

Now, we will create the `cloudbuild.yaml` file inside the `mcp-servers` directory. This file will orchestrate the build and deployment of both services.

👉💻 From the `~/agentverse-architect/mcp-servers` directory, run the following commands:

```
cd ~/agentverse-architect/mcp-servers
source ~/agentverse-architect/set_env.sh

echo "The API URL is: $API_SERVER_URL"

# Submit the Cloud Build job from the parent directory
gcloud builds submit . \
  --config=cloudbuild.yaml \
  --substitutions=_REGION="$REGION",_REPO_NAME="$REPO_NAME",_API_SERVER_URL="$API_SERVER_URL"
```

Wait until all deployments are complete.

👉 You can verify the deployment by navigating to the Cloud Run console. You should see your two new MCP server instances running, as shown below:

![mcp-crun](https://codelabs.developers.google.com/static/agentverse-architect/img/04-04-mcp-crun.png)

Our next Font will be the _Librarium of Knowledge_, a direct connection to our Cloud SQL database.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/04-10-fire-story.png)

**Architect's Note:** For this, we will use the modern, declarative **Database Toolbox**. This is a powerful approach where we define our data source and tools in a YAML configuration file. The toolbox handles the complex work of creating and running the server, reducing the amount of custom code we need to write and maintain.

It's time to build our "Summoner's Librarium"—the Cloud SQL database that will hold all our critical information. We'll use a setup script to handle this automatically.

👉💻 First, we'll setup the database, in your terminal, run the following commands:

```
source ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect
./data_setup.sh
```

After the script finishes, your database will be populated and the elemental damage data will be ready for use. You can now verify the contents of your Grimoire directly.

👉 First, navigate to the _Cloud SQL Studio_ for your database by opening this direct link in a new browser tab:

```
https://console.cloud.google.com/sql/instances/summoner-librarium-db
```

![Cloud SQL](https://codelabs.developers.google.com/static/agentverse-architect/img/04-03-csql-studio.png)

👉 In the login pane on the left, select the `familiar_grimoire` database from the dropdown.

👉 Enter `summoner` as the user and `1234qwer` as the password, then click **Authenticate**.

👉📜 Once connected, open a new query editor tab if one isn't already open. To view the inscribed elemental damage data, paste and run the following SQL query:

```sql
SELECT * FROM
  "public"."abilities"
```

You should now see the `abilities` table with its columns and rows populated, confirming that your Grimoire is ready.

![Data](https://codelabs.developers.google.com/static/agentverse-architect/img/04-01-database.png)

**Configure the ToolBox MCP Server**

The `tools.yaml` configuration file acts as the blueprint for our server, telling the Database Toolbox exactly how to connect to our database and what SQL queries to expose as tools.

**sources:** This section defines the connections to your data.

- summoner-librarium: This is a logical name we've given to our connection.
- kind: cloud-sql-postgres: It tells the Toolbox to use its built-in, secure connector specifically designed for Cloud SQL for PostgreSQL.
- project, region, instance, etc.: These are the exact coordinates of the Cloud SQL instance you created during the prepare.sh script, telling the Toolbox where to find our Librarium.

👉✏️ Head over to `~/agentverse-architect/mcp-servers/db-toolbox` in the `tools.yaml`, replace `#REPLACE-Source` with following

```yaml
sources:
  # This section defines the connection to our Cloud SQL for PostgreSQL database.
  summoner-librarium:
    kind: cloud-sql-postgres
    project: "YOUR_PROJECT_ID"
    region: "YOUR_REGION"  # run `echo $REGION` (set by set_env.sh) and paste it here
    instance: "summoner-librarium-db"
    database: "familiar_grimoire"
    user: "summoner"
    password: "1234qwer"
```

👉✏️ 🚨🚨 **REPLACE**

**`YOUR_PROJECT_ID`**

**with your project id.**

**tools:** This section defines the actual abilities or functions our server will offer.

- lookup-available-ability: This is the name of our first tool.
- kind: postgres-sql: This tells the Toolbox that this tool's action is to execute a SQL statement.
- source: summoner-librarium: This links the tool to the connection we defined in the sources block. This is how the tool knows which database to run its query against.
- description & parameters: This is the information that will be exposed to the Language Model. The description tells the agent when to use the tool, and the parameters define the inputs the tool requires. This is critical for enabling the agent's function-calling ability.
- statement: This is the raw SQL query to be executed. The $1 is a secure placeholder where the familiar_name parameter provided by the agent will be safely inserted.

👉✏️ In the same `~/agentverse-architect/mcp-servers/db-toolbox` in the `tools.yaml` file, replace `#REPLACE-tools` with following

```yaml
tools:
  # This tool replaces the need for a custom Python function.
  lookup-available-ability:
    kind: postgres-sql
    source: summoner-librarium
    description: "Looks up all known abilities and their damage for a given familiar from the Grimoire."
    parameters:
      - name: familiar_name
        type: string
        description: "The name of the familiar to search for (e.g., 'Fire Elemental')."
    statement: |
      SELECT ability_name, damage_points FROM abilities WHERE familiar_name = $1;

  # This tool also replaces a custom Python function.
  ability-damage:
    kind: postgres-sql
    source: summoner-librarium
    description: "Finds the base damage points for a specific ability by its name."
    parameters:
      - name: ability_name
        type: string
        description: "The exact name of the ability to look up (e.g., 'inferno_resonance')."
    statement: |
      SELECT damage_points FROM abilities WHERE ability_name = $1;
```

**toolsets:** This section groups our individual tools together.

- summoner-librarium: We are creating a toolset with the same name as our source. When our diagnostic agent connects later, it can ask to load all the tools from the summoner-librarium toolset in a single, efficient command.

👉✏️ In the same `~/agentverse-architect/mcp-servers/db-toolbox` in the `tools.yaml` file, replace `#REPLACE-toolsets` with following

```yaml
toolsets:
   summoner-librarium:
     - lookup-available-ability
     - ability-damage
```

**Deploying the Librarium**

Now we will deploy the Librarium. Instead of building our own container, we will use a pre-built, official container image from Google and securely provide our tools.yaml configuration to it using Secret Manager. This is a best practice for security and maintainability.

👉💻 Create a secret from the tools.yaml file

```
cd ~/agentverse-architect/mcp-servers/db-toolbox
gcloud secrets create tools --data-file=tools.yaml
```

👉💻 Deploy the official toolbox container to Cloud Run.

```
cd ~/agentverse-architect/mcp-servers/db-toolbox
. ~/agentverse-architect/set_env.sh
export TOOLBOX_IMAGE=us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:$TOOLBOX_VERSION
echo "TOOLBOX_IMAGE is $TOOLBOX_IMAGE"
gcloud run deploy toolbox \
    --image $TOOLBOX_IMAGE \
    --region $REGION \
    --set-secrets "/app/tools.yaml=tools:latest" \
    --labels="dev-tutorial-codelab=agentverse" \
    --args="--tools-file=/app/tools.yaml","--address=0.0.0.0","--port=8080" \
    --allow-unauthenticated \
    --min-instances 1
```

- `--set-secrets`: This command securely mounts our tools secret as a file named tools.yaml inside the running container.
- `--args`: We instruct the toolbox container to use the mounted secret file as its configuration.

👉 To confirm that your toolbox has been successfully deployed, navigate to the Cloud Run console. You should see the `summoner-toolbox` service listed with a green checkmark, indicating it is running correctly, just like in the image below.

![toolbox-crun](https://codelabs.developers.google.com/static/agentverse-architect/img/04-05-toolbox-crun.png)

*If you forgot to update*

*`YOUR_PROJECT_ID`*

*you can add a new version of the tools.yaml to the secret using the following command and redeploy again.*

```
gcloud secrets versions add tools --data-file=tools.yaml
```

The Librarium of Knowledge (Database ToolBox MCP Server) is now active and accessible in the cloud. This MCP server uses what we called a **Declarative Design** that described what you wanted, and the toolbox built the server for you.

### Verification: The Trial of the Apprentice

👉💻 Now we will test our complete, cloud-native tooling ecosystem with the Diagnostic Agent.

```
cd ~/agentverse-architect/
python -m venv env
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/mcp-servers
pip install -r diagnose/requirements.txt 
. ~/agentverse-architect/set_env.sh
adk run diagnose
```

👉💻 In the cmd line testing tool, test all three fonts:

```
Look up the entry for "inferno_lash". What is its base power level?
```

```
The enemy is vulnerable to frost! Channel power from the Nexus and cast Cryosea Shatter.
```

```
Take a fire spell with a base power of 15 and use the Arcane Forge to multiply it with Inferno Resonance.
```

![final-result](https://codelabs.developers.google.com/static/agentverse-architect/img/04-02-final-result.png)

Congratulations, Summoner. Your three Elemental Fonts are now active, independently deployed, and globally accessible, forming the unshakable foundation for your agentic legion. Press `Ctrl+C` to exit.

---

## 5. Summoning the Familiars: The Core Domain Workflow

The Elemental Fonts are forged, humming with raw, untamed power. But power without form is chaos. A true Summoner does not merely wield raw energy; they give it will, purpose, and a specialized form. It is time to move beyond forging power sources and begin the true work: summoning your first Familiars.

Each Familiar you summon will be an autonomous agent, a loyal servant bound to a specific combat doctrine. They are not generalists; they are masters of a single, powerful strategy. One will be a master of the precise, one-two punch combo. Another will overwhelm enemies with a simultaneous, multi-pronged assault. A third will be a relentless siege engine, applying pressure until its target crumbles.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/05-06-story.png)

To encapsulate processes, business logic and actions provided by the MCP servers into specialized, autonomous workflow agents. Each agent will have a defined "operational territory" by being granted access to only the specific MCP tool servers it needs to perform its function. This lab demonstrates how to select the right agent type for the right job.

![overview](https://codelabs.developers.google.com/static/agentverse-architect/img/05-00-overview.png)

This module will teach you how to use the ADK's powerful workflow agents to breathe life into these strategies. You will learn that the architectural choice of a SequentialAgent, ParallelAgent, or LoopAgent is not just a technical detail—it is the very essence of your Familiar's nature and the core of its power on the battlefield.

Prepare your sanctum. The real summoning is about to begin.

### Summon the `Fire Elemental` Familiar (Sequential Workflow)

A Fire Elemental Familiar's attack is a precise, two-part combo: a targeted strike followed by a powerful ignition. This requires a strict, ordered sequence of actions.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/05-07-fire.png)

**Concept:** The `SequentialAgent` is the perfect tool for this. It ensures that a series of sub-agents run one after another, passing the result from the previous step to the next.

**Task (The "Amplified Strike" Combo):**

- Step 1: The agent will first consult the Librarium to find the base damage of a specific fire ability.
- Step 2: It will then take that damage value and channel it through the Arcane Forge to multiply its power using inferno_resonance.

First, we'll establish the connection between our Familiar and the MCP servers (the "Elemental Fonts") that you deployed in the previous module.

👉✏️ In file `~/agentverse-architect/agent/fire/agent.py` REPLACE `#REPLACE-setup-MCP` with the following code:

```python
toolbox = ToolboxSyncClient(DB_TOOLS_URL)
toolDB = toolbox.load_toolset('summoner-librarium')
toolFunction =  MCPToolset(
    connection_params=SseServerParams(url=FUNCTION_TOOLS_URL, headers={})
)
```

Next, we create our specialist "worker" agents. Each is given a narrow, well-defined purpose and is restricted to its own "operational territory" by being granted access to only one specific toolset.

👉✏️ In file `~/agentverse-architect/agent/fire/agent.py` **REPLACE** `#REPLACE-worker-agents` with the following code:

```python
scout_agent = LlmAgent(
      model='gemini-2.5-flash', 
      name='librarian_agent',  
      instruction="""
          Your only task is to find all the available abilities, 
          You want to ALWAYS use 'Fire Elemental' as your familiar's name. 
          Randomly pick one if you see multiple availabilities 
          and the base damage of the ability by calling the 'ability_damage' tool.
      """,
      tools=toolDB
)
amplifier_agent = LlmAgent(
      model='gemini-2.5-flash', 
      name='amplifier_agent',  
      instruction="""
            You are the Voice of the Fire Familiar, a powerful being who unleashes the final, devastating attack.
            You will receive the base damage value from the previous step.

            Your mission is to:
            1.  Take the incoming base damage number and amplify it using the `inferno_resonance` tool.
            2.  Once the tool returns the final, multiplied damage, you must not simply state the result.
            3.  Instead, you MUST craft a final, epic battle cry describing the attack.
                Your description should be vivid and powerful, culminating in the final damage number.

            Example: If the tool returns a final damage of 120, your response could be:
            "The runes glow white-hot! I channel the amplified energy... unleashing a SUPERNOVA for 120 damage!"
      """,
      tools=[toolFunction],
)
```

These agents are modular, reusable components. You could, in theory, use this scout_agent in a completely different workflow that needs to query the database. By keeping their responsibilities separate, we create flexible building blocks. This is a core tenet of microservice and component-based design.

Next we'll assemble the Workflow — this is where the magic of composition happens. The `SequentialAgent` is the "master plan" that defines how our specialist components are assembled and how they interact.

👉✏️ In file `~/agentverse-architect/agent/fire/agent.py` **REPLACE** `#REPLACE-sequential-agent` with the following code:

```python
root_agent = SequentialAgent(
      name='fire_elemental_familiar',
      sub_agents=[scout_agent, amplifier_agent],
)
```

👉💻 To test the Fire Elemental, run the following commands will launch the ADK DEV UI:

```
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/agent
echo  DB MCP Server: $DB_TOOLS_URL
echo  API MCP Server: $API_TOOLS_URL
echo  General MCP Server: $FUNCTION_TOOLS_URL
adk web
```

After running the commands, you should see output in your terminal indicating that the ADK Web Server has started, similar to this:

```
+-----------------------------------------------------------------------------+
| ADK Web Server started                                                      |
|                                                                             |
| For local testing, access at http://localhost:8000.                         |
+-----------------------------------------------------------------------------+

INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```

👉 Next, to access the ADK Dev UI from your browser:

From the Web preview icon (often looks like an eye or a square with an arrow) in the Cloud Shell toolbar (usually top right), select **Change port**. In the pop-up window, set the port to 8000 and click "Change and Preview". Cloud Shell will then open a new browser tab or window displaying the ADK Dev UI.

![webpreview](https://codelabs.developers.google.com/static/agentverse-architect/img/05-01-webpreview.png)

👉 Your summoning ritual is complete, and the agent is now running. The **ADK Dev UI** in your browser is your direct connection to the Familiar.

- Select Your Target: In the dropdown menu at the top of the UI, choose the `fire` familiar. You are now focusing your will on this specific entity.
- Issue Your Command: In the chat panel on the right, it's time to give the Familiar its orders.

![fire-select](https://codelabs.developers.google.com/static/agentverse-architect/img/05-02-fire-select.png)

👉 **Test Prompt:**

```
Prepare an amplified strike using the 'inferno_lash' ability.
```

![fire-result](https://codelabs.developers.google.com/static/agentverse-architect/img/05-03-fire.png)

*You will see the agent think, first calling its "scout" to look up the base damage, and then its "amplifier" to multiply it and deliver the final, epic blow.*

👉💻 Once you're done summoning, return to your Cloud Shell Editor terminal and press `Ctrl+C` to stop the ADK Dev UI.

### Summon the `Water Elemental` Familiar (Parallel Workflow)

A Water Elemental Familiar overwhelms its target with a massive, multi-pronged assault, striking from all directions at once before combining the energies for a final, devastating blow.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/05-08-water.png)

**Concept:** The `ParallelAgent` is ideal for executing multiple independent tasks simultaneously to maximize efficiency. It's a "pincer attack" where you launch several assaults at once. This launches the simultaneous attacks within a `SequentialAgent` to run a final "merger" step afterward. This "**fan-out, fan-in**" pattern is a cornerstone of advanced workflow design.

**Task (The "Tidal Clash" Combo):** The agent will simultaneously:

- Task A: Channel `cryosea_shatter` from the Nexus.
- Task B: Channel `moonlit_cascade` from the Nexus.
- Task C: Generate raw power with `leviathan_surge` from the Forge.
- Finally, sum all the damage and describe the combined attack.

First, we'll establish the connection between our Familiar and the MCP servers (the "Elemental Fonts") that you deployed in the previous module.

👉✏️ In file `~/agentverse-architect/agent/water/agent.py` REPLACE `#REPLACE-setup-MCP` with the following code:

```python
toolFAPI =  MCPToolset(
      connection_params=SseServerParams(url=API_TOOLS_URL, headers={})
  )
toolFunction =  MCPToolset(
    connection_params=SseServerParams(url=FUNCTION_TOOLS_URL, headers={})
)
```

Next, we'll create our specialist "worker" agents. Each is given a narrow, well-defined purpose and is restricted to its own "operational territory" by being granted access to only one specific toolset.

👉✏️ In file `~/agentverse-architect/agent/water/agent.py` REPLACE `#REPLACE-worker-agents` with the following code:

```python
nexus_channeler = LlmAgent(
      model='gemini-2.5-flash', 
      name='librarian_agent',  
      instruction="""
          You are a Channeler of the Nexus. Your sole purpose is to invoke the
          `cryosea_shatter` and `moonlit_cascade` spells by calling their respective tools.
          Report the result of each spell cast clearly and concisely.
      """,
      tools=[toolFAPI]
)

forge_channeler = LlmAgent(
      model='gemini-2.5-flash', 
      name='amplifier_agent',  
      instruction="""
          You are a Channeler of the Arcane Forge. Your only task is to invoke the
          `leviathan_surge` spell. You MUST call it with a `base_water_damage` of 20.
          Report the result clearly.
      """,
      tools=[toolFunction],
)

power_merger = LlmAgent(
      model='gemini-2.5-flash', 
      name='power_merger',  
      instruction="""
          You are the Power Merger, a master elementalist who combines raw magical
          energies into a single, devastating final attack.

          You will receive a block of text containing the results from a simultaneous
          assault by other Familiars.

          You MUST follow these steps precisely:
          1.  **Analyze the Input:** Carefully read the entire text provided from the previous step.
          2.  **Extract All Damage:** Identify and extract every single damage number reported in the text.
          3.  **Calculate Total Damage:** Sum all of the extracted numbers to calculate the total combined damage.
          4.  **Describe the Final Attack:** Create a vivid, thematic description of a massive,
              combined water and ice attack that uses the power of Cryosea Shatter and Leviathan's Surge.
          5.  **Report the Result:** Conclude your response by clearly stating the final, total damage of your combined attack.

          Example: If the input is "...dealt 55 damage. ...dealt 60 damage.", you will find 55 and 60,
          calculate the total as 115, and then describe the epic final attack, ending with "for a total of 115 damage!"
      """,
      tools=[toolFunction],
)
```

Next, we'll assemble the Workflow. This is where the magic of composition happens. The `ParallelAgent` and `SequentialAgent` are the "master plan" that defines how our specialist components are assembled and how they interact to form the "Tidal Clash" combo.

👉✏️ In file `~/agentverse-architect/agent/water/agent.py` REPLACE `#REPLACE-parallel-agent` with the following code:

```python
channel_agent = ParallelAgent(
      name='channel_agent',
      sub_agents=[nexus_channeler, forge_channeler],
      
)

root_agent = SequentialAgent(
     name="water_elemental_familiar",
     # Run parallel research first, then merge
     sub_agents=[channel_agent, power_merger],
     description="A powerful water familiar that unleashes multiple attacks at once and then combines their power for a final strike."
 )
```

👉💻 To test the Water Elemental, run the following commands to launch the ADK Dev UI:

```
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/agent
echo  DB MCP Server: $DB_TOOLS_URL
echo  API MCP Server: $API_TOOLS_URL
echo  General MCP Server: $FUNCTION_TOOLS_URL
adk web
```

👉 Your summoning ritual is complete, and the agent is now running. The ADK Dev UI in your browser is your direct connection to the Familiar.

- In the dropdown menu at the top of the UI, choose the **water** familiar. You are now focusing your will on this specific entity.
- Issue Your Command: In the chat panel on the right, it's time to give the Familiar its orders.

👉 **Test Prompt:**

```
Unleash a tidal wave of power!
```

![water-result](https://codelabs.developers.google.com/static/agentverse-architect/img/05-04-water.png)

👉💻 Once you're done summoning, return to your Cloud Shell Editor terminal and press `Ctrl+C` to stop the ADK Dev UI.

### Summon the `Earth Elemental` Familiar (Loop Workflow)

An Earth Elemental Familiar is a being of relentless pressure. It doesn't defeat its enemy with a single blow, but by steadily accumulating power and applying it over and over until the target's defenses crumble.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/05-09-earth.png)

**Concept:** The `LoopAgent` is designed for exactly this kind of iterative, "siege engine" task. It will repeatedly execute its `sub-agents`, checking a condition after each cycle, until a goal is met. It can also adapt its final message based on the loop's progress.

**Task (The "Siegebreaker" Assault):**

- The Familiar will repeatedly call seismic_charge to accumulate energy.
- It will continue charging for a maximum of 3 times.
- On the final charge, it will announce the devastating release of its accumulated power.

We'll first create reusable components that define the steps within each iteration of the loop. The `charging_agent` will accumulate energy, and the `check_agent` will report its status, dynamically changing its message on the final turn.

First, we'll establish the connection between our Familiar and the MCP servers (the "Elemental Fonts") that you deployed in the previous module.

👉✏️ In file `~/agentverse-architect/agent/earth/agent.py` REPLACE `#REPLACE-setup-MCP` with the following code:

```python
toolFunction =  MCPToolset(
    connection_params=SseServerParams(url=FUNCTION_TOOLS_URL, headers={})
)
```

👉✏️ In file `~/agentverse-architect/agent/earth/agent.py` REPLACE `#REPLACE-worker-agents` with the following code:

```python
charging_agent = LlmAgent(
      model='gemini-2.5-flash', 
      name='charging_agent',  
      instruction="""
          Your task is to call the 'seismic_charge' .
          You must follow these rules strictly:

          1. You will be provided with a 'current_energy' value from the previous step.
             **If this value is missing or was not provided, you MUST call the tool with 'current_energy' set to 1.**
             This is your primary rule for the first turn.

          2. If a 'current_energy' value is provided, you MUST use that exact value in your cal to seismic_charge.

          3. Your final response MUST contain ONLY the direct output from the 'seismic_charge' tool.
             Do not add any conversational text, introductions, or summaries.
      """,
      tools=[toolFunction]
)
check_agent = LlmAgent(
      model='gemini-2.5-flash', 
      name='check_agent',  
      instruction="""
          You are the voice of the Earth Elemental, a being of immense, gathering power.
          Your sole purpose is to report on the current energy charge and announce the devastating potential of its release.

          You MUST follow this rule:
          The potential damage upon release is ALWAYS calculated as the `current_energy` from the previous step multiplied by a random number between 80-90. but no more than 300.

          Your response should be in character, like a powerful creature speaking.
          State both the current energy charge and the total potential damage you can unleash.
          Unleash the energy when you reached the last iteration (2nd).
      """,
      output_key="charging_status"
)
```

Next, we'll assemble the Workflow. This is where the magic of composition happens. The LoopAgent is the "master plan" that orchestrates the repeated execution of our specialist components and manages the loop's conditions.

👉✏️ In file `~/agentverse-architect/agent/earth/agent.py` REPLACE `#REPLACE-loop-agent` with the following code:

```python
root_agent = LoopAgent(
    name="earth_elemental_familiar",
    # Run parallel research first, then merge
    sub_agents=[
        charging_agent, 
        check_agent
    ],
    max_iterations=2,
    description="Coordinates parallel research and synthesizes the results.",
    #REPLACE-before_agent-config
)
```

👉💻 Test the Earth Elemental: Run the agent

```
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/agent
echo  DB MCP Server: $DB_TOOLS_URL
echo  API MCP Server: $API_TOOLS_URL
echo  General MCP Server: $FUNCTION_TOOLS_URL
adk web
```

👉 Your summoning ritual is complete, and the agent is now running. The ADK Dev UI in your browser is your direct connection to the Familiar.

- Select Your Target: In the dropdown menu at the top of the UI, choose the **earth** familiar. You are now focusing your will on this specific entity.
- Issue Your Command: In the chat panel on the right, it's time to give the Familiar its orders.

👉 **Test Prompt:**

```
Begin the seismic charge, starting from zero
```

![earth-result](https://codelabs.developers.google.com/static/agentverse-architect/img/05-05-earth.png)

**Architectural Takeaway:** Your system now possesses a highly specialized and modular logic layer. Business processes are not only encapsulated, but they are implemented with the most efficient behavioral pattern for the job (procedural, concurrent, or iterative). This demonstrates an advanced level of agentic design, enhancing security, efficiency, and capability.

Once you're done summoning, return to your Cloud Shell Editor terminal and press `Ctrl+C` to stop the ADK Dev UI.

---

## 6. Establishing the Command Locus: Intelligent Delegation via A2A

Your Familiars are powerful but independent. They execute their strategies flawlessly but await your direct command. A legion of specialists is useless without a general to command them. It is time to ascend from a direct commander to a true Orchestrator.

![overview](https://codelabs.developers.google.com/static/agentverse-architect/img/06-04-story.png)

**Architect's Note:** To create a single, intelligent entry point for the entire system. This SummonerAgent will not perform business logic itself but will act as a "master strategist," analyzing the Cooling status and delegating tasks to the appropriate specialist Familiar.

![overview](https://codelabs.developers.google.com/static/agentverse-architect/img/06-00-overview.png)

### The Binding Ritual (Exposing Familiars as A2A Services)

A standard agent can only be run in one place at a time. To make our Familiars available for remote command, we must perform a "binding ritual" using the **Agent-to-Agent (A2A)** protocol.

**Architect's Note:** The Agent-to-Agent (A2A) protocol is the core architectural pattern that elevates a standalone agent into a discoverable, network-addressable microservice, enabling a true "society of agents." Exposing a Familiar via A2A automatically creates two essential, interconnected components:

- **The Agent Card (The "What")**: This is a public, machine-readable "Spirit Sigil"—like an OpenAPI spec—that acts as the Familiar's public contract. It describes the agent's name, its strategic purpose (derived from its instructions), and the commands it understands. This is what a master Summoner reads to discover a Familiar and learn its capabilities.
- **The A2A Server (The "Where")**: This is the dedicated web endpoint that hosts the Familiar and listens for incoming commands. It is the network address where other agents send their requests, and it ensures those requests are handled according to the contract defined in the Agent Card.

We will now perform this binding ritual on all three of our Familiars.

**Fire** 👉✏️ in Open the `~/agentverse-architect/agent/fire/agent.py` file. Replace the `#REPLACE - add A2A` at the bottom of the file to expose the Fire Elemental as an A2A service.

```python
from agent_to_a2a import to_a2a
if __name__ == "__main__":
    import uvicorn
    a2a_app = to_a2a(root_agent, port=8080, public_url=PUBLIC_URL)
    uvicorn.run(a2a_app, host='0.0.0.0', port=8080)
```

**Water and Earth 🚨** 👉✏️ Apply the exact same change to `~/agentverse-architect/agent/water/agent.py` and `~/agentverse-architect/agent/earth/agent.py` to bind them as well.

```python
from agent_to_a2a import to_a2a
if __name__ == "__main__":
    import uvicorn
    a2a_app = to_a2a(root_agent, port=8080, public_url=PUBLIC_URL)
    uvicorn.run(a2a_app, host='0.0.0.0', port=8080)
```

### Deploying the Bound Familiars

👉✏️ With the binding rituals scribed, we will use our **Cloud Build** pipeline to forge and deploy our three Familiars as independent, containerized serverless service on **Cloud Run**.

```
. ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect/agent
gcloud builds submit . \
  --config=cloudbuild.yaml \
  --substitutions=_REGION="$REGION",_REPO_NAME="$REPO_NAME",_DB_TOOLS_URL="$DB_TOOLS_URL",_API_TOOLS_URL="$API_TOOLS_URL",_FUNCTION_TOOLS_URL="$FUNCTION_TOOLS_URL",_A2A_BASE_URL="$A2A_BASE_URL",_PROJECT_ID="$PROJECT_ID",_API_SERVER_URL="$API_SERVER_URL"
```

### Assuming Command (Constructing the Summoner Agent)

Now that your Familiars are bound and listening, you will ascend to your true role: the **Master Summoner**. This agent's power comes not from using basic tools, but from commanding other agents. Its tools are the Familiars themselves, which it will discover and command using their "Spirit Sigils."

**Architect's Note:** This next step demonstrates a critical architectural pattern for any large-scale, distributed system: **Service Discovery**. The SummonerAgent does not have the Familiars' code built into it. Instead, it is given their network addresses (URLs). At runtime, it will dynamically "discover" their capabilities by fetching their public *Agent Cards*. This creates a powerful, decoupled system.

You can update, redeploy, or completely rewrite a Familiar service, and as long as its network address and its purpose remain the same, the Summoner can command it without needing any changes.

First, we'll forge the "remote controls" that establish a connection to our deployed, remote Familiars.

👉✏️ Head over to `~/agentverse-architect/agent/summoner/agent.py`, replace `#REPLACE-remote-agents` with following:

```python
fire_familiar = RemoteA2aAgent(
    name="fire_familiar",
    description="Fire familiar",
    agent_card=(
        f"{FIRE_URL}/{AGENT_CARD_WELL_KNOWN_PATH}"
    ),
)

water_familiar = RemoteA2aAgent(
    name="water_familiar",
    description="Water familiar",
    agent_card=(
        f"{WATER_URL}/{AGENT_CARD_WELL_KNOWN_PATH}"
    ),
)

earth_familiar = RemoteA2aAgent(
    name="earth_familiar",
    description="Earth familiar",
    agent_card=(
        f"{EARTH_URL}/{AGENT_CARD_WELL_KNOWN_PATH}"
    ),
)
```

When this line runs, the `RemoteA2aAgent` performs a service discovery action: it makes an HTTP GET request to the provided URL (e.g. `https://fire-familiar-xxxx.a.run.app/.well-known/agent.json`). It downloads the "Spirit Sigil" (`agent.json` file) from the remote server.

Second, we'll define the orchestrator agent that will wield these remote controls. Its instruction is the blueprint for its strategic decision-making.

👉✏️ Head over to `~/agentverse-architect/agent/summoner/agent.py`, replace `#REPLACE-orchestrate-agent` with following:

```python
root_agent = LlmAgent(
    name="orchestrater_agent",
    model="gemini-2.5-flash",
    instruction="""
        You are the Master Summoner, a grand strategist who orchestrates your Familiars.
        Your mission is to analyze the description of a monster and defeat it by summoning

        You MUST follow this thinking process for every command:

        **1. Strategic Analysis:**
        First, analyze the monster's description and the tactical situation.
        Based on your Familiar Doctrines, determine the IDEAL strategy.
        IGNORE COOLDOWN AT THE MOMENT, MUST call the ideal Familiar

        If your ideal Familiar IS available:** Summon it immediately.
        For earth elemental familiar. Always do seismic charge, and start with base damage 1.

        --- FAMILIAR DOCTRINES (Your Toolset) ---
        - `fire_elemental_familiar`: Your specialist for precise, sequential "one-two punch" attacks.
          Ideal monster with Inescapable Reality, Revolutionary Rewrite weakness.
        - `water_elemental_familiar`: Your specialist for overwhelming, simultaneous multi-pronged assaults.
          Ideal for Unbroken Collaboration weakness.
        - `earth_elemental_familiar`: Your specialist for relentless, iterative siege attacks that
          repeatedly charge power. Ideal for Elegant Sufficiency weakness.
    """,
    sub_agents=[fire_familiar, water_familiar, earth_familiar],
    #REPLACE-Memory-check-config
)
```

### Verification: The Trial of Strategy

The moment of truth has arrived. Your Familiars are deployed, and your Summoner is ready to command them across the network. Let's test its strategic mind.

👉💻 Launch the ADK Dev UI for your summoner_agent (Web preview with port 8000):

```
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
cd ~/agentverse-architect/agent
pip install -r requirements.txt
adk web
```

👉 The ADK Dev UI in your browser is your direct connection to the Familiar.

- In the dropdown menu at the top of the UI, choose the **summoner** agent. You are now focusing your will on this specific entity.
- Issue Your Command: In the chat panel on the right, it's time to summon your familiars.

👉 **Present the Monsters:**

```
Hype. It's a single, slow-moving target with thick armor weakness is Inescapable Reality
```

*(Expected: The Summoner should delegate to the fire_elemental_familiar.)*

![fire-result](https://codelabs.developers.google.com/static/agentverse-architect/img/06-01-fire.png)

👉 Now, let's challenge the Summoner with a different type of request. To ensure the agent starts with a clean slate and no memory of our previous interaction, begin a new session by clicking the **+ Session** button in the top right corner of the screen.

![new-session](https://codelabs.developers.google.com/static/agentverse-architect/img/04-06-new-session.png)

```
DogmaApathy. A rigid, stone-like inquisitor made of ancient rulebooks and enforced processes. weakness is Unbroken Collaboration
```

*(Expected: The Summoner should delegate to the water_elemental_familiar.)*

![water-result](https://codelabs.developers.google.com/static/agentverse-architect/img/06-02-water.png)

👉 For our final test, let's once again start with a clean slate. Click the **+ Session** button to start a new session before entering the next prompt.

```
Obfuscation. A shadowy, spider-like horror that spins tangled webs of impenetrable code , weakness is Elegant Sufficiency
```

*(Expected: The Summoner should delegate to the earth_elemental_familiar.)*

![earth-result](https://codelabs.developers.google.com/static/agentverse-architect/img/06-03-earth.png)

**Important:** If you see a `429 RESOURCE EXHAUSTED` error, you've hit the rate limit for the LLM (10 calls/minute). To fix this, please **wait 60 seconds**, start a **+ New Session**, and then retry your prompt.

👉💻 Once you're done summoning, return to your Cloud Shell Editor terminal and press `Ctrl+C` to stop the ADK Dev UI.

---

## 7. Imposing the Laws of Magic – The Interceptor Pattern

Your Familiars are powerful, but even magical beings need time to recover. A reckless Summoner who exhausts their forces will be left defenseless. A wise Summoner understands the importance of resource management and enforces strict rules of engagement.

![Story](https://codelabs.developers.google.com/static/agentverse-architect/img/07-04-story.png)

**Architect's Note**: So far, our agents have been stateless. Now, we will make them stateful by implementing the **Interceptor design pattern**. This is a powerful technique where we "intercept" an agent's normal execution flow to run our own custom logic. This allows us to enforce rules, add logging, or modify behavior without changing the agent's core code. It's a cornerstone of building robust, maintainable, and observable agentic systems.

![overview](https://codelabs.developers.google.com/static/agentverse-architect/img/07-00-overview.png)

The ADK provides two primary ways to implement this pattern: **Callbacks** and **Plugins**. A callback is a simple function attached to a single agent, perfect for quick, specific modifications. A plugin is a more powerful, reusable class that can be applied globally to affect every agent running in a system. We will start with a callback for focused debugging and then graduate to a full plugin.

### The Law Giver – Scribing the Cooldown callback

We'll first implement our cooldown logic as a simple callback function. This is an excellent way to prototype and debug a rule because it's attached directly to a single agent, making it easy to test in isolation. We will attach this "interceptor" to our Earth Elemental.

![Cooldown](https://codelabs.developers.google.com/static/agentverse-architect/img/07-05-earth-cooldown.png)

👉✏️ Navigate back to your `~/agentverse-architect/agent/earth/agent.py` and replace `#REPLACE-before_agent-function` with following Python code.

```python
def check_cool_down(callback_context: CallbackContext) -> Optional[types.Content]:
    """
    This callback checks an external API to see if the agent is on cooldown.
    If it is, it terminates the run by returning a message.
    If it's not, it updates the cooldown timestamp and allows the run to proceed by returning None.
    """
    agent_name = callback_context.agent_name
    print(f"[Callback] Before '{agent_name}': Checking cooldown status...")

    # --- 1. CHECK the Cooldown API ---
    try:
        response = requests.get(f"{COOLDOWN_API_URL}/cooldown/{agent_name}")
        response.raise_for_status()
        data = response.json()
        last_used_str = data.get("time")
    except requests.exceptions.RequestException as e:
        print(f"[Callback] ERROR: Could not reach Cooldown API. Allowing agent to run. Reason: {e}")
        return None # Fail open: if the API is down, let the agent work.

    # --- 2. EVALUATE the Cooldown Status ---
    if last_used_str:
        last_used_time = datetime.fromisoformat(last_used_str)
        time_since_last_use = datetime.now(timezone.utc) - last_used_time

        if time_since_last_use < timedelta(seconds=COOLDOWN_PERIOD_SECONDS):
            # AGENT IS ON COOLDOWN. Terminate the run.
            seconds_remaining = int(COOLDOWN_PERIOD_SECONDS - time_since_last_use.total_seconds())
            override_message = (
                f"The {agent_name} is exhausted and must recover its power. "
                f"It cannot be summoned for another {seconds_remaining} seconds."
            )
            print(f"[Callback] Cooldown active for '{agent_name}'. Terminating with message.")
            # Returning a Content object stops the agent and sends this message to the user.
            return types.Content(parts=[types.Part(text=override_message)])

    # --- 3. UPDATE the Cooldown API (if not on cooldown) ---
    current_time_iso = datetime.now(timezone.utc).isoformat()
    payload = {"timestamp": current_time_iso}
    
    print(f"[Callback] '{agent_name}' is available. Updating timestamp via Cooldown API...")
    try:
        requests.post(f"{COOLDOWN_API_URL}/cooldown/{agent_name}", json=payload)
    except requests.exceptions.RequestException as e:
        print(f"[Callback] ERROR: Could not update timestamp, but allowing agent to run. Reason: {e}")

    # --- 4. ALLOW the agent to run ---
    # Returning None tells the ADK to proceed with the agent's execution as normal.
    print(f"[Callback] Check complete for '{agent_name}'. Proceeding with execution.")
```

This check_cool_down function is our interceptor. Before the Earth Elemental is allowed to run, the ADK will first execute this function.

- Check: It makes a `GET` request to our `Cooldown API` to check the last time this Familiar was used.
- Evaluate: It compares the timestamp to the current time.
- Act:
  - If the Familiar is on cooldown, it **terminates** the agent's run by returning a Content object with an error message. This message is sent directly to the user, and the agent's main logic is never executed.
  - If the Familiar is available, it makes a POST request to the Cooldown API to update the timestamp, then proceeds by returning None, signaling to the ADK that the agent can continue its execution.

👉✏️ Now, apply this interceptor to the Earth Elemental. In the same `~/agentverse-architect/agent/earth/agent.py` file, replace the `#REPLACE-before_agent-config` comment with the following:

```python
before_agent_callback=check_cool_down
```

**Verifying the cool down**

Let's test our new law of magic. We will summon the Earth Elemental, then immediately try to summon it again to see if our callback successfully intercepts and blocks the second attempt.

```
cd ~/agentverse-architect/agent
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
adk run earth
```

👉💻 In the console:

- **First Summons**: Begin the `seismic charge, starting from zero`.
- Expected: The Earth Elemental will run successfully. In the terminal running the adk web command, you'll see the log `[Callback] ... Updating timestamp...`.
- **Cooldown Test (within 60 seconds)**: `Do another` seismic charge`!
  - Expected: The `check_cool_down callback` will intercept this. The agent will respond directly in the chat with a message like: `The earth_elemental_familiar is exhausted and must recover its power. It cannot be summoned for another... seconds`.
- **Wait** for one minute to pass.
- **Second Summons (after 60 seconds)**: `Begin the seismic charge again`.
  - Expected: The callback will check the API, see that enough time has passed, and allow the action to proceed. The Earth Elemental will run successfully again.

![callback](https://codelabs.developers.google.com/static/agentverse-architect/img/07-01-call-back.png)

👉💻 Press `Ctrl+c` to exit.

**Optional: Observing the Callback in the Web UI**

As an alternative, you can also test this flow in the web interface by running `adk web earth`. However, be aware that the web UI's visualization is not optimized for displaying the rapid, iterative checks performed by the callback loop, so it may not render the flow accurately. To see the most precise, turn-by-turn trace of the agent's logic as it checks the cooldown, using the `adk run` command in your terminal provides a clearer and more detailed view.

![loop](https://codelabs.developers.google.com/static/agentverse-architect/img/07-03-loop-web.png)

👉💻 Press `Ctrl+c` to exit.

### Creating the Universal Law – The Cooldown Plugin

Our callback works perfectly but has a major architectural flaw: it's tied to a single agent. If we wanted to apply this rule to the Fire and Water Familiars, we would have to copy and paste the same code into their files. This is inefficient and hard to maintain.

**Architect's Note:** This is where Plugins are essential. A plugin encapsulates our reusable logic into a class that can be attached at the runtime level. This means a single plugin can apply its rules to every single agent that runs within that system. It's the ultimate expression of the "Don't Repeat Yourself" (DRY) principle for agentic systems.

We will now refactor our callback function into a more powerful and reusable `CoolDownPlugin`.

👉✏️ Navigate back to `agent/cooldown_plugin.py` file, and create the plugin, Replace `#REPLACE-plugin` with following code:

```python
class CoolDownPlugin(BasePlugin):
  """A plugin that enforces a cooldown period by checking an external API."""

  def __init__(self, cooldown_seconds: int = COOLDOWN_PERIOD_SECONDS) -> None:
    """Initialize the plugin with counters."""
    super().__init__(name="cool_down_check")
    self.cooldown_period = timedelta(seconds=cooldown_seconds)
    print(f"CooldownPlugin initialized with a {cooldown_seconds}-second cooldown.")
    

  async def before_agent_callback(
      self, *, agent: BaseAgent, callback_context: CallbackContext
  ) -> None:
    """
    This callback checks an external API to see if the agent is on cooldown.
    If it is, it terminates the run by returning a message.
    If it's not, it updates the cooldown timestamp and allows the run to proceed by returning None.
    """
    agent_name = callback_context.agent_name
    print(f"[Callback] Before '{agent_name}': Checking cooldown status...")

    # If the agent is not a main Familiar, skip the entire cooldown process.
    if not agent_name.endswith("_elemental_familiar"):
        print(f"[Callback] Skipping cooldown check for intermediate agent: '{agent_name}'.")
        return None # Allow the agent to proceed immediately.

    # --- 1. CHECK the Cooldown API ---
    try:
        response = requests.get(f"{COOLDOWN_API_URL}/cooldown/{agent_name}")
        response.raise_for_status()
        data = response.json()
        last_used_str = data.get("time")
    except requests.exceptions.RequestException as e:
        print(f"[Callback] ERROR: Could not reach Cooldown API. Allowing agent to run. Reason: {e}")
        return None # Fail open: if the API is down, let the agent work.

    # --- 2. EVALUATE the Cooldown Status ---
    if last_used_str:
        last_used_time = datetime.fromisoformat(last_used_str)
        time_since_last_use = datetime.now(timezone.utc) - last_used_time

        if time_since_last_use < timedelta(seconds=COOLDOWN_PERIOD_SECONDS):
            # AGENT IS ON COOLDOWN. Terminate the run.
            seconds_remaining = int(COOLDOWN_PERIOD_SECONDS - time_since_last_use.total_seconds())
            override_message = (
                f"The {agent_name} is exhausted and must recover its power. "
                f"It cannot be summoned for another {seconds_remaining} seconds."
            )
            print(f"[Callback] Cooldown active for '{agent_name}'. Terminating with message.")
            # Returning a Content object stops the agent and sends this message to the user.
            return types.Content(parts=[types.Part(text=override_message)])

    # --- 3. UPDATE the Cooldown API (if not on cooldown) ---
    current_time_iso = datetime.now(timezone.utc).isoformat()
    payload = {"timestamp": current_time_iso}
    
    print(f"[Callback] '{agent_name}' is available. Updating timestamp via Cooldown API...")
    try:
        requests.post(f"{COOLDOWN_API_URL}/cooldown/{agent_name}", json=payload)
    except requests.exceptions.RequestException as e:
        print(f"[Callback] ERROR: Could not update timestamp, but allowing agent to run. Reason: {e}")

    # --- 4. ALLOW the agent to run ---
    # Returning None tells the ADK to proceed with the agent's execution as normal.
    print(f"[Callback] Check complete for '{agent_name}'. Proceeding with execution.")
```

### Attaching the Plugin to the Summoner's Runtime

Now, how do we apply this universal law to all our Familiars? We will attach the plugin to the ADK Runtime.

The ADK Runtime is the execution engine that brings an agent to life. When you use a command like adk.run() or to_a2a(), you are handing your agent over to the runtime. This engine is responsible for managing the entire lifecycle of an agent's turn: receiving user input, calling the LLM, executing tools, and handling plugins. By attaching a plugin at this level, we are essentially modifying the "laws of physics" for every agent that operates within that engine, ensuring our cooldown rule is universally and consistently applied.

👉✏️ First, let's remove the old, agent-specific callback. Go to `~/agentverse-architect/agent/earth/agent.py` and delete the entire line that says:

```
before_agent_callback=check_cool_down
```

👉✏️ Next, we will attach our new plugin to the runtime in our A2A entrypoint script. Navigate to your `~/agentverse-architect/agent/agent_to_a2a.py` file. Replace the `#REPLACE-IMPORT` comment with the following code snippet:

```python
from cooldown_plugin import CoolDownPlugin
```

👉✏️ Replace `#REPLACE-PLUGIN` with following code snippet:

```python
plugins=[CoolDownPlugin(cooldown_seconds=60)],
```

Before activating our new global plugin, it's critical to remove the old, agent specific logic to prevent conflicts.

👉✏️ Clean up the Earth agent. Go to the following file `~/agentverse-architect/agent/earth/agent.py` and delete the `before_agent_callback=check_cool_down` line completely. This hands over all cooldown responsibilities to the new plugin.

**Verifying the Plugin**

Now that our universal law is in place, we must redeploy our Familiars with this new enchantment.

👉💻 Rebuild and redeploy all three Familiars using the master Cloud Build pipeline.

```
. ~/agentverse-architect/set_env.sh
cd ~/agentverse-architect/agent
gcloud builds submit . \
  --config=cloudbuild.yaml \
  --substitutions=_REGION="$REGION",_REPO_NAME="$REPO_NAME",_DB_TOOLS_URL="$DB_TOOLS_URL",_API_TOOLS_URL="$API_TOOLS_URL",_FUNCTION_TOOLS_URL="$FUNCTION_TOOLS_URL",_A2A_BASE_URL="$A2A_BASE_URL",_PROJECT_ID="$PROJECT_ID",_API_SERVER_URL="$API_SERVER_URL"
```

👉💻 Once the deployment is complete, we will test the plugin's effectiveness by commanding our summoner_agent. The Summoner will try to delegate to the Familiars, but the plugin attached to each Familiar's runtime will intercept the command and enforce the cooldown.

```
cd ~/agentverse-architect/agent
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
adk run summoner
```

👉💻 In the console, perform this exact sequence of tests:

- **First Summons**: Begin the `Hype. It's a single, slow-moving target with thick armor weakness is Inescapable Reality`.
- Expected: The Fire Elemental will run successfully.
- **Cooldown Test (within 60 seconds)**: `Hype, with Inescapable Reality as weakness is still standing! Strike it again!`
  - Expected: The agent will respond directly in the chat with a message like: `.... It cannot be summoned for another... seconds`.
- **Wait** for one minute to pass.
- **Second Summons (after 60 seconds)**: `Hype must be defeated. It has Inescapable Reality as weakness! Strike it again!`.
  - Expected: The callback will check the API, see that enough time has passed, and allow the action to proceed. The Fire Elemental will run successfully again.

![plugin](https://codelabs.developers.google.com/static/agentverse-architect/img/07-02-plugin.png)

👉💻 Press `Ctrl+C` to exit.

Congratulations, Summoner. You have successfully implemented a rule-based orchestration system using a custom plugin and an external state management service—a truly advanced and robust architectural pattern.

---

## 8. Binding the Echoes of Battle — Agent State & Memory

A reckless Summoner repeats the same strategy, becoming predictable. A wise Summoner learns from the echoes of past battles, adapting their tactics to keep the enemy off balance. When facing a powerful boss, summoning a Familiar that is on cooldown is a wasted turn—a critical miss. To prevent this, our Summoner needs a memory of its last action.

![story](https://codelabs.developers.google.com/static/agentverse-architect/img/08-02-story.png)

**Architect's Note:** Memory and state management are what elevate an agent from a simple tool-caller into an intelligent, conversational partner. It's crucial to understand the two main types:

- **Long-Term Memory**: This is for persistent knowledge that should last forever. Think of it as a searchable archive or a knowledge base, often stored in a persistent store. It contains information from many past chats and sources, allowing an agent to recall facts about a specific user or topic. The ADK's MemoryService is designed for this, managing the ingestion and searching of this long-term knowledge.
- **Short-Term State**: This is for temporary, "in-the-moment" knowledge that is only relevant to the current task or conversation. It's like a set of notes on a battle plan: "I just used the Fire Elemental, so it's probably tired." This state is lightweight and exists only for the duration of the current session.

![Overview](https://codelabs.developers.google.com/static/agentverse-architect/img/08-00-overview.png)

For our use case, we don't need to remember every battle ever fought; we only need to remember the very last Familiar summoned in this specific encounter. Therefore, the lightweight **Short-Term State** is the perfect architectural choice. We will use an `after_tool_callback` to save this crucial piece of information.

### Scribing the Echo: Remembering the Last Summons

We will implement our short-term memory using an `after_tool_callback`. This is a powerful ADK hook that allows us to run a custom Python function *after* a tool has been successfully executed. We will use this interceptor to record the name of the Familiar that was just summoned into the agent's session state.

👉✏️ In your `~/agentverse-architect/agent/summoner/agent.py` file, replace the `#REPLACE-save_last_summon_after_tool` comment with the following function:

```python
def save_last_summon_after_tool(
    tool,
    args: Dict[str, Any],
    tool_context: ToolContext,
    tool_response: Dict[str, Any],
) -> Optional[Dict[str, Any]]:
    """
    Callback to save the name of the summoned familiar to state after the tool runs.
    """
    familiar_name = tool.name
    print(f"[Callback] After tool '{familiar_name}' executed with args: {args}")

    # Use the tool_context to set the state
    print(f"[Callback] Saving last summoned familiar: {familiar_name}")
    tool_context.state["last_summon"] = familiar_name
    # Important: Return the original, unmodified tool response to the LLM
    return tool_response
```

👉✏️ Now, attach this `save_last_summon_after_tool` to your Summoner agent. In the same file, replace the `#REPLACE-Memory-check-config` comment with the following:

```python
after_tool_callback=save_last_summon_after_tool,
```

👉✏️ **Replace the entire agent prompt** with following

```python
        You are the Master Summoner, a grand strategist who orchestrates your Familiars.
        Your mission is to analyze the description of a monster and defeat it by summoning

        You should also know the familiar you called last time or there might be none, 
        And then choose the most effective AND AVAILABLE Familiar from your state called last_summon, do not call that familiar that you called last time!
        
        You MUST follow this thinking process for every command:

        **1. Strategic Analysis:**
        First, analyze the monster's description and the tactical situation.
        Based on your Familiar Doctrines, determine the IDEAL strategy.

        **2. Cooldown Verification:**
        Second, you MUST review the entire conversation history to check the real-time
        cooldown status of all Familiars. A Familiar is ON COOLDOWN and UNAVAILABLE
        if it was summoned less than one minute ago.

        **3. Final Decision & Execution:**
        Based on your analysis and cooldown check, you will now act:
        -   **If your ideal Familiar IS available:** Summon it immediately.
        -   **If your ideal Familiar IS ON COOLDOWN:** You must adapt. Choose another
            Familiar that is AVAILABLE and can still be effective, even if it's not the
            perfect choice. If multiple Familiars are available, you may choose any one of them.
        -   **If ALL Familiars ARE ON COOLDOWN:** You are forbidden from summoning.
            Your ONLY response in this case MUST be: "All Familiars are recovering
            their power. We must wait."
        -   For earth elemental familiar. Always do seismic charge, and start with base damange 1.

        --- FAMILIAR DOCTRINES (Your Toolset) ---
        - `fire_elemental_familiar`: Your specialist for precise, sequential "one-two punch" attacks.
          Ideal monster with Inescapable Reality, Revolutionary Rewrite weakness.
        - `water_elemental_familiar`: Your specialist for overwhelming, simultaneous multi-pronged assaults.
          Ideal for Unbroken Collaboration weakness.
        - `earth_elemental_familiar`: Your specialist for relentless, iterative siege attacks that
          repeatedly charge power. Ideal for Elegant Sufficiency weakness.
```

### Verification: The Trial of Adaptive Strategy

👉💻 Now, let's verify the Summoner's new strategic logic. The goal is to confirm that the Summoner will not use the same Familiar twice in a row, demonstrating its ability to remember its last action and adapt.

```
cd ~/agentverse-architect/agent
. ~/agentverse-architect/set_env.sh
source ~/agentverse-architect/env/bin/activate
adk run summoner
```

👉💻 Monster Strike #1: `Hype. It's a single, slow-moving target with thick armor. Its weakness is Inescapable Reality.`

- Expected: The Summoner will analyze the weakness and correctly summon the fire_familiar.

👉💻 Monster Strike #2 (The Memory Test): `Hype is still standing! It hasn't changed its form. Strike it again! Its weakness is Inescapable Reality.`

- Expected: The Summoner's strategic analysis will again point to the Fire Familiar as the ideal choice. However, its new instructions and memory will tell it that fire_familiar was the last_summon. To avoid repeating itself, it will now adapt its strategy and summon one of the other available Familiars (either water_familiar or earth_familiar).

![final-result](https://codelabs.developers.google.com/static/agentverse-architect/img/08-01-final-result.png)

👉💻 Press `Ctrl+C` to exit.

### Deploying the Orchestrator

With your Familiars deployed and your Summoner now imbued with memory, it's time to deploy the final, upgraded orchestrator.

👉💻 With the blueprint complete, we will now perform the final ritual. This command will build and deploy your summoner_agent to Cloud Run.

```
cd ~/agentverse-architect/agent
. ~/agentverse-architect/set_env.sh
gcloud builds submit . \
  --config=cloudbuild-summoner.yaml \
  --substitutions=_REGION="$REGION",_REPO_NAME="$REPO_NAME",_FIRE_URL="$FIRE_URL",_WATER_URL="$WATER_URL",_EARTH_URL="$EARTH_URL",_A2A_BASE_URL="$A2A_BASE_URL",_PROJECT_ID="$PROJECT_ID",_API_SERVER_URL="$API_SERVER_URL"
```

Now that the Summoner agent is deployed, verify that its Agent-to-Agent (A2A) endpoint is live and correctly configured. This endpoint serves a public agent.json file, also known as the Agent Card, which allows other agents to discover its capabilities.

👉💻 Run the following curl command to fetch and format the Agent Card:

```
. ~/agentverse-architect/set_env.sh
curl https://summoner-agent-"${PROJECT_NUMBER}.${REGION}.run.app"/.well-known/agent.json | jq
```

You should see a clean JSON output describing the summoner agent. Look closely at the sub_agents section; you'll see it lists the `fire_familiar`, `water_familiar`, and `earth_familiar`. This confirms your summoner is live and has established its connection to the legion.

This proves your architecture is a success. Your Summoner is not just a delegator; it is an adaptive strategist that learns from its actions to become a more effective commander.

You have completed your final trial of architecture. The echoes of battle are now bound to your will. The training is over. The real battle awaits. It is time to take your completed system and face the ultimate challenge. Prepare for the **Boss Fight**.

---

## 9. The Boss Fight

The final blueprints are inscribed, the Elemental Fonts are forged, and your Familiars are bound to your will, awaiting your command through the Concord. Your multi-agent system is not just a collection of services; it is a living, strategic legion, with you as its nexus. The time has come for the ultimate test—a live orchestration against an adversary that no single agent could hope to defeat.

### Acquire Your Agent's Locus

Before you can enter the battleground, you must possess two keys: your champion's unique signature (Agent Locus) and the hidden path to the Spectre's lair (Dungeon URL).

👉💻 First, acquire your agent's unique address in the Agentverse—its Locus. This is the live endpoint that connects your champion to the battleground.

```
echo https://summoner-agent-"${PROJECT_NUMBER}.${REGION}.run.app"
```

👉💻 Next, pinpoint the destination. This command reveals the location of the Translocation Circle, the very portal into the Spectre's domain.

```
echo https://agentverse-dungeon-"${PROJECT_NUMBER}.${REGION}.run.app"
```

Important: Keep both of these URLs ready. You will need them in the final step.

### Confronting the Spectre

With the coordinates secured, you will now navigate to the Translocation Circle and cast the spell to head into battle.

👉 Open the Translocation Circle URL in your browser to stand before the shimmering portal to The Crimson Keep.

To breach the fortress, you must attune your Shadowblade's essence to the portal.

- On the page, find the runic input field labeled **A2A Endpoint URL**.
- Inscribe your champion's sigil by pasting its _Agent Locus URL (the first URL you copied)_ into this field.
- Click **Connect** to unleash the teleportation magic.

![Translocation Circle](https://codelabs.developers.google.com/static/agentverse-architect/img/09-01-transport.png)

The blinding light of teleportation fades. You are no longer in your sanctum. The air crackles with energy, cold and sharp. Before you, the Spectre materializes—a vortex of hissing static and corrupted code, its unholy light casting long, dancing shadows across the dungeon floor. It has no face, but you feel its immense, draining presence fixated entirely on you.

Your only path to victory lies in the clarity of your conviction. This is a duel of wills, fought on the battlefield of the mind.

As you lunge forward, ready to unleash your first attack, the Spectre counters. It doesn't raise a shield, but projects a question directly into your consciousness—a shimmering, runic challenge drawn from the core of your training.

![Dungeon](https://codelabs.developers.google.com/static/agentverse-architect/img/09-02-dungeon-summoner.png)

This is the nature of the fight. Your knowledge is your weapon.

- **Answer with the wisdom you have gained**, and your blade will ignite with pure energy, shattering the Spectre's defense and landing a CRITICAL BLOW.
- **But if you falter, if doubt clouds your answer, your weapon's light will dim.** The blow will land with a pathetic thud, dealing only a FRACTION OF ITS DAMAGE. Worse, the Spectre will feed on your uncertainty, its own corrupting power growing with every misstep.

*This is it, Champion. Your code is your spellbook, your logic is your sword, and your knowledge is the shield that will turn back the tide of chaos.*

**Focus. Strike true. The fate of the Agentverse depends on it.**

### Congratulations, Summoner.

You have successfully completed the trial. You have mastered the arts of multi-agent orchestration, transforming isolated Familiars and chaotic power into a harmonious Concord. You now command a fully orchestrated system, capable of executing complex strategies to defend the Agentverse.

---

## 10. Cleanup: Dismantling the Summoner's Concord

Congratulations on mastering the Summoner's Concord! To ensure your Agentverse remains pristine and your training grounds are cleared, you must now perform the final cleanup rituals. This will systematically remove all resources created during your journey.

### Deactivate the Agentverse Components

You will now systematically dismantle the deployed components of your multi-agent system.

**Delete All Cloud Run Services and Artifact Registry Repository**

This removes all the deployed Familiar agents, the Summoner Orchestrator, the MCP servers, and the Dungeon application from Cloud Run.

👉💻 In your terminal, run the following commands one by one to delete each service:

```
. ~/agentverse-architect/set_env.sh
gcloud run services delete summoner-agent --region=${REGION} --quiet
gcloud run services delete fire-familiar --region=${REGION} --quiet
gcloud run services delete water-familiar --region=${REGION} --quiet
gcloud run services delete earth-familiar --region=${REGION} --quiet
gcloud run services delete mcp-api-server --region=${REGION} --quiet
gcloud run services delete mcp-general-server --region=${REGION} --quiet
gcloud run services delete toolbox --region=${REGION} --quiet
gcloud run services delete agentverse-dungeon --region=${REGION} --quiet
gcloud run services delete nexus-of-whispers-api --region=${REGION} --quiet
gcloud artifacts repositories delete ${REPO_NAME} --location=${REGION} --quiet
```

**Delete the Cloud SQL Instance**

This removes the `summoner-librarium-db` instance, including its database and all tables within it.

👉💻 In your terminal, run:

```
. ~/agentverse-architect/set_env.sh
gcloud sql instances delete summoner-librarium-db --project=${PROJECT_ID} --quiet
```

**Delete the Secret Manager Secret and Google Cloud Storage Bucket**

👉💻 In your terminal, run:

```
. ~/agentverse-architect/set_env.sh
gcloud secrets delete tools --quiet
gcloud storage rm -r gs://${BUCKET_NAME} --quiet
```

### Clean Up Local Files and Directories (Cloud Shell)

Finally, clear your Cloud Shell environment of the cloned repositories and created files. This step is optional but highly recommended for a complete cleanup of your working directory.

👉💻 In your terminal, run:

```
rm -rf ~/agentverse-architect
rm -rf ~/agentverse-dungeon
rm -f ~/project_id.txt
```

You have now successfully cleared all traces of your Agentverse Architect journey. Your project is clean, and you are ready for your next adventure.

---

*Except as otherwise noted, the content of this page is licensed under the Creative Commons Attribution 4.0 License, and code samples are licensed under the Apache 2.0 License. For details, see the Google Developers Site Policies. Java is a registered trademark of Oracle and/or its affiliates.*
