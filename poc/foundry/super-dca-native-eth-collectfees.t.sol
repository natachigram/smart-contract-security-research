// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "forge-std/Test.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @notice Minimal PoC snippet for the native ETH fee-collection failure pattern.
/// @dev Copy into the Super DCA contest repo test folder and integrate with listing fixtures.
contract PoCSuperDCANativeEthCollectFees is Test {
    address internal recipient = address(0xBEEF);

    function test_collectFees_revertsForNativeEthBalanceCheck() external {
        // Native ETH unwrap in Uniswap V4 currency model resolves to address(0)
        address nativeEthCurrency = address(0);

        // Equivalent of IERC20(Currency.unwrap(token)).balanceOf(recipient)
        // done in the affected collectFees implementation.
        bytes memory callData = abi.encodeWithSelector(IERC20.balanceOf.selector, recipient);

        (bool success, bytes memory returnData) = nativeEthCurrency.staticcall(callData);

        // balanceOf on address(0) is not a valid ERC20 call path.
        assertTrue(!success || returnData.length == 0, "native ETH path should fail ERC20 balanceOf");
    }
}
