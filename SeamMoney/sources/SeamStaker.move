
module  seam::SeamStaker {

    use std::signer;
    use std::string;
    use AptosFramework::aptos_coin:AptosCoin;
    use AptosFramework::Table::{Self, Table};
    use std::Event::{Self, EventHandle};
    use std::type_info::{TypeInfo, type_of};
    use std::vector;
    use std::option;
    use std::signer::address_of;
    use AptosFramework::coin::{Coin};
    use AptosFramework::coins;
    use seam::SNFT;



    // STRUCTS

    const MIN_STAKE: u128 = 2222;
    const MAX_STAKE: u128 = 100000;
        // Staking options in ms 
    const TWO_DAYS: u64 = 2;
    const WEEK: u64 = 0;
    const MONTH: u64 = 1;



    struct DepositStake has store {
        validator_id: u64,
        deposit: u64,
        duration: u64
    }



    // FUNCTIONS 

    public entry fun user_stake<X,Y>(sender: &signer,amount_x u64)  {
        
        


        // TO FIGUREOUT 
        // - how to make function payable 

        // 1.) Create deposit stake struct 
        // 2.)  Input it into token we make ? 
        // 3.) send our  DIY token back to the user 
        

    }

    public entry fun claim_stake(acc: &signer) {

        

        
        // GOAL: allow user to close position & give them. back aptos coins 
        
        // accept DIY token
        // get information from this token 
        // transfer user back Aptos 

    }

    
    // CURRENT QUESTIONS 

    // 1.) How to split up deposited funds (if we get to much for one node)
    // 2.) How we want to take $$ of the top from nodes once the user closes 
    // their position and we are giving back aptos coin 



    // EVENTS NEEDED 

    struct SeamStakerEvents has key {
        
    }

    /// emit an event on user stake deposit

    /// emit event on claim of stake rewards

    // emit an event on stake relock/autolock

    /// emit an event from a different module when stake is expired
}

// GOAL NEXT MEETING - (Sunday) Make token and give it to them && Deposit Front End - 8 hours 
// GOAL NEXT MEETING - (Monday)  Claim Stake && Claim Front End - 6 hours 
// GOAL NEXT MEETING - (Tuesday) Debug and practice demo  3.5 hours 