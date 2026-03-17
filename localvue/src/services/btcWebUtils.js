// import * as bitcoin from 'bitcoinjs-lib';
// import * as bitcoin from '@pefish/bch-bitcoinjs-lib';
import * as bitcoin from 'bitcoinjs-lib';
import Decimal from 'decimal.js';
import { nowNodeRequest, get, requestBtc } from "./request";
import * as bip39 from 'bip39';
import * as bip32 from 'bip32';


export default class BTCWallet {
    node = '';
    address = '';
    privateKey = '';
    test = false;
    chain = 'BTC';
    addressType = 'P2WPKH';
    baseUrl = 'https://blockchain.info/balance?active=';
    baseTestUrl = 'https://blockchain.info/test/balance?active=';
    baseInfoUrl = 'https://blockchain.info/rawaddr/';
    // 比特币节点的RPC配置
    rpcUsername = 'rpc_username'; // 节点 RPC 用户名
    rpcPassword = 'rpc_password'; // 节点 RPC 密码
    rpcUrl = 'http://127.0.0.1:8332'; // 节点 RPC 地址
    // https://blockchain.info/rawaddr/1MAHFyFrmTYoJhX64sk1gDykB96dvL4MSU - 查询地址相关信息，返回 json 格式数据。
    constructor(node) {
        this.node = node;
    }


    static getNetwork() {
        
        console.log('----1---a-');
        console.log(this.chain);
        if (this.chain === 'BTC') {
            console.log('----1--s--');
            console.log(bitcoin);
            console.log(bitcoin.networks);
            console.log(bitcoin.networks.bitcoin);
            return bitcoin.networks.bitcoin;
        } else if (this.chain === 'BTCTest') {
            return bitcoin.networks.testnet;
        }
    }

    getNetwork() {
        if (this.chain === 'BTC') {
            return bitcoin.networks.bitcoin;
        } else if (this.chain === 'BTCTest') {
            return bitcoin.networks.testnet;
        }
    }

    async getAddressWithPrivateKey( wif, series ) {
        try {
            console.log(series);
            const network = this.getNetwork();
            if (series == 'BTCTest') {
                const seed = await bip39.mnemonicToSeed(wif);
                const root = bip32.fromSeed(seed, network);
                wif = root.derivePath(`m/44'/1'/0'/0/0`).toWIF();
            }
            const keyPair = bitcoin.ECPair.fromWIF(wif, network);
            console.log('BTC获取网络*******b****2***');
            // 普通地址
            const address_P2PKH = this.generateAddress('P2PKH', keyPair);
            console.log('BTC获取网络*******b***3****');
            // 隔离见证地址
            const witness_P2WPKH = this.generateAddress('P2WPKH', keyPair);
            console.log('BTC获取网络*******b****4***');
            const address = this.addressType === 'P2WPKH' ? witness_P2WPKH : address_P2PKH;
            console.log('BTC获取网络*******b****5***');
            return { "success": true,'address': address, 'addressp2pkh': address_P2PKH, 'addressp2wpkh': witness_P2WPKH};
        } catch (error) {
            console.log(error);
            return {"success": false};
        }
    }

    // 生成地址
    generateAddress(type, keyPair) {
        try {
            let address;
            let network = this.getNetwork();
            if (type === 'P2WPKH') {
                console.log('----1----');
                console.log(network);
                const redeem = bitcoin.payments.p2wpkh({
                    pubkey: keyPair.publicKey,
                    network,
                });
                console.log('-----2---');
                const p2wpkh = bitcoin.payments.p2sh({ redeem, network });
                console.log(p2wpkh);
                console.log('-----3---');
                address = p2wpkh.address;
            } else {
                const p2pkh = bitcoin.payments.p2pkh({
                    pubkey: keyPair.publicKey,
                    network,
                });
                address = p2pkh.address;
            }

            return address;
        } catch (err) {
            console.error(err);
            return 'error';
        }
    }

    // 获取Bitcoin 某个地址资产
    async getBalanceX(symbol, btcAddress, chain) {
        try {
            delay(500);
            const url = `/api/v2/address/${btcAddress}`;
            const result = await nowNodeRequest(chain, url);
            console.log('BTC获取余额*********0**********');
            console.log(result);
            const balance = new Decimal(result.balance).add(result.unconfirmedBalance).toString();
            return new Decimal(balance).div(Math.pow(10, 8)).toString();
        } catch (ex) {
            console.log(ex);
            console.error('>>>> get btc balance error');
            return '0.00';
        }
    }

    // 获取Bitcoin 某个地址资产 
    async getBalance(symbol, btcAddress, chain) {
        try {
            console.log('BTC获取余额*********0**********');
            console.log(btcAddress);
            console.log(chain);
            console.log('BTC获取余额*********1**********');
            const explorers = require('bitcore-explorers');
            console.log('BTC获取余额*********2**********');
            const bitcore = require('bitcore-explorers/node_modules/bitcore-lib');
            console.log('BTC获取余额*********3**********');
            // BlockHeader
            console.log(explorers);
            console.log(bitcore);
            const insight = new explorers.Insight('https://insight.bitpay.com');
            bitcore.BlockHeader = {'Access-Control-Allow-Origin': '*'};
            let address = bitcore.Address(btcAddress);
            insight.getUnspentUtxos(address, (err, utxos) => {
            if (err) return console.log(err);

            const balance = utxos.reduce((total, utxo) => {
                return total + utxo.satoshis;
            }, 0) / 1e8;

            console.log(`Balance of ${btcAddress}: ${balance} BTC`);
            });


            let res = await get( this.baseInfoUrl + '1MAHFyFrmTYoJhX64sk1gDykB96dvL4MSU');
            // 返回结果是一个Map
            if (res == null || res == undefined) return '0.00';
            let cobject = res[btcAddress];
            if (cobject == null || cobject == undefined) return '0.00';
            let balance = cobject['final_balance'];
            const btcValue = new Decimal(balance)
                    .div(Math.pow(10, this.contractPrecision || 18))
                    .toString();
            return btcValue.length <= 0 ? "0.00" : btcValue;
        } catch (ex) {
            console.log(ex);
            console.error('>>>> get btc balance error');
            return '0.00';
        }
    }

    /**
     *
     * @param {*} recipientAddress 接收地址
     * @param {*} recipientAmount  接收金额
     * @param {*} fee  fee = 50000; // 指定的交易手续费用
     * @memberof BTCWallet
     */
    async sendX(recipientAddress, recipientAmount, fee){
        try {
            const senderAddress = 'your sender address';  // 发送方比特币地址
            const senderPrivateKey = 'your_sender_address_private_key';  // 发送方比特币私钥，WIF格式
            const utxos = await this.getUTXO(senderAddress);
            console.log(utxos);
            const rawTx = await this.createAndSignTx(senderAddress, senderPrivateKey, recipientAddress, recipientAmount, fee, utxos);
            console.log(`Raw transaction: ${rawTx.txHex}`);
            const txHash = await this.broadcastTx(rawTx.txHex);
            console.log(`Transaction Broadcasted! Hash:${txHash}`);
        } catch (error) {
            console.error(`Failed to complete transaction:[${error}]`);
        }

    }

    // 构造交易并签名
    async createAndSignTx(senderAddress, senderPrivateKey, recipientAddress, recipientAmount, fee, utxos) {
        const network = bitcoin.networks.bitcoin;
        const txBuilder = new bitcoin.TransactionBuilder(network);
        let totalInput = 0;

        // 添加 UTXO 作为交易的输入
        for (let i = 0; i < utxos.length; i++) {
            txBuilder.addInput(utxos[i].txid, utxos[i].vout);
            totalInput += utxos[i].amount;
        }

        // 添加输出作为交易的输出，实际的值要扣除交易手续费
        txBuilder.addOutput(recipientAddress, recipientAmount);
        const changeValue = parseInt(totalInput - recipientAmount - fee);
        if (changeValue <= 0) {
            throw new Error("Not enough funds for the transaction handling fee");
        }
        txBuilder.addOutput(senderAddress, changeValue);

        // 对交易输入进行签名
        for (let i = 0; i < utxos.length; i++) {
            txBuilder.sign(i, bitcoin.ECPair.fromWIF(senderPrivateKey), undefined, bitcoin.Transaction.SIGHASH_ALL, utxos[i].amount);
        }
        const tx = txBuilder.build();

        return {
            txHex: tx.toHex(),
            txId: tx.getId()
        };
    }

    // 广播交易到比特币网络
    async broadcastTx(rawTransaction) {
        return new Promise((resolve, reject) => {
            const requestOptions = {
                url: 'rpcUrl',
                method: 'POST',
                auth: {
                    user: 'rpcUsername',
                    pass: 'rpcPassword'
                },
                json: true,
                body: {
                    jsonrpc: '2.0',
                    id: 'broadcastTx',
                    method: 'sendrawtransaction',
                    params: [rawTransaction]
                }
            };

            requestBtc(requestOptions, (error, response, body) => {
                if (error) {
                    reject(error);
                } else {
                    resolve(body.result);
                }
            });
        });
    }


    // 获取发送交易所需的 UTXO
    async getUTXO(senderAddress) {
        return new Promise((resolve, reject) => {
            const requestOptions = {
                url: 'rpcUrl',
                method: 'POST',
                auth: {
                    user: 'rpcUsername',
                    pass: 'rpcPassword'
                },
                json: true,
                body: {
                    jsonrpc: '2.0',
                    id: 'getUTXO',
                    method: 'listunspent',
                    params: [0, 100, [senderAddress]]
                }
            };

            requestBtc(requestOptions, (error, response, body) => {
                if (error) {
                    reject(error);
                } else {
                    resolve(body.result);
                }
            });
        });
    }




    async getUtxolist(address) {
        try {
            console.log(address);
            const url = `/api/v2/utxo/${address}`;
            const result = await nowNodeRequest(this.chain, url);
            return result.map((tx) => {
                return { value: Number(tx.value), tx_hash: tx.txid, tx_pos: tx.vout };
            });
        } catch (ex) {
            console.error(ex);
            throw ex;
        }
    }

    async send(to, value, options = { send: true }) {
        console.log('转账 - BTC');
        let singed = await this.signTransaction(to, 'P2PKH', Number(value), 1, options);
        if (!options.send) return singed;
        await delay(1000);
        const url = `/api/v2/sendtx/${singed.transaction}`;
        const result = await nowNodeRequest(this.chain, url);
        if (result.result) {
            return result.result;
        } else {
            console.error('>>>> send btc fail');
            throw new Error('send fail');
        }
    }


    // // 签名交易
    async signTransaction(
        to,
        addressType,
        sendAmount,
        sat = 1,
        options = { send: true }
    ) {
        try {
            let { privateKey, address } = this;
            let network = this.getNetwork();
            let txs = await this.getUtxolist(address);
            console.log('txs', txs);
            if (txs == null || address == undefined) {
                throw 'UTXO获取失败！';
            }
            let inputCount = txs.length;
            let inputArr = [];
            let amount = 0;
            if (inputCount <= 0) {
                throw new Error('insufficient funds');
            }
            console.log(`整理输入信息:`);
            // 整理输入信息
            for (let x = 0; x < inputCount; x++) {
                amount += txs[x].value;
                let it = {
                    txid: txs[x].tx_hash,
                    vout: txs[x].tx_pos,
                    value: txs[x].value,
                };
                inputArr.push(it);
            }
            // 计算手续费以及发送金额
            let fee = (inputCount * 180 + 2 * 34 + 10 + 40) * sat;
            // 如果不发送，只返回费用
            if (!options.send) return { fee: new Decimal(fee).div(100000000).toNumber() };
            sendAmount = new Decimal(sendAmount).mul(100000000).toNumber();
            console.log(`转账金额:${sendAmount}`);
            console.log(`输入总金额:${amount}`);
            console.log(`手续费:${fee}`);
            const keyPair = bitcoin.ECPair.fromWIF(privateKey, network);
            // 构建交易对象
            const RawTransaction = new bitcoin.TransactionBuilder(network);
            inputArr.forEach((item, i) => {
                console.log(`输入UTXO_${i + 1}:${item.txid} => ${item.value}`);
                RawTransaction.addInput(item.txid, item.vout);
            });
            RawTransaction.addOutput(to, sendAmount);
            RawTransaction.addOutput(address, amount - sendAmount - fee);

            // 对交易签名
            if (addressType == 'P2PKH') {
                //p2pkp 普通地址 签名
                inputArr.forEach((item, index) => {
                    RawTransaction.sign(index, keyPair);
                });
            } else if (addressType == 'P2WPKH') {
                let p2sh = bitcoin.payments.p2sh({
                    redeem: bitcoin.payments.p2wpkh({
                        pubkey: keyPair.publicKey,
                        network,
                    }),
                    network,
                });
                inputArr.forEach((item, index) => {
                    RawTransaction.sign(
                        index,
                        keyPair,
                        p2sh.redeem?.output,
                        undefined,
                        parseInt(item.value)
                    );
                });
            } else {
                throw 'address error';
            }

            const transaction = RawTransaction.build().toHex();
            console.log('交易签名:' + transaction);

            return { transaction, fee };
        } catch (err) {
            // show error
            console.error(err);
            throw err;
        }
    }

}

export function delay(time = 100) {
    return new Promise((resolve, reject) => {
        console.log(reject);
        setTimeout(resolve, time || 100);
    });
}