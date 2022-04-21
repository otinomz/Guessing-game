// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SecretNumber {
    uint secretNumber;
    uint guessTime;
    string displayText  =  "you have 1 minutes to guess the Secret Number";
    
    address owner;

    // modifier endGameTime will be limiting the
    // game time to 30 seconds
    modifier endGameTime {
        require(block.timestamp <= (guessTime + 1 minutes), "Game Over");
        _;
    }

    constructor(uint _secretNumber) {
        secretNumber = _secretNumber;
        owner = msg.sender;
        guessTime = block.timestamp;
    }

    function gameInstruction() public view returns(string memory) { 
        return displayText;
    }

    // function for the owner to give right to a new player
    // to guess the game right
    function giveRightToPlay(address _player) public {
        require(owner == msg.sender, "only owner can give right to play");
        require( _player != address(0), "invalid address");
        owner = _player;
    }

    // function for new player to guess the secret number before the end of 1 minutes
    function guessNumber(uint _guessNumber) public view endGameTime  returns(string memory){
        require( owner == msg.sender, "owner cannot play");       

        if( _guessNumber == secretNumber) {
            return "You got the number right";
        } else {
            return "Try again";
        }
    }


}