// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {TestContract} from "../src/TestContract.sol";
import {ICREATE3Factory} from "../src/ICREATE3Factory.sol";

/// @title Deploy Test Contract using CREATE3
/// @notice Demonstrates deterministic deployment using CREATE3Factory
contract DeployTestWithCREATE3Script is Script {
    // Our deployed CREATE3Factory address
    address constant CREATE3_FACTORY = 0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d;
    
    // Salt for deterministic deployment
    bytes32 constant SALT = keccak256("BMN_TEST_CONTRACT_V1");
    
    function run() public returns (address deployed) {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("PRIVATE_KEY"));
        address deployer = vm.addr(deployerPrivateKey);
        
        // Predict the deployment address
        address predictedAddress = ICREATE3Factory(CREATE3_FACTORY).getDeployed(deployer, SALT);
        console.log("Deployer:", deployer);
        console.log("Predicted address:", predictedAddress);
        
        // Check if already deployed
        if (predictedAddress.code.length > 0) {
            console.log("Contract already deployed at predicted address");
            return predictedAddress;
        }
        
        // Prepare constructor arguments
        string memory message = "Hello from CREATE3 on Base!";
        bytes memory constructorArgs = abi.encode(message);
        
        // Get creation code
        bytes memory creationCode = abi.encodePacked(
            type(TestContract).creationCode,
            constructorArgs
        );
        
        console.log("Creation code length:", creationCode.length);
        console.log("Using salt:", vm.toString(SALT));
        
        vm.startBroadcast(deployerPrivateKey);
        
        // Deploy using CREATE3
        deployed = ICREATE3Factory(CREATE3_FACTORY).deploy(SALT, creationCode);
        
        vm.stopBroadcast();
        
        // Verify deployment
        require(deployed == predictedAddress, "Deployment address mismatch!");
        require(deployed.code.length > 0, "Deployment failed - no code at address");
        
        console.log("Successfully deployed TestContract at:", deployed);
        console.log("Address matches prediction!");
        
        // Test the deployed contract
        TestContract testContract = TestContract(deployed);
        (string memory deployedMessage, address contractDeployer, uint256 deployedAt) = testContract.getInfo();
        
        console.log("Contract message:", deployedMessage);
        console.log("Contract deployer:", contractDeployer);
        console.log("Deployed at timestamp:", deployedAt);
        
        return deployed;
    }
    
    // Helper function to just check the predicted address
    function predictAddress() public {
        address deployer = vm.addr(uint256(vm.envBytes32("PRIVATE_KEY")));
        address predicted = ICREATE3Factory(CREATE3_FACTORY).getDeployed(deployer, SALT);
        console.log("Predicted deployment address:", predicted);
    }
}