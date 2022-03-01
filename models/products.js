'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class products extends Model {
    static associate(models) {
      // define association here
    }
  }
  products.init({
    eanCode: DataTypes.STRING,
    prodName: DataTypes.STRING,
    price: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'products',
  });
  return products;
};