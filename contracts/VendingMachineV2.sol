// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMachineV2 is Initializable {
	uint public numSodas;
	address public owner;

	function initialize(uint _numSodas) public initializer {
		numSodas = _numSodas;
		owner = msg.sender;
	}

	function purchaseSoda() public payable {
		require(msg.value >= 1000 wei, "less than 1000 wei");
		numSodas--;
	}

	function withdraw() external onlyOwner {
		(bool s, ) = owner.call{ value: address(this).balance }("");
		require(s);
	}

	function setNewOwner(address _newOwner) public onlyOwner {
    	owner = _newOwner;
	}

	modifier onlyOwner() {
		require(msg.sender == owner, "not owner");
		_;
	}
}