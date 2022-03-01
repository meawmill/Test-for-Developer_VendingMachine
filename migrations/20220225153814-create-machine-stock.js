'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('machineStocks', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      vm_code: {
        type: Sequelize.STRING
      },
      channel: {
        type: Sequelize.STRING
      },
      prod_id: {
        type: Sequelize.INTEGER
      },
      maxqty: {
        type: Sequelize.INTEGER
      },
      restqty: {
        type: Sequelize.INTEGER
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('machineStocks');
  }
};