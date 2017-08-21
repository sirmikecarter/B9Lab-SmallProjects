var Campaign = artifacts.require("./Campaign.sol");

contract('Campaign', function(accounts) {

	var contract;	
	var goal = 1000;
	var duration = 10;
	var expectedDeadline;

	owner = accounts[0];


	beforeEach(function() {
		return Campaign.new(duration,goal, {from:owner})
		.then(function(instance) {
			contract = instance;
			expectedDeadline = web3.eth.blockNumber + duration;

		});
	});

	it("should say Hello", function() {
		assert.strictEqual(true,true,"Something is wrong.");
	});

	it("should be owned by owner", function() {
		return contract.owner({from:owner})
		.then(function(_owner) {
	assert.strictEqual(_owner,owner,"Contract is not owned by Owner.");

		});
		
	});

	it("should have a deadline", function() {
		return contract.deadline({from:owner})
		.then(function(_deadline) {
	assert.equal(_deadline.toString(10),expectedDeadline,"Deadline is incorrect.");

		});
		
	});

});
