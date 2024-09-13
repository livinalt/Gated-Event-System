//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./GatedToken.sol";

contract GatedProgram{

    GatedToken public gatedToken;
    address public gatedTokenAddress;

    event ProgramCreated(uint256 indexed _programID, string indexed  _title, uint256 indexed _programDate, uint256 _programDuration);
    event UserRegisterd(uint256 indexed _userID, address indexed _userAddress, string indexed _userName);
    event ProgramRegistered(address indexed participant, uint256 indexed _programID, bool indexed);

     struct Program{
        uint256 programID;
        address creator;
        string title;
        string desc;
        uint256 programDate;
        uint256 programDuration;
        address[] attendees;
     }

     Program public newProgram;

     Program[] public allPrograms;

     mapping(uint256 => Program) public programID; // holds the list of all attenders of the program
     mapping(uint256 => bool) public programExists; // returns true if programId exists

     struct User{
        uint256 userID;
        address userAddress;
        string userName;
        bool isRegistered;
     }

     User public newUser;
     User[] public allUser;

     mapping(address => User) public allUsers; // returns the addresses of all the users on the event platform
     mapping(uint256 => bool) public userIdExist; // mapping of userId to the bool tracking if a user is registerd on the event platform
     mapping(address => bool) public isUser; // mapping of userId to the bool tracking if a user is registerd on the event platform

     struct Participant{
        uint256 participantID;
        uint256 programID;
        address participantAddress;
     }

     Participant[] public allParticipants;
    
    mapping(uint256 => Participant) public programs; // connects particpant to event they are attending/ registered for
    mapping(uint256 => bool) public isAttending; // tracks a user with ID is attending a program of programID
    mapping(address => bool) public attendee; // tracks a user with ID is attending a program of programID

    
    constructor(address _gatedTokenAddress){
      gatedTokenAddress = _gatedTokenAddress;
    }


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
        newProgram.attendees.push(msg.sender);

        allPrograms.push(newProgram);

        emit ProgramCreated(_programID, _title, _programDate, _programDuration);

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

        allUser.push(newUser);

        emit UserRegisterd(_userID, _userAddress, _userName);

     }


     function registerForProgram(uint256 _programID) external{

        require(isUser[msg.sender], "You are not registered");
        // The program must have been created/existed
        require(programExists[_programID], "Program doesn't exist");

        require(gatedToken.balanceOf(msg.sender) == 1, "Must have an NFT to register");
        // the user must be a registerd member of the platform
        require(_programID > 0, "Id doesn't exist");
        
        attendee[msg.sender] = true;

        emit ProgramRegistered(msg.sender, _programID, true);

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

     function getAllPrograms() external view returns (Program[] memory) {
         return allPrograms;
      }


     function getAllUsers() external view returns (User[] memory) {
         return allUser;
      }


     function geUserProgram() external view returns (Program memory, User memory) {
         return (newProgram, newUser);   
      }



}