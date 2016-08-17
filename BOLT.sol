contract BOLT {
  address public minter;
  bool public mainToken;
  address public carrierReference;
  address public referencetoGT;
  bool public validity;
  string public name;
  string public symbol;
  uint8 public decimals = 0;
  string public standard = 'Token 0.1';
  bool public minterSet = false;
  mapping (address => uint256) public balance;

  function BOLT(string tokenName, string tokenSymbol) {
    name = tokenName;
    symbol = tokenSymbol;
  }

  function transfer(address _to, uint _amount) {
    if (balance[msg.sender] < _amount) throw;
    balance[msg.sender] -= _amount;
    balance[_to] += _amount;
  }

  function mint(address receiver) {
    if (msg.sender != minter) return;
    balance[receiver] += 1;
  }

  function owner(address owner) {
    if (!minterSet) {
      minter = owner;
      minterSet = true;
    }
  }
}

contract GT {
  uint public productCode;
  string public description;
  uint public weight;
  uint public volume;
  uint public dangerLevel;
  address public referenceToBOLT;
  bool public validity;
  string public name;
  string public symbol;
  uint8 public decimals = 0;
  string public standard = 'Token 0.1';
  mapping public (address => uint) balance;
         
  function GT(string tokenName, string tokenSymbol) {
    name = tokenName;
    symbol = tokenSymbol;
  }

  function transfer(address _to, uint _amount) {
    if (balance[msg.sender] < _amount) throw;
      balance[msg.sender] -= _amount;
      balance[_to] += _amount;
  }

  function mint(address receiver) {
    balance[receiver] += 1;
  }
}
