//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract BuyCar {
    address owner;
    address[] carOwners;
    mapping(string => Car) public cardsByModel;
    mapping(address => bool) isCarOwned;
    mapping(string => bool) doesCarExist;
    mapping(address => uint256) balanceOf;
    mapping(address => mapping(string => uint256)) carsPerOwner; //owner => car.Mode => ownerCarsCount
    Car[] public cars;
    address[] public owners;
    bytes32[] carIndexator;
    Car public thisCar;

    struct Car {
        address carOwner;
        string model;
        uint256 yearCreated;
        uint256 Price;
        bool forSale;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier existingCar(string memory _model) {
        require(doesCarExist[_model] = true);
        _;
    }

    function AddNewCarToTheShop(
        string memory _model,
        uint256 _yearCreated,
        uint256 _price,
        bool _forSale
    ) external {
        address carOwnerAddres = address(0);
        doesCarExist[_model] = true;
        cars.push(Car(carOwnerAddres, _model, _yearCreated, _price, _forSale));
        addHashedCarKey(_model, _yearCreated, _price, _forSale);
    }

    function addHashedCarKey(
        string memory _model,
        uint256 _yearCreated,
        uint256 _price,
        bool _forSale
    ) public {
        bytes32 hashedCar = keccak256(
            abi.encode(_model, _yearCreated, _price, _forSale)
        );
        carIndexator.push(hashedCar);
    }

    function buyNewCar(string memory _model)
        external
        payable
        existingCar(_model)
    {}

    function CheckHowManyCarsHaveIntTheShop() external view returns (uint256) {
        return cars.length;
    }

    function buyCar(Car memory car) public payable {
        require(msg.value >= car.Price, "not enought balance!");
        balanceOf[msg.sender] -= car.Price;
        carsPerOwner[msg.sender][car.model]++;
    }
}
