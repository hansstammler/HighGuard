# Local Solana Validitor Information Extractor

This module provides a utility function to extract Solana-related information from the output of the solana-test-validator (STV) command.

## Usage

To use the `extractSTVInfo` function (in CI directory of the project):

```javascript
const { extractSTVInfo } = require("./CI/envs/solana-test-validator/solana-test-validator.js");

extractAnvilInfo()
  .then((info) => {
    console.log(info);
  })
  .catch((error) => {
    console.error(error);
  });
```

## Functionality

### `extractAnvilInfo()`

Extracts Ethereum accounts, private keys, and the RPC address from the Anvil command's output.

- **Returns**: A promise that resolves with an object containing:

  - `accounts`: An array of Ethereum account addresses.
  - `privateKeys`: An array of private keys corresponding to the Ethereum accounts.
  - `rpcAddress`: The RPC address on which Anvil is listening.

- **Throws**: An error if there's an issue executing the Anvil command or processing its output.

### Supported Versions

This tool is tested with the following version of Anvil.

```
anvil 0.2.0 (0232ee5 2023-10-16T00:17:47.266734000Z)
```
