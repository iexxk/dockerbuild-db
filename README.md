# dockerbuild-db
开发环境基础数据库mysql+redis
使用：
docker run -d --name mydb -p 3306:3306 -p 6379:6379 -v db:/var/lib/mysql  exxk/db:latest
