# CREATE3Factory Deployments

## Unified Factory Address
**Base, Etherlink & Optimism**: `0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d`

## Overview
Our CREATE3Factory is deployed at the same address on Base, Etherlink, and Optimism networks, enabling true cross-chain address consistency. Contracts deployed through this factory with the same salt will have identical addresses on both chains.

## Key Benefits
- **Same factory address** on Base, Etherlink, and Optimism
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

# Optimism
cast code 0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d --rpc-url https://mainnet.optimism.io
```

### Explorer links
- Base (Basescan): https://basescan.org/address/0x7b9e9be124c5a0e239e04fdc93b66ead4e8c669d#code
- Optimism (Etherscan): https://optimistic.etherscan.io/address/0x7b9e9be124c5a0e239e04fdc93b66ead4e8c669d#code

### Foundry verification (Etherscan V2)
If re-verification is needed, use Foundry's built-in verification per Etherscan V2 docs:

```bash
forge verify-contract --watch --chain base \
  0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d \
  src/CREATE3Factory.sol:CREATE3Factory \
  --verifier etherscan --etherscan-api-key $ETHERSCAN_API_KEY

forge verify-contract --watch --chain optimism \
  0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d \
  src/CREATE3Factory.sol:CREATE3Factory \
  --verifier etherscan --etherscan-api-key $ETHERSCAN_API_KEY
```

Reference: Etherscan V2 "Verify with Foundry" docs: https://docs.etherscan.io/etherscan-v2/contract-verification/verify-with-foundry