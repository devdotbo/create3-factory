// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// @title Simple Test Contract for CREATE3 Deployment
/// @notice A minimal contract to demonstrate CREATE3 deterministic deployment
contract TestContract {
    string public message;
    address public deployer;
    uint256 public deployedAt;
    
    constructor(string memory _message) {
        message = _message;
        deployer = msg.sender;
        deployedAt = block.timestamp;
    }
    
    function updateMessage(string memory _newMessage) external {
        message = _newMessage;
    }
    
    function getInfo() external view returns (
        string memory _message,
        address _deployer,
        uint256 _deployedAt
    ) {
        return (message, deployer, deployedAt);
    }
}