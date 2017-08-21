pragma solidity ^0.4.4;

contract Splitter {

	address public alice;
	address public bob;
	address public carol;

	event LogSplitAmount(uint amount,address sender,address receiver1,address receiver2);

	function Splitter(address _bob, address _carol) {
		alice = msg.sender;
		bob = _bob;
		carol = _carol;
	}

	function getBalance() public constant returns (uint amount){
        return this.balance;
    }

    function sendWei() public payable returns (bool success) {

		 if(msg.sender != alice) revert();
	     if(msg.value == 0) revert();
         bob.transfer(msg.value / 2);
         carol.transfer(msg.value / 2);
         LogSplitAmount(msg.value,msg.sender,bob,carol);
         return true;
    }

	function getAliceBalance() public returns (uint) {
		return alice.balance;
	}

	function getBobBalance() public returns (uint) {
		return bob.balance;
	}

	function getCarolBalance() public returns (uint) {
		return carol.balance;
	}
	
	function killMe() {
        assert(msg.sender==alice);
        suicide(alice);
    }

}
