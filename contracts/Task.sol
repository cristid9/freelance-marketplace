// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;


contract Task {

    string public name;
    string public description;
    string public domainOfExpertise;
    string public manager;
    uint256 public evalFee;
    uint256 public freelancerFee;


    constructor(string memory _name, string memory _description, string memory _domainOfExpertise,
        string memory _manager, uint256 _evalFee, uint256 _freelancerFee
    ) public  {
        name = _name;
        description = _description;
        domainOfExpertise = _domainOfExpertise;
        manager = _manager;
        evalFee = _evalFee;
        freelancerFee = _freelancerFee;
    } 
}