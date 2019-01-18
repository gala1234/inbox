pragma solidity ^0.4.25;

contract Campaign {
    struct Request {
        string description;
        uint amount; // in ether unit
        address recipient;
        bool complete;
        mapping (address => Approval) ApprovalsMap;
        uint approvalsCount;
    } 
    struct Approver {
        address wallet;
        string name;
        uint contribution; // in ether unit
    }
    
    address public manager;
    Request[] public requests;
    uint public numRequests;
    mapping (address => Approver) approversMap;
    uint public numApprovers;

    modifier restrictedFinalizeRequest() {
        require(msg.sender == manager);
        require(msg.sender == manager);
        
        _;
    }
    
    constructor() public  payable {
        manager = msg.sender;
        numRequests = 0;
        numApprovers = 0;
    }
    
    function contribute(string _name) public payable{
        //called when someone wants to donate money to the campaign and become an 'approver'
        require(msg.value >= 0.1 ether);
        require(approversMap[msg.sender].wallet == 0x0);
        
        Approver memory newApprover = Approver({
            wallet: msg.sender, 
            name: _name, 
            contribution: msg.value
        });
        approversMap[msg.sender] = newApprover;
        numApprovers++;
    }
    
    function createRequest(string _description, uint _amount, address _recipient) public returns(uint requestID) {
        require(msg.sender == manager);
        
        Request memory newRequest = Request({
            description: _description, 
            amount: _amount, 
            recipient: _recipient, 
            complete: false, 
            approvalsCount: 0
        });
        
        requestID = numRequests;
        // Creates new struct and saves in storage. We leave out the mapping type.
        requests.push(newRequest);
        
        numRequests++;
    }
    
    function aproveRequest(uint requestID) public view {
        require(approversMap[msg.sender].wallet == msg.sender); 
   
        Approval memory newApproval = Approval({
            address: msg.sender
        });

        Request[requestID].ApprovalsMap[newApproval] = true;

        approvalsCount = Request[requestID].approvalsCount++;
        
        if (numApprovers % approvalsCount >= 2) {
            Request[requestID].complete = true;
            finalizeRequest(requestID);
        }
        
    }
    
    function finalizeRequest() public restrictedFinalizeRequest payable {
        requests[requestID].recipient.transfer(address(this).balance);
    }
}