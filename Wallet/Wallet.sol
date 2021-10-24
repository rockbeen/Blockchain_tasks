pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {
   
    constructor() public {
        // check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }


    modifier checkOwnerAndAccept {

        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

  
    function sendTransaction(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {//send a transaction 
        dest.transfer(value, bounce, 0+1);
    }
    function sendTransaction_Without_Commission(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {//send a transaction without commission
        
        dest.transfer(value, bounce, 0);
    }
      function sendTransactionALL(address dest, bool bounce) public pure checkOwnerAndAccept {//Send all the money and destroy the wallet
        
        dest.transfer(1, bounce, 128+32);
    }

}