'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class machineStock extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  machineStock.init({
    vm_id: DataTypes.STRING,
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