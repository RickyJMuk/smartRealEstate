// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/**
 * @title MyToken
 * @dev MyToken is an ERC20 token with permit extension.
 */
contract MyToken is ERC20, ERC20Permit {
    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {}
}

/**
 * @title RealEstateContract
 * @dev A simple smart contract for buying and selling real estate.
 */
contract RealEstateContract {
    address public owner;
    mapping(address => uint256) public propertyOwners;
    uint256 public propertyCount;

    event PropertyTransferred(address indexed from, address indexed to, uint256 propertyId);

    /**
     * @dev Modifier to check if the sender is the owner of the contract.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    /**
     * @dev Contract constructor.
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Mint a new property and assign it to the specified buyer.
     * @param to The address of the buyer.
     */
    function mintProperty(address to) external onlyOwner {
        propertyOwners[to] = propertyCount;
        propertyCount++;
        emit PropertyTransferred(address(0), to, propertyCount - 1);
    }

    /**
     * @dev Transfer a property from the sender to the specified buyer.
     * @param to The address of the buyer.
     * @param propertyId The ID of the property to be transferred.
     */
    function transferProperty(address to, uint256 propertyId) external {
        require(propertyOwners[msg.sender] == propertyId, "Not the property owner");
        propertyOwners[msg.sender] = 0;
        propertyOwners[to] = propertyId;
        emit PropertyTransferred(msg.sender, to, propertyId);
    }
}
