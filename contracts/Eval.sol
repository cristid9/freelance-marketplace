// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

contract Eval {

    string public name;
    string public domainOfExpertise;

    constructor(string memory _name, string memory _domainOfExpertise) {
        name = _name;
        domainOfExpertise = _domainOfExpertise;
    }

    function getName() public view returns(string memory) {
        return name;
    }

    function getDomainOfExpertise() public view returns(string memory) {
        return domainOfExpertise;
    }
}