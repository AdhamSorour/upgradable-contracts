const { ethers, upgrades } = require('hardhat');

const proxyAddress = '0x165F90d8FB727d34e0c95DD505b62bE0b9B57434';

async function main() {
  const VendingMachineV2 = await ethers.getContractFactory('VendingMachineV2');
  const upgraded = await upgrades.upgradeProxy(proxyAddress, VendingMachineV2);
  await upgraded.deployed();
  
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(proxyAddress);

  console.log(upgraded.owner());
  console.log(upgraded.address);
  console.log('New implementation contract address: ' + implementationAddress);
}

main();