// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract CompareStrings {


    function compareStrings(string memory a, string memory b) public pure returns (bool isEqual) {
        isEqual = keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }


}

