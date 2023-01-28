# Foliage #

<p align="center">
<img src="https://raw.githubusercontent.com/AVS1508/foliage/main/lib/assets/images/icon_alpha.png" alt="Foliage" width="160px" height="160px"/>
</p>

Foliage is a cryptocurrency wallet mobile application developed in Flutter, deployed to Android and iOS, using Firebase tooling.

## Purpose ##

This app was created with the intent of learning:

- Mobile Application UI Development (transitioning from Web-oriented Development experience)
- Flutter
- Solidity
- Firebase integrations with Flutter
    - Firebase Authentication
    - Firebase Cloud Firestore
- How cryptocurrency amounts are managed in a wallet
- How cryptocurrency transactions are recorded by a wallet

## Definitions & Usage ##

- **Cryptocurrency Wallet**: Utility to store relevant private keys - keeping user-owned cryptocurrencies safe and accessible - and enable sending, receiving and spending cryptocurrencies such as Bitcoin and Ethereum. These utilities can be hardware wallets such as [Ledger](https://www.ledger.com/) to mobile apps such as [Coinbase Wallet](https://wallet.coinbase.com/). (From [Coinbase Learn](https://www.coinbase.com/learn/crypto-basics/what-is-a-crypto-wallet))

- **Smart Contract**: A smart contract establishes the terms of an agreement, by executing code running on a blockchain such as Ethereum, removing the typical intermediary of banks or lawyers. They enable developers to build apps utilizing blockchain security, reliability, and accessibility while providing sophisticated peer-to-peer functionality, ranging from offerings like loans, insurance, logistics and gaming. (From [Coinbase Learn](https://www.coinbase.com/learn/crypto-basics/what-is-a-smart-contract))

- **ERC-20 Token**: ERC-20 is a protocol for Ethereum tokens to follow within the larger Ethereum ecosystem, allowing developers to program how new tokens will function in this ecosystem. It also enables developers to accurately predict interaction between tokens, by including how tokens are transferred between addresses and how data within each token is accessed. (From [Coinbase Help](https://help.coinbase.com/en/coinbase/getting-started/crypto-education/what-is-erc20))

## Folder Structure ##

The `/lib` folder has been compartmentalized into the following sections:

1. `api`:
2. `assets`:
3. `components`:
4. `constants`:
5. `utils`:
6. `views`:

## Cloud Firestore Database Structure ##

```json
{
    "users": {
        "_type": "Collection",
        "$uid1": {
            "_type": "Document",
            "displayName": "User 1",
            "email": "uid1@email.com",
            "cryptocurrencies": {
                "_type": "Collection",
                "$coin1": {
                    "_type": "Document",
                    "amount": "0.1"
                },
                "$coin2": {
                    "_type": "Document",
                    "amount": "1.0"
                },
            },
            "stocks": {
                "_type": "Collection",
                "$stock1": {
                    "_type": "Document",
                    "amount": "0.8"
                },
                "$stock2": {
                    "_type": "Document",
                    "amount": "4.0"
                },
            }
        },
        "$uid2": {
            "_type": "Document",
            "displayName": "User 2",
            "email": "uid2@email.com",
            "cryptocurrencies": {
                "_type": "Collection",
                "$coin1": {
                    "_type": "Document",
                    "amount": "0.1"
                },
                "$coin2": {
                    "_type": "Document",
                    "amount": "1.0"
                },
            },
            "stocks": {
                "_type": "Collection",
                "$stock1": {
                    "_type": "Document",
                    "amount": "0.8"
                },
                "$stock2": {
                    "_type": "Document",
                    "amount": "4.0"
                },
            }
        },
    },
}
```

## Theming ##

Theming for the project has been configured via `lib/utils/theme.dart`, and complies with the color palette as follows:

| Color Name   | Color Hex Code |
|--------------|----------------|
| trueWhite    | #FFFFFF        |
| trueBlack    | #000000        |
| offWhite     | #F1F0EA        |
| charadeBlack | #272838        |
| foliageGreen | #64B746        |
| errorRed     | #D10000        |
| materialBlue | #448AFF        |
| cadetGrey    | #5D737E        |

This color palette is used with the following theme configuration:

| Property       | Light Mode   | Dark Mode    |
|----------------|--------------|--------------|
| `brightness`   | light        | dark         |
| `background`   | offWhite     | charadeBlack |
| `onBackground` | charadeBlack | offWhite     |
| `error`        | errorRed     | errorRed     |
| `onError`      | trueWhite    | trueWhite    |
| `primary`      | foliageGreen | foliageGreen |
| `onPrimary`    | trueWhite    | trueWhite    |
| `secondary`    | materialBlue | materialBlue |
| `onSecondary`  | trueWhite    | trueWhite    |
| `surface`      | foliageGreen | foliageGreen |
| `onSurface`    | trueWhite    | trueWhite    |
