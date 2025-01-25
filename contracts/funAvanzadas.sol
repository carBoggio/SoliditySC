// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract Food {
    // Estructura de datos
    struct DinnerPlate {
        string name;
        string ingredients;
    }
    // Dinner Plate
    DinnerPlate [] menu;

    function newMenu(string memory _name, string memory _ingretients) internal {
        menu.push(DinnerPlate(_name, _ingretients));
    }

}

contract Hamburguer is Food {
    address public owner;
    constructor(){
        owner = msg.sender;
    }

    function doHamburguers(string memory _ingredients, uint _utins) external {
        require (_utins <= 5, "No se pueden pedir tantas hamburguesas");
        newMenu("Hamburguer", _ingredients);
    }


    modifier onlyOwner(){
        require(owner == msg.sender, "No hay permisos para ejecutar esto, solo lo puede hacer el owner");
        _;
    }
    // Le pusimos una restriccion, solo la puede ejecutar el owner
    function hashPrivateNumber(uint _number) public  view onlyOwner returns (bytes32){
        return keccak256(abi.encodePacked(_number));
    }

}