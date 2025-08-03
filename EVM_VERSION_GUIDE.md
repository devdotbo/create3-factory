# EVM Version Configuration Guide

## Problem: NotActivated Error

When deploying contracts and you encounter `EvmError: NotActivated`, this typically means:
- The compiled bytecode uses opcodes that aren't available on the target chain
- You need to adjust the EVM version in your compilation settings

## Key Insight: Direction Matters

**IMPORTANT**: Modern chains like Base and Etherlink support NEWER EVM features, not older ones.

### ❌ Wrong Approach (Going Backwards)
```toml
# DON'T do this - these are too old
evm_version = 'london'    # Too old
evm_version = 'shanghai'  # Still too old
```

### ✅ Correct Approach (Going Forward)
```toml
# DO this - modern chains support newer features
evm_version = 'cancun'    # ✅ Works perfectly!
```

## Chain Support (as of 2024)

### Base Chain
- **Cancun Support**: ✅ Full support since March 2024
- **EIP-4844**: Supported (blob transactions for cheaper L2 costs)
- **Recommended**: `evm_version = 'cancun'`

### Etherlink
- **Dencun Support**: ✅ Supported via Dionysus upgrade (2025)
- **EVM Compatibility**: Full Ethereum tooling support
- **Recommended**: `evm_version = 'cancun'`

## Our Successful Configuration

### foundry.toml
```toml
[profile.default]
optimizer_runs = 1000000
evm_version = 'cancun'

[rpc_endpoints]
base = "${RPC_URL_BASE}"
etherlink = "${RPC_URL_ETHERLINK}"
```

### Results
- **CREATE3Factory**: Same address on both chains ✅
- **Test deployments**: Perfect cross-chain consistency ✅
- **Gas costs**: Optimized for modern chains ✅

## Troubleshooting Steps

1. **Check chain documentation** for supported EVM features
2. **Start with latest** (`cancun`) and work backwards if needed
3. **Test with simple contracts** before complex deployments
4. **Verify compilation** succeeds before deployment

## Reference Links

- **Ethereum Cancun Upgrade**: March 13, 2024
- **Base EVM Support**: Full Cancun compatibility
- **Etherlink Dencun**: Supported via Dionysus upgrade
- **Solidity 0.8.24+**: Added Cancun EVM version support

## Success Story

Our CREATE3Factory deployment:
- **Address**: `0x7B9e9BE124C5A0E239E04fDC93b66ead4e8C669d`
- **Chains**: Base + Etherlink (same address!)
- **EVM Version**: `cancun`
- **Status**: Production ready! 🚀

## Key Takeaway

When you see `NotActivated` errors:
1. Don't go backwards to older EVM versions
2. Research what modern features the chain supports
3. Use the newest compatible EVM version
4. Modern L2s often support cutting-edge EVM features!