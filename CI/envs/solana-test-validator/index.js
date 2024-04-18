require('module-alias/register');
const { spawn } = require('child_process');
const Web3 = require("web3");
const Solana = require("@solana/web3.js")
const { findFreePorts } = require('@lib/os/network');


/**
 * Extracts information from the Anvil command.
 * 
 * @returns {Promise<Object>} A promise that resolves with an object containing the accounts, private keys, and RPC address.
 * @throws {Error} If there's an error while executing the Anvil command or processing its output.
 */
let extractSTVInfo = (port) => {
    return new Promise((resolve, reject) => {
        let STVProcess = spawn('solana-test-validator', ['--rpc-port', port, '--reset', '--ledger', '.solana-test-validator'], {cwd:process.env.HOME}); //This temp probably needs changing
        let output = '';
        STVProcess.stdout.on('data', (data) => {
            output += data.toString();

            if (output.includes('WebSocket PubSub URL:')) { //Wait until initialize is complete
                STVProcess.stdout.removeAllListeners('data'); 

                let rpcAddressMatch = output.match(/JSON RPC URL: http:\/\/(\d+\.\d+\.\d+\.\d+:\d+)/);
                let rpcAddress = rpcAddressMatch ? rpcAddressMatch[1] : null;

                let connection = new Solana.Connection("http://" + rpcAddress, "confirmed");
                
                const keypairs = [];
                const privateKeys = [];
                const accounts = [];

                for(let i = 0; i < 10; i++) {
                    keypairs.push(Solana.Keypair.generate());
                    privateKeys.push(keypairs[i].secretKey);
                    accounts.push(keypairs[i].publicKey);
                    (async () => {
                        let airdropSignature = await connection.requestAirdrop(accounts[i], 10000 * Solana.LAMPORTS_PER_SOL);
                        await connection.confirmTransaction({signature: airdropSignature});
                    })()
                }
                resolve({
                    accounts,
                    privateKeys,
                    rpcAddress,
                    pid: STVProcess.pid
                });
            }
        });
        // Handle any errors
        STVProcess.stderr.on('data', (data) => {
            reject(`Error: ${data}`);
        });
    });
}


let setupEnv = async () => {
    let freePorts = await new Promise(resolve => findFreePorts(3000, 100, resolve));
    if (!freePorts.length) {
        throw new Error("No free ports found!");
    }
    let port = freePorts[Math.floor(Math.random() * freePorts.length)];

    let envInfo = await extractSTVInfo(port);

    const wsPort = `ws://127.0.0.1:${port}`;
    const web3 = new Web3(new Web3.providers.WebsocketProvider(wsPort));
    

    //let web3 = new Web3('http://127.0.0.1:' + port);

    // Assuming the first account and private key are the signer's
    let signer = web3.eth.accounts.privateKeyToAccount(envInfo.privateKeys[0]);
    web3.eth.accounts.wallet.add(signer);

    return {
        web3,
        envInfo
    };
}

//remove these before commit and 
let testing = async () => {
    let envInfo = await extractSTVInfo(8811);
}
testing().then(() => console.log("done"));
//module.exports = setupEnv;