
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
    use std::string::{Self,String};
    use std::table::{Self,Table};
    use AptosFramework::coin::{Self,Coin};
    // use aptin_lend::lend::{};

    // use 

    use liquidswap::scripts::{Self,add_liqudity};
    use liquidswap::coins::{Self,BTC as LBTC,USDT as LUSDT};
    use liquidswap::lp::{Self,LP};
    use liquidswap::curves::{Self,Uncorrelated};
    use std::type_info::{Self,TypeInfo, type_of};
    // LIQUID SWAP TEST COINS
    
    use hippo_swap::router::{Self as HRouter};

    const THREAD_TYPE_POOL: u8 = 0;
    const THREAD_TYPE_LEND: u8 = 1;
    const THREAD_TYPE_SWAP: u8 = 2;
    
    

    // use anime::FaucetV1::{Self,request};

    struct Thread<phantom XCOIN,phantom YCOIN> has key, store, copy, drop {
        thread_type: u8,
        name: string::String,
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

    public fun liquidswap_lp<X,Y>( x0: coin::Coin<X>, y0: coin::Coin<Y>, q0:u64, q1:u64 ){
        // const pool: lp::LP = lp::LP<0x1::aptos_coin::AptosCoin, 0x43417434fd869edee76cca2a4d2301e528a1551b1d719b75c350c3c97d15b8b9::coins::BTC>
        liquidswap::add_liqudity<X,Y,lp::LP<Y,X>>();
    }

    // public fun hippo_lp<X,Y>(){};

    // public fun enchanter_lp<X,Y>(){}

    // public fun anime_swap(){}

    struct CPU<phantom X,phantom Y> has key, store,copy {
        threads: vector<Thread<X,Y>>,
        weights: vector<u128>,
        _: coin::MintCapability<LPToken<X, Y>>,
        
    }

    // Thread Vault
    // struct TV {
    //     thread:
    // }

    

    public entry fun init_thread_table(creator: &signer){
        let t = table::new<String,Thread>();
        move_to(creator, ThreadStore{threadTable:t,count:0});
    }


    public entry fun add_thread<XCOIN,YCOIN> (
        thread_type: u8, name: string::String , coin0: type_info::TypeInfo, coin1:TypeInfo, pool_address: address){
            
            let thread = Thread {
                thread_id: u8,
                thread_type: thread_type,
                name: name,
                coin0: type_info::type_of<XCOIN>(),
                coin1: type_info::type_of<YCOIN>(),
                addr: pool_address,
            };
            let t = &borrow_global_mut<ThreadStore>();
            t.count = t.count + 1;
            thread.thread_id = t.count;
            table::add<String, Thread>(t, thread.name, thread)
        }


    struct ThreadStore has key {
        threadTable: table::Table<String,Thread>,
        count: u8
    }

    public fun get_thread_table()acquires Table<String,Thread>  : Table<String,Thread>  {
        borrow_global<Thread
    }

    // Creates the thread table and
    public entry fun init(signer: &signer) {
        init_thread_table(signer);

        // INIT pontem LP
        add_thread<LBTC,LUSDT>(THREAD_TYPE_POOL, string::utf8(b"PONTEM_LBTC_LUSDT"),type_info::type_of<LBTC>() ,type_info::type_of<LUSDT>(), @liquidswap);
        // add_thread<LBTC,LUSDT>(THREAD_TYPE_POOL,type_info::type_of<LBTC>() ,type_info::type_of<LUSDT>(), @liquidswap)

    }


    public entry fun init_seam(signer:&signer, thread_ids: vector<String>, weights: vector<u8>){
        
        let cpu = Seam {
            threads: vector::singleton<Thread<XCOIN,YCOIN>>(Thread {
                thread_type: THREAD_TYPE_POOL,
                coin0: type_info::type_of<X>(),
                coin1: type_info::type_of<Y>(),
                addr: @hippo_swap,
            })
        };
        
        move_to(signer, cpu);
    }

    // public entry fun seam_deposit(name: String, q:128) aquires Seam{}

}


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