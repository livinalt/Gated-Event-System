//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GatedToken is ERC721, Ownable {
    
    constructor(address initialOwner)
        ERC721("GatedToken", "GTK")
        Ownable(initialOwner)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://coffee-blank-owl-368.mypinata.cloud/ipfs/QmUYpzFoJLnnq97HL9Vo8FMz8KHDeoCgzJ6BCJkakR4eVU";
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}