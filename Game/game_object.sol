pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

 import"game_interface.sol";

abstract contract GameObject is Interface{

     uint HP;
    
      constructor() public {
        require(tvm.pubkey() != 0, 101); 
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
     modifier checkOwnerAndAccept() {
         tvm.accept();
         _;
     }

    function Defense() public virtual checkOwnerAndAccept returns(uint){//show unit HP
        return HP;
    }

    function accept_attack(uint damage) public override virtual checkOwnerAndAccept{//take damage and die if HP is below zero
        if (!life_check(damage)) {//death check
                death_unit(msg.sender);
        }
        else   { HP=HP-damage;}

    }
    
    function life_check(uint damage)internal view returns(bool) {//is the unit alive or dead

        if(HP<=damage) return false;
        else return true;

    }
    
    function death_unit(address winner) override public virtual checkOwnerAndAccept {//Send all the money and destroy the unit
        
        winner.transfer(1, true, 128+32);
    }


 }