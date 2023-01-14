//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract BuyCar {
    address owner;
    address[] carOwners;
    mapping(address => bool) isCarOwned;
    mapping(string => bool) doesCarExist;
    address newCarAddres = address(0);

    struct Car {
        address carOwner;
        string model;
        uint256 yearCreated;
        uint256 Price;
        bool forSale;
    }
    Car[] public cars;
    address[] public owners;
    bytes32[] carIndexator;
    // address[][] public carsPerOwner;

    Car public thisCar;

    constructor() {
        owner = msg.sender;
    }

    function AddNewCar(
        string memory _model,
        uint256 _yearCreated,
        uint256 _price,
        bool _forSale
    ) external {
        doesCarExist[_model] = true;
        cars.push(Car(newCarAddres, _model, _yearCreated, _price, _forSale));
        bytes32 hashedCar = keccak256(
            abi.encode(_model, _yearCreated, _price, _forSale)
        );
        carIndexator.push(hashedCar);
    }

    function CheckHowManyCardsHaveIntTheShop() external view returns (uint256) {
        return cars.length;
    }
}
