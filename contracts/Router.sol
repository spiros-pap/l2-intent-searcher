// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IRouterAdapter} from "./IRouterAdapter.sol";
import {LibSafeTransfer} from "./LibSafeTransfer.sol";

contract Router {
    using LibSafeTransfer for address;

    error DeadlineExpired();
    error InsufficientOutput(uint256 out, uint256 minOut);

    struct Step {
        address adapter;
        address tokenIn;
        address tokenOut;
        uint256 minOut;
        bytes data;
    }

    function executeExactIn(
        uint256 amountIn,
        uint256 minTotalOut,
        address recipient,
        uint256 deadline,
        Step[] calldata route
    ) external returns (uint256 amountOut) {
        if (block.timestamp > deadline) revert DeadlineExpired();
        require(route.length > 0, "EMPTY_ROUTE");

        address currTokenIn = route[0].tokenIn;
        currTokenIn.safeTransferFrom(msg.sender, address(this), amountIn);
        uint256 runningAmount = amountIn;

        for (uint256 i = 0; i < route.length; i++) {
            Step calldata s = route[i];
            currTokenIn.safeApprove(s.adapter, runningAmount);
            uint256 received = IRouterAdapter(s.adapter).swapExactIn(
                s.tokenIn, s.tokenOut, runningAmount, s.minOut, s.data
            );
            if (received < s.minOut) revert InsufficientOutput(received, s.minOut);
            currTokenIn = s.tokenOut;
            runningAmount = received;
        }

        if (runningAmount < minTotalOut) revert InsufficientOutput(runningAmount, minTotalOut);
        currTokenIn.safeTransfer(recipient, runningAmount);
        return runningAmount;
    }
}
