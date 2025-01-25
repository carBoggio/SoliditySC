// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./tokenERC20.sol";


contract SuperERC20 is SuperToken{
    constructor() SuperToken("joan", "JP"){

    } 
    function createTokens() public {
        mint(msg.sender, 1000);
    }


}