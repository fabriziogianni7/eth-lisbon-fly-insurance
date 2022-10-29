// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./FlightPolicyInterface.sol";
import "./Policy.sol";

contract FlightPolicy is ERC721 , FlightPolicyInterface{


    Policy public policy;
    ERC20 public asset;
    uint256 public policyValue;

    constructor(Policy memory _policy, ERC20 _asset, address _firstSubscriber) ERC721("Fly Policy Token", "FPT") {
        policy = _policy;
        asset = _asset;
        addSubscriber(_firstSubscriber);
    }

    function addSubscriber(address _subscriber) public  {
        // require(asset.allowance(msg.sender, address(this)) >= policy.premium, 'Approve tokens first!');
        policy.subscribers.push(_subscriber);
        asset.transferFrom(msg.sender, address(this), policy.premium);
        emit newSubscriber(_subscriber);

        // TODO should mint an recepitNFT
    }

    function totalamount() public view returns(uint256) {
        return asset.balanceOf(address(this));
    } 

    function isExpired() public view returns(bool){
        if (policy.expiryTimestamp > block.timestamp){
            return true;
        }
        return false;
    }




    // function mint(address _subscriber, uint256 _ticketPrice, uint256 _refund,uint256 _expiryTimestamp) public returns (uint256 _id) {
    //     //TODO callable on ly by broker contract
    //     uint256 totSupply = totalSupply();
    //     uint256 dcmls = decimals();
    //     _id = totSupply++;

    //     subscriberToPolicies[_subscriber][_id].subscriber = _subscriber; 
    //     subscriberToPolicies[_subscriber][_id].ticketPrice = _ticketPrice; 
    //     subscriberToPolicies[_subscriber][_id].refund = _refund; 
    //     subscriberToPolicies[_subscriber][_id].expiryTimestamp = _expiryTimestamp; 
    //     subscriberToPolicies[_subscriber][_id].expired = false; 

    //     uint256 amount = 1 * (10 ** dcmls);
        
    //     _mint(msg.sender, amount);
    //     emit Transfer(address(0), msg.sender, amount);
    //     return _id;
    // }



}