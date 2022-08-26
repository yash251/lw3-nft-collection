// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract CryptoDevs is ERC721Enumerable, Ownable {
    string _baseTokenURI; // _baseTokenURI for computing {tokenURI}
    uint256 public _price = 0.01 ether;
    bool public _paused; // pause the contract in case of an emergency
    uint256 public maxTokenIds = 100;
    uint256 public tokenIds;
    IWhitelist whitelist; // Whitelist contract instance
    bool public presaleStarted;
    uint256 public presaleEnded;

    modifier onlyWhenNotPaused() {
        require(!_paused, "Contract currently paused");
    }

    constructor(string memory baseURI, address whitelistContract)
        ERC721("CryptoDevs", "CD")
    {
        _baseTokenURI = baseURI;
        whitelist = IWhitelist(whitelistContract); // initializes an instance
    }

    function startPresale() public onlyOwner {
        presaleStarted = true;
        presaleEnded = block.timestamp + 5 minutes;
    }
}
