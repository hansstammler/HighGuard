## Clawk: Monitoring Business Processes in Smart Contracts 
Clawk is Acronym for Contract Law Keeper, read "clock".


## Installation
The ecosystem is tested with: 

|       | Server | Client |
|-------|----------|----------|
| **Node** |  v16.20.2  | v18.17.1   |
| **NPM** | 8.19.4   | 9.6.7   |


Run the `npm install` in the main repository directory and the following directories:

`server/monitor`

`client`


## Usage

### Using Clawk in Client-Server Mode
Run the following commands (in order):

In **server**:

`npm start`

The server will ask for your DCRGraphs credentials the first time you run it. The credentials will be stored under `server/monitor/datastore/` directory as a sqlite database.

In **client**:

`npm start`

Go to the following address in your browser (or alternatives that were used if port 3001 is unavailable), and use the monitor web interface:
[http://localhost:3000](http://localhost:3001)

Fill the forms inputs from top to down for it to work properly. 

### Using Clawk Standalone CLI Monitor
Run the following CLI command using the options in the table below:
```sh
node server/monitor/monitorCLI.js
```
Use the following options with the Clawk Standalone CLI Monitor:


| Option        | Description   | Required |
|---------------|---------------|----------|
| `--help`      | Show help     | No       |
| `--version`   | Show version number | No       |
| `--address`   | The address of the deployed contract | Yes      |
| `--dcrID`     | The DCR model identifier from DCRGraphs.net website | Yes      |
| `--simID`     | The identifier of the specific simulation you want to model this contract against. This identifier is retrievable by going to address [https://repository.dcrgraphs.net/api/graphs/${dcrID}/sims/](https://repository.dcrgraphs.net/api/graphs/${dcrID}/sims/) replacing ${dcrID} with the ID of the model you are trying to monitor against | Yes      |
| `--ABIFileName` | The name of the contract ABI file (for example: PiggyBank.json). You should first put this file in the path `server/monitor/contracts/json-interface`  | Yes      |
| `--contract`  | The contract parameter | Yes      |

#### Example command usage:
```sh
node monitorCLI.js --address 0xB343f140a4426dc4eb40C2aFCe777D0509e4dCC0 --dcrID 1700559 --simID 1925367 \
--ABIFileName PiggyBank.json --contract PiggyBank
```

## Cite Us
```
@misc{Clawk,
  author       = {Mojtaba Eshghie and Wolfgang Ahrendt and 
                  Cyrille Artho and Thomas Troels Hildebrandt and 
                  Gerardo Schneider},
  title        = {CLawK: Monitoring Business Processes in 
                  Smart Contracts},
  year         = {2023},
  month        = {May},
  url          = {https://arxiv.org/abs/2305.08254},
  doi          = {10.48550/arXiv.2305.08254},
  abstract     = {Smart contracts embody complex business processes that can be difficult to analyze statically.
                  In this paper, we present CLawK, a runtime monitoring tool that leverages business process
                  specifications written in DCR graphs to provide runtime verification of smart contract execution.
                  We demonstrate how CLawK can detect and flag deviations from specified behaviors in smart 
                  contracts deployed in the Ethereum network without code instrumentation or additional gas costs.},
  note         = {arXiv:2305.08254v1 [cs.CR]},
  keywords     = {dcr-graphs, dynamic-condition-response, 
                  runtime-monitoring, runtime-verification, 
                  smart-contract-specifications, 
                  smart-contracts-security}
}

```

## Screenshot of the tool web interface (client)
![CLawK Screenshot](https://raw.githubusercontent.com/mojtaba-eshghie/CLawK/main/client/public/Screenshot%202023-06-21%20at%2016.32.03.png)

