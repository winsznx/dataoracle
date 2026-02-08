// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Udataoracle.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        Udataoracle registry = new Udataoracle();
        
        console.log("Udataoracle deployed to:", address(registry));
        
        vm.stopBroadcast();
    }
}
