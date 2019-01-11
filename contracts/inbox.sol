pragma solidity ^0.4.25;

contract Lottery {
    struct Player {
        address wallet;
        string name;
    }
    
    address public manager;
    mapping (address => Player) public playersMap;
    mapping (uint => address) private addressesMap;
    Player private winner;
    uint public numPlayers;
    
    modifier restrictedPickWinner() {
        require(msg.sender == manager);
        require(numPlayers > 0);
        require(winner.wallet == 0x0);
        
        _;
    }
    
    constructor() public {
        manager = msg.sender;
        numPlayers = 0;
    }
    
    function enter(string _name) public payable {
        require(msg.value > 0.1 ether);
        require(playersMap[msg.sender].wallet == 0x0);
        
        Player memory newPlayer = Player({
            wallet: msg.sender,
            name: _name
        });
        
        playersMap[msg.sender] = newPlayer;
        numPlayers++;
        addressesMap[numPlayers] = msg.sender;
    }
    
    function pickWinner() public restrictedPickWinner returns(address) {
        address aux = addressesMap[random() % numPlayers];
        
        winner = playersMap[aux];
        
        winner.wallet.transfer(address(this).balance);
            
        return winner.wallet;
    }
    
    function getWinner() public view returns (address, string) {
        return (winner.wallet, winner.name);
    }
    
    function getPlayer(uint index) public view returns (address) {
        address aux = addressesMap[index];
        return playersMap[aux].wallet;
    }
    
    function random() private view returns(uint) {
        return uint(keccak256(block.difficulty, now, numPlayers, manager));
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}