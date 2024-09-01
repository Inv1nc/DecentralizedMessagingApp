// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ChatApp} from "../src/ChatApp.sol";
import {Test} from "forge-std/Test.sol";
import {DeployChatApp} from "../script/ChatApp.s.sol";

contract TestChatApp is Test {
    ChatApp app;

    address immutable USER1 = makeAddr("Inv1nc");
    address immutable USER2 = makeAddr("Ajay");
    address immutable USER3 = makeAddr("OmniMan");
    address immutable USER4 = makeAddr("KidOmniMan");

    function setUp() external {
        app = new ChatApp();
    }

    function _testCreateAccount() internal {
        vm.prank(USER1);
        string memory username = vm.getLabel(USER1);

        app.createAccount(username);
        assertEq(app.getUserName(USER1), username);
    }

    function testFailNoName() external {
        vm.prank(USER1);
        app.createAccount("");
    }

    function testFailUserNotRegistered() external view {
        app.getUserName(USER1);
    }

    function testCheckUserExists() external {
        vm.prank(USER1);
        app.createAccount(vm.getLabel(USER1));

        bool check = app.checkUserExists(USER1);
        assert(check);
    }

    function testFailAddFriendCreateAccount() external {
        vm.prank(USER1);
        app.addFriend(USER2, vm.getLabel(USER2));

        vm.prank(USER1);
        app.createAccount(vm.getLabel(USER1));

        vm.prank(USER1);
        app.addFriend(USER2, vm.getLabel(USER2));
    }

    function testFailOnAccountDuplication() external {
        _testCreateAccount();
        vm.prank(USER1);
        app.createAccount("Hlo");
        assertEq(app.getUserName(USER1), vm.getLabel(USER1));
    }

    function testCreateAccounts() public {
        vm.prank(USER1);
        app.createAccount(vm.getLabel(USER1));

        vm.prank(USER2);
        app.createAccount(vm.getLabel(USER2));

        vm.prank(USER3);
        app.createAccount(vm.getLabel(USER3));

        vm.prank(USER4);
        app.createAccount(vm.getLabel(USER4));
    }

    function testAddFriends() public {
        testCreateAccounts();
        vm.prank(USER1);
        app.addFriend(USER2, vm.getLabel(USER2));
    }

    function testFailAlreadyFriends() public {
        testAddFriends();
        vm.prank(USER1);
        app.addFriend(USER2, vm.getLabel(USER2));
    }

    function testFailAddFriends() public {
        app.addFriend(USER1, vm.getLabel(USER1));

        vm.prank(USER1);
        app.createAccount(vm.getLabel(USER1));
        app.addFriend(USER2, vm.getLabel(USER2));

        vm.prank(USER1);
        app.addFriend(USER1, vm.getLabel(USER1));
    }

    function testSendMessage() public {
        testCreateAccounts();
        vm.expectRevert();
        vm.prank(USER1);
        app.sendMessage(USER2, "hiii");
    }

    function testFailSendMessage() public {
        testCreateAccounts();

        string memory message = "hii";

        vm.startPrank(USER1);

        app.sendMessage(USER1, message);

        app.sendMessage(address(0), message);

        app.sendMessage(USER2, message);
    }

    function testReadMessage() public {
        vm.prank(USER1);
        app.readMessage(USER2);
    }

    function testAddMoreFriends() public {
        testCreateAccounts();
        vm.startPrank(USER1);
        app.addFriend(USER2, vm.getLabel(USER2));
        app.addFriend(USER3, vm.getLabel(USER3));
        vm.stopPrank();

        vm.prank(USER4);
        app.addFriend(USER1, vm.getLabel(USER1));

        vm.prank(USER2);
        app.getMyFriendList();

        app.getAllAppUser();
    }

    function testScript() public {
        DeployChatApp deploy = new DeployChatApp();
        ChatApp _app = deploy.run();
        assertTrue(address(_app) != address(0));
    }
}
