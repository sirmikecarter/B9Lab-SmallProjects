var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter', function(accounts) {

	var contract;	
	address1 = accounts[0];
	address2 = accounts[1];
	address3 = accounts[2];
	owner = accounts[0];


	beforeEach(function() {
		return Splitter.new(address1,address2,address3, {from:owner})
		.then(function(instance) {
			contract = instance;

		});
	});

	it("should say Hello", function() {
		assert.strictEqual(true,true,"Something is wrong.");
	});

	it("should be owned by owner", function() {
		return contract.alice({from:owner})
		.then(function(_alice) {
	assert.strictEqual(owner,_alice,"Contract is not owned by Owner.");

		});
		
	});

});
