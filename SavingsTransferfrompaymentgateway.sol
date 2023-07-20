// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract PaymentGateway {
    address payable savingsAccount;
    uint savingsPercent;
    address owner;

    constructor (address payable _savingsAccount,uint _savingsPercent) public{
        savingsAccount = _savingsAccount;
        savingsPercent = _savingsPercent;
        owner = msg.sender;
    }
    
    function pay() public payable {
        // Calculate savings portion.
        uint savings = msg.value * savingsPercent / 100;
        // Send
 // Send savings to savings account.
        savingsAccount.transfer(savings);
        
        // Send the rest to the owner.
        uint balance = address(this).balance;
        address payable ownerPayable = address(uint160(owner));
        ownerPayable.transfer(balance);
    }

    // Function to update savings account
    function updateSavingsAccount(address payable _newSavingsAccount) public {
        require(msg.sender == owner, "Only owner can update the savings account");
        savingsAccount = _newSavingsAccount;
    }

    // Function to update savings percentage
    function updateSavingsPercent(uint _newSavingsPercent) public {
        require(msg.sender == owner, "Only owner can update the savings percentage");
        require(_newSavingsPercent <= 100, "Savings percentage cannot be more than 100");
        savingsPercent = _newSavingsPercent;
    }
}


// Note: provides a payment gateway where the funds are split into savings and the rest. Whenever a payment is made to this contract, the amount is automatically distributed according to the predefined percentage.
// we can implement this contract by setting up external oracle server like chain link keepers and off-chain oracle server should have ether to pay the transaction fee.
