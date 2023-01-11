// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract MappingEnnumes {
    mapping(string => string) capitals;
    mapping(string => bool) isCapital;
    mapping(bytes32 => bool) isEU_Country;

    enum continents {
        Africa,
        Europe,
        South_America,
        North_America,
        Asia,
        Austrailia,
        Antartica
    }

    //CountryStruct
    struct Country {
        bytes32 name;
        continents continent;
        uint16 populationInMilions;
    }

    Country[] EuropeanCountries;
    Country[] NotEuropeanCountries;

    function GetEuropeanCountry(bytes32 countryName)
        public
        view
        returns (
            bytes32,
            uint8,
            uint16
        )
    {
        for (uint256 index = 0; index < EuropeanCountries.length; index++) {
            if (countryName == EuropeanCountries[index].name) {
                return (
                    EuropeanCountries[index].name,
                    uint8(EuropeanCountries[index].continent),
                    EuropeanCountries[index].populationInMilions
                );
            }
        }
    }

    function addOnlyEuropeanCountry(
        bytes32 name,
        uint8 continent,
        uint16 population
    ) public {
        Country memory EU_Country;
        Country memory Out_EU_Country;
        if (continent != uint8(continents.Europe)) {
            EU_Country = Country(name, continents(continent), population);
            EuropeanCountries.push(EU_Country);
        } else {
            Out_EU_Country = Country(name, continents(continent), population);
            NotEuropeanCountries.push(Out_EU_Country);
        }
    }

    function AddNewCapital(string memory countryCheck, string memory newCapital)
        public
    {
        require(isCapital[newCapital] == false);
        capitals[countryCheck] = newCapital;
        isCapital[newCapital] = true;
    }

    function specificContinet(uint8 continent)
        public
        pure
        returns (string memory)
    {
        if (continent == uint8(continents.Africa)) return "Africa";
        if (continent == uint8(continents.Europe)) return "Europe";
        if (continent == uint8(continents.South_America))
            return "South_America";
        if (continent == uint8(continents.North_America))
            return "North_America";
        if (continent == uint8(continents.Asia)) return "Asia";
        if (continent == uint8(continents.Austrailia)) return "Austrailia";
        if (continent == uint8(continents.Antartica)) return "Antartica";
    }

    function removeCapital(string memory CountryCapital) public {
        require(isCapital[CountryCapital] == true);
        delete (capitals[CountryCapital]);
    }

    // mapping(string => bool) isEU_Country;
    function removePopulrationFromCountry(
        bytes32 countryName,
        uint16 popToRemove
    ) public {
        if (isEU_Country[countryName] == true) {
            for (uint256 index = 0; index < EuropeanCountries.length; index++) {
                if (EuropeanCountries[index].name == countryName) {
                    require(
                        EuropeanCountries[index].populationInMilions >=
                            popToRemove
                    );
                    EuropeanCountries[index].populationInMilions -= popToRemove;
                }
            }
        } else {
            for (
                uint256 index = 0;
                index < NotEuropeanCountries.length;
                index++
            ) {
                if (NotEuropeanCountries[index].name == countryName) {
                    require(
                        NotEuropeanCountries[index].populationInMilions >=
                            popToRemove
                    );
                    NotEuropeanCountries[index]
                        .populationInMilions -= popToRemove;
                }
            }
        }
    }
}
