#[test_only]
module seam::cpuTests {
    use std::unit_test;
    use std::vector;
    // use std::signer;
    use seam::cpu::{Self,Thread};
    // liquid swap test coins
    // use test_coins::coins::{USDT, BTC};
    // Hippo swap devnet coins
    // use coin_list::devnet_coins::{DevnetUSDT as WUSDT, DevnetBTC as WBTC, DevnetSOL as WDAI, DevnetUSDC as WDOT, DevnetETH as WETH};
    use liquidswap::coins::{Self,BTC as LBTC,USDT as LUSDT};
    // const HELLO_WORLD: vector<u8> = vector<u8>[150, 145, 154, 154, 157, 040, 167, 157, 162, 154, 144];
    const test_weights: vector<u8> = vector<u8>[50, 50];

     #[test]
    public entry fun test_send_stake() {
        let (alice, _) = create_two_signers();
        
        // add stuff to table

        cpu::init(&alice);
        
        cpu::init_seam<WUSDT,DevnetBTC>(&alice)

    }

    #[test]
    fun create_two_signers(): (signer, signer) {
        let signers = &mut unit_test::create_signers_for_testing(2);
        (vector::pop_back(signers), vector::pop_back(signers))
    }

}