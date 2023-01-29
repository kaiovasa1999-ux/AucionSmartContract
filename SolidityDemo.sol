pragma solidity ^ 0.8.7;

contract Demo{
	address owner;

	constructor() public{
		owner = msg.sender;
 	}
	
	modifier onlyForOwner(){
		require(msg.sender == owner);
		_;
	}
	
	function ChangeOwner(address _newOwnerAddres) external onlyForOwner{
	   	require(_newOwnerAddres != address(0));
		msg.sender = newOwnerAddres;
	}
}

