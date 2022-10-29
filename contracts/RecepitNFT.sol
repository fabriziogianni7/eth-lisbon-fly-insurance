// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./FlightPolicyInterface.sol";
import "./RecepitNFTInterface.sol";
import "./Policy.sol";
import "./Broker.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RecepitNFT is ERC721, RecepitNFTInterface, Ownable {


    Policy public policy;
    address public brokerAddress;
    address public subscriber;

    constructor(Policy memory _policy, ERC20 _asset, address _subscriber, address _brokerAddress, uint256 _id) ERC721("Policy Recepit NFT", "PRN") {
        policy = _policy;
        brokerAddress = _brokerAddress;
        subscriber = _subscriber;
        _mint(_subscriber,_id);
    }

    function claimRefund() public onlyOwner {
        Broker(brokerAddress).refundSubscriber(address(this));
        emit Refunded(policy.flightn, policy.refund);
    }

    function getPolicy() public returns(Policy memory) {
        return policy;
    }

    function getSubscriber() public returns(address) {
        return subscriber;
    }

}