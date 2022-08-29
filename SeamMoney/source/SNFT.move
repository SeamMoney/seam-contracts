

address seam {
    use AptosFramework::Timestamp;
    use AptosFramework::Token::{Self, Token, TokenId};
    module SNFT {   

    
      
        struct AuctionEvent has store, drop {
        id: TokenId,
        min_selling_price: u64,
        duration: u64
        }
        
        public(script)fun initialize_snft(sender: &signer, creator: address, duration: u64) acquires StakeData {
            
            let token_id = Token::create_token_id_raw(creator, collection_name, name);
            let sender_addr = Signer::address_of(sender);
            
            
            if (!exists<AuctionData>(sender_addr)) {
                move_to(sender, AuctionData {
                    auction_items: Table::new<TokenId, AuctionItem>(),
                    auction_events: Event::new_event_handle<AuctionEvent>(sender),
                    
                });
            };

            
            let start_time = Timestamp::now_microseconds();
            let token = Token::withdraw_token(sender, token_id, 1);

            let auction_data = borrow_global_mut<AuctionData>(sender_addr);
            let auction_items = &mut auction_data.auction_items;

            // if auction_items still contain token_id, this means that when sender_addr last auctioned this token,
            // they did not claim the coins from the highest bidder
            // sender_addr has received the same token somehow but has not claimed the coins from the initial auction
            assert!(!Table::contains(auction_items, token_id), ERROR_CLAIM_COINS_FIRST);

            Event::emit_event<SeamMintEvent>(
                &mut auction_data.auction_events,
                SeamMintEvent { id: token_id, duration: duration },
            );

            Table::add(stake_items, token_id, AuctionItem {
                duration,
                start_time,
                current_bid: min_selling_price - 1,
                current_bidder: sender_addr,
                locked_token: Option::some(token),
            })
        }


      

    }
}


