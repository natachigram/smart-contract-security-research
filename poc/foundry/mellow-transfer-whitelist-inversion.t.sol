// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "forge-std/Test.sol";

/// @notice PoC logic model for transfer whitelist inversion.
/// @dev Mirrors the issue where sender whitelist is treated inversely.
contract PoCMellowTransferWhitelistInversion is Test {
    function buggyShouldRevert(bool fromCanTransfer, bool toCanTransfer) internal pure returns (bool) {
        // Modeled from flawed condition:
        // if (info.canTransfer || !accounts[to].canTransfer) revert;
        return fromCanTransfer || !toCanTransfer;
    }

    function fixedShouldRevert(bool fromCanTransfer, bool toCanTransfer) internal pure returns (bool) {
        // Intended condition:
        // revert only when neither side is whitelisted
        return !fromCanTransfer && !toCanTransfer;
    }

    function test_whitelistedSender_unexpectedlyRevertsInBuggyLogic() external {
        bool bug = buggyShouldRevert(true, false);
        bool fix = fixedShouldRevert(true, false);

        assertTrue(bug, "buggy logic reverts with whitelisted sender");
        assertTrue(!fix, "fixed logic should allow whitelisted sender path");
    }

    function test_bothWhitelisted_unexpectedlyRevertsInBuggyLogic() external {
        bool bug = buggyShouldRevert(true, true);
        bool fix = fixedShouldRevert(true, true);

        assertTrue(bug, "buggy logic reverts when both are whitelisted");
        assertTrue(!fix, "fixed logic should allow both whitelisted");
    }
}
