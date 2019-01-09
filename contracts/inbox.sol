pragma solidity ^0.4.25;

contract Inbox {
    string private message;
    
    function Inbox(string _message) public  {
        message = _message;
    }
    
    function setMessage (string _message) public {
        message = _message;
    }
    
    function getMessage() public view returns(string) {
        return message;
    }
}