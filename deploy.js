const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
    'call glow acoustic vintage front ring trade assist shuffle mimic volume reject',
    'https://'
);
const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log('Attempting to deply from account', account[0]);

    const result = await web3.eth.Contract(JSON.parse(interface))
    .deploy({ data: bytecode, arguments: ['Hi there'] })
    .send({ gas: '1000000', from: accounts[0] });
};

deploy();
