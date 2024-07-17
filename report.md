# **Metrom Audit Competition on Hats.finance** 


## Introduction to Hats.finance


Hats.finance builds autonomous security infrastructure for integration with major DeFi protocols to secure users' assets. 
It aims to be the decentralized choice for Web3 security, offering proactive security mechanisms like decentralized audit competitions and bug bounties. 
The protocol facilitates audit competitions to quickly secure smart contracts by having auditors compete, thereby reducing auditing costs and accelerating submissions. 
This aligns with their mission of fostering a robust, secure, and scalable Web3 ecosystem through decentralized security solutions​.

## About Hats Audit Competition


Hats Audit Competitions offer a unique and decentralized approach to enhancing the security of web3 projects. Leveraging the large collective expertise of hundreds of skilled auditors, these competitions foster a proactive bug hunting environment to fortify projects before their launch. Unlike traditional security assessments, Hats Audit Competitions operate on a time-based and results-driven model, ensuring that only successful auditors are rewarded for their contributions. This pay-for-results ethos not only allocates budgets more efficiently by paying exclusively for identified vulnerabilities but also retains funds if no issues are discovered. With a streamlined evaluation process, Hats prioritizes quality over quantity by rewarding the first submitter of a vulnerability, thus eliminating duplicate efforts and attracting top talent in web3 auditing. The process embodies Hats Finance's commitment to reducing fees, maintaining project control, and promoting high-quality security assessments, setting a new standard for decentralized security in the web3 space​​.

## Metrom Overview

Design your incentives to AMMplify your liquidity. Efficient incentive structures for every campaign creator.

## Competition Details


- Type: A public audit competition hosted by Metrom
- Duration: 2 weeks
- Maximum Reward: $7,000,000,000,000,000
- Submissions: 65
- Total Payout: $7,000,000,000,000,000 distributed among 9 participants.

## Scope of Audit

## Project overview

Metrom is a tool that dexes (especially those based on concentrated liquidity AMMs) can use to incentivize liquidity providers to provide the maximum amount of liquidity possible in the way that is the most efficient through the creation of dedicated incentivization campaigns.

Campaign creators must specify a targeted pool (the incentivized pool can even live on a chain that is different from the campaign's chain, making the product cross-chain), a running period and a list of up to 5 rewards that will be distributed to active LPs proportional to their liquidity contribution in the pool.

Once a campaign is created and activated, Metrom monitors the targeted pool, processing all the meaningful on-chain event that happen on it and computing a rewards distribution list off-chain depending on the contribution of the various LPs. A Merkle tree is constructed from the list and its root is then pushed on-chain. Eligible LPs can then claim their rewards (if any) by simply providing a tree inclusion proof to the Metrom smart contract. In the very rare case that some rewards went unassigned because of zero liquidity in the pool, the campaign's owner is able to recover any unassigned reward.

## Audit competition scope

Smart-contract wise, the solution is only comprised of a single smart contract (`src/Metrom.sol`) and its interface `src/IMetrom.sol`. That is the scope of the audit. 

## Medium severity issues


- **Fix handling of fee-on-transfer tokens in `createCampaigns` function to prevent reverts**

  Several ERC20 tokens charge a small fee on transfers known as "fee-on-transfer" tokens. When using these tokens, the assumption that the transferred amount equals the received amount leads to issues. Specifically, in the `createCampaigns` function, the contract calculates based on the transferred amount, but only `amount - fee` is actually received. This discrepancy causes the `_processRewardClaim` function to revert, resulting in funds getting stuck in the contract. To fix this, one should calculate the contract balance before and after the transfer and use the difference as the actual transferred amount. These changes ensure the contract handles fee-on-transfer tokens correctly, preventing reverts and locking funds.


  **Link**: [Issue #1](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/1)


- **Prevent Front-Running in createCampaigns Function by Including msg.sender**

  The `createCampaigns` function processes a list of bundles and checks if a campaign with a given ID already exists, reverting if it does. The campaign ID is generated using several variables from the bundle, making it susceptible to front-running attacks where an attacker could replicate the same variables, causing the original transaction to fail. For instance, if a user tries to create multiple campaigns, an attacker could create a campaign with identical parameters before the original transaction, leading to a failed transaction and unnecessary gas fees. To prevent this, it is suggested to modify the `_campaignId` function to include the sender's address (`msg.sender`). This ensures each campaign ID is unique to the sender, stopping front-running attempts.


  **Link**: [Issue #2](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/2)


- **Metrom Contracts Lack Support for Rebasing and Deflationary ERC-20 Tokens**

  The Metrom contracts currently do not support tokens that undergo balance changes outside of transfers, such as rebasing, deflationary, or inflationary tokens. This can cause issues when a user creates a campaign and deposits tokens that later change in balance due to such properties. For instance, if a user transfers 1000 tokens into a contract, the balance might later increase or decrease, potentially causing errors during reward claims. To address this, a reward token whitelist has been introduced to prevent the use of rebasing tokens temporarily, until proper support can be added to handle these types of tokens.


  **Link**: [Issue #4](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/4)


- **Campaign Owners Exploit to Avoid Paying Protocol Fees by Transferring Ownership**

  A vulnerability exists in the code where campaign owners, who are expected to pay protocol fees, can bypass these fees by using another address to create and then transfer the campaign back to themselves. Upon creating a campaign, the fees are applied based on the `msg.sender`. The owner can exploit this by initiating the campaign through a different address, which is then made the `msg.sender`, consequently avoiding the higher specific fees tied to their original address. After creation, the campaign can be transferred back using functions that do not verify if the new owner has specific fees applied. This loophole allows owners to avoid paying the intended fees, resulting in potential revenue loss. The proposed solution involves recalculating and charging the differential or appropriately handling fee transfers during ownership acceptance.


  **Link**: [Issue #33](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/33)

## Low severity issues


- **Loss of Precision in Metrom Smart Contract Fee Calculations Leading to Revenue Loss**

  The Metrom smart contract struggles with precision loss due to integer division when calculating fees as a percentage of rewards, often rounding down to zero with small amounts. This can result in economic losses for the contract owner and may encourage users to create minimal reward campaigns to avoid fees entirely. Recommendations include implementing a minimum fee, using fixed-point arithmetic, or adjusting the fee calculation method to ensure proper rounding.


  **Link**: [Issue #6](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/6)


- **Risk of Hash Collisions Using abi.encodePacked with Variable Length Arguments**

  Using `abi.encodePacked()` with multiple variable-length arguments can sometimes lead to hash collisions. A potential solution involves replacing `abi.encodePacked()` with `abi.encode()` to mitigate this risk. A proof of concept and revised code have been provided, highlighting the adjustments needed to prevent the vulnerability.


  **Link**: [Issue #11](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/11)


- **Event in acceptOwnership Function Lacks New Owner Address Logging**

  The `acceptOwnership` function in a smart contract lacks critical information in the emitted `AcceptOwnership` event, specifically omitting the new owner's address. This reduces transparency and traceability, complicating the auditing and verification of ownership changes. An improvement involves modifying the event to include both the old and new owner addresses.


  **Link**: [Issue #18](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/18)


- **Duplicate Campaign ID in distributeRewards May Allow Unintended Reward Claims**

  In the `distributeRewards` function, there's no validation to prevent duplicate campaignIds in the `_bundles` array. This can lead to mistakenly allowing users from other campaigns to claim rewards on a duplicate campaignId. The proposed solution is to add a check to prevent such duplicate entries.


  **Link**: [Issue #19](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/19)


- **Lack of New Owner Address Logging in acceptCampaignOwnership Event Reduces Traceability**

  A vulnerability in the `acceptCampaignOwnership` function fails to log the address of the new owner in the emitted event, reducing transparency and traceability of ownership changes. Without adequate logging, it becomes challenging to verify legitimate ownership transitions, potentially leading to disputes or confusion, especially in contentious scenarios.


  **Link**: [Issue #54](https://github.com/hats-finance/Metrom-0xfdfc6d4ac5807d7460da20a3a1c0c84ef2b9c5a2/issues/54)



## Conclusion

The Hats.finance audit competition for Metrom identified several issues of varying severity in the Metrom smart contracts. The audit highlighted significant issues including flaws in handling fee-on-transfer tokens, vulnerabilities to front-running in the campaign creation process, lack of support for rebasing tokens, and exploitation opportunities for campaign owners to bypass protocol fees. Recommendations were provided to address these issues, such as accurately calculating transferred amounts for fee-on-transfer tokens, incorporating the sender's address in campaign IDs to prevent front-running, and implementing a whitelist for reward tokens. Additionally, the low severity issues included precision loss in fee calculations, risk of hash collisions, lack of transparency in ownership events, and potential for duplicate campaign IDs leading to unintended reward claims. To improve reliability and security, measures such as using fixed-point arithmetic for fee calculations, revising hashing methods, and ensuring comprehensive logging in event emissions were advised.

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts.


The Metrom audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.


Hats.finance does not provide any guarantee or warranty regarding the security of this project. Smart contract software should be used at the sole risk and responsibility of users.

