// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
// Capacidad de multitoken

// Owner: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// Receptor: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// Operador: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db



import "@openzeppelin/contracts@4.5.0/token/ERC1155/ERC1155.sol";
contract erc1155 is ERC1155 {
    // Variables son los id:
    uint public constant GOLD = 0;
    uint public constant SILVER = 1;
    uint public constant PLATINUM = 2;
    uint public constant COPPER = 3;
    uint public constant IRON = 4;
    uint public constant TITANIUM = 5;
     
     
     constructor() ERC1155("https://metalesSolidity.com/{id}.json") {
        // En la uri se guarda informacion de cada uno de los tipos de tokens
       _mint(msg.sender, GOLD, 10**18, ""); // Crear un nuevos tokens
        _mint(msg.sender, SILVER, 10**17, "");
        _mint(msg.sender, PLATINUM, 10**16, "");
        _mint(msg.sender, COPPER, 10**15, "");
        _mint(msg.sender, IRON, 10**14, "");
        _mint(msg.sender, TITANIUM, 10**13, "");
     }


}


