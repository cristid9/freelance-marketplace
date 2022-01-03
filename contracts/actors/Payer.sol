// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

import "./Actor.sol";

contract Payer is Actor {

    string public name;

    constructor(string memory _name) public  {
        name = _name;
        role = "Payer";
    } 
}