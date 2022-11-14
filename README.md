# seam-contracts

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/aqua.png)

This repository will serve as the base for the seam protocol on the aptos network

The primary functions of the contracts are:

- management of staked positions on aptos as NFTs
- compose strategies by combining deposits
- perform a swap(s) using an orderbook's or liquidity pool using
- governance of the seam protocol and validators managed by seam

possible future additions:

- management of an index tracking validator perfomance and rewards
- incentivize operation of nodes connected to seam validators

please visit the docs listed on our site for a more complete view of Seam

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/aqua.png)

## Reference from stake pool conract

Each validator has a separate StakePool resource and can provide a stake.

**Changes in stake for an active validator**

- If a validator calls add_stake, the newly added stake is moved to pending_active.
- If validator calls unlock, their stake is moved to pending_inactive.
- When the next epoch starts, any pending_inactive stake is moved to inactive and can be withdrawn.
- Any pending_active stake is moved to active and adds to the validator's voting power.

**Changes in stake for an inactive validator**

1. If a validator calls add_stake, the newly added stake is moved directly to active.
2. If validator calls unlock, their stake is moved directly to inactive.
3. When the next epoch starts, the validator can be activated if their active stake is more than the minimum.
