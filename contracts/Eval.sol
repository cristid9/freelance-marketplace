// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

contract Eval {

    string public name;
    string public domainOfExpertise;
    string public role;

    constructor(string memory _name, string memory _domainOfExpertise) {
        name = _name;
        domainOfExpertise = _domainOfExpertise;
        role = "Eval";
    }
}