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
- Maximum Reward: $6,998.49
- Submissions: 65
- Total Payout: $6,998.49 distributed among 9 participants.

## Scope of Audit

## Project overview

Metrom is a tool that dexes (especially those based on concentrated liquidity AMMs) can use to incentivize liquidity providers to provide the maximum amount of liquidity possible in the way that is the most efficient through the creation of dedicated incentivization campaigns.

Campaign creators must specify a targeted pool (the incentivized pool can even live on a chain that is different from the campaign's chain, making the product cross-chain), a running period and a list of up to 5 rewards that will be distributed to active LPs proportional to their liquidity contribution in the pool.

Once a campaign is created and activated, Metrom monitors the targeted pool, processing all the meaningful on-chain event that happen on it and computing a rewards distribution list off-chain depending on the contribution of the various LPs. A Merkle tree is constructed from the list and its root is then pushed on-chain. Eligible LPs can then claim their rewards (if any) by simply providing a tree inclusion proof to the Metrom smart contract. In the very rare case that some rewards went unassigned because of zero liquidity in the pool, the campaign's owner is able to recover any unassigned reward.

## Audit competition scope

Smart-contract wise, the solution is only comprised of a single smart contract (`src/Metrom.sol`) and its interface `src/IMetrom.sol`. That is the scope of the audit. 



## Conclusion

The audit report on Metrom, conducted through Hats Audit Competitions, highlights the decentralized and efficient approach the Hats.finance platform employs for web3 security. Hats.finance offers a robust mechanism whereby skilled auditors participate in time-bound competitions, aiming to discover vulnerabilities in various smart contracts. This pay-for-results model ensures cost-effective security assessments by rewarding only successful bug finders, thereby prioritizing quality submissions and attracting top auditing talent.

In this specific audit, Metrom — a tool designed to incentivize liquidity providers in decentralized exchanges — was scrutinized. The competition, lasting two weeks, attracted 65 submissions, with a total reward of $6,998.49 distributed among nine participants. The audit focused on Metrom’s smart contracts, specifically `src/Metrom.sol` and `src/IMetrom.sol`.

Overall, the Hats audit competition successfully identified vulnerabilities within Metrom's implementation, aligning with the goal of fortifying web3 projects pre-launch and underscoring the effectiveness of decentralized security mechanisms in the ecosystem.

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts.


The Metrom audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.


Hats.finance does not provide any guarantee or warranty regarding the security of this project. Smart contract software should be used at the sole risk and responsibility of users.

