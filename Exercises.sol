//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Mappings {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => bool)) public isFriend;

    function exmaple() external {
        balances[msg.sender] = 123;
        uint256 balnce = balances[msg.sender];
        uint256 balance2 = balances[address(1)]; // uint default  value = 0;

        balances[msg.sender] += 451; // uint balacen = 123 + 451;
        delete balances[msg.sender]; // balance = 0;

        //nested mapping example;

        isFriend[msg.sender][address(this)] = true;
    }

    // iterateMApping

    mapping(address => uint256) public balances2;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint256 _value) external {
        // require(inserted[_key] == true);

        balances2[_key] = _value;
        if (!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint256) {
        //represed the lenghth of mapping balances2
        return keys.length;
    }

    function getValuesInBalances2() external view returns (uint256) {
        for (uint256 index = 0; index < keys.length; index++) {
            //retuns each addres his balance;
            balances2[keys[index]];
        }
    }

    function getLastValue() external view returns (uint256) {
        return balances2[keys[keys.length - 1]];
    }

    function getSpecificBlance2(uint256 _i) external view returns (uint256) {
        return balances2[keys[_i]];
    }
}
