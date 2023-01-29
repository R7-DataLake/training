
const fastify = require('fastify')({
  logger: true
})

fastify.addHook('onSend', (request, reply, playload, next) => {
  reply.headers({
    'X-Powered-By': 'R7 Health Platform System',
    'X-Processed-By': process.env.SERVER_NAME || 'APP 1',
  });
  next();
});

fastify.register(require('@fastify/postgres'), {
  connectionString: 'postgres://postgres:789124@localhost/test'
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

