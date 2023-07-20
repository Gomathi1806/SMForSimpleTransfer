// SPDX-License-Identifier's: MIT
pragma solidity ^0.7.0;

contract SavingsContract {
    address public owner;
    uint public savingsPercent;
    address payable public savingsAccount;

    event SavingMade(uint amount);

    constructor(uint _savingsPercent, address payable _savingsAccount) {
        owner = msg.sender;
        savingsPercent = _savingsPercent;
        savingsAccount = _savingsAccount;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this operation");
        _;
    }

    function depositMoney() public payable onlyOwner {
        uint savingAmount = (msg.value * savingsPercent )/ 100 ;
        savingsAccount.transfer(savingAmount);
        emit SavingMade(savingAmount);
    }

    function setSavingsAccount(address payable _savingsAccount) external onlyOwner{
        savingsAccount = _savingsAccount;
    }

    function setSavingsPercent(uint _savingsPercent) external onlyOwner{
        savingsPercent = _savingsPercent;
    }
}
