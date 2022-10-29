//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./FlightPolicy.sol";
import "./Policy.sol";

// create your contract and inherit the your imports
contract Broker is ERC20 {

    event Deposit(address caller, uint256 amt);
    event Withdraw(address caller, address receiver, uint256 amt);

    ERC20 public immutable asset;
    FlightPolicy public flightPolicy;

    // uint256 policyCount;
    uint256 totalRefundValue; //TVR


    mapping(address => uint256) shareHolderToAmount;
    mapping(string => address) flightnToPolicyContract;

    //the USDC or CRO contract - create vault
    constructor(ERC20 _asset, string memory _name, string memory _symbol )
     ERC20(_name, _symbol) {
        asset = _asset;
    }

    // deposit function for LP (Liquidity Providers)
    function deposit(uint256 amount) public {
        require (amount >= 0, "Deposit is 0");
        asset.transferFrom(msg.sender, address(this), amount);
        shareHolderToAmount[msg.sender] += amount;
        _mint(msg.sender, amount);
        emit Deposit(msg.sender, amount);
    }

    // returns total number of amount
    function totalamount() public view returns(uint256) {
        return asset.balanceOf(address(this));
    } 

    // LP to return shares and get thier token back before they can withdraw, and requiers that the user has a deposit
    function redeem(uint256 shares, address receiver ) internal returns (uint256 amount) {
        require(shareHolderToAmount[msg.sender] > 0, "Not a share holder");
        shareHolderToAmount[msg.sender] -= shares;
        _burn(msg.sender, shares);
        amount = shares;
        emit Withdraw(msg.sender, receiver, amount);
        return amount;
    }

    // allow msg.sender (LP) to withdraw his deposit plus interest
    function lpWithdraw(uint256 shares, address receiver) public {
        uint256 payout = redeem(shares, receiver);
        uint256 shareValue = sharesValue(payout);
        asset.transfer(receiver, shareValue);
    }

    //calculate value of shares
    function sharesValue(uint256 shares) public view returns (uint256 value)   {
        value = totalamount()/shares;
        return value;
    }

    // TODO should pay the refund to the subscriber 
    // the recepitNFT should be passed here
    function refundSubscriber(FlightPolicy _FlightPolicy) public {
        // _FlightPolicy.subscriberToPolicies

    }

    function managePolicies(Policy memory _policy, address _subscriber) public {
        require(totalamount() > 0, "TVL is 0!");
        require(totalamount() > totalRefundValue, "TVL is less than TVR!");

        //check if the policy is present
            // if it is, add subscriber
            // if it isn't create a new one
        if(flightnToPolicyContract[_policy.flightn] > 0){
            FlightPolicy(flightnToPolicyContract[_policy.flightn]).addSubscriber(_subscriber);
        }else{
            _createPolicy(_policy,_subscriber);
        }
        // increment tot refund 
        totalRefundValue +=  _policy.refund;
    }

    function _createPolicy(Policy memory _policy, address _subscriber) internal {
        FlightPolicy newPolicy = new FlightPolicy(_policy, asset, _subscriber);
        flightnToPolicyContract[_policy.flightn] = address(newPolicy);
    }

}
