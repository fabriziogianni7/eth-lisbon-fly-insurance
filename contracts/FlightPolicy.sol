// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./FlightPolicyInterface.sol";
import "./Policy.sol";
import "./RecepitNFT.sol";
import "./RecepitNFTInterface.sol";

contract FlightPolicy is ERC721 , FlightPolicyInterface{


    Policy public policy;
    ERC20 public asset;

    constructor(Policy memory _policy, ERC20 _asset, address _firstSubscriber) {
        policy = _policy;
        asset = _asset;
        addSubscriber(_firstSubscriber);
    }

    function addSubscriber(address _subscriber) public  {
        policy.subscribers.push(_subscriber);
        asset.transferFrom(msg.sender, address(this), policy.premium);
        new RecepitNFT(policy, asset, _subscriber, _broker);
        emit newSubscriber(_subscriber);
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
}