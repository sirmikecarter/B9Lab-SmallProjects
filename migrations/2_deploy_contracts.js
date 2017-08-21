var Remittance = artifacts.require("./Remittance.sol");
var Splitter = artifacts.require("./Splitter.sol");

module.exports = function(deployer) {
  deployer.deploy(Remittance);
  deployer.deploy(Splitter);
};
