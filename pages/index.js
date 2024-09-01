import React, { useEffect, useState, useContext }from 'react';

import {ChatAppContect} from "../context/ChatAppContext";
import { Filter, Friend } from '../components/index';

const ChatApp = () => {
	
	// const { } = useContext(ChatAppContect);

  return (
    <div> 
      <Filter/>
      <Friend/>
    </div>
  )
};

export default ChatApp;
