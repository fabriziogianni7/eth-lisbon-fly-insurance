// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct Policy {
        address[] subscribers;
        string flightn;
        uint256 premium; // what subscriber pay
        uint256 refund; // what subscriber get if flight is late
        uint256 expiryTimestamp; // departure of flight
    }