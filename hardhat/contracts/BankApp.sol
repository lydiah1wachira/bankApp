// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract BankApp {
    string name;
    address public owner;

    // register events;
    event Register(address creater, uint256 accountId, uint256 timestamp);
    event Deposit(address sender, uint256 amount, uint256 timestamp);
    event Transfer(address sender, address reciever, uint256 amount, uint256 timestamp);

//declare a struct to hold the data for each account
    struct Account {
        address user;
        uint id;
        string name;
        string kraPin;
        uint balance;
        bool status;
    }

    mapping(address => Account) public accounts;

    modifier isLoggedIn(address _user) {
        Account memory account = accounts[_user];

        if (!account.status){
            revert("User not logged in");
        }
        _;    
    }

    constructor(string memory _name){
    owner = msg.sender;
    name = _name;
    }

    //registers a new user
     function register(address user, uint id,string memory _name,string memory _kraPin,uint256 balance ) public returns (bool) {
            require(msg.sender == owner, "Only the owner can register a new user");

        //mapping accounts
        Account memory account = accounts[user];

        //check if the account exists
        if(account.id != 0){
            revert("Account already exists");
        }

        //set the account data
        account.id = id;
        account.name = _name;
        account.kraPin = _kraPin;
        account.balance = balance;
         
        accounts[user] = account;

        // Emit the event
        emit Register(msg.sender, id, block.timestamp);

        return true;
     }


     function login() public returns (bool) {

        address _user = msg.sender;
        // Get the account details
        Account storage account = accounts [_user];

        // check if user is logged in
        if (account.status) {
            return true;    
        } 

        // set the login status to true if user is not logged in
        account.status = true;
        return true;
           
     }

     function deposit(uint amount) public  isLoggedIn(msg.sender){

        Account memory account = accounts[msg.sender]; // copies the account records from storage to memory 

        account.balance += amount;   

        accounts[msg.sender] = account; //overwrites the record in the storage location

        emit Deposit(msg.sender, amount, block.timestamp);

     }

     function checkBalance(address _user) public view  isLoggedIn(msg.sender) returns (uint) {

        Account memory account = accounts[_user];   

        return account.balance;   
        
     }

    function transfer(address _to, uint256 amount) public isLoggedIn(msg.sender)  {

        Account storage account0 = accounts[msg.sender];
        Account storage account1 = accounts[_to];

        require(account0.balance >= amount, "Insufficient balance");

        // check if the reciever account exists 
        require(account1.id != 0, "Account does not exist");

        // Transfer the amount 
        account1.balance += amount;
        account0.balance -= amount;

        emit Transfer(msg.sender,_to, amount,block.timestamp);
        

    }


}

