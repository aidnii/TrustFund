// SPDX-License-Identifier: GPL-3.0
// Current Solidity version
pragma solidity =0.8.11;

//starting contract and naming the smart contract Trust
contract Trust {
    //declaring a state variable (stored in blockchain) and its types are address and uint
    //classifying the state variable to be public (reading outside the contract)
    //to send and receive ETH, you need an address
    address public child;

    //when child can unlock the ETH using timestamps
    uint public mature;

    //constructor function is only called when you first deploy a smart contract
    //using 'payable' allows to send ETH when deploying smart contract
    constructor(address _child, uint timeToMature) payable {
        mature = block.timestamp + timeToMature;
        child = _child;
    }

    //contract defines the function as withdraw
    function withdraw() external {
        require(block.timestamp >= mature, 'too early');
        require(msg.sender == child, 'only child can withdraw');
        payable(msg.sender).transfer(address(this).balance);
    }
}