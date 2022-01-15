# [Crypto Composer](https://crypto-composer.bangtoven.com/)

- Mint NFTs storing music data, in a abstractive and discrete form
- Ensure originality and uniqueness by checking hash
- Play back the songs registered on blockchain

![](./screenshot.png)

## User workflows

- Sign in with Ethereum provider
- Browe songs and see metadata (title, composer account)
- Play songs
  - by selecting one from the list
  - or accessing directly via link. e.g. https://crypto-composer.bangtoven.com/songs/0
- Buy CCT(CryptoComposerToken) to pay for minting new songs
- Write a new song and mint it as NFT
- (Access them on NFT marketplaces like OpenSea. e.g. [Song #1 on Crypto Composer](https://testnets.opensea.io/assets/0xde58a83bc2634753143c555dd08d47d22463e71f/1)

## Architecture and directory structure

### [Design patterns](./design_pattern_decisions.md)

### [Security measures](./avoiding_common_attacks.md)

### Smart contracts

Bootstraped with [Truffle](https://github.com/trufflesuite/truffle),
and deployed on [Ropsten](https://ropsten.etherscan.io/address/0xA27FACD3FB95E8a159f69522151caA6DA4224EC2)
and [Rinkeby](https://rinkeby.etherscan.io/address/0xDE58a83BC2634753143C555dD08d47D22463E71f)([deployed_address.txt](./deployed_address.txt))

```
- contracts
 - CryptoComposer.sol   - deployed. checks payment and call minter
 - CryptoNFTMinter.sol  - inherited by CryptoComposer. manages minting
 - CryptoComposerToken.sol       - ERC20 token to use CryptoComposer.
 - CryptoComposerTokenVendor.sol - manages price and minting of CCT.
- migrations
- tests
```

### Frontend

React app built with [next.js](https://github.com/vercel/next.js/) accessible at https://crypto-composer.bangtoven.com/

Referenced [Reactronica](https://github.com/unkleho/reactronica) to build DAWStepsEditor

```
- pages
- components
- hooks
- styles
- public
```

## Instructions

### Install and migration

```sh
# install frontend dependencies, smart contract tooling, and solidity libraries
yarn install

# deploy smart contracts to local network
ganache-cli -p 8545 # or Ganache GUI
truffle migrate
```

You need these local contract addresses of `CryptoComposerTokenVendor` and `CryptoComposer` later to update frontend.

> Deploy to public network: Create and fill `.secret` and `.infura_api_key` files, then run `truffle migrate --network {NETWORK}`

### Run unit tests

```sh
ganache-cli -p 8545 # or Ganache GUI
truffle test
```

### Run frontend locally

Update contract addresses for `1337` network on `hooks/useContract.js` with addresses from the previous step.

```JavaScript
// hooks/useContract.js
...
export function useCryptoComposerContract() {
...
      [1337, `{CryptoComposer_address}`],
...

export function useCCTVendorContract() {
...
      [1337, `{CryptoComposerTokenVendor_address}`],
...
```

### Use the deployed web app

Set your local network id to `1337` and open https://crypto-composer.bangtoven.com/

## Ethereum account for certificatation NFT

```
jungho.eth
0xB8E1aCe6Aa298777552eda47B71857201D662134
```
