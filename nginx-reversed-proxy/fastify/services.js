
const fastify = require('fastify')({
  logger: true
})

fastify.addHook('onSend', (request, reply, playload, next) => {
  reply.headers({
    'X-Powered-By': 'DEMO Services',
    'X-Processed-By': process.env.SERVER_NAME || 'APP 1',
  });
  next();
});

const DB_HOST = process.env.DB_HOST || 'localhost'
const DB_PORT = process.env.DB_PORT ? Number(process.env.DB_PORT) : 5432
const DB_USER = process.env.DB_USER || 'postgres'
const DB_PASS = process.env.DB_PASS || ''
const DB_NAME = process.env.DB_NAME || ''

fastify.register(require('@fastify/postgres'), {
  connectionString: `postgres://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_NAME}`
})

fastify.get('/', async (request, reply) => {
  return { hello: 'world' }
})

fastify.get('/users', (req, reply) => {
  fastify.pg.connect(onConnect)

  function onConnect(err, client, release) {
    if (err) return reply.send(err)

    client.query(
      'SELECT id, username, first_name, last_name FROM users',
      function onResult(err, result) {
        release()
        reply.send(err || result.rows)
      }
    )
  }
})

const start = async () => {
  try {
    await fastify.listen({ port: 3000, host: '0.0.0.0' })
  } catch (err) {
    fastify.log.error(err)
    process.exit(1)
  }
}

start()

