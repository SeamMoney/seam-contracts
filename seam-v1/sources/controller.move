module seam::controller {
    use seam::engine;

    public fun get_strategy(seam: &Seam::SeamState, i: u8): address {
        engine::strategies(seam, i)
    }
}
