// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Padre {
    // Amacenamiento de los contratos
    mapping(address => address) public personalContracts;

    function factory() public {
        personalContracts[msg.sender] = address(new Hijo(msg.sender, address(this)));
    }


}


contract Hijo{
    // Datos recividos del contrato padre

    Owner public padre;

    struct Owner {
        address _owner;
        address _smartContractPadre;
    }



    constructor(address _accountCons, address _accountSC){
        padre._owner = _accountCons;
        padre._smartContractPadre = _accountSC;
    }
}