var Remittance = artifacts.require("./Remittance.sol");

contract('Remittance', function(accounts) {

	var contract;	
	var fee = 300000 * 4000000 ;


	beforeEach(function() {
		return Remittance.new({from:owner})
		.then(function(instance) {
			contract = instance;

		});
	});

	it("should say Hello", function() {
		assert.strictEqual(true,true,"Something is wrong.");
	});

	it("should be owned by owner", function() {
		return contract.owner({from:owner})
		.then(function(_owner) {
	assert.strictEqual(owner,_owner,"Contract is not owned by Owner.");

		});
		
	});


});
