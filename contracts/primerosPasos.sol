// SPDX-License-Identifier: MIT

//Version
pragma solidity ^0.8.4;

// Importar un smartContract desde OpenZeppeling:
import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";

// Declaracion del smart Contract:
contract varaibles_modifiers is ERC721 {
    
    // Almacenamos en owner la direccion de quien despliega el contrato
    address public owner;
    uint256 a;
    uint8 public b = 3;
    string public str_private = "Esto es privado";

    bytes1 one_byte;
    bytes32 first_bytes;
    bytes4 second_bytes;
    bytes32 public hashing = keccak256(abi.encodePacked("Hola", "joel", uint(10)));
    bytes32 public hashing_sha256 = sha256(abi.encodePacked("Hello Word"));
    bytes20 public hashing_ripemd160 = ripemd160(abi.encodePacked("Hello Word"));


    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        owner = msg.sender; // Te da la direccion de quien despliega el contrato
    }

    address addRandom = msg.sender;

    enum options {ON, OFF}
    options constant defaultChoice = options.OFF;
    options state;


    function turnOn() public {
        state = options.OFF;
    }

    function turnOff() public {
        state = options.ON;
    }



}