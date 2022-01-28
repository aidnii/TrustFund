// SPDX-License-Identifier: GPL-3.0
// Current Solidity version
pragma solidity =0.8.11;

//starting contract and naming the smart contract Trust
contract Trust {
    //declaring a state variable (stored in blockchain) and its types are address and uint
    //classifying the state variable to be public
    //to send and receive ETH, you need an address
    address public child;
    uint public maturity;

    constructor(address _child, uint timeToMaturity) payable {
        maturity = block.timestamp + timeToMaturity;
        child = _child;
    }

    //contract defines the function as withdraw
    function withdraw() external {
        require(block.timestamp >= maturity, 'too early');
        require(msg.sender == child, 'only child can withdraw');
        payable(msg.sender).transfer(address(this).balance);
    }
}