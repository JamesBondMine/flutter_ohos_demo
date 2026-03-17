
import cosmosclient from '@cosmos-client/core';


const cosmos_prefix = {
    COSMOS: 'cosmos',
    KAVA: 'kava',
    LUNA: 'terra',
};


const cosmos_host = {
    COSMOS: {
        denom: 'uatom',
        main: {
            URL: 'https://api.cosmos.network',
            chainID: 'cosmoshub-4',
        },
        test: {
            URL: 'https://rpc-theta.interchain.io',
            chainID: 'theta-testnet-001',
        },
    },
    KAVA: {
        denom: 'kava',
        main: {
            URL: 'https://api.data.kava.io',
            chainID: 'kava-9',
        },
        test: {
            URL: 'https://api.testnet.kava.io',
            chainID: 'kava-testnet-14000',
        },
    },
    LUNA: {
        denom: 'uluna',
        main: {
            URL: 'https://pisco-lcd.terra.dev',
            chainID: 'pisco-1',
        },
        test: {
            URL: 'https://phoenix-lcd.terra.dev',
            chainID: 'phoenix-1',
        },
    },
    // LUNC: {
    //     denom: 'uluna',
    //     main: {
    //         URL: 'https://pisco-lcd.terra.dev',
    //         chainID: 'pisco-1',
    //     },
    //     test: {
    //         URL: 'https://phoenix-lcd.terra.dev',
    //         chainID: 'phoenix-1',
    //     },
    // },
};

export default class COSMOSWallet {
    chainId = '';
    node = '';
    sdk;
    address = '';
    contractAddress = '';
    privateKey = '';
    chain = '';
    host;
    denom = '';
    prefix = '';

    constructor(node) {
        const [nodeAddress] = node.split(';');
        // console.log('[节点地址]', nodeAddress);
        this.node = nodeAddress;
        this.loadChain();
    }

    loadChain(chain = 'COSMOS') {
        this.chain = chain;
        this.prefix = cosmos_prefix[this.chain];
        this.setPrefix();
        this.host = cosmos_host[this.chain].main;
        this.denom = cosmos_host[this.chain].denom;
        console.log(cosmos_host[this.chain]);
        this.sdk = new cosmosclient.CosmosSDK(this.host.URL, this.host.chainID);
    }

    setPrefix() {
        const addressPrefix = {
            Cosmos: this.prefix,
            Public: 'pub',
            Account: 'acc',
            Validator: 'val',
            Operator: 'oper',
            Consensus: 'cons',
        };
        const bech32Prefix = {
            accAddr: addressPrefix.Cosmos,
            accPub: addressPrefix.Cosmos + addressPrefix.Public,
            valAddr: addressPrefix.Cosmos + addressPrefix.Validator + addressPrefix.Operator,
            valPub:
                addressPrefix.Cosmos +
                addressPrefix.Validator +
                addressPrefix.Operator +
                addressPrefix.Public,
            consAddr: addressPrefix.Cosmos + addressPrefix.Validator + addressPrefix.Consensus,
            consPub:
                addressPrefix.Cosmos +
                addressPrefix.Validator +
                addressPrefix.Consensus +
                addressPrefix.Public,
        };
        cosmosclient.config.setBech32Prefix(bech32Prefix);
    }

    // 创建钱包
    async createSeed(index = 0, mnemonic = '') {
        const path = this.chooseBipSeed(index);
        const privateKey = await cosmosclient.generatePrivKeyFromMnemonic(mnemonic);
        const privKey = new cosmosclient.proto.cosmos.crypto.secp256k1.PrivKey({
            key: privateKey,
        });
        const pubKey = privKey.pubKey();
        const address = cosmosclient.AccAddress.fromPublicKey(pubKey);
        return {
            address: address.toString(),
            privateKey: Buffer.from(privateKey.buffer).toString('hex'),
            bip: path,
        };
    }

    static chooseBipSeed(count) {
        const path = `m/44'/118'/0'/0/${count}`;
        return path;
    }

    async getAddressWithMemonic(index = 0, mnemonic = '') {
        try {
            console.log("----COSMOS助记词换取address----");
            const path = COSMOSWallet.chooseBipSeed(index);
            const privateKey = await cosmosclient.generatePrivKeyFromMnemonic(mnemonic);
            const privKey = new cosmosclient.proto.cosmos.crypto.secp256k1.PrivKey({
                key: privateKey,
            });
            const pubKey = privKey.pubKey();
            const address = cosmosclient.AccAddress.fromPublicKey(pubKey);
            let bf = Buffer.from(privateKey.buffer).toString('hex');
            
            return {
                'address': address.toString(),
                "success": true,
                'privateKey': bf,
                'bip': path,
            };
        } catch (error) {
            return { 'address': '', "success": false, 'privateKey': '', 'bip': ''};   
        }
    }

    

    // 获取资产
    async getBalance(symbol) {
        try {
            const accAddress = cosmosclient.AccAddress.fromString(this.address);
        const response = await cosmosclient.rest.bank.allBalances(this.sdk, accAddress);
        const balances =
            response.data.balances?.reduce(
                (acc, { amount, denom }) =>
                    !!amount && !!denom
                        ? [
                              ...acc,
                              new cosmosclient.proto.cosmos.base.v1beta1.Coin({ amount, denom }),
                          ]
                        : acc,
                []
            ) || [];
        const balance = balances.find((item) => item.denom === symbol);
        // return balance == undefined ? '0' : balance.amount;
        return {"success": true,'symbol': symbol,'balance': balance == undefined ? '0' : balance.amount};
            
        } catch (error) {
            return {"success": false,'symbol': symbol,'balance': "0.00"};
        }
    }

}