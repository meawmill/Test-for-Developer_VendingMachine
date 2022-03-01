const express = require('express')
const consola = require('consola')
const { Nuxt, Builder } = require('nuxt')
const app = express()

const config = require('../nuxt.config.js')
const productsController = require('../controllers/products')
const machinesController = require('../controllers/machines')
const stockController = require('../controllers/machinestock')
const buyingController = require('../controllers/buying')

// Import and Set Nuxt.js options
config.dev = process.env.NODE_ENV !== 'production'

async function start() {
  // Init Nuxt.js
  const nuxt = new Nuxt(config)

  const { host, port } = nuxt.options.server

  await nuxt.ready()
  // Build only in dev mode
  if (config.dev) {
    const builder = new Builder(nuxt)
    await builder.build()
  }
  // JSON Parser
  app.use(express.json())

  // products Controller routing
  app.get('/api/products', productsController.index)
  app.post('/api/products', productsController.store)
  app.put('/api/products/:id', productsController.update)
  app.delete('/api/products/:id', productsController.destroy)
  // machine Controller routing
  app.get('/api/machine', machinesController.index)
  app.post('/api/machine', machinesController.store)
  app.put('/api/machine/:id', machinesController.update)
  app.delete('/api/machine/:id', machinesController.destroy)
  // stock Controller routing
  app.get('/api/stock', stockController.index)
  app.post('/api/stock', stockController.store)
  app.put('/api/stock/:id', stockController.update)
  app.delete('/api/stock/:id', stockController.destroy)

  // buying Controller routing
  app.get('/api/buying', buyingController.index)
  app.get('/api/buying/lessstock', buyingController.stock)

  // Give nuxt middleware to express
  app.use(nuxt.render)

  // Listen the server
  app.listen(port, host)
  consola.ready({
    message: `Server listening on http://${host}:${port}`,
    badge: true
  })
}
start()
