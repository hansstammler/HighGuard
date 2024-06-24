## HighGuard: Monitoring Smart Contracts Business Logic

<p align="center">
  <img src="https://github.com/mojtaba-eshghie/Clawk/assets/37236297/4ea40602-3791-478b-b121-28f4cd9555a5" width="200" alt="HighGuard Logo">
</p>

Smart contracts embody complex business processes that can be difficult to analyze statically. Therefore, we present HighGuard, a runtime monitoring tool that leverages business process specifications written in DCR graphs to provide runtime verification of smart contract execution. We demonstrate how HighGuard can detect and flag deviations from specified behaviors in smart contracts deployed in the Ethereum network without code instrumentation and any additional gas costs.

## Installation

### Manual Installation

To manually install and run HighGuard, follow these steps:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/mojtaba-eshghie/HighGuard.git
   cd HighGuard
   ```

2. **Install Node.js and npm:**

   Ensure you have Node.js version 16.20.2 and npm version 8.19.4 installed. You can download and install Node.js from [Node.js official website](https://nodejs.org/).

   Verify the installation:

   ```sh
   node --version
   npm --version
   ```

3. **Install project dependencies:**

   ```sh
   npm install
   ```

4. **Install Foundry and Anvil:**

   Follow the instructions to install Foundry from the [Foundry Book](https://book.getfoundry.sh/getting-started/installation).

   ```sh
   curl -L https://foundry.paradigm.xyz | bash
   source ~/.bashrc
   foundryup
   ```

5. **Run the CLI commands:**

   You can now run the CLI commands as needed:

   ```sh
   pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-governance.yml
   pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-escrow.yml
   pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-multistageauction.yml
   pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-prizedistribution.yml
   pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-productorder.yml
   ```

### Running via Docker

To build and run HighGuard using Docker, follow these steps:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/mojtaba-eshghie/HighGuard.git
   cd HighGuard
   ```

2. **Build the Docker image:**

   ```sh
   docker build -t HighGuard-cli-docker .
   ```

3. **Run the Docker container with specific commands:**

   Replace the command as needed:

   ```sh
   docker run --rm -v $(pwd):/usr/src/app HighGuard-cli-docker bash -c "pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-governance.yml"
   ```

   Example commands:

   ```sh
   docker run --rm -v $(pwd):/usr/src/app HighGuard-cli-docker bash -c "pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-escrow.yml"
   docker run --rm -v $(pwd):/usr/src/app HighGuard-cli-docker bash -c "pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-multistageauction.yml"
   docker run --rm -v $(pwd):/usr/src/app HighGuard-cli-docker bash -c "pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-prizedistribution.yml"
   docker run --rm -v $(pwd):/usr/src/app HighGuard-cli-docker bash -c "pkill anvil; node CI/run.js -t synthesized -e separate -v -c micro-configs/config-synthesized-productorder.yml"
   ```

## Features

### Main Features

- Fully automated model-based monitoring/testing of smart contracts.
- Supports DCR graphs enhanced with data and time.
- Supports multi- and cross-chain smart contract monitoring
- Platform agnostic as the models are built based on high-level business logic specifications.

### Axiliary Features

- **Batteries included**: Many of the smart contract libraries HighGuard uses are part of its project under `lib` directory.
- **Distributed logging**: As HighGuard can monitor many contracts at once, and it includes a distributed logging ecosystem to better suit large-scale monitoring operations.
<!--

## Installation

The ecosystem is tested with:

|          | Server   | Client   |
| -------- | -------- | -------- |
| **Node** | v16.20.2 | v18.17.1 |
| **NPM**  | 8.19.4   | 9.6.7    |

Run the `npm install` in the main repository directory and the following directories:

`server/monitor`

`client` -->

## Cite Us

```
@misc{HighGuard,
  author       = {Mojtaba Eshghie and Wolfgang Ahrendt and
                  Cyrille Artho and Thomas Troels Hildebrandt and
                  Gerardo Schneider},
  title        = {HighGuard: Monitoring Business Processes in
                  Smart Contracts},
  year         = {2023},
  month        = {May},
  url          = {https://arxiv.org/abs/2305.08254},
  doi          = {10.48550/arXiv.2305.08254},
  abstract     = {Smart contracts embody complex business processes that can be difficult to analyze statically.
                  In this paper, we present HighGuard, a runtime monitoring tool that leverages business process
                  specifications written in DCR graphs to provide runtime verification of smart contract execution.
                  We demonstrate how HighGuard can detect and flag deviations from specified behaviors in smart
                  contracts deployed in the Ethereum network without code instrumentation or additional gas costs.},
  note         = {arXiv:2305.08254v1 [cs.CR]},
  keywords     = {dcr-graphs, dynamic-condition-response,
                  runtime-monitoring, runtime-verification,
                  smart-contract-specifications,
                  smart-contracts-security}
}

```

## Using HighGuard in Client-Server Mode

This part is deprecated, and is not actively maintained. You can look [here](https://github.com/mojtaba-eshghie/HighGuard/wiki/Using-HighGuard-in-Client%E2%80%90Server-Mode) for the old documentation.
