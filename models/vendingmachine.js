'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class vendingMachine extends Model {
    static associate(models) {
      // define association here
    }
  }
  vendingMachine.init({
    vm_code: DataTypes.STRING,
    location: DataTypes.TEXT
  }, {
    sequelize,
    modelName: 'vendingMachine',
  });
  return vendingMachine;
};