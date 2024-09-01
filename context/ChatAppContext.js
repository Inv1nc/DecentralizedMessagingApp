import React, { useState, useEffect } from "react";
import { useRouter } from "next/router";

import { CheckIfWalletConnected, connectWallet, fetchContract, connectingWithContract } from "../utils/apiFeature.js" ;

export const ChatAppContect = React.createContext();

export const ChatAppProvider = ({children}) => {
	const title = "Hey Welcome to Blockchain Chat Application";
	const [account, setAccount] = useState("");
	const [userName, setUserName] = useState("");
	const [friendLists, setFriendLists] = useState([]);
	const [friendMsg, setFriendMsg] = useState([]);
	const [loading, setLoading] = useState("");
	const [userLists, setUserLists] = useState([]);
	const [error, setError] = useState("");

	// CHAT USER DATA

	const [currentUserName, setCurrentUserName] = useState("");
	const [currentUserAddress, setCurrentUserAddress] = useState("");
	
	const router = useRouter();


	const fetchData = async() => {
		try {
			const contract = await connectingWithContract();
			const connectAccount = await connectWallet();
			setAccount(connectAccount);
			const userName = await contract.getUserName(connectAccount);
			setUserName(userName);
			const friendLists = await contract.getMyFriendList();
			setFriendLists(friendLists);
			const userList = await contract.getAllAppUser();
			setUserLists(userList);
		} catch (error) {
			setError("Please Install and Connect Your Wallet");
		} 
	};

	useEffect(() => {
		fetchData();
	}, []);


	const readMessage = async(friendAddress) => {
		try {
			const contract = await connectingWithContract();
			const read = await contract.readMessage(friendAddress);
			setFriendMsg(read);
		} catch (error) {
			console.log("Currently you have no message");
		}
	};

	const createAccount = async({name, accountAddress}) => {
		try {
			// if(name || accountAddress) return setError("Name and Account Address, cannot be empty");
			const contract = await connectingWithContract();
			const getCreatedUser = await contract.createAccount(name);
			setLoading(true);
			await getCreatedUser.wait();
			window.location.reload();	
		} catch(error) {
			setError("Error while creating account");
		} 
	};

	const addFriends = async({name, accountAddress}) => {
		try {
			//if(name || accountAddress) return setError("please provide");
			const contract = await connectingWithContract();
			const addMyFriend = await contract.addFriend(accountAddress, name);
			setLoading(true);
			await addMyFriend.wait();
			router.push("/");
			window.location.reload();
		} catch (error) {
			setError("something went wrong while adding friend");
		}
	}

	const sendMessage = async({msg, address}) => {
		try {
			// if(msg || address) return setError("message cant be empty");
			const contract = await connectingWithContract();
			const addMessage = await contract.sendMessage(address, msg);
			setLoading(true);
			await addMessage.wait();
			setLoading(false);
			window.location.reload();
			
		} catch(error) {
			setError("error while sending message");
		}
	}

	const readUser = async(userAddress) => {
		const contract = await connectingWithContract();
		const userName = await  contract.getUserName(userAddress);
		setCurrentUserName(userName);
		setCurrentUserAddress(userAddress);
	}
	return (

		<ChatAppContect.Provider
			value={{ 
				readMessage,
				createAccount,
				addFriends,
				sendMessage,
				readUser,
				connectWallet,
				CheckIfWalletConnected,
				account,
				userName,
				friendLists,
				friendMsg,
				loading,
				userLists,
				error,
				currentUserName,
				currentUserAddress
			}}
		>
			{children}
		</ChatAppContect.Provider>
	)
}
