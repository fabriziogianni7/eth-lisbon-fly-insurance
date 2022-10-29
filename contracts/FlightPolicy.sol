// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./FlightPolicyInterface.sol";
import "./Policy.sol";
import "./RecepitNFT.sol";
import "./RecepitNFTInterface.sol";

contract FlightPolicy is ERC721 , FlightPolicyInterface{

    event NewSubscriber(address);
    
    Policy public policy;
    ERC20 public asset;
    address public brokerAddress;
    uint256 totalRecepits;

    constructor(Policy memory _policy, ERC20 _asset, address _firstSubscriber, address _brokerAddress) {
        policy = _policy;
        asset = ERC20(_asset);
        brokerAddress = _brokerAddress;
    }

    function addSubscriber(address _subscriber) external  {
        policy.subscribers.push(_subscriber);
        asset.transferFrom(msg.sender, address(this), policy.premium);
        uint256 tokenId = totalRecepits++;
        new RecepitNFT(policy, asset, _subscriber, brokerAddress, tokenId);
        emit NewSubscriber(_subscriber);
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