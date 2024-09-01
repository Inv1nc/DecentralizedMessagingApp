import "@/styles/globals.css";

import { ChatAppProvider } from "../context/ChatAppContext";
import { NavBar } from "../components/index";

const MyApp = ({ Component, pageProps }) => {
    return (
        <div>
            <ChatAppProvider>
                <NavBar/>
                <Component {...pageProps} />
            </ChatAppProvider>
        </div>
    );
}

export default MyApp;

