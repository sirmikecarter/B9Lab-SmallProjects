pragma solidity ^0.4.6;

contract Remittance {
    address public owner;
    address public contractAddress;
    uint    public deadline;
    uint    public fee;
    
    event LogExchange(address msgSender, address recieverAddress, uint contractAmount);
    
    struct ExchangeShopDetails {
        address creatorAddress;
        address recieverAddress;
        uint recieverAmount;
        uint deadline;
    }

    mapping(bytes32=>ExchangeShopDetails) private exchangeShopDetails;

    function Remittance(){
        owner = msg.sender;
        fee = 300000 * 4000000 ; //Fee (gas*gasPrice)
        contractAddress = this;
        
    }

    function exchangeShop(bytes32 inputHash1,bytes32 inputHash2, uint duration, address recieverAdd) public payable returns (bool success) {
         
         if(msg.value== 0) revert();
        
         ExchangeShopDetails memory newTransfer;
         newTransfer.creatorAddress = msg.sender;
         newTransfer.recieverAddress = recieverAdd;
         newTransfer.recieverAmount = msg.value/2; //Local Currency
         newTransfer.deadline = block.number+duration;
         exchangeShopDetails[keccak256(inputHash1,inputHash2)] = newTransfer;
         
         LogExchange(msg.sender, recieverAdd, msg.value );

         return true;
    }

    function verifyFunds(bytes32 verifyhash1, bytes32 verifyhash2, address contractOwner) public returns (bool success) {
       
       ExchangeShopDetails memory toVerify = exchangeShopDetails[keccak256(verifyhash1,verifyhash2)];
        require(toVerify.recieverAmount > 0);
        require(contractOwner == toVerify.creatorAddress);
        toVerify.recieverAddress.transfer(toVerify.recieverAmount);
        contractOwner.transfer(fee);
        return true;
    }


    function killMe() {
        assert(msg.sender==owner);
        suicide(owner);
    }

}
