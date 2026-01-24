# CreditFlow

## Decentralized Credit & Lending Protocol for Bitcoin via Stacks

## Overview

**CreditFlow** is a decentralized credit and lending system built on the [Stacks 2.0](https://docs.stacks.co/) blockchain, leveraging Bitcoin's security. The protocol enables users to access loans based on a **dynamic credit scoring model** that rewards responsible behavior with lower collateral requirements and interest rates.

By integrating on-chain credit reputation, CreditFlow paves the way for more accessible and equitable lending in the Bitcoin ecosystem.

## Key Features

* **Credit-Based Lending**: Users begin with a base credit score and improve it by repaying loans.
* **Dynamic Interest Rates**: Borrowers with higher scores receive better rates.
* **Collateral Optimization**: Collateral requirements decrease as creditworthiness increases.
* **Fully Decentralized**: Trustless protocol logic governed entirely by Clarity smart contracts.
* **Bitcoin Finality**: Built on Stacks, with Bitcoin-secured transactions and data.

## How It Works

1. **Score Initialization**
   Users opt-in to the protocol by initializing their credit profile (starting at a base score of 50).

2. **Loan Request**
   Borrowers request a loan by specifying the amount, collateral, and duration. The protocol checks eligibility based on their current credit score.

3. **Loan Repayment**
   Loans are repaid with interest. On successful repayment, the user's credit score increases, and their collateral is returned.

4. **Defaults & Penalties**
   If a loan is not repaid by its due date, it may be marked as defaulted by the contract owner, decreasing the user’s score.

## Credit Scoring Logic

* **Score Range**: `50 (min)` – `100 (max)`
* **Loan Eligibility**: Requires score ≥ `70`
* **Score Impact**:

  * ✅ Repayment: +2 points (up to 100)
  * ❌ Default: −10 points (not below 50)

## Collateral & Interest Calculations

* **Collateral Ratio**: Inversely proportional to credit score
  `collateral = amount * (100 - score * 0.5) / 100`

* **Interest Rate**: Also based on score
  `rate = 10 - (score * 5 / 100)` (%)

## Data Structures

### Maps

* `UserScores`: Tracks user’s score and repayment history
* `Loans`: Stores individual loan data
* `UserLoans`: Keeps track of each user's active loan IDs

### Variables

* `next-loan-id`: Incremental ID for new loans
* `total-stx-locked`: Global STX collateral locked in the system

## Access Control

* **Only the contract deployer** (`tx-sender`) can mark loans as defaulted.
* All other functions are open to users who have initialized their score.

## Key Functions

### Public Functions

* `initialize-score`: Initializes user score to 50
* `request-loan(amount, collateral, duration)`: Requests a new loan
* `repay-loan(loan-id, amount)`: Repays an active loan
* `mark-loan-defaulted(loan-id)`: Marks a loan as defaulted (admin only)

### Read-Only Functions

* `get-user-score(user)`: Retrieves user credit info
* `get-loan(loan-id)`: Fetches loan details
* `get-user-active-loans(user)`: Lists user's current active loans

## Deployment Notes

* Written in [Clarity](https://docs.stacks.co/write-smart-contracts/clarity-overview), a decidable smart contract language for Stacks.
* Ensure integration with a Stacks wallet and environment (e.g., Clarinet) for deployment and testing.

## Future Enhancements

* Oracle integration for off-chain credit data
* P2P lending pools
* DAO-based governance for protocol parameters
* NFT-based credit badges

## Contributing

We welcome contributions! Please fork the repo, open issues, or submit PRs to improve the protocol logic or documentation.

## Learn More

* [Stacks Documentation](https://docs.stacks.co/)
* [Bitcoin Layer 1](https://bitcoin.org)
* [Clarity Language](https://clarity-lang.org)
