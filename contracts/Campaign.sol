pragma solidity ^0.4.6;

contract Campaign {
    address public owner; // That is a state variable
    uint    public deadline;
    uint    public goal;
    uint    public fundsRaised;
    bool    public refundsSent;
    
    struct FunderStruct {
        address funder;
        uint amount;
        
    }
    
    FunderStruct[] public funderStructs;
    
    event LogContribution(address sender, uint amount);
    event LogRefundSent(address funder, uint amount);
    event LogWithdrawal(address beneficiary, uint amount);
    
    modifier onlyMe () {
        if(msg.sender != owner) revert();
        _;
    }
    
    function Campaign(uint campaignDuration, uint campaignGoal){ // Constructor
        owner = msg.sender;
        deadline = block.number + campaignDuration;
        goal = campaignGoal;
    }

    function isSuccess() public constant returns(bool isIndeed){
        return(fundsRaised >= goal);
        
    }

    function hasFailed() public constant returns(bool hasIndeed){
        return(fundsRaised < goal && block.number > deadline);
    }


    function contribute() public payable onlyMe() returns(bool success) {
        
        if(msg.value==0) revert();
        if(isSuccess()) revert();
        if(hasFailed()) revert();
        fundsRaised += msg.value;
        FunderStruct memory newFunder;
        newFunder.funder = msg.sender;
        newFunder.amount = msg.value;
        funderStructs.push(newFunder);
        LogContribution(msg.sender, msg.value);
        return true;

    }
    
    function widthdrawFunds() public onlyMe() returns(bool success) {
        if(!isSuccess()) revert();
        uint amount = this.balance;
        owner.transfer(amount);
        LogWithdrawal(owner, amount);
        return true;
    }
    
    function sendMeFunds() public onlyMe() returns(bool success) {
        if(refundsSent) revert();
        if (!hasFailed()) revert();
        
        uint funderCount = funderStructs.length;
        for(uint i=0; i<funderCount; i++){
            funderStructs[i].funder.transfer(funderStructs[i].amount);
            LogRefundSent(funderStructs[i].funder, funderStructs[i].amount);
        }
        refundsSent = true;
        return true;
    }
    
    
    
}
