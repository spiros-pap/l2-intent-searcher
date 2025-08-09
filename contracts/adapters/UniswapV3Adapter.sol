// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IRouterAdapter} from "../IRouterAdapter.sol";
import {LibSafeTransfer} from "../LibSafeTransfer.sol";

/// @title UniswapV3Adapter (stub)
/// @notice Simulates a swap by applying a feeBps to amountIn (placeholder for real UniV3).
contract UniswapV3Adapter is IRouterAdapter {
    using LibSafeTransfer for address;

    /// @dev data: abi.encode(address routerOrPool, uint24 feeBps)
    function swapExactIn(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 minAmountOut,
        bytes calldata data
    ) external payable override returns (uint256 amountOut) {
        (address /*routerOrPool*/, uint24 feeBps) = abi.decode(data, (address, uint24));
        require(feeBps <= 10_000, "fee too high");
        amountOut = (amountIn * (10_000 - feeBps)) / 10_000;
        require(amountOut >= minAmountOut, "min out");
        return amountOut;
    }
}
