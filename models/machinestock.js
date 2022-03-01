'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class machineStock extends Model {
    static associate(models) {
      this.hasMany(models.products, {
        foreignKey: 'id',
        sourceKey: 'prod_id',
        onDelete: 'CASCADE'
      });
      this.hasMany(models.vendingMachine, {
        foreignKey: 'vm_code',
        sourceKey: 'vm_code',
        onDelete: 'CASCADE'
      });
    }
  }
  machineStock.init({
    vm_code: DataTypes.STRING,
    channel: DataTypes.STRING,
    prod_id: DataTypes.INTEGER,
    maxqty: DataTypes.INTEGER,
    restqty: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'machineStock',
  });
  return machineStock;
};