// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title IRouterAdapter
interface IRouterAdapter {
    function swapExactIn(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 minAmountOut,
        bytes calldata data
    ) external payable returns (uint256 amountOut);
}
