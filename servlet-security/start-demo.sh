mvn clean install
sh ./target/server/bin/add-user.sh -p chatbot-user -u chatbot-user
JAVA_OPTS="$JAVA_OPTS -Xmx64m" sh ./target/server/bin/standalone.sh
