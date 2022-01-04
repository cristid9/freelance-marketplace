// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

contract Payer {

    string public role;
    string public name;

    constructor(string memory _name) {
        name = _name;
        role = "Payer";
    } 
}