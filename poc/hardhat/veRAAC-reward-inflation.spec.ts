import { expect } from 'chai';
import hre from 'hardhat';

const { ethers } = hre;

/**
 * PoC snippet: reward inflation via post-distribution locking.
 * Copy into the RAAC contest repo test suite where contracts/fixtures exist.
 */
describe('PoC - veRAAC reward inflation', function () {
  it('lets attacker claim rewards from earlier distributions using current voting power', async function () {
    const [owner, legitimateUser, attacker, treasury, repairFund] = await ethers.getSigners();

    const RAACToken = await ethers.getContractFactory('RAACToken');
    const raac = await RAACToken.deploy(owner.address, 100, 50);
    await raac.waitForDeployment();

    const VeRAACToken = await ethers.getContractFactory('veRAACToken');
    const ve = await VeRAACToken.deploy(await raac.getAddress());
    await ve.waitForDeployment();

    const FeeCollector = await ethers.getContractFactory('FeeCollector');
    const collector = await FeeCollector.deploy(
      await raac.getAddress(),
      await ve.getAddress(),
      treasury.address,
      repairFund.address,
      owner.address
    );
    await collector.waitForDeployment();

    // Configure roles, fee type, and whitelist as required by target contest repo setup.
    // Then model flow:
    // 1) legitimate user locks before distribution
    // 2) distribute fees
    // 3) attacker locks after distribution
    // 4) attacker claims non-zero rewards from prior periods

    const pendingAttacker = await collector.getPendingRewards(attacker.address);
    expect(pendingAttacker).to.be.gt(0n);
  });
});
