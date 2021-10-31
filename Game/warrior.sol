pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


 import"military_unit.sol";
 
  contract  Warrior is MilitaryUnit {
      
      constructor(BaseStation address_Base_Station) MilitaryUnit(address_Base_Station) public {//call the "military unit" constructor 
        HP=8;
        attack=4; 
    }

 }