const Token = artifacts.require("Token");
const Main = artifacts.require("Main");

module.exports = function(deployer) {
  deployer.deploy(Token, "MetaPoint", "MTPNT", 10000);
  deployer.deploy(Main);
};
