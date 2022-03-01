const db = require('../models')
const Sequelize = require('sequelize');
const Op = Sequelize.Op;
module.exports = {
  index: async (req, res) => {
    try {
      const tasks = await db.machineStock.findAll({
        include: [{ model: db.products }]
      })
      return res.json(tasks)
    } catch (e) {
      return res.status(500).json({ message: e.message })
    }
  },
  stock: async (req, res) => {
    try {
      const tasks = await db.machineStock.findAll({
        include: [{ model: db.products }],
        where: {
          restqty: {
            [Op.lt]: 10,
          },
        }
      })
      console.log(JSON.stringify(tasks, null, 2));
      return res.json(tasks)
    } catch (e) {
      return res.status(500).json({ message: e.message })
    }
  },
}
