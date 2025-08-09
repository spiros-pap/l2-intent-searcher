// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library LibSafeTransfer {
    error TransferFailed();
    error ApproveFailed();

    function safeTransfer(address token, address to, uint256 amount) internal {
        (bool s, bytes memory r) = token.call(abi.encodeWithSignature("transfer(address,uint256)", to, amount));
        if (!s || (r.length != 0 && !abi.decode(r, (bool)))) revert TransferFailed();
    }

    function safeTransferFrom(address token, address from, address to, uint256 amount) internal {
        (bool s, bytes memory r) = token.call(abi.encodeWithSignature("transferFrom(address,address,uint256)", from, to, amount));
        if (!s || (r.length != 0 && !abi.decode(r, (bool)))) revert TransferFailed();
    }

    function safeApprove(address token, address spender, uint256 amount) internal {
        (bool s, bytes memory r) = token.call(abi.encodeWithSignature("approve(address,uint256)", spender, amount));
        if (!s || (r.length != 0 && !abi.decode(r, (bool)))) revert ApproveFailed();
    }
}
