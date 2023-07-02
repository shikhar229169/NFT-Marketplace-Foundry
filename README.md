# NFT-Marketplace-Foundry
This repo contains NFT Marketplace contracts, which allows one to mint NFTs. It contains two types of NFT, one hosted on IPFS and one is SVG which is purely on-chain.

## Quickstart
```
git clone https://github.com/shikhar229169/NFT-Marketplace-Foundry.git
cd NFT-Marketplace-Foundry
forge build
```

# Usage
## Openzeppelin Contracts Library
```
forge install OpenZeppelin/openzeppelin-contracts --no-commit
```

## Foundry DevOps
```
forge install Cyfrin/foundry-devops --no-commit
```

## Start a Local Node
```
anvil
```

## Deploy on Sepolia Test Network
```
forge script script/DeployKittyMoodNFT.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_API_KEY --broadcast
```

## Deploy on Anvil
```
forge script script/DeployKittyMoodNFT.s.sol --rpc-url $RPC_URL --private-key $ANVIL_PRIVATE_KEY --broadcast
```

## Test on anvil
```
forge test
```

## Test on fork sepolia test network
```
forge test --fork-url $SEPOLIA_RPC_URL
```

## Test Coverage
```
forge coverage
```

# Interactions
## To mint NFT on KittyMoodNFT (Sepolia Network)
```
forge script script/Interactions.s.sol:MintKittyNFT_KittyMoodNFT --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast
```

## To mint NFT on KittyMoodNFT (Anvil Local Network)
```
forge script script/Interactions.s.sol:MintKittyNFT_KittyMoodNFT --rpc-url $ANVIL_RPC_URL --private-key $ANVIL_PRIVATE_KEY --broadcast
```

## To flip the Kitty NFT Mood (Sepolia Network)
```
forge script script/Interactions.s.sol:FlipKittyMood_KittyMoodNFT --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast
```

## To flip the Kitty NFT Mood (Anvil Local Network)
```
forge script script/Interactions.s.sol:FlipKittyMood_KittyMoodNFT --rpc-url $ANVIL_RPC_URL --private-key $ANVIL_PRIVATE_KEY --broadcast
```
