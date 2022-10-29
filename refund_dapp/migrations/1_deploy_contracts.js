const paybylocation = artifacts.require("paybylocation");
module.exports = function(deployer) {
  deployer.deploy(paybylocation);
};