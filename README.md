# eth-lisbon-fly-insurance
Simple PoC of a decentralized flight insurance protocol - ETH Lisbon
The protocol aims to provide insurance prices for flight delays.
The project would be deployed on **cronos blockchain**

## Flow
An oracle would fetch data from a flight API
A smart contract would manage the logic for the refound: if fly is delayed --> pay off a % of ticket price
A vault will automatically pay who bought the insurance


## Flyers
flyers would buy the premium and get the inscurance money if the flight is delayed

## Vault
Liquidity Providers would put Stablecoins in the Vault and earn interests
it pays the premium to flyers

## Broker Smart Contract
This contract manages the logic behind the application.
it holds a mapping <Flyer,Ticket>
it has a function **checkFlights** that checks if the flights are delayed or not
in case some premium is to be paid, this contract invoke a function in the Vault 

## UI
Allows user to buy the insurance or deposit into the vault
In the scope of the POC it invokes the oracle every xx hrs to see if some price need to be paid

## P1
Tokens in the vault can be used for farming/yeld bearing mechanisms



