// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

contract Payer {

    string private name;

    constructor(string memory _name) public  {
        name = _name;
    } 

    function getName() public view returns(string memory) {
        return name;
    }
}