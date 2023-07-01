// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract KittyMoodNFT is ERC721 {
    error KittyMoodNFT__invalidTokenId();
    error KittyMoodNFT__notNFTOwner();

    enum Mood {
        Happy,
        Sad
    }

    uint256 private s_tokenCounter;
    string private s_sadCatImageURI;
    string private s_happyCatImageURI;
    mapping(uint256 => Mood) private s_tokenIdToMood;

    // Events
    event mintedNFT(uint256 indexed tokenId, address indexed owner);
    event moodFlipped(uint256 indexed tokenId, Mood indexed oldMood, Mood indexed newMood);

    constructor(string memory happyCatImageURI, string memory sadCatImageURI) ERC721("KittyMoodNFT", "KMN") {
        s_tokenCounter = 0;
        s_happyCatImageURI = happyCatImageURI;
        s_sadCatImageURI = sadCatImageURI;
    }

    function mintKittyNFT() public {
        uint256 tokenId = s_tokenCounter;
        s_tokenCounter++;

        _safeMint(msg.sender, tokenId);
        s_tokenIdToMood[tokenId] = Mood.Happy;

        emit mintedNFT(tokenId, msg.sender);
    }

    function flipKittyMood(uint256 tokenId) public {
        if (tokenId >= s_tokenCounter) {
            revert KittyMoodNFT__invalidTokenId();
        }

        if (msg.sender != _ownerOf(tokenId)) {
            revert KittyMoodNFT__notNFTOwner();
        }

        Mood prevMood = s_tokenIdToMood[tokenId];

        if (prevMood == Mood.Happy) {
            s_tokenIdToMood[tokenId] = Mood.Sad;
        }
        else {
            s_tokenIdToMood[tokenId] = Mood.Happy;
        }

        emit moodFlipped(tokenId, prevMood, s_tokenIdToMood[tokenId]);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (tokenId >= s_tokenCounter) {
            revert KittyMoodNFT__invalidTokenId();
        }

        string memory tokenName;
        string memory imageURI;
        string memory desc;

        if (s_tokenIdToMood[tokenId] == Mood.Happy) {
            tokenName = "Happy Cat";
            imageURI = s_happyCatImageURI;
            desc = "A cute cat, very happy, adorable and playful.";
        }
        else {
            tokenName = "Sad Cat";
            imageURI = s_sadCatImageURI;
            desc = "The cat is sad, our prayers are with the cat, it will be happy soon. The one who made her sad will be punished.";
        }

        bytes memory tokenMetadata = abi.encodePacked('{"name":"', tokenName, '","description":"', desc, '","image":"', imageURI, '","attributes":[{"hobbies":["cooking","gaming"]}, {"attitude":100}]}');
        return string.concat(_baseURI(), Base64.encode(tokenMetadata));
    }

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }

    function getSadCatImageURI() external view returns (string memory) {
        return s_sadCatImageURI;
    }
    
    function getHappyCatImageURI() external view returns (string memory) {
        return s_happyCatImageURI;
    }

    function getMood(uint256 tokenId) external view returns (Mood) {
        if (tokenId >= s_tokenCounter) {
            revert KittyMoodNFT__invalidTokenId();
        }

        return s_tokenIdToMood[tokenId];
    }
}