//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Aucion{
    address public owner;
    uint public startblock;
    uint public endBlock;

    bool public isAucionCanceld;
    address public highestBidder;
    mapping(address => uint) public fundsPerBidder;

    event LogBid(address bidder,uint bid,address highestBidder,uint highestBid);
    event LogWithdraw(address withdrawer,address withdrawlAccount, uint amount);
    event LogCancel();

     constructor (uint _startBlock, uint _endBlock){
        require(_startBlock <=_endBlock);
        require(_startBlock > block.number);

        owner = msg.sender;
        startblock = _startBlock;
        endBlock = _endBlock;
    }

    modifier onlyAucrionIsOpen(){
        require (isAucionCanceld == false, "auction is not open at the moment");
        require ((block.number > startblock) && (block.number < endBlock));
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    modifier onlyNotOwner(){
        require(msg.sender != owner);
        _;
    }

    modifier onlyAfterStart(){
        require (block.number > startblock);
        _;
    }

    modifier onlyBeforeEnd(){
        require(block.number < endBlock);
        _;
    }

    modifier onlyWhenAucionIsOpen(){
        require(isAucionCanceld == false);
        _;
    }

    modifier EndOrCanceled(){
        require (block.number > endBlock || isAucionCanceld == true);
        _;
    }

    function placeBid() public payable onlyAucrionIsOpen onlyNotOwner onlyAfterStart onlyBeforeEnd {
        require (msg.value > 0);

        uint newBid = fundsPerBidder[msg.sender] + msg.value;

        uint lastbiggestBid = fundsPerBidder[highestBidder];

        require(newBid > lastbiggestBid);

        fundsPerBidder[msg.sender] = newBid;
        highestBidder = msg.sender;

        emit LogBid(msg.sender,newBid,highestBidder,lastbiggestBid);
    }

    function withdraw() public EndOrCanceled {
        address payable withdrawAccount;
        uint amountToWithdraw;

        if(isAucionCanceld == true){
            amountToWithdraw = fundsPerBidder[msg.sender];
        }else{
            //check if the account is not of the highestBidder;
            require(msg.sender != highestBidder);

            if(msg.sender == owner){
                amountToWithdraw = fundsPerBidder[highestBidder];
            }
            else{
                amountToWithdraw = fundsPerBidder[msg.sender];
            }
        }

        require(amountToWithdraw > 0);


        fundsPerBidder[withdrawAccount] -= amountToWithdraw;

        msg.sender.transfer(amountToWithdraw);

        emit LogWithdraw(msg.sender,withdrawAccount,amountToWithdraw);
    }

    function cancelAucion() public  onlyOwner onlyBeforeEnd onlyWhenAucionIsOpen {
        isAucionCanceld =true;
        emit LogCancel();
    }
    
}