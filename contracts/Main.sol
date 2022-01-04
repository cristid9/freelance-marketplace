// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

import "./Task.sol";
import "./actors/Freelancer.sol";
import "./actors/Manager.sol";
import "./actors/Eval.sol";
import "./actors/Payer.sol";
import "./Token.sol";
import "./Utils.sol";

contract Main is Utils {

    mapping(address => Freelancer) public freelancers;
    mapping(address => Manager) public managers;
    mapping(address => Eval) public evals;
    mapping(address => Payer) public payers;
    mapping(address => string) public roles;
    
    mapping(string => Task) public tasks;

    Token private metaPoints;

    constructor() {
        metaPoints = new Token("MetaPoint", "MTPNT", 10000);
        initMarketplace();
    }

    function initMarketplace() public {
        // hardcoded for now %todo% to fix soon
        managers[parseAddr('0x37B8143A8fd67D72452faf61f1C9D29387782ECb')] = new Manager("manager1");
        freelancers[parseAddr('0x967063cAbE123cdb1C5355856d542FEe4F5596dC')] = new Freelancer("freelancer1", 5, "blockchain");
        evals[parseAddr('0x61DF4c742247b4398AC383926695080a2bCB3Dc7')] = new Eval("eval1", "blockchain");
        payers[parseAddr('0x52b678d63B199E5b1148f0DCC719483aB41881de')] = new Payer("payer1");

        roles[parseAddr('0x37B8143A8fd67D72452faf61f1C9D29387782ECb')] = "manager";
        roles[parseAddr('0x967063cAbE123cdb1C5355856d542FEe4F5596dC')] = "freelancer";
        roles[parseAddr('0x61DF4c742247b4398AC383926695080a2bCB3Dc7')] = "eval";
        roles[parseAddr('0x52b678d63B199E5b1148f0DCC719483aB41881de')] = "payer";

        metaPoints.transfer(parseAddr('0x52b678d63B199E5b1148f0DCC719483aB41881de'), 50);
    }

    function createTask(string memory name,
                        string memory description,
                        string memory domainOfExpertise,
                        string memory manager,
                        uint256 evalFee,
                        uint256 freelancerFee
    ) public {
        // add require to check manager existence
        tasks[name] = new Task(description, domainOfExpertise, manager, evalFee, freelancerFee);
    }

    function fundTask(string memory taskName, uint256 amount) public {
        require(tasks[taskName].currentFunds() < (tasks[taskName].evalFee() + tasks[taskName].freelancerFee()));
        require(equals(roles[msg.sender], "payer"));
        require(metaPoints.balanceOf(msg.sender) >= amount);
        // where do we block the money?

        metaPoints.transferFrom(msg.sender, address(this), amount);
        string memory payerName = payers[msg.sender].name();
        tasks[taskName].fund(payerName, amount);
    }

    function refund(string memory taskName, uint256 amount) public {
        require(tasks[taskName].currentFunds() < tasks[taskName].evalFee() + tasks[taskName].freelancerFee());
        require(equals(roles[msg.sender], "payer"));
        // require(tasks[taskName].getFundHistory(actors[msg.sender].name) >= amount);

        string memory payerName = payers[msg.sender].name();
        tasks[taskName].refund(payerName, amount);


    }


    function getRoleOf(address addr) public view returns(string memory) {
        return roles[addr];
    }

    // %todo% retthink this
    // function getTasks() public returns(mapping(string => Task) memory) {
    //     return tasks;
    // }

}