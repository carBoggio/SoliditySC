// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns  (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);
    // Le permitimos a nuesto amigo gastar tal cantidad
    function approve(address spender, uint amount) external returns (bool);
    //Desde que direccion se envian los tokens, indica el emisor
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    // Cuando trnasferimos 
    event Transer(address indexed from, address indexed to, uint256 value);
    // Cuando se designa una cantidad para gastar, es emite el evento en la blockchain
    event Aprobal(address indexed owner, address indexed spender, uint256 value);
    // Direccion indexada: Cuando tenemos un evento lo podemos filtrar por propiedades indexadas
    // Basicamente es para filtrar

}


contract SuperToken is IERC20 {
    mapping(address => uint256) private _balances;

    // Owner (Joan -> Spender (Alberto -> 5 tokens))
    
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;


constructor(string memory name_, string memory symbol_){
    _name = name_;
    _symbol = symbol_;
}


// Getter para el nombre
function name() public view virtual returns (string memory) {
    return _name;
}

// Getter para el símbolo
function symbol() public view virtual returns (string memory) {
    return _symbol;
}

function decimals() public view virtual returns (uint8) {
    return 18; // Es la cantidad de decimales para el token
    // por ejemplo, si el saldo de un usuario es 505, en realidad tiene 5.05 tokens
}

function totalSupply() public view virtual override returns (uint256){
    return _totalSupply;
}

function balanceOf(address account) external view virtual override returns  (uint256){
    return _balances[account];
}

function transfer(address to, uint256 amount) public virtual override returns (bool){
    address owner = msg.sender;
    _transfer(owner, to, amount);
    return true;
}


function allowance(address owner, address spender) public view virtual override returns (uint256){
    return _allowances[owner][spender];
}
// Le permitimos a nuesto amigo gastar tal cantidad
function approve(address spender, uint amount) public virtual override returns (bool){
    address owner = msg.sender;
    _approve(owner, spender, amount);
    return true;
}
//Desde que direccion se envian los tokens, indica el emisor
function transferFrom(
    address from,
    address to,
    uint256 amount
) public virtual override returns (bool){
    address spender = msg.sender;
    _spendAllowance(from, spender, amount);
    _transfer(from, to, amount);
    return true;
}
function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool){
    address owner = msg.sender;
    uint256 newAllowance = allowance(owner, spender) + addedValue;
    _approve(owner, spender,newAllowance);
    return true;
}

function decreaseAllowance(address spender, uint256 substractedValue) public virtual returns (bool){
    address owner = msg.sender;
    uint256 currentAllowance = allowance(owner, spender);
    require(currentAllowance >= substractedValue, "not enouth tokens to substract");
    unchecked {
        _approve(owner, spender, currentAllowance - substractedValue);
    }
    return true;
}

function _transfer(
    address from, 
    address to,
    uint amount
) internal virtual {
    _avoidCeroAddreces(from, to);
    _beforeTokenTransfer(from, to, amount);
    _transferTheBalance(from, to, amount);
    emit Transfer(from, to, amount);
    _afterTokenTransference(from, to, amount);

}
event Transfer(address indexed from, address indexed to, uint256 value);

function _avoidCeroAddreces(address to, address from) pure private {
    _avoidZeroAddress(from,  "ERC20: transfer from the zero address");
    _avoidZeroAddress(to, "ERC20: transfer to the zero address");
}


function _avoidZeroAddress(address addr, string memory errorMessage) pure private {
    require(addr != address(0), errorMessage);
}


function _checkThatSenderHaveEnougthFounds(address from, uint amount) view private {
    uint256 fromBalance = _balances[from];
    require(fromBalance >= amount, "ERC20 : Transfer amount exceeds balance");
}



function _transferTheBalance(address from, address to, uint256 amount) private {
    _checkThatSenderHaveEnougthFounds(from, amount);
    unchecked {
    _balances[from] -= amount;     
    }
    _balances[to] += amount;
}


function mint(address account, uint amount) internal virtual {
    _avoidZeroAddress(account, "ERC20: mind to the zero address");
    _beforeTokenTransfer(address(0), account, amount);
    _addToTotalSupply(amount);
    _addToAccountBalance(account, amount);
    emit Transer(address(0), account, amount);
    _afterTokenTransference(address(0), account, amount);

}

function _burn(address account, uint amount) internal virtual{
    _avoidZeroAddress(account, "ERC20: burn from cero address");
    _beforeTokenTransfer(account, address(0), amount);
    _checkThatSenderHaveEnougthFounds(account, amount);
    unchecked {
        _balances[account] -= amount;  
    }
    _SubstractToTotalSupply(amount);
    emit Transer(account, address(0), amount);
    _afterTokenTransference(account, address(0), amount);

}



function _addToTotalSupply(uint quantity) private {
    _totalSupply += quantity;
}

function _SubstractToTotalSupply(uint quantity) private {
    _totalSupply -= quantity;
}


function _addToAccountBalance(address account, uint quantity) private {
    _balances[account] += quantity;
}


event Approval(address indexed owner, address indexed spender, uint256 value);

function _approve (
    address owner,
    address spender,
    uint256 amount
) internal virtual  {
    _avoidZeroAddrecesInAprove(owner, spender);
    _allowances[owner][spender] += amount;
    emit Approval(owner, spender, amount);
}

function _avoidZeroAddrecesInAprove(address to, address from) private pure {
    _avoidZeroAddress(from,  "ERC20: aprove from the zero address");
    _avoidZeroAddress(to, "ERC20: aprove to the zero address");
}

function _spendAllowance(address owner, address spender,uint amount) internal virtual{
    uint currentAllownace =  allowance(owner, spender);
    if (currentAllownace == type(uint256).max){
        return;
    }
    
    _checkHaveEnoughtAllownce(currentAllownace, amount);
    unchecked {
        _approve(owner, spender, amount);
    }

}

function _checkHaveEnoughtAllownce(uint currentAllownace, uint amount) private pure{
    
        require(currentAllownace >= amount, "ERC20: insuffienct allowance");
    }


function _beforeTokenTransfer(
    address from, 
    address to,
    uint256 amount
) internal virtual {}

function _afterTokenTransference(
    address from, 
    address to,
    uint256 amount
) internal virtual {}

}


