// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Policy.sol";

interface FlightPolicyInterface {
   

    event newSubscriber(address);

    function addSubscriber(address _subscriber) external;

    function isExpired() external view returns(bool);

    function totalamount() public view returns(uint256)

}