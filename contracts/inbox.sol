pragma solidity ^0.4.25;

contract Campaign {

    struct Request {
        string description;
        uint amount;
        address recipient;
        bool complete;
        mapping approvals;
        uint approvalCount;
    }

    address public manager;
    uint public minimumContribition;
    address[] public approvers; //transform to mapping
    Requests[] public ;

    constructor() public {
        //constructor function that sets the minimumContribution and the owner.
        manager = msg.sender;
    }

    function contribute() public view payable{
        bool isApprover = false;

        for(uint i=0; i<approvers.length; i++){
            isApprover = isApprover || (msg.sender = approvers[i]);
        }
        if (!isApprover) {
            approvers.push(msg.sender);
        }
        //called when someone wants to donate money to the campaign and become an 'approver'
    }

    function createRequest() public view return(string description){
        require(msg.sender == manager);
        description = _description;
        //called by the manager to create a new spending request
    }

    function approveRequest() public pure return(bool){
        bool approve = false;

        //called by each contributor to approve a spending request
    }

    function finalizeRequest() public view payable{
        if (msg.sender == manager) {
            approvers[].filter((aprover) => aprover.yes);
            return approvalCount
        }
        if (approvers.lenght % approvalCount >= 2) {
            return 
        }
        //after a request has gotten enough approvals, the manager can call this to get money sent to vendor
    }
}