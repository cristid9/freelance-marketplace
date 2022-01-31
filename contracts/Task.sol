// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;


contract Task {

    string public description;
    string public domainOfExpertise;
    string public manager;
    uint256 public evalFee;
    uint256 public freelancerFee;

    uint256 public currentFunds;

    mapping(string => uint256) private fundHistory;

    constructor(string memory _description, string memory _domainOfExpertise,
        string memory _manager, uint256 _evalFee, uint256 _freelancerFee
    ) {
        description = _description;
        domainOfExpertise = _domainOfExpertise;
        manager = _manager;
        evalFee = _evalFee;
        freelancerFee = _freelancerFee;
        currentFunds = 0;
    } 

    function getFundHistory(string memory payerName) public view returns(uint256) {
        return fundHistory[payerName];
    }

    function fund(string memory payerName, uint256 amount) public {
        fundHistory[payerName] += amount;
        currentFunds += amount;
    }

    function refund(string memory payerName, uint256 amount) public {
        // fundHistory
    }


}