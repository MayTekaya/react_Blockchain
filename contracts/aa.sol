pragma solidity >0.4.99 <0.6.0;

 

contract ERC20Basic {

 

    // @return total amount of tokens
    function totalSupply() public view returns (uint256);

 

    // @param _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(address who) public view returns (uint256);

 

    // @notice send `_value` token to `_to` from `msg.sender`
    // @param _to The address of the recipient
    // @param _value The amount of token to be transferred
    // @return Whether the transfer was successful or not
    function transfer(address to, uint256 value) public returns (bool);

 

    // @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    // @param _from The address of the sender
    // @param _to The address of the recipient
    // @param _value The amount of token to be transferred
    // @return Whether the transfer was successful or not
    function transferFrom(address from, address to, uint256 value) public returns (bool) {}

 

    // @notice `msg.sender` approves `_addr` to spend `_value` tokens
    // @param _spender The address of the account able to transfer the tokens
    // @param _value The amount of wei to be approved for transfer
    // @return Whether the approval was successful or not
    function approve(address spender, uint256 value) public returns (bool);

 

    // @param _owner The address of the account owning tokens
    // @param _spender The address of the account able to transfer the tokens
    // @return Amount of remaining tokens allowed to spent
    function allowance(address owner, address spender) public view returns (uint256);

 

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
}

 

contract StandardToken is ERC20Basic {
    
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public _totalSupply;

 

    function totalSupply() public view returns (uint256) {
            return _totalSupply;
    }
 
    function balanceOf(address who) public view returns (uint256) {
        return balances[who];
    }
    
    function transfer(address to, uint256 value) public returns (bool) {
        //Default assumes totalSupply can't be over max (2^256 - 1).
        if (balances[msg.sender] >= value && value > 0) {
            balances[msg.sender] -= value;
            balances[to] += value;
            emit Transfer(msg.sender, to, value);
            return true;
        } else { return false; }
    }

 

    function transferFrom(address from, address to, uint256 value) public returns (bool){
        if (balances[from] >= value && value > 0) {
            balances[to] += value;
            balances[from] -= value;
           allowed[from][msg.sender] -= value;
            emit Transfer(from, to, value);
            return true;
        } else { return false; }
    }

 

    function approve(address spender, uint256 value) public returns (bool) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender,spender, value);
        return true;
    }

 

    function allowance(address owner, address spender) public view returns (uint256){
        return allowed[owner][spender];
    }
   
}

 


//name this contract whatever you'd like
contract MyToken is StandardToken {

 

     
      string public name;
      string public symbol;
      uint32 public decimals;
    
     /**
     * @dev assign totalSupply to account creating this contract
     */
     constructor () public {
      symbol = "IMFT";
      name = "IMFToken";
      decimals = 0;
      _totalSupply= 100000000000;
  
       balances[msg.sender] = _totalSupply;
    
    }
    
    
}