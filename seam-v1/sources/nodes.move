module Nodes {
    resource struct SplitStruct {
        user: address,
        token: address,
        amount: u64,
        firstToken: address,
        secondToken: address,
        percentageFirstToken: u64,
        amountOutMinFirst: u64,
        amountOutMinSecond: u64,
    }
}
