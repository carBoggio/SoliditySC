// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract functions {
    function getName() public pure returns (string memory){
        return "Joan";
    }

    uint256 x = 100;
    // Esta funcion lee datos de la blockchain en este caso x
    function getNumber() public view returns (uint256){
        return x * 2;
    }




}