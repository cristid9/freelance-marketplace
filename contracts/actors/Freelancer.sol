// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

contract Freelancer {

    string public role;
    string public name;
    uint8 public reputation;
    string public domainOfExpertise; 

    constructor(string memory _name, uint8 _reputation, string memory _domainOfExpertise) {
        name = _name;
        reputation = _reputation;
        domainOfExpertise = _domainOfExpertise;
        role = "Freelancer";
    }

    function getBalance() public pure returns(uint256) {
        return 100;
    }
}