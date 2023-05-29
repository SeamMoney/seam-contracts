module seam::engine {
    use seam::seam_external;
    use seam::seam_owner;
    use seam::controller;
    use seam::strategy_registry;

    public fun initialize(
        seam_owner: &signer,
        controller: &signer,
        strategy_registry: &signer,
        fast_withdraw: address
    ) {
        seam_external::initialize(seam_owner, controller, strategy_registry, fast_withdraw);
    }
}
