# A demo that shows how WildFly MCP Server can be used to help developers debug misconfigured application

The jboss-web.xml contains a security domain that is wrongly named. AI LLM should be abe to help 
identify this issue.

## Clone the repository

* `git clone -b mcp-demo-march-2025 git@github.com:jfdenise/quickstart`

* `cd quickstart/servlet-security`

## Start the WildFly server

* In a terminal, build and start the server: `sh ./start-demo.sh`

## Attempt to access the application

* Access to `http://localhost:8080/servlet-security` You should see a NPE for the principal.

## Start claude desktop

* For [claude.ai](http://claude.ai), on Fedora, add the following content to the file `~/.config/Claude/claude_desktop_config.json`.

```
{
  "mcpServers": {
    "wildfly": {
            "command": "podman",
            "args": [
                     "run",
                     "--rm",
                     "-i",
                     "--network=host",
                     "-e", "WILDFLY_MCP_SERVER_USER_NAME=chatbot-user",
                     "-e", "WILDFLY_MCP_SERVER_USER_PASSWORD=chatbot-user",
                     "quay.io/wildfly-snapshots/wildfly-mcp-server:latest"]
    }
  }
}
```

Then start `claude-desktop`.

Questions:

* What is the status of my WildFly server?
* I just accessed the application but got an exception, could you help me understand what is wrong?


# Use the WildFly Chat Bot (and mistral that managed to succeed).

```
podman run -e WILDFLY_CHATBOT_LLM_NAME=mistral -e MISTRAL_API_KEY=<YOUR API KEY> --network=host -e PORT_OFFSET=10 \
-e WILDFLY_MCP_SERVER_USER_NAME=chatbot-user -e WILDFLY_MCP_SERVER_USER_PASSWORD=chatbot-user \
-e JBOSS_HA_IP=localhost -e JBOSS_MESSAGING_HOST=localhost -e SERVER_PUBLIC_BIND_ADDRESS=localhost \
quay.io/wildfly-snapshots/wildfly-chat-bot:latest
```

Then access to `http://localhost:8090`

Questions:

Mistral will answer differently, here is a set of questions that helped to identify the misconfiguration:

* What is the status of my WildFly server?
* What are the applications deployed in my WildFly server?
* I just tried to access the servlet-security.war running in WildFly but I got an exception, could you tell me what is wrong?
* Could you check the servlet-security.war deployment content (jboss-web.xml, web.xml, ...) and see how authentication is configured?
* Ok, could you check if the demo-security-domain is properly configured in the server configuration?
* Ok, thank-you, I changed the jboss-web.xml to use the test-sd security domain. It worked!