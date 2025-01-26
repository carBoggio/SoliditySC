// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.4.2/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.4.2/access/Ownable.sol";

contract ArtToken is ERC721, Ownable {

// Smart Contract constructor:
constructor(string memory _name, string memory _symbol) 
ERC721(_name, _symbol){}

    // ============================================
    // Initial Statements
    // ============================================

struct Art {
    string name;
    uint id;
    uint dna;
    uint level;
    uint rarity;
}

// El counter sirve para llevar un track de la cantidad de tokens que existen
// y para poner ids
uint counter;
// El fee es el precio de los tokens
uint public fee = 5 ether;
// Storage structure for keeping artworks:
Art [] public artWorks;
// Declaration for an event:
event NewArtWork(address indexed owner, uint id, uint dna);

    // ============================================
    // Functions:
    // ============================================

    // Creation of a random number, su rareza
    function _createRandomNumber(uint _mod) internal view returns (uint){
        bytes32 has_random = keccak256(abi.encodePacked(block.timestamp, msg.sender));
        uint randomNumber = uint256(has_random);
        return randomNumber % _mod;
    }

    // Crear tokens nfts:
    function _crearArtWork(string memory _name) internal {
        uint rarity = uint(_createRandomNumber(1000));
        uint dna = uint(_createRandomNumber(10**16));
        Art memory newArtWork = Art(_name, counter, dna, 1, rarity);
        artWorks.push(newArtWork);
        _safeMint(msg.sender, counter);
        emit NewArtWork(msg.sender, counter, dna);
        counter++;
    }

    // Update nft price
    function updateFee(uint _newFee) external onlyOwner{
        fee = _newFee;
    }
    // Update info del smart Contract
    function infoSmartContract() public view returns (address, uint){
        address SCaddress = address(this);
        uint SCMoney = address(this).balance / (10**18);
        return (SCaddress, SCMoney); 
    }
    // Obtener todos los artWorks:
    function getAllArts() public view returns (Art [] memory)  {
        return artWorks;
    }

    function getOwnerArtWork(address _owner) public view returns (Art [] memory) {
        Art [] memory result = new Art [](balanceOf(_owner));
        uint counter_internal = 0;
        for (uint i = 0 ; i < artWorks.length ; i++){
            if (ownerOf(i) == _owner){
                result[counter_internal] = artWorks[i];
                counter_internal++;

            }
        }
        return result;
    }

    // ============================================
    // NFT token dev:
    // ============================================
    // NFT token payment:

    function createRandomArtWork(string memory _name ) public payable {
        require(msg.value >= fee);
        _crearArtWork(_name);
    }
    function withdraw() external payable onlyOwner {
        address payable _owner = payable(owner());
        _owner.transfer(address(this).balance);
    }

    function levelUp(uint _artId) public {
        require(ownerOf(_artId) == msg.sender, "sender don't owns the Art");
        Art storage art = artWorks[_artId];
        art.level++;
    }

}