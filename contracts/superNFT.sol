// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


// Importacion en openZeppelin:
import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.5.0/utils/Counters.sol";

contract erc721 is ERC721 {
    // Contador para los id de los nft:
    using Counters for Counters.Counter;
    Counters.Counter private _tokensId;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){
    }

    function sendNFT(address _account) public {
        _tokensId.increment();
        uint newItemId = _tokensId.current();
        _safeMint(_account, newItemId);
    }




}