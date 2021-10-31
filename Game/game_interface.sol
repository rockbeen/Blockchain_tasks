pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface Interface {
    function accept_attack(uint damage) external;
    function death_unit(address) external;
}