### Smart Contract Overview (`ChatApp.sol`):

The `ChatApp` smart contract is a decentralized messaging system that allows users to:
- Create accounts linked to their Ethereum addresses.
- Add friends by sending friend requests to other registered users.
- Send and receive messages between friends.
- Retrieve chat history securely stored on the blockchain.

Key Functions:
- **`createAccount(string calldata name)`**: Allows a user to register by associating their Ethereum address with a unique username.
- **`addFriend(address friend_key, string calldata name)`**: Enables a user to add another registered user as a friend.
- **`sendMessage(address friend_key, string calldata _msg)`**: Sends a message to a friend. The contract ensures both users are registered and friends before sending the message.
- **`readMessage(address friend_key)`**: Allows a user to retrieve the chat history between themselves and a friend.

The contract ensures security and privacy by using Ethereum addresses as unique identifiers and preventing actions like adding oneself as a friend or messaging non-friends.

---

### Test Suite Summary:

The tests ensure the contract behaves correctly under various scenarios. Here’s a breakdown of the tests run and their purposes:

1. **`testAddFriends()`** (gas: 458924):
   - Tests the ability to successfully add a friend to a user’s friend list.
   
2. **`testAddMoreFriends()`** (gas: 719141):
   - Verifies the functionality of adding multiple friends to the user's friend list.

3. **`testCheckUserExists()`** (gas: 103198):
   - Ensures the system correctly checks if a user exists when querying for account information.

4. **`testCreateAccounts()`** (gas: 317809):
   - Tests account creation by registering users with unique Ethereum addresses and usernames.

5. **`testFailAddFriendCreateAccount()`** (gas: 13791):
   - Tests the failure case where a user attempts to add a friend without creating an account first.

6. **`testFailAddFriends()`** (gas: 13164):
   - Tests failure when trying to add a non-existent user as a friend.

7. **`testFailAlreadyFriends()`** (gas: 465164):
   - Ensures that users cannot add someone who is already on their friend list again.

8. **`testFailNoName()`** (gas: 11732):
   - Tests failure when attempting to create an account without providing a valid username.

9. **`testFailOnAccountDuplication()`** (gas: 108939):
   - Ensures that a user cannot register the same account (Ethereum address) multiple times.

10. **`testFailSendMessage()`** (gas: 320663):
    - Verifies failure when a user tries to send a message to someone who is not their friend.

11. **`testFailUserNotRegistered()`** (gas: 8546):
    - Tests failure when querying account information for a non-registered user.

12. **`testReadMessage()`** (gas: 13191):
    - Ensures that users can correctly read messages sent between themselves and a friend.

13. **`testScript()`** (gas: 3621041):
    - Runs the deployment and basic interaction script to ensure full functionality.

14. **`testSendMessage()`** (gas: 326240):
    - Tests the successful sending of a message between two friends, ensuring that messages are properly recorded on-chain.

---

### Code Coverage:

- **Lines**: 89.47% of lines in the `ChatApp` smart contract are covered by the tests.
- **Statements**: 84.44% of statements are tested.
- **Branches**: 76.92% of logical branches (e.g., `if` statements) are covered by tests.
- **Functions**: 100% of the functions in the contract are tested.

This extensive test coverage ensures that the contract functions as expected under both typical and edge-case conditions, with failures tested for invalid or out-of-bound inputs.