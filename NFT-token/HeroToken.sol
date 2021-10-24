pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract HeroToken {


	struct hero{
        string name;
        string heroclass;
        uint mana;
        uint power;

    }
    hero[] tokenArr;
    mapping (uint=>uint) tokenMap;
	mapping (uint=>uint) tokenSale;
	
	constructor() public {
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}


	modifier checkOwnerAndAccept {
	
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	function createHero(string name, string heroclass, uint mana, uint power) public checkOwnerAndAccept {//Creating a hero with a unique name

		for(hero val:tokenArr)
		{
			require(val.name!=name,103);
		}

		tokenArr.push(hero(name,heroclass,mana,power));
        uint key=tokenArr.length-1;
        tokenMap[key]=msg.pubkey();
	}
	function put_up_for_sale(uint key,uint cost) public checkOwnerAndAccept ///put it up for sale if you own a hero
	{
		
		require(msg.pubkey()==tokenMap[key],104);
		tokenSale[key]=cost;

	}
	function getInfoHero(uint key) public view returns(hero)
	{
		return tokenArr[key];
	}
	function checkCost(uint key) public checkOwnerAndAccept view returns(uint cost)///checking at what price the hero is sold
	{
		cost=tokenSale[key];
	}
}