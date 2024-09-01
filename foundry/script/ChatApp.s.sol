// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {ChatApp} from "../src/ChatApp.sol";

contract DeployChatApp is Script {
    ChatApp chatApp;

    function run() external returns (ChatApp) {
        vm.startBroadcast();
        chatApp = new ChatApp();
        vm.stopBroadcast();
        return chatApp;
    }
}
