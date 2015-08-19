First i build the world api image
```
docker build -t worldapi .
```

Then i create the container for the database
```
docker run --name db -e "MYSQL_ROOT_PASSWORD=rootpwd" -e "MYSQL_DATABASE=apidb" -e "MYSQL_USER=apiusr" -e "MYSQL_PASSWORD=apipass" -v "/var/lib/mysql" -d mysql/mysql-server:5.6
```

In the end i create the container for the worldapi solution and link it to the database container. I run it on the port 49155 because i have apache running on my computer.
```
docker run --name worldapi -v /home/leonardo/repos/docker-final-project/worldapi:/opt/www/worldapi -p 49155:80 --link db:db worldapi
```