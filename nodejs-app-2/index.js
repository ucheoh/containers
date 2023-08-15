const hapi = require("@hapi/hapi");

async function start() {
  const server = hapi.server({
    host: "0.0.0.0",
    port: process.env.port || 3000
  });

  server.route({
    method: "GET",
    path: "/",
    handler() {
      return { success: true}
    }
  })

  await server.register({
    plugin: require("hapi-pino"),
    options: {
      prettyPint: true
    }
  })

  await server.start();

  return server;
}

start().catch(err => {
  console.log(err);
  process.exit(1);
})