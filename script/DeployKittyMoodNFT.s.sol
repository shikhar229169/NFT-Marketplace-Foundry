// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {KittyMoodNFT} from "../src/KittyMoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployKittyMoodNFT is Script {
    function run() external returns (KittyMoodNFT) {
        string memory happySVG = vm.readFile("./images/svgs/happyCat.svg");
        string memory sadSVG = vm.readFile("./images/svgs/sadCat.svg");
        string memory happyCatURI = svgToImageURI(happySVG);
        string memory sadCatURI = svgToImageURI(sadSVG);

        vm.startBroadcast();

        KittyMoodNFT kittyMoodNFT = new KittyMoodNFT(happyCatURI, sadCatURI);

        vm.stopBroadcast();

        return kittyMoodNFT;
    }

    function svgToImageURI(string memory svgImage) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svgImage));

        return string.concat(baseURI, svgBase64Encoded);
    }
}