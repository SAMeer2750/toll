//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract toll {
    mapping(address => uint256) public UserBalance; //user to ballance
    address payable public immutable owner;
    uint256 minAmt = 10;
    uint256 PerKm = 1;

    constructor(){
        owner = payable(msg.sender);
    }

    function payToWallet() public payable {
        require(msg.value >= minAmt , "Pay More Eth");
        UserBalance[msg.sender] += msg.value;
    }

    function payToll(uint256 _traveledKm) public payable {
        require(UserBalance[msg.sender] > 0 , "you have 0 balance");
        uint256 totalTollAmt = (PerKm * _traveledKm)/10;
        (bool success,) = owner.call{
            value:(totalTollAmt)
            }("payment sucessful");
        // bool success = owner.send(totalTollAmt);
        require (success, "Somthing went wrong");    
        UserBalance[msg.sender] -= totalTollAmt ;
    }

    function userWithdraw() public payable{
        (bool success,) = payable(msg.sender).call{
            value:(UserBalance[msg.sender])
            }("payment sucessful");
        require(success, "Somthing went wrong");
        UserBalance[msg.sender] = 0;
    }

    function getPoolBalance() public view returns(uint256){
        return address(this).balance;
    }
}