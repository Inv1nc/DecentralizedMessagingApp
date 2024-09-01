// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract ChatApp {
    struct user {
        string name;
        friend[] friendList;
    }

    struct friend {
        address pubkey;
        string name;
    }

    struct message {
        address sender;
        uint256 timestamp;
        string msg;
    }

    struct AlluserStruck {
        string name;
        address accountAddress;
    }

    mapping(address => user) userList;
    mapping(bytes32 => message[]) allMessages;

    AlluserStruck[] getAllusers;

    function checkUserExists(address pubkey) public view returns (bool) {
        return bytes(userList[pubkey].name).length > 0;
    }

    function createAccount(string calldata name) external {
        require(!checkUserExists(msg.sender), "user already exists");
        require(bytes(name).length > 0, "username cannot be empty");

        userList[msg.sender].name = name;
        getAllusers.push(AlluserStruck(name, msg.sender));
    }

    function getUserName(address pubkey) external view returns (string memory) {
        require(checkUserExists(pubkey), "user is not registered");
        return userList[pubkey].name;
    }

    function addFriend(address friend_key, string calldata name) external {
        require(checkUserExists(msg.sender), "create an account first");
        require(checkUserExists(friend_key), "create an account first");
        require(msg.sender != friend_key, "users cannot add themselves as friends");
        require(!checkAlreadyFriends(msg.sender, friend_key), "these users are already friends");
        _addFriend(msg.sender, friend_key, name);
        _addFriend(friend_key, msg.sender, userList[msg.sender].name);
    }

    function checkAlreadyFriends(address pubkey1, address pubkey2) internal view returns (bool) {
        if (userList[pubkey1].friendList.length > userList[pubkey2].friendList.length) {
            address tmp = pubkey1;
            pubkey1 = pubkey2;
            pubkey2 = tmp;
        }
        uint256 friendLength = userList[pubkey1].friendList.length;
        for (uint256 i = 0; i < friendLength; i++) {
            if (userList[pubkey1].friendList[i].pubkey == pubkey2) {
                return true;
            }
        }

        return false;
    }

    function _addFriend(address me, address friend_key, string memory name) internal {
        friend memory newFriend = friend(friend_key, name);
        userList[me].friendList.push(newFriend);
    }

    function getMyFriendList() external view returns (friend[] memory) {
        return userList[msg.sender].friendList;
    }

    function _getChatCode(address pubkey1, address pubkey2) internal pure returns (bytes32) {
        if (pubkey1 < pubkey2) {
            return keccak256(abi.encodePacked(pubkey1, pubkey2));
        } else {
            return keccak256(abi.encodePacked(pubkey2, pubkey1));
        }
    }

    function sendMessage(address friend_key, string calldata _msg) external {
        require(msg.sender != friend_key, "user cannot message to himself");
        require(checkUserExists(msg.sender), "user not exists");
        require(checkUserExists(friend_key), "user not exists");
        require(checkAlreadyFriends(msg.sender, friend_key), "you both are not friends");

        bytes32 chatCode = _getChatCode(msg.sender, friend_key);
        message memory newMsg = message(msg.sender, block.timestamp, _msg);
        allMessages[chatCode].push(newMsg);
    }

    function readMessage(address friend_key) external view returns (message[] memory) {
        bytes32 chatCode = _getChatCode(msg.sender, friend_key);
        return allMessages[chatCode];
    }

    function getAllAppUser() public view returns (AlluserStruck[] memory) {
        return getAllusers;
    }
}