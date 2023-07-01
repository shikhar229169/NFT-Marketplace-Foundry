// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";


contract BasicNFTTest is Test {
    BasicNFT public basicNFT;
    string public constant kitty = "ipfs://QmNPtWDJ3uWVuAFzC36izupThZQjqLJRvX6hFK86cQzwdT";
    address public user = makeAddr("user");
    uint256 public START_ETH = 10 ether;

    event NFTMinted(address indexed owner, uint256 indexed tokenId);

    function setUp() external {
        DeployBasicNFT deployBasicNFT = new DeployBasicNFT();
        basicNFT = deployBasicNFT.run();
        vm.deal(user, START_ETH);
    }

    function test_tokenCounterInitializedToZero() public {
        assertEq(basicNFT.getTokenCounter(), 0);
    }

    function test_NFT_NameSymbolIsCorrect() public {
        string memory expectedName = "Kitty";
        string memory expectedSymbol = "PAW";

        assertEq(basicNFT.name(), expectedName);
        assertEq(basicNFT.symbol(), expectedSymbol);
    }

    function test_MintNFT_WorksCorrect() public {
        uint256 prevTokenCounter = basicNFT.getTokenCounter();
        uint256 prevUserBalance = basicNFT.balanceOf(user);

        vm.prank(user);
        vm.expectEmit(true, true, false, false, address(basicNFT));
        emit NFTMinted(user, prevTokenCounter);
        basicNFT.mintNFT(kitty);

        assertEq(prevTokenCounter + 1, basicNFT.getTokenCounter());
        assertEq(basicNFT.balanceOf(user), prevUserBalance + 1);
        assertEq(basicNFT.ownerOf(prevTokenCounter), user);
        assertEq(basicNFT.tokenURI(prevTokenCounter), kitty);
    }

    function test_tokenURI_RevertsIfTokenIdNotExist(uint256 randomTokenId) public {
        vm.expectRevert(
            abi.encodeWithSignature("BasicNFT__invalidTokenId()")
        );
        basicNFT.tokenURI(randomTokenId);
    }
}