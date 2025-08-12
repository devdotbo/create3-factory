# CREATE3 Factory Deployment Instructions

## Factory Address
**Base, Etherlink & Optimism**: `0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d`

## Deployment Steps

### 1. Basic Usage
Deploy contracts with identical addresses on Base, Etherlink, and Optimism:

```solidity
// Deploy.s.sol
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/ICREATE3Factory.sol";

contract DeployScript is Script {
    address constant CREATE3_FACTORY = 0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d;
    
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        // Use consistent salt for same address on both chains
        bytes32 salt = keccak256("MyContract-v1");
        
        // Your contract bytecode
        bytes memory bytecode = type(YourContract).creationCode;
        
        // Deploy (same address on Base, Etherlink, and Optimism)
        ICREATE3Factory(CREATE3_FACTORY).deploy(salt, bytecode);
        
        // Get deployed address
        address deployed = ICREATE3Factory(CREATE3_FACTORY).getDeployed(msg.sender, salt);
        
        vm.stopBroadcast();
    }
}
```

### 2. Deploy Command
```bash
# Base
forge script script/Deploy.s.sol --rpc-url $BASE_RPC_URL --broadcast

# Etherlink
forge script script/Deploy.s.sol --rpc-url $ETHERLINK_RPC_URL --broadcast

# Optimism
forge script script/Deploy.s.sol --rpc-url $OPTIMISM_RPC_URL --broadcast
```

### 3. Best Practices
- Use descriptive salts: `keccak256("ProjectName-ContractType-Version")`
- Deploy with same salt on both chains for identical addresses
- Verify deployments using `getDeployed()` before interacting

## RPC Endpoints
- **Base**: `https://mainnet.base.org`
- **Etherlink**: `https://node.mainnet.etherlink.com`
- **Optimism**: `https://mainnet.optimism.io`