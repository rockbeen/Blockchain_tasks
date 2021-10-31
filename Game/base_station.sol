pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

 import"game_object.sol";

 contract BaseStation is GameObject {

     address[] units;//array for storing unit addresses

      constructor() public {

        require(tvm.pubkey() != 0, 101); 
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        HP=10;
    }

    function add_unit(address unit)public checkOwnerAndAccept{//add an element
        units.push(unit);

    }
    function clear_unit(address unit)public checkOwnerAndAccept{
    	require(!units.empty(),103) ;//array is empty
         uint i;
         for(i=0;i<units.length-1;i++) {//index search by address
            if(units[i]==unit) break;
        }
        for(uint k=i;k<units.length-1;k++)//deleting an element
        {
            units[k]=units[k+1];
        }
        units.pop();
    }

    function accept_attack(uint damage) public override checkOwnerAndAccept{//take damage and die if HP is below zero
        if (!life_check(damage)) {//death check
                death_base(msg.sender);
        }
        else   { HP=HP-damage;}

    }
    function death_base(address winner) private  view checkOwnerAndAccept { //deleting a base   

        for(address val:units)//deleting a units
        {
            Interface(val).death_unit(winner);//calling a "death" for each unit
           
        }
        winner.transfer(1, true, 128+32); 
    }
 
    function List_of_units() public  view checkOwnerAndAccept returns(address[]){ //output of all elements in the array

        return  units;
    }
        
 }