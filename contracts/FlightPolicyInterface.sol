// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Policy.sol";

interface FlightPolicyInterface {

    function addSubscriber(address _subscriber) external;

    function isExpired() external view returns(bool);

    function totalamount() external view returns(uint256);

}