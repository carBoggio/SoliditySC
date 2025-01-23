// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract dataStructures {
    struct Custumer {
        uint id;
        string name;
        string email;
    }

    Custumer custumer1 = Custumer(1, "Joan", "joan@gmail.com");
    // Todo los datos que se guardan en la blockchain son publicos, hay que tener
    // cuidado con lo que se guarda


    // Longitud fija
    uint256 [5] public fixed_list_uints = [1, 3, 4, 5, 6];

    // longitud dinamica
    // Basicamente no le ponemos unidades
    uint256 [] dynamic_list_uints ;

    // Array dinamico de tipo cliente

    Custumer [] public dynamic_list_Custumer;

    // Mappings:
    mapping(address => uint256) public address_uint;
    mapping(string => uint256 []) public string_listUnits;
    mapping(address => Custumer) public address_dataStructures;

    
    function insertInMappings(string memory _name, uint _number) public {
        string_listUnits[_name].push(_number);
    }
    
        function addClient(uint _id, string memory _name, string memory _email) public {
        address_dataStructures[msg.sender] = Custumer(_id, _name, _email);
    }
    
    function arrayModifications (uint256 _id, string memory _memory_name, string memory _email ) public {
        // El hecho de que sea memory hace que no se guarde en la blockchain
        Custumer memory randomCustomer = Custumer(_id, _memory_name, _email);
        dynamic_list_Custumer.push(randomCustomer);
    }




}



