import React, {useState, useEffect, useContext} from 'react'

import {UserCard} from "../components/index";
import Style from "../styles/alluser.module.css"

import { ChatAppContect } from "../context/ChatAppContext";


const alluser = () => {

    const {userLists, addFriends} = useContext(ChatAppContect);
  return (
    <div>
        <div className={Style.alluser_info}>
            <h1>Find Your Friend</h1>
        </div>
        <div className={Style.alluser}>
            {userLists.map((el, i)=> (
                <UserCard key={i+1} el={el} i = {i} addFriends={addFriends}/>
            ))}
        </div>
    </div>
  )
}

export default alluser