module seam::seam_external {
    use aptos_framework::signer;

    public fun initialize(
        seam_owner: &signer,
        controller: &signer,
        strategy_registry: &signer,
        fast_withdraw: address
    ) {
        let seam_state = SeamState {
            seam_owner: Signer::address_of(seam_owner),
            controller: Signer::address_of(controller),
            strategy_registry: Signer::address_of(strategy_registry),
            fast_withdraw: fast_withdraw
        };

        move_to(seam_owner, seam_state);
    }

    public fun deposit(strat: address, amount: u128, index: u64) {
        return
    }
}