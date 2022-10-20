module WagmiNFT::NFT {

    use std::signer;
    use std::vector;
    use std::string;

    use aptos_framework::account;
    use aptos_framework::aptos_account;
    use aptos_framework::managed_coin;
    use aptos_framework::coin;

    use aptos_token::token;

    const EVENUE_NOT_CREATED: u64 = 0;
    const EINVALID_VENUE_OWNER: u64 = 1;
    const EINVALID_VECTOR_LENGTH: u64 = 2;
    const ETICKET_NOT_FOUND: u64 = 3;
    const ETICKETS_NOT_AVAILABLE: u64 = 4;
    const EINVALID_BALANCE: u64 = 5;

    struct NFT has store {
        name: vector<u8>,
        description: vector<u8>, 
        max_quantity: u64,
        price: u64,
        available: u64,
        token_data: token::TokenDataId
    }
}