pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

 import"game_object.sol";
 import"base_station.sol";

 abstract contract MilitaryUnit is GameObject {

    address addr_base;//address of the parent base
    uint attack;//unit damage
   
   
      constructor(address base) public {
        require(tvm.pubkey() != 0, 101); 
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        addr_base=base;
        BaseStation(base).add_unit(this);//add the unit to the array
    }
 
     function Damage()  public  checkOwnerAndAccept returns(uint){//show unit damage
        return attack;
    }

     function Attack_enemy(Interface addInt) external  checkOwnerAndAccept {//attack a unit on the address
      
      addInt.accept_attack(attack);//enemy unit takes damage
    
    }
    function death_unit(address winner) override public  checkOwnerAndAccept {//Send all the money and destroy the unit
        BaseStation(addr_base).clear_unit(this);//remove from array
        winner.transfer(1, true, 128+32);
    }
 }