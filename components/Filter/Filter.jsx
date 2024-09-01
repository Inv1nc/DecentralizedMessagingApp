import React, { useContext, useState } from 'react';
import Image from 'next/image';

import Style from "./Filter.module.css";
import images from "../../assets";
import { ChatAppContect } from '../../context/ChatAppContext';
import {Model} from "../index";


const Filter = () => {
  const {account, addFriends} = useContext(ChatAppContect);
  const [addFriend, setAddFriend] = useState(false);

  return (
    <div className={Style.Filter}>
      <div className={Style.Filter_box}>
        <div className={Style.Filter_box_left}>
          <div className={Style.Filter_box_left_search}>
            <Image src={images.search} alt="image" width={20} height={20}/>
            <input type="text" placeholder="search"/>
          </div>
        </div>
        <div className={Style.Filter_box_right}>
          <button>
            <Image src={images.clear} alt="clear" width={20} height={20}/>
            CLEAR CHAT
          </button>
          <button onClick={()=> setAddFriend(true)}>
            <Image src={images.user} alt="clear" width={20} height={20}/>
            ADD FRIEND CHAT
          </button>
        </div>
      </div>

      {/* MODEL COMPONENT */}
      {addFriend && (
        <div className={Style.Filter_model}>
          <Model 
            openBox={setAddFriend}
            title="Welcome To"
              head = "Chat Buddy"
                info="hii gays welcome to this sh1tty application love you b1tchs"
                  smallInfo="kindly select your friend name & address"
                  image = {images.hero}
                  functionName={addFriends}
          />
        </div>
      )}
    </div>
  )
}

export default Filter