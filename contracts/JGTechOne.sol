//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./ERC721Tradable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract JGTechOne is ERC721Tradable{
    uint8 private _tokenCounter;
    mapping(uint8 => string) tokenIdToHash;

    constructor(address _proxyRegistryAddress) ERC721Tradable("JGTech", "1JGT", _proxyRegistryAddress) {
        _tokenCounter = 1;
    }

    function baseTokenURI() override public pure returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function mintToken(address _to, string memory _hash) public onlyOwner returns (uint256) {
        require(!_hashExists(_hash), "Hash already exists on blockchain");
        uint8 _tokenId = _tokenCounter;
        tokenIdToHash[_tokenId] = _hash;
        _tokenCounter = _tokenCounter + 1;
        _mint(_to, _tokenId);
        tokenURI(_tokenId, _hash);
        return _tokenId;
    }

    function _hashExists(string memory _hash) internal view returns (bool) {
        for (uint8 i = 1; i <= _tokenCounter; i++) {
            if (keccak256(bytes(tokenIdToHash[i])) == keccak256(bytes(_hash))) {
                return true;
            }
        }
        return false;
    }

    function getHash(uint8 _tokenId) public view onlyOwner returns (string memory _hash) {
        _hash = tokenIdToHash[_tokenId];
    }
}