# build

```shell
sh build.sh
```

# run

```shell
DB_HOST=localhost \
DB_PORT=5432 \
DB_USER=postgres \
DB_PASS=789124 \
DB_NAME=test \
SERVER_NAME=DEMO1 \
node services.js
```

# docker run 

```shell
docker run -p 3001:3000 -e TEST_MESSAGE=doraemon r7platform/fastify-demo
```