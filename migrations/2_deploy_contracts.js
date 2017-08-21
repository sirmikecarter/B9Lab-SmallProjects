var Remittance = artifacts.require("./Remittance.sol");
var Splitter = artifacts.require("./Splitter.sol");
var Campaign = artifacts.require("./Campaign.sol");

module.exports = function(deployer) {
  deployer.deploy(Remittance);
  deployer.deploy(Splitter);
  deployer.deploy(Campaign);
};
