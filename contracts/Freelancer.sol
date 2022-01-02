// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

contract Freelancer {

    string public name;
    uint8 public reputation;
    string public domainOfExpertise; 

    constructor(string _name, uint8 _reputation, string _domainOfExpertise) public {
        name = _name;
        reputation = _reputation;
        domainOfExpertise = _domainOfExpertise;
    }

    function getName() public view returns(string) {
        return string;
    }

    function getReputation() public view returns(uint8) {
        return reputation;
    }

    function getDomainOfExpertise() public view returns(string) {
        return domainOfExpertise;
    }

    function getBalance() public view returns(uint256) {
        return 100;
    }
}