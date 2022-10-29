// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./FlightPolicyInterface.sol";
import "./Policy.sol";
import "./Broker.sol";

interface RecepitNFTInterface {

    event Refunded(string flightn, uint256 amount);

    function claimRefund() external;

}