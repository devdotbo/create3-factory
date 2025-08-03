# CREATE3Factory Deployments

## Unified Factory Address
**Base & Etherlink**: `0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d`

## Overview
Our CREATE3Factory is deployed at the same address on both Base and Etherlink networks, enabling true cross-chain address consistency. Contracts deployed through this factory with the same salt will have identical addresses on both chains.

## Key Benefits
- **Same factory address** on Base and Etherlink
- **Same contract addresses** when using identical salts
- **Simplified cross-chain development** with unified addresses
- **No address mapping needed** between chains

## Verification
To verify the factory deployment:
```bash
# Base
cast code 0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d --rpc-url https://mainnet.base.org

# Etherlink
cast code 0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d --rpc-url https://node.mainnet.etherlink.com
```