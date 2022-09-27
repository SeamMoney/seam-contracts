
// LIQUID SWAP (pontem dex add liquidity
// {
//   "arguments": [
    // 
//     "0x43417434fd869edee76cca2a4d2301e528a1551b1d719b75c350c3c97d15b8b9",
//     "44366",
//     "44144",
//     "4000000",
//     "3980000"
//   ],
//   "function": "0x43417434fd869edee76cca2a4d2301e528a1551b1d719b75c350c3c97d15b8b9::scripts::add_liquidity",
//   "type": "entry_function_payload",
//   "type_arguments": [
//     "0x43417434fd869edee76cca2a4d2301e528a1551b1d719b75c350c3c97d15b8b9::coins::BTC",
//     "0x1::aptos_coin::AptosCoin",
//     "0x43417434fd869edee76cca2a4d2301e528a1551b1d719b75c350c3c97d15b8b9::lp::LP<0x1::aptos_coin::AptosCoin, 0x43417434fd869edee76cca2a4d2301e528a1551b1d719b75c350c3c97d15b8b9::coins::BTC>"
//   ]
// }


module seam::cpu { 
    use std::signer::{Self};
    use std::vector::{Self};
    use AptosFramework::coin::{Self,Coin};
    // use aptin_lend::lend::{};

    // use 

    use liquidswap::scripts::{Self};
    use liquidswap::curves::Uncorrelated;
    use std::type_info::{Self,TypeInfo, type_of};
    // LIQUID SWAP TEST COINS
    use test_coins::coins::{USDT as LUSDT, BTC as LBTC};
    use hippo_swap::router;

    const THREAD_TYPE_POOL:u8 = 0;
    const THREAD_TYPE_LEND:u8 = 1;
    const THREAD_TYPE_SWAP:u8 = 2;
    
    // struct Route has copy, drop {
    //     pool_address: address,
    //     deposit_payload: address
    // }
    // use anime::FaucetV1;
    

    // use anime::FaucetV1::{Self,request};

    struct Thread<phantom CoinType,phantom CoinType> has key,store,copy,drop {
        thread_type: u8,
        coin0: type_info::TypeInfo,
        coin1: type_info::TypeInfo,
        addr: address
        
    }

    

    const SEAM_ADMIN: address = @seam;



    // const ANIME: address = @anime;

    // public fun aptin_lend<aCoin>(signer:&signer,c0:A){
    //     // let _ = signer::address_of(signer);
    //     // anime(to)
    //     aptin_deposit::lend::supply<aCoin>(signer);
        
    // }

    // public hippo_swap<X,Y>(x0: coin::Coin<X>, y0: coin<Y>, q_in:u128)

    // public fun anime_swap(){}

    struct CPU<phantom X,phantom Y> has key, store,copy {
        threads: vector<Thread<X,Y>>,

    }

    
    

    public entry fun init_dual<X,Y>(signer:&signer){
        
        let cpu = CPU {
            threads: vector::singleton<Thread<X,Y>>(Thread {
                thread_type: THREAD_TYPE_POOL,
                coin0: type_info::type_of(coin::Coin<X>),
                coin1: type_info::type_of(Y),
                addr: @hippo_swap,
            })
        };
        
        move_to(signer, cpu);
    }


    // public entry func init(

    // public ent
}


#[test_only]
module seam::cpuTests {
    use std::unit_test;
    use std::vector;
    // use std::signer;
    use seam::cpu::{Self,Thread};
    use test_coins::coins::{USDT, BTC};
    use coin_list::devnet_coins::{DevnetUSDT as WUSDT, DevnetBTC as WBTC, DevnetSOL as WDAI, DevnetUSDC as WDOT, DevnetETH as WETH};

    // const HELLO_WORLD: vector<u8> = vector<u8>[150, 145, 154, 154, 157, 040, 167, 157, 162, 154, 144];
    const WEIGHTS: vector<u8> = vector<u8>[50,50];

     #[test]
    public entry fun test_send_stake() {
        let (alice, _) = create_two_signers();
        cpu::init_dual<WBTC,WUSDT>(&alice);
        // CapBasedMB::send_message_to(bob, signer::address_of(&alice), BOB_IS_HERE);
    }

    #[test]
    fun create_two_signers(): (signer, signer) {
        let signers = &mut unit_test::create_signers_for_testing(2);
        (vector::pop_back(signers), vector::pop_back(signers))
    }

}