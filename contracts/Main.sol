// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <=0.8.7;

import "./Task.sol";
import "./Freelancer.sol";
import "./Manager.sol";
import "./Eval.sol";
import "./Payer.sol";
import "./Token.sol";

contract Main {

    mapping(uint256 => Task) public tasks;
    mapping(address => Freelancer) public freelancers;
    mapping(address => Manager) public managers;
    mapping(address => Eval) public evals;
    mapping(address => Payer) public payers;
    Token private metaPoints;


    constructor() public {
        metaPoints = new Token("MetaPoint", "MTPNT", 10000);
        initMarketplace();
    }

    function initMarketplace() public {
        managers[parseAddr('0x37B8143A8fd67D72452faf61f1C9D29387782ECb')] = new Manager("manager1");
        freelancers[parseAddr('0x967063cAbE123cdb1C5355856d542FEe4F5596dC')] = new Freelancer("freelancer1", 5, "blockchain");
        evals[parseAddr('0x61DF4c742247b4398AC383926695080a2bCB3Dc7')] = new Eval("eval1", "blockchain");
        payers[parseAddr('0x52b678d63B199E5b1148f0DCC719483aB41881de')] = new Payer("payer1");

        metaPoints.transfer(parseAddr('0x52b678d63B199E5b1148f0DCC719483aB41881de'), 50);
    }

    function createTask() public {

    }

    function getTasks() public returns(mapping(uint256 => Task)) {
        return tasks;
    }

    function parseAddr(string memory _a) internal pure returns (address _parsedAddress) {
        bytes memory tmp = bytes(_a);
        uint160 iaddr = 0;
        uint160 b1;
        uint160 b2;

        for (uint i = 2; i < 2 + 2 * 20; i += 2) {
            iaddr *= 256;
            b1 = uint160(uint8(tmp[i]));
            b2 = uint160(uint8(tmp[i + 1]));
            if ((b1 >= 97) && (b1 <= 102)) {
                b1 -= 87;
            } else if ((b1 >= 65) && (b1 <= 70)) {
                b1 -= 55;
            } else if ((b1 >= 48) && (b1 <= 57)) {
                b1 -= 48;
            }
            if ((b2 >= 97) && (b2 <= 102)) {
                b2 -= 87;
            } else if ((b2 >= 65) && (b2 <= 70)) {
                b2 -= 55;
            } else if ((b2 >= 48) && (b2 <= 57)) {
                b2 -= 48;
            }
            iaddr += (b1 * 16 + b2);
        }
        return address(iaddr);
    }

}