// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../contracts/Router.sol";

contract MockAdapter is IRouterAdapter {
    function swapExactIn(address, address, uint256 amountIn, uint256 minAmountOut, bytes calldata) external pure returns (uint256) {
        uint256 out = amountIn * 99 / 100;
        require(out >= minAmountOut, "mock: slippage");
        return out;
    }
}

contract RouterTest is Test {
    Router router;
    MockAdapter adapter;
    address token = address(0xDEAD);

    function setUp() public {
        router = new Router();
        adapter = new MockAdapter();
        vm.deal(address(this), 100 ether);
    }

    function testExecuteExactInHappyPath() public {
        Router.Step;
        steps[0] = Router.Step({ adapter: address(adapter), tokenIn: token, tokenOut: token, minOut: 99, data: "" });

        vm.mockCall(token, abi.encodeWithSignature("transferFrom(address,address,uint256)", address(this), address(router), 100), abi.encode(true));
        vm.mockCall(token, abi.encodeWithSignature("approve(address,uint256)", address(adapter), 100), abi.encode(true));
        vm.mockCall(token, abi.encodeWithSignature("transfer(address,uint256)", address(this), 99), abi.encode(true));

        uint outAmount = router.executeExactIn(100, 99, address(this), block.timestamp + 1, steps);
        assertEq(outAmount, 99);
    }
}
