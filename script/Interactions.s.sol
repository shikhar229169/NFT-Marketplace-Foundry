// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {KittyMoodNFT} from "../src/KittyMoodNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintNFT_BasicNFT is Script {
    string public constant kitty = "ipfs://QmNPtWDJ3uWVuAFzC36izupThZQjqLJRvX6hFK86cQzwdT";

    function run() external {
        address basicNFTAddress = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        vm.startBroadcast();
        // mintNft(0xDAE2903C1Da0CfAbb79E28c1139D6E4717E6Da97);
        mintNft(basicNFTAddress);
        vm.stopBroadcast();
    }

    function mintNft(address basicNFTaddress) public {
        BasicNFT(basicNFTaddress).mintNFT(kitty);
    }
}

contract MintKittyNFT_KittyMoodNFT is Script {
    function run() external {
        address kittyMoodNFT = DevOpsTools.get_most_recent_deployment("KittyMoodNFT", block.chainid);

        vm.startBroadcast();
        // mintKittyNFT(0xDA9A1F6375830E8565910837cf9deb022077Dd83);
        mintKittyNFT(kittyMoodNFT);
        vm.stopBroadcast();
    }

    function mintKittyNFT(address kittyMoodNFT) public {
        KittyMoodNFT(kittyMoodNFT).mintKittyNFT();
    }
}

contract FlipKittyMood_KittyMoodNFT is Script {
    function run() external {
        address kittyMoodNFT = DevOpsTools.get_most_recent_deployment("KittyMoodNFT", block.chainid);
        uint256 tokenId = 0;
        
        vm.startBroadcast();
        // flipKittyMood(0xDA9A1F6375830E8565910837cf9deb022077Dd83, tokenId);
        flipKittyMood(kittyMoodNFT, tokenId);
        vm.stopBroadcast();
    }

    function flipKittyMood(address kittyMoodNFT, uint256 tokenId) public {
        KittyMoodNFT(kittyMoodNFT).flipKittyMood(tokenId);
    }
}