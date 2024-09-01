### Decentralized Messaging Application

The **Decentralized Messaging Application** is a blockchain-based project that enables secure peer-to-peer communication. It eliminates reliance on centralized servers by using Ethereum smart contracts to handle account registration, friend management, and messaging between users. All data is stored immutably on the blockchain, ensuring security, privacy, and transparency.

#### Key Features:
1. **Account Creation**: Users can create an account by registering their name on the platform. Each account is uniquely tied to their Ethereum address.
2. **Friend Management**: Users can add friends using their Ethereum addresses. Friendship is mutual, meaning both users must accept each other to start messaging.
3. **Messaging**: Users can send and receive messages with their friends. Messages are stored securely on the blockchain and can be retrieved anytime.
4. **Immutability & Security**: The use of blockchain ensures that messages and account data are tamper-proof and cannot be altered.
5. **No Central Authority**: All data is stored on the blockchain, preventing any single entity from controlling or censoring the messages.

#### Technical Stack:
- **Smart Contracts**: Written in Solidity, deployed on Ethereum, ensuring decentralized, peer-to-peer messaging functionality.
- **Frontend**: Built using modern web technologies (React, Next.js), providing an intuitive user interface for interacting with the smart contracts.
- **Blockchain**: Ethereum serves as the backend, securing user data and messages on the blockchain.

#### Smart Contract Overview:
1. **Account Management**:
   - Users can create an account by submitting their name and Ethereum address.
   - The platform checks for duplicates to avoid multiple accounts.
2. **Friend System**:
   - Users can send friend requests by adding other users via their Ethereum addresses.
   - A check ensures that users are not adding themselves or already existing friends.
3. **Messaging**:
   - Messages are stored on-chain, uniquely identified by the combination of both users' Ethereum addresses.
   - Users can retrieve message histories with their friends using a unique chat code.
4. **Security**:
   - All users' data and messages are protected by the immutability of the Ethereum blockchain.
   - Only registered users can send messages or add friends, ensuring privacy.

---

## Installation of Dependencies

Ensure you have the following installed to run the application:

- **npm** (for frontend dependencies)
- **Rust** (for contract compilation or utility purposes)
- **Foundry** (for testing and deploying the smart contracts)

### Step 1: Install npm Dependencies
```bash
npm install
```

### Step 2: Install Rust
Install Rust using the official installation script:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
**Reference**: [Rust Installation](https://www.rust-lang.org/tools/install)

### Step 3: Install Foundry
Install Foundry for contract deployment and testing:
```bash
curl -L https://foundry.paradigm.xyz | bash
```
Once installed, run the following command to update Foundry:
```bash
foundryup
```
**Reference**: [Foundry Installation](https://book.getfoundry.sh/getting-started/installation)

---

## Running the Application

Once all dependencies are installed, follow the demo video to run the application and deploy smart contracts:

1. Compile and deploy the smart contracts using Foundry.
2. Start the application by running the following command:

```bash
npm start
```

The application will run locally on `http://localhost:3000`. Ensure your Ethereum wallet (e.g., MetaMask) is connected for account registration and message sending.

---

```shell
cd foundry
```

Once you're in the `foundry` directory, you can manage your smart contracts and testing scripts. Here’s what you can typically do inside the `foundry` folder:

1. **Compile Smart Contracts**:
   Compile the smart contracts using:
   ```bash
   forge build
   ```

2. **Run Tests**:
   Run the smart contract tests to ensure everything is working correctly:
   ```bash
   forge test
   ```

3. **Deploy Smart Contracts**:
   To deploy your contracts on a local or test network, you can use the following command:
   ```bash
   forge script deployScript --fork-url <NETWORK_URL> --private-key <YOUR_PRIVATE_KEY>
   ```


## Demo Video

[Watch the Demo Video](demo.mp4)
