// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract functions {
    event log(string _name, address _sender, uint _amount, bytes _data);


    fallback() external payable {
        emit log("fallback", msg.sender, msg.value, msg.data);
     }

    receive() external payable { 
        emit log("receive", msg.sender, msg.value, "");
    }


    constructor() payable {

    }

    function _addMod(uint x, uint y, uint k ) public pure returns (uint, uint) {
        return (addmod(x, y, k), (x+y)%k );
    }

 
}