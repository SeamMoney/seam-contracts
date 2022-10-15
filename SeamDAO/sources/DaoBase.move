/// This module demonstrates a basic messageboard using capability to control the access.
/// Admin can
///     (1) create their messageboard
///     (2) offer participants capability to update the pinned message
///     (3) remove the capability from a participant
/// participant can
///     (1) register for the board
///     (2) redeem the offered capability to update pinned message
///     (3) send a new message
///
/// The module also emits two types of events for subscribes
///     (1) message cap update event, this event contains the board address and participant offered capability
///     (2) message change event, this event contains the board, message and message author
module seam::base {
    // use aptos_std::event::{Self, EventHandle};
    use aptos_std::event::{Self, EventHandle};
    use aptos_std::table::{Self, Table,new, borrow};
    // use aptos_std::guid::{Self,GUID,ID};
    // use std::offer;
    use std::signer;
    use std::vector::{Self};
    use std::coin::{Self};
    // use AptosFramework::token::{Self, Token, TokenId};

    // Error map
    // const EACCOUNT_NO_NOTICE_CAP: u64 = 1;
    // const EONLY_ADMIN_CAN_REMOVE_NOTICE_CAP: u64 = 2;


    // struct WagEscrow has key {
    //     locked_wags: Table<TokenId, Token<t>>
    // }

    /// provide the capability to alert the board message
    struct DaoOwner has key, store {
        welcome_msg: vector<u8>,
    }

    struct DaoData has key,store,drop,copy {
        owner: address,
        count: u8,
        members: vector<Member>
        // memStore: DaoStore<u64,Member>
    }

    // struct DaoStore<phantom K: copy + drop, phantom V> has store, copy {
    //     members: vector<Member>
    // }

    // struct TreasuryItems<string, phantom J> has key {
    //     name: string,
    //     coin: Coin<J>
    // }

    struct Member has key, store, drop, copy {
        id: u64,
    }


    // struct EventsStore<phantom X, phantom Y> has key {
        // storage_handle: event::EventHandle<StorageCreatedEvent<X, Y>>,
        // member_handle: event::EventHandle<MemberEvent>,
        // info_handle: event::EventHandle<CoinDepositedEvent<X, Y, Curve>>,
        // tokens_handle: event::EventHandle<CoinWithdrawnEvent<X, Y, Curve>>,
    // }

    // struct StorageCreatedEvent<phantom X, phantom Y> has store, drop {}

    // struct CoinDepositedEvent<phantom X, phantom Y, phantom Curve> has store, drop {
    //     x_val: u64,
    //     y_val: u64,
    // }

    // struct MemberEvent has store, drop {
    //     id: u64,
    //     // y_val: u64,
    // }
   

    // struct SuggestionEvent has store, drop {
    //     member: address,
    //     suggestion: vector<u8>
    // }


    /// create the message board and move the resource to signer
    public entry fun dao_init(account: &signer,msg:vector<u8>) {
        let owner = DaoOwner {
            welcome_msg: msg
        };


        let dao_addr = signer::address_of(account);
        // let dao_id = event::guid(dao_addr,0);
        let temp = vector::empty<Member>();

        move_to(account, owner);
        // let hand = MemberEventHandle{
        //     member_events: event::new_event_handle<MemberChangeEvent>(account)
        // };
        // move_to(account, );
        move_to(account, DaoData {
            count:0,
            owner: dao_addr,
            members: temp
        });
        
    }

    
    public entry fun add_member(account: &signer, participant: address,msg:vector<u8>) acquires DaoData {
        let dao_addr = signer::address_of(account);
        
        let mem = borrow_global_mut<DaoData>(dao_addr).members;
        // let n = Member
        vector::push_back<Member>(&mut mem, Member {
            id: 0,
        })
    }

    

    

    // public entry fun send_pinned_message(
    //     account: &signer, board_addr: address, message: vector<u8>
    // ) acquires MessageChangeCapability, MessageChangeEventHandle, CapBasedMB {
    //     let cap = borrow_global<MessageChangeCapability>(signer::address_of(account));
    //     assert!(cap.board == board_addr, EACCOUNT_NO_NOTICE_CAP);
    //     let board = borrow_global_mut<CapBasedMB>(board_addr);
    //     board.pinned_post = message;
    //     let event_handle = borrow_global_mut<MessageChangeEventHandle>(board_addr);
    //     event::emit_event<MessageChangeEvent>(
    //         &mut event_handle.change_events,
    //         MessageChangeEvent{
    //             message,
    //             participant: signer::address_of(account)
    //         }
    //     );
    // }

    // public entry fun send_message_to(
    //     account: signer, board_addr: address, message: vector<u8>
    // ) acquires MessageChangeEventHandle {
    //     let event_handle = borrow_global_mut<MessageChangeEventHandle>(board_addr);
    //     event::emit_event<MessageChangeEvent>(
    //         &mut event_handle.change_events,
    //         MessageChangeEvent{
    //             message,
    //             participant: signer::address_of(&account)
    //         }
    //     );
    // }
}

#[test_only]
module seam::DaoTests {
    use std::unit_test;
    use std::vector;
    use std::signer;
    use seam::base;


    const HELLO_WORLD: vector<u8> = vector<u8>[150, 145, 154, 154, 157, 040, 167, 157, 162, 154, 144];

    #[test]
    public entry fun test_init_dao() {
        let (alice, b) = create_two_signers();
        seam::base::dao_init(&alice,HELLO_WORLD);
        let dao_addr = signer::address_of(&alice);
        seam::base::add_member(&alice, dao_addr,HELLO_WORLD);
    }

    // #[test]
    // public entry fun test_send_pinned_message_v_cap() {
    //     let (alice, bob) = create_two_signers();
    //     CapBasedMB::message_board_init(&alice);
    //     CapBasedMB::add_participant(&alice, signer::address_of(&bob));
    //     CapBasedMB::claim_notice_cap(&bob, signer::address_of(&alice));
    //     CapBasedMB::send_pinned_message(&bob, signer::address_of(&alice), BOB_IS_HERE);
    //     let message = CapBasedMB::view_message(signer::address_of(&alice));
    //     assert!(message == BOB_IS_HERE, 1)
    // }

    // #[test]
    // public entry fun test_send_message_v_cap() {
    //     let (alice, bob) = create_two_signers();
    //     CapBasedMB::message_board_init(&alice);
    //     CapBasedMB::send_message_to(bob, signer::address_of(&alice), BOB_IS_HERE);
    // }

    // #[test]
    // #[expected_failure]
    // public entry fun test_add_new_participant_v_cap() {
    //     let (alice, bob) = create_two_signers();
    //     CapBasedMB::message_board_init(&alice);
    //     CapBasedMB::add_participant(&alice, signer::address_of(&bob));
    //     CapBasedMB::send_pinned_message(&bob, signer::address_of(&alice), BOB_IS_HERE);
    // }

    #[test_only]
    fun create_two_signers(): (signer, signer) {
        let signers = &mut unit_test::create_signers_for_testing(2);
        (vector::pop_back(signers), vector::pop_back(signers))
    }
}

