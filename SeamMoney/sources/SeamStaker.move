

// The reponsibility of the seam staker modules is to direct the incoming stake to the specified validator
// in return the user recives a token representing their stake deposit
// The user can use this to claim stake rewards, sell a conditional contract to 

module seam::SeamStaker {

    use std::signer;
    use std::string::{Self,String};
    use std::aptos_coin::AptosCoin;
    use std::table::{Self, Table};
    use std::event::{Self, EventHandle};
    // use std::type_info::{TypeInfo, type_of};
    use std::vector;
    use std::unit_test;
    // use std::option;
    // use std::stake;
    // use aptos_framework::staking_config::{StakingConfig,get};
    use std::signer::address_of;
    // use AptosFramework::coin::{Coin};
    // use AptosFramework::coins::{self,Coin};
    // use ap tin::lend::{Self,lend};

    // STRUCTS

    // const MIN_STAKE: u128 = 2222;
    // const MAX_STAKE: u128 = 100000;
    // Staking options in ms 
    // const TWO_DAYS: u64 = 2;
    // const WEEK: u64 = 0;
    // const MONTH: u64 = 1;



    struct DepositStake has store,drop {
        duration: u64,
        validator_id: u64,
        stake_id: u64, 
        deposit: u64,
    }

    // struct FactoryOwner has key {
    //     table_addy: vector<u8>;
    // }


    struct Pool has key,store {
        id: u8,
        // a: address
    }


    struct Pools has key {
        items: Pool
    }


    // FUNCTIONS 


    public entry fun factory_init(acc: &signer){
        let owner = signer::address_of(acc);
        // let table = table::new<vector<u8>,vector<u8>>();
        let pool = Pool{id: 1u8};
        move_to(acc, pool);
    }


    // public entry fun user_stake(amount_x :u64){
        // assert(address_of(sender)==


    
}

#[test_only]
module seam::seamStakeTests {
    use std::unit_test;
    use std::vector;
    use std::signer;
    use seam::SeamStaker;


    // const HELLO_WORLD: vector<u8> = vector<u8>[150, 145, 154, 154, 157, 040, 167, 157, 162, 154, 144];
    // const BOB_IS_HERE: vector<u8> = vector<u8>[142, 157, 142, 040, 151, 163, 040, 150, 145, 162, 145];

     #[test]
    public entry fun test_send_stake() {
        let (alice, bob) = create_two_signers();
        SeamStaker::factory_init(&alice);
        // CapBasedMB::send_message_to(bob, signer::address_of(&alice), BOB_IS_HERE);
    }

    #[test]
    fun create_two_signers(): (signer, signer) {
        let signers = &mut unit_test::create_signers_for_testing(2);
        (vector::pop_back(signers), vector::pop_back(signers))
    }

}