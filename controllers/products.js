const db = require('../models')

module.exports = {
  index: async (req, res) => {
    try {
      const prods = await db.products.findAll();
      // console.log("All:", JSON.stringify(prods, null, 2));
      return res.json(prods)
    } catch (e) {
      return res.status(500).json({ message: 'Cannot get data from database.' })
    }
  },
  store: async (req, res) => {
    const data = req.body
    if (data) {
      try {
        const product = await db.products.sequelize.transaction((t) => {
          return db.products.create(data, { transaction: t })
        })
        return res.status(201).json(product)
      } catch (e) {
        return res.status(500).json({ message: 'Cannot store data to database.' })
      }
    }
    return res.status(400).json({ message: 'Bad request.' })
  },
  update: async (req, res) => {
    const id = req.params.id
    const data = req.body
    if (id && data) {
      await db.products.sequelize.transaction((t) => {
        return db.products.update(data, { where: { id } }, { transaction: t })
      })
      return res.json(data)
    }
    return res.status(400).json({ message: 'Bad request.' })
  },
  destroy: async (req, res) => {
    const id = req.params.id
    if (id) {
      try {
        await db.products.destroy({ where: { id } })
        return res.status(204).send()
      } catch (e) {
        return res.status(500).json({ message: 'Cannot remove data from database.' })
      }
    } else {
      return res.status(400).json({ message: 'Bad request.' })
    }
  }
}
