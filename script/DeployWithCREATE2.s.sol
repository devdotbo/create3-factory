// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {CREATE3Factory} from "../src/CREATE3Factory.sol";

contract DeployWithCREATE2Script is Script {
    address constant CREATE2_DEPLOYER = 0x4e59b44847b379578588920cA78FbF26c0B4956C;
    
    function run() public returns (address factory) {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("PRIVATE_KEY"));
        vm.startBroadcast(deployerPrivateKey);

        // The salt used in the original deployment
        bytes32 salt = 0x3f20a3e68b65544bc40d1e7682147f90c14afdf8ebd93c5f2b12cf64a8c44a43;
        
        // Get the bytecode
        bytes memory bytecode = type(CREATE3Factory).creationCode;
        
        // Deploy using CREATE2
        bytes memory data = abi.encodePacked(salt, bytecode);
        (bool success, bytes memory result) = CREATE2_DEPLOYER.call(data);
        require(success, "CREATE2 deployment failed");
        
        // Extract the deployed address from the result
        factory = address(uint160(uint256(bytes32(result))));
        
        console.log("CREATE3Factory deployed at:", factory);
        
        vm.stopBroadcast();
    }
}