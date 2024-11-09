// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./HealthManagement.sol";

// Example usage of the addGoat function for a newborn goat 
contract ExampleUsage { 
    GoatManagement goatManagement; 
    constructor(address goatManagementAddress) { 
        goatManagement = GoatManagement(goatManagementAddress); 
    } function addNewbornGoat() public { 
            
        // Adding a newborn goat with the following details: 
        // Age: 0 years, Weight: 5 kg, Breed: "Boer", Health Status: "Healthy" 
        goatManagement.addGoat("15345", 0, 5, "Boer", "Healthy"); 
    } 
}
