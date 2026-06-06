// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {VyperDeployer} from "utils/VyperDeployer.sol";
import {ICounter} from "../interfaces/ICounter.sol";

contract CounterTest is Test {
    VyperDeployer private vyperDeployer = new VyperDeployer();

    ICounter public counter;

    function setUp() public {
        counter = ICounter(vyperDeployer.deployContract("src/", "Counter"));
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        vm.prank(address(vyperDeployer));
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function testSetNumberRequiresOwner() public {
        address nonOwner = makeAddr("nonOwner");
        vm.prank(nonOwner);
        vm.expectRevert(bytes("ownable: caller is not the owner"));
        counter.setNumber(42);
    }
}
