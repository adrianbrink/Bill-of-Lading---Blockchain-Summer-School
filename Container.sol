contract Container {
    uint public id;
    string public contentDescription;
    enum State { Initial, LoadingSpecified, Sent, ApprovedForShipping, Loaded, ApprovedForCollecting, Collected  }
    State public currentState;
    address public owner;
    address public forwarder;
    mapping (address => bool) public whitelist;
    bool ownerSet = false;

    modifier isWhitelisted {
        if (whitelist[msg.sender] == false) throw;
        _
    }
    
    function Container(){
        whitelist[msg.sender] = true;
        forwarder = msg.sender;
    }
    
    function specifyLoading(uint idEx, string description) isWhitelisted {
        if (currentState != State.Initial) throw;
        id = idEx;
        contentDescription = description;    
    }
    
    function send() isWhitelisted {
        if (currentState != State.LoadingSpecified) throw;
        currentState = State.Sent;
    }
    
    function approveForShipping() isWhitelisted {
        if (currentState != State.Sent) throw;
        currentState = State.ApprovedForShipping;    
    }
    
    function load() isWhitelisted {
        if (currentState != State.ApprovedForShipping) throw;
        currentState = State.Loaded;    
    }
    
    function approvForCollecting() isWhitelisted {
        if (currentState != State.Loaded) throw;
        currentState = State.ApprovedForShipping;    
    }
    
    function collect() isWhitelisted {
        if (currentState != State.ApprovedForCollecting && msg.sender != owner) throw;
        currentState = State.ApprovedForCollecting;    
    }
    
    function addToWhitelist(address party) isWhitelisted {
        whitelist[party] = true;
    }
    
    function removefromWhitelist(address party) isWhitelisted {
        whitelist[party] = false;
    }
    
    function updateOwnership(address newOwner) isWhitelisted {
        if (msg.sender != owner) throw;
        owner = newOwner;   
    }
    
    function setOwner(address newOwner) isWhitelisted {
        if (msg.sender != forwarder && !ownerSet) throw;
        ownerSet = true;
        owner = newOwner;
    }
}
