//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract GatedProgram{
    /* 
    tis contract is used to manage Programs. so that 
    1. a participant needs to mint before they register
    2. a participant can register for the Program
    3. a participant can choose to not attend/deregister.

     */

     /* 
     1. we need users to register on the platform
     2. we need users to create the Programs for participant to register
     3. Every Program needs to have its own nft
     4. this nft is what users need to have */

     struct Program{
        uint256 programID;
        address creator;
        string title;
        string desc;
        uint256 programDate;
        uint256 programDuration;
     }

     Program public newProgram;

     mapping(uint256 => Program) public programID; // holds the list of all attenders of the program
     mapping(uint256 => bool) public programExists; // returns true if programId exists

     struct User{
        uint256 userID;
        address userAddress;
        string userName;
        bool isRegistered;
     }

     User public newUser;

     mapping(address => User) public allUsers; // returns the addresses of all the users on the event platform
     mapping(uint256 => bool) public userIdExist; // mapping of userId to the bool tracking if a user is registerd on the event platform
     mapping(address => bool) public isUser; // mapping of userId to the bool tracking if a user is registerd on the event platform

     struct Participant{
        uint256 participantID;
        uint256 programID;
        address participantAddress;
     }
    
    mapping(uint256 => Participant) public programs; // connects particpant to event they are attending/ registered for
    mapping(uint256 => bool) public isAttending; // tracks a user with ID is attending a program of programID
    mapping(address => bool) public attendee; // tracks a user with ID is attending a program of programID


    function createProgram( uint256 _programID,
        address _creator,
        string memory _title,
        string memory _desc,
        uint256 _programDate,
        uint256 _programDuration) external{

        uint256 _id = _programID ++;

        newProgram.programID = _id;
        newProgram.creator = _creator;
        newProgram.title = _title;
        newProgram.desc = _desc;
        newProgram.programDate = _programDate;
        newProgram.programDuration = _programDuration;

     }
    
    // this function lets user get registered on the platform
     function registerUser(
        uint256 _userID,
        address _userAddress,
        string memory _userName
        ) external{

        uint256 _id = _userID ++;

        newUser.userID = _id;
        newUser.userAddress = _userAddress;
        newUser.userName = _userName;
        newUser.isRegistered = true;

     }


     function registerForProgram(uint256 _programID) external{
        require(_programID > 0, "Id doesn't exist");
        // the user must be a registerd member of the platform
        require(isUser[msg.sender], "you are not registered");
        // the program must have been created/existed
        require(programExists[_programID],"program doesn't exist");
        
        attendee[msg.sender] = true;

     }

     function deregisterForProgram(uint256 _programID) external{
        require(_programID > 0, "Id doesn't exist");
        // the user must be a registerd member of the platform
        require(isUser[msg.sender], "you are not registered");
        // the program must have been created/existed
        require(programExists[_programID],"program doesn't exist");
        
       if(!attendee[msg.sender]){

         attendee[msg.sender] = false;

       }        
       
     }

    function getAllPrograms() external{

    }
    


}