import { ethers } from "ethers";

import {ChatAppAddress, ChatAppABI} from "../context/constants";

export const CheckIfWalletConnected = async() => {
	try {
		if (!window.ethereum) return console.log("Install MetaMask");
		const accounts = await window.ethereum.request({
			method: "eth_accounts",
		});
		
		const firstAccount = accounts[0];
		return firstAccount;
	} catch (error) {
		console.log("Install MetaMask");	
	}

}

export const connectWallet = async() => {
	try {
		if (!window.ethereum) return console.log("Install MetaMask");
		const accounts = await window.ethereum.request({
			method: "eth_requestAccounts",
		});		
		const firstAccount = accounts[0];
		return firstAccount;
	} catch (error) {
		console.log("Install MetaMask");	
	}
}

const fetchContract = (signerOrProvider) => new ethers.Contract( ChatAppAddress, ChatAppABI, signerOrProvider);

export const connectingWithContract = async() => {
	try {
		const provider = new ethers.BrowserProvider(window.ethereum);
		const signer = await provider.getSigner();
		const contract = fetchContract(signer);

		return contract;
	} catch(error) {
		console.log(error);
	}
}

export const converTime = (time) => {
	const newTime = new Date(Number(time));

	const realTime = newTime.getHours() + "/" + newTime.getMinutes() + "/" + newTime.getSeconds() + "Date: " + newTime.getDate() + "/" + (newTime.getMonth() + 1) + "/" + newTime.getFullYear();

	return realTime;
}
