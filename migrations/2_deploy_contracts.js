const Token = artifacts.require("Freelancer");
const Main = artifacts.require("Freelancer");

module.exports = function(deployer) {
  deployer.deploy(Token);
  deployer.deploy(Main);
};
