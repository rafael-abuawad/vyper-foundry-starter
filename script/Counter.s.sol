// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "utils/VyperDeployer.sol";
import {ICounter} from "../interfaces/ICounter.sol";

contract CounterScript is Script {
    ICounter public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        VyperDeployer deployer = new VyperDeployer();
        counter = ICounter(deployer.deployContract("src/", "Counter"));

        vm.stopBroadcast();
    }
}
