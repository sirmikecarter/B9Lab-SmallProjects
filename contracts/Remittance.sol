pragma solidity ^0.4.6;

contract Remittance {
    address public owner;
    address public contractAddress;
    uint    public deadline;
    uint    public fee;
    
    event LogExchange(address msgSender, address recieverAddress, uint contractAmount);
    
    struct ExchangeShopDetails {
        address recieverAddress;
        uint recieverAmount;
        uint deadline;
    }
    
    struct HashCodes {
        bytes32 theHash;
    }
    
    HashCodes[] private hashCodes;
    
    mapping(address=>ExchangeShopDetails) public exchangeShopDetails;

    function Remittance(){
        owner = msg.sender;
        fee = 300000 * 4000000 ; //Fee (gas*gasPrice)
        contractAddress = this;
        
    }
    
    function enterHashCodes(bytes32 inputHash1,bytes32 inputHash2) public returns (bool success) {
        
         HashCodes memory newCodes;
         newCodes.theHash = keccak256(inputHash1,inputHash2);
         hashCodes.push(newCodes);
         return true;
    }

    function exchangeShop(uint duration, address recieverAdd) public payable returns (bool success) {
         
         if(msg.value== 0) revert();
         
         exchangeShopDetails[msg.sender].recieverAddress = recieverAdd;
         exchangeShopDetails[msg.sender].recieverAmount = msg.value/2; //Local Currency
         exchangeShopDetails[msg.sender].deadline = block.number+duration;
         
         LogExchange(msg.sender, recieverAdd, msg.value );

         return true;
    }

    function verifyFunds(bytes32 verifyhash1, bytes32 verifyhash2, address contractOwner) public returns (bool success) {
       
        require(hashCodes[0].theHash == keccak256(verifyhash1,verifyhash2));
        exchangeShopDetails[contractOwner].recieverAddress.transfer(exchangeShopDetails[contractOwner].recieverAmount);
        contractOwner.transfer(fee);
        return true;
    }


    function killMe() {
        assert(msg.sender==owner);
        suicide(owner);
    }

}
