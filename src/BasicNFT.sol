// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    error BasicNFT__invalidTokenId();

    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToURI;

    // Events
    event NFTMinted(address indexed owner, uint256 indexed tokenId);

    constructor() ERC721("Kitty", "PAW") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory _tokenURI) public {
        uint256 id = s_tokenCounter;
        s_tokenCounter++;
        _safeMint(msg.sender, id);
        s_tokenIdToURI[id] = _tokenURI;

        emit NFTMinted(msg.sender, id);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (tokenId >= s_tokenCounter) {
            revert BasicNFT__invalidTokenId();
        }

        return s_tokenIdToURI[tokenId];
    }

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
}