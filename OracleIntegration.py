from web3 import Web3, KeepAliveRPCProvider, IPCProvider
import time

web3 = Web3(IPCProvider())
my_account_address = '0xYourAccountAddress'
oracle_private_key = '0xYourPrivateKey'
savingsContract = web3.eth.contract(address='SavingsContractAddress', abi=YOUR_CONTRACT_ABI)

def watch_for_income():
    balance = 0
    while True:
        new_balance = web3.eth.getBalance(my_account_address)
        if new_balance > balance:
            income = new_balance - balance
            savings_portion = income // 5    # 20% as savings, adjust as needed
            send_to_savings(savings_portion)
        balance = new
Of course, here is the completion of the Python code.

```python
            balance = new_balance
        time.sleep(60)  # checks each minute. Adjust this value as needed.

def send_to_savings(amount):
    nonce = web3.eth.getTransactionCount(my_account_address)
    txn = savingsContract.functions.transferFunds(amount).buildTransaction({
        'chainId': 1,
        'gas': 70000,
        'gasPrice': web3.toWei('1', 'gwei'),
        'nonce': nonce,
    })
    signed_txn = web3.eth.account.signTransaction(txn, oracle_private_key)
    web3.eth.sendRawTransaction(signed_txn.rawTransaction)

if __name__ == "__main__":
    watch_for_income()
