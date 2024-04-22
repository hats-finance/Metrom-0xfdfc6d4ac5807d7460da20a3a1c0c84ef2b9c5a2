pragma solidity 0.8.25;

import {MetromHarness} from "./harnesses/MetromHarness.sol";
import {BaseTest} from "./Base.t.sol";
import {MAX_FEE} from "../src/Metrom.sol";
import {IMetrom} from "../src/IMetrom.sol";

/// SPDX-License-Identifier: GPL-3.0-or-later
contract AcceptOwnershipTest is BaseTest {
    function test_acceptOwnershipFail() public {
        vm.expectRevert(IMetrom.Forbidden.selector);
        metrom.acceptOwnership();
    }

    function test_acceptOwnershipSuccess() public {
        vm.assertEq(metrom.owner(), owner);

        address _newOwner = address(10001);
        vm.prank(owner);
        metrom.transferOwnership(_newOwner);
        vm.assertEq(metrom.pendingOwner(), _newOwner);
        vm.assertEq(metrom.owner(), owner);

        vm.expectEmit();
        emit IMetrom.AcceptOwnership();

        vm.prank(_newOwner);
        metrom.acceptOwnership();
        vm.assertEq(metrom.pendingOwner(), address(0));
        vm.assertEq(metrom.owner(), _newOwner);
    }

    function testFuzz_acceptOwnership(address _newOwner) public {
        vm.assertEq(metrom.owner(), owner);

        vm.prank(owner);
        metrom.transferOwnership(_newOwner);
        vm.assertEq(metrom.pendingOwner(), _newOwner);
        vm.assertEq(metrom.owner(), owner);

        vm.expectEmit();
        emit IMetrom.AcceptOwnership();

        vm.prank(_newOwner);
        metrom.acceptOwnership();
        vm.assertEq(metrom.pendingOwner(), address(0));
        vm.assertEq(metrom.owner(), _newOwner);
    }
}
