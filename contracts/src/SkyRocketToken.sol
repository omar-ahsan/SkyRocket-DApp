// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

/// @notice  This ERC20 contract represents the SkyRocket ($SKT) token.
///          This contract should support the following functionalities:
///           - Burnable.
///           - Fixed supply of 25,000,000 $SKT.
contract SkyRocketToken is ERC20 {

    /// @notice The minter's address
    address funding;

    /// @notice Initializes the SkyRocket contract ($SKT).
    /// @param  _name   The name of $SKT (SkyRocket).
    /// @param  _symbol The symbol of $SKT (SKT).
    /// @param  init    The initial address to escrow $SKT supply, prior to distribution.
    constructor(
        string memory _name,
        string memory _symbol,
        address init
    ) ERC20(_name, _symbol) {
        funding = init;
    }

    modifier onlyFunding() {
        require(msg.sender == address(funding), "Not Authorized");
        _;
    }

    /// @notice returns the decimals of $SKT.
    function decimals() public pure override returns (uint8) {
        return 6;
    }

    /// @notice Mints $SKT tokens.
    /// @param  amount The number of $SKT tokens to mint.
    function mint(address account, uint256 amount) external onlyFunding {
        _mint(account, amount);
    }
}
