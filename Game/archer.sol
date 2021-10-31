pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


 import"military_unit.sol";
 
  contract  Archer is MilitaryUnit {
      
      constructor(BaseStation val) MilitaryUnit(val) public {//call the "military unit" constructor 
        HP=6;
        attack=5;
       
    }

    
 }