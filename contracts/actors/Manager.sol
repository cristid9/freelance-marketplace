// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

contract Manager {

    string public name;
    string public role;

    constructor(string memory _name) public  {
        name = _name;
        role = "Manager";
    } 

}