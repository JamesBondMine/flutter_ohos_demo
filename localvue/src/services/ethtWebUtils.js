
import Web3 from 'web3';
import erc20_abi from "../assets/eth/ERC20niu.json";
// import erc20_abi from "../assets/eth/ERC20TEST.json";
// import erc20_abi from "../assets/eth/ERC20.json";
import Decimal from 'decimal.js';
// import { WalletBase } from "./base";
// import * as transitSwap from '@transitswap/js-sdk'

const tmp = {};

// const ChainIdToChain = {
//     1: 'ETH',
//     10: 'OP',
//     56: 'BSC',
//     66: 'OEC',
//     70: 'HSC',
//     128: 'HECO',
//     137: 'MATIC',
//     250: 'FTM',
//     321: 'KCC',
//     1030: 'CFX',
//     1284: 'GLMR',
//     8217: 'KLAY',
//     42161: 'ARB',
//     43114: 'AVAX',
//     95500: 'TRON',
// };

export default class EthWallet {
    nodeAddress = "";
    ethWeb3;
    ethObj;
    ethUtils;
    isChain;
    contractAddress;
    contractPrecision = 18;
    chain = "BSC"

    constructor(node) {
        const [nodeAddress] = node.split(';');
        let ethWeb3 = tmp[nodeAddress];
        // 缓存
        if (!ethWeb3) {
            ethWeb3 = new Web3(new Web3.providers.HttpProvider(nodeAddress));
            tmp[nodeAddress] = ethWeb3;
        }
        this.node = nodeAddress;
        this.ethWeb3 = ethWeb3;
        this.ethObj = this.ethWeb3.eth;
        this.ethUtils = this.ethWeb3.utils;
    }

    // 获取资产
    async getBalance(symbol, isChain, address, contractAddress) {
        
        this.ethWeb3 = new Web3(new Web3.providers.HttpProvider(this.nodeAddress));
        this.ethObj = this.ethWeb3.eth;
        this.ethUtils = this.ethWeb3.utils;
    
        try {
            if (isChain == "1") {
                const result = await this.ethObj.getBalance(address);
                const ethValue = this.ethUtils.fromWei(result, 'ether');
                return {"success": true,'address':address,'symbol': symbol,'contractAddress':contractAddress,'balance': ethValue};
            } else {
                let contract = new this.ethObj.Contract(erc20_abi.abi, contractAddress);
                let result = await contract.methods.balanceOf(address).call();
                const ethValue = new Decimal(result)
                    .div(Math.pow(10, this.contractPrecision || 18))
                    .toString();
                return {"success": true,'address':address,'symbol': symbol,'contractAddress':contractAddress,'balance': ethValue.length <= 0 ? "0.00" : ethValue};
            }
        } catch (ex) {
            console.log('获取余额失败:' + ex.message);
            return {"success": false,'address':address,'symbol': symbol,'contractAddress':contractAddress,'balance': "0.00"};
        }
    }

    // 检查授权
    async checkAllowed(contractAddress) {
        try {
            console.log('检查授权');
            
            let { address, ethObj } = this;
            
            let contract = new ethObj.Contract(erc20_abi.abi, contractAddress, {
                from: address,
            });
            let allowValue = await contract.methods.allowance(address, '0xC9E90F88932827c32065A5e0DdBF077e01CFA1Ac').call();
            console.log('检查授权结果');
            console.log(allowValue);
            return {needApprove : allowValue <= 0 , success: true}
        } catch (error) {
            console.log('检查授权异常');
            console.log(error);
            return {needApprove : true , success: false}
        }
    }

    async signOnlyCrossSwap(data) {
        return new Promise((resolve, reject) => {
            let { ethObj } = this;
            ethObj.sendSignedTransaction(data)
                .on('transactionHash', (v) => {
                    resolve(v);
                })
                .on('error', (error) => {
                    resolve('error' + error);
                    reject('false')
                });
        });

    }

    // 获取网络费
    async tradeNetworkFee(isChain,to, value, data, fromcontractAddress, aggregator,tocontractAddress,fromAddress,toAddress,fromcontract,route1,route) {
        try {
            let { address, ethObj, ethUtils, contractPrecision } = this;
            let nonce = await ethObj.getTransactionCount(address);
            console.log('*******构建交易*******');
            let params = {
                from: address,// 接受地址 此处指的是接受的 钱包地址不是合约地址
                to: aggregator,
                value: value,
                data: data,
                nonce,
            };
            console.log(isChain);
            if (isChain != "1") {
                console.log('*******非主币*******');
                let wei = value / Math.pow(10, contractPrecision || 18);
                let contract = new ethObj.Contract(erc20_abi.abi, route, {
                    from: this.address,
                });

  
            wei = ethUtils.toWei(String(wei.toFixed(18)), 'ether');

                params.data = contract.methods.transfer(toAddress, wei).encodeABI();
                params.to = tocontractAddress;
                params.value = 0;
            } else {
                console.log('*******主币*******');
                params.to = to;
                params.value = new Decimal(value)
                    .mul(Math.pow(1, 1))
                    .floor()
                    .toNumber();
            }
            let gas = await ethObj.estimateGas(params);
            //签名交易
            params.gas = ethUtils.numberToHex(gas);
             gas = Math.ceil(gas * 1).toString();
             let gasPrice = await ethObj.getGasPrice();
             let v = new Decimal(gas * 1).mul(gasPrice).floor().toString();
             console.log(v);
             let feevalue = ethUtils.fromWei(v, 'ether');
             console.log('*******获取交易费用成功*******');
             console.log(feevalue);
             return { 'success': true, fee: feevalue };
        } catch (error) {
            console.log('****失败1*****');
            console.log('' + error);
            return { 'message': '' + error.toString(), 'success': false }
        }

    }
    
    // 闪兑
    async signOnlySwap(to, value, data, aggregator) {
        console.log('[signApprove]');
        try {
            let { address, privateKey, ethObj, ethUtils, contractAddress } = this;
            console.log('*******获取交易数量*******');
            console.log('address', address);
            console.log('contractAddress', contractAddress);
            let nonce = await ethObj.getTransactionCount(address);
            console.log('*******构建交易*******');
            let params = {
                from: address,// 接受地址 此处指的是接受的 钱包地址不是合约地址
                to: aggregator,
                value: value,
                data: data,
                nonce,
            };
            console.log('params', params);
            let gas = await ethObj.estimateGas(params);

            console.log('gas',gas);
            //签名交易
            params.gas = ethUtils.numberToHex(gas);
            // params.to = to;
            console.log('params',params);
            //签名
            console.log('*******签名*******');
            let signed = await ethObj.accounts.signTransaction(params, privateKey);
            //广播
            let result = await this.sendTransaction(signed.rawTransaction);
            console.log(result);
            return { 'message': 'success', 'txid': result, 'success': true } ;
        } catch (error) {
            console.log('****失败1*****');
            console.log('' + error);
            return { 'message': '' + error.toString(), 'success': false }
        }
    }

    
    // 进行授权
    async getApproveX(contractAddress, transit, fromAddress, privateKey,value) {
        console.log('开始进行授权');
        console.log(value)
        try {
            let {ethObj } = this;
            let contract = new ethObj.Contract(erc20_abi.abi, contractAddress, {
                from: this.address,
            });
            let gasPrice = await ethObj.getGasPrice();
            let UINT_MAX_VALUE = '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';
            UINT_MAX_VALUE = '12000000000000000000'
            const gasLimit = await contract.methods.approve(transit, UINT_MAX_VALUE).estimateGas();
            const approveData = contract.methods.approve(transit, UINT_MAX_VALUE).encodeABI();
            let result;
            const nonce = await ethObj.getTransactionCount(fromAddress);
            const tx = {
                from: fromAddress,
                to: contractAddress,
                nonce: nonce,
                gasLimit: gasLimit,
                data: approveData,
              };
              const signedTx = await ethObj.accounts.signTransaction(tx, privateKey);
              result = await ethObj.sendSignedTransaction(signedTx.rawTransaction);
              console.log('授权 结果=======');
              console.log(result);
            let v = new Decimal(gasLimit * 1).mul(gasPrice).floor().toString();
            const fee = this.ethUtils.fromWei(v, 'ether');
            console.log('*******费用*******');
            return { 'message': 'success', 'fee': fee, 'success': true };
        } catch (error) {
            console.log('****授权失败*****');
            console.log('' + error);
            return { 'message': '' + error.toString(), 'success': false }
        }
    }

    // 交易
    async signApprove(contractAddress, transit, value) {
        console.log('[signApprove]');
        try {
            let { address, privateKey, ethObj, ethUtils } = this;
            let contract = new ethObj.Contract(erc20_abi.abi, contractAddress, {
                from: this.address,
            });
            console.log('*******获取交易信息*******');
            console.log('gasPrice');
            const UINT_MAX_VALUE = '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';
            const gasLimit = await contract.methods.approve(transit, UINT_MAX_VALUE).estimateGas();
            console.log(gasLimit);
            console.log('*******构建交易*******');
            let nonce = await ethObj.getTransactionCount(address);
            //签名交易
            const tx = {
                from: address,
                to: contractAddress,
                gas: ethUtils.numberToHex(gasLimit),
                value: value,
                nonce,
                data: contract.methods.approve(transit, UINT_MAX_VALUE).encodeABI(),
            };
            //签名
            console.log('*******签名*******');
            let signed = await ethObj.accounts.signTransaction(tx, privateKey);
            //广播
            let result = await this.sendTransaction(signed.rawTransaction);
            return result;

        } catch (error) {
            console.log('****失败1*****');
            console.log('' + error);
            return { 'message': '' + error.toString(), 'success': false }
        }
    }

    // 获取交易状态
    async getTransactionReceipt(txHash) {
        try {
            console.log('[getTransactionReceipt]');
            let { ethObj } = this;
            const result = await ethObj.getTransactionReceipt(txHash)
            return result;
        } catch (error) {
            console.log('*******5**12*****');
            console.log(error);
            return {}

        }
    }


    // 签名广播
    async crossSwap(value , data, router,faddress) {
        console.log('ETH:*********开始跨链交易*********');
        try {
            let { privateKey, ethObj, ethUtils } = this;
            let nonce = await ethObj.getTransactionCount(faddress);
            console.log(nonce);
            console.log('*******构建交易*******');
            let params = {
                from: faddress,// 接受地址 此处指的是接受的 钱包地址不是合约地址
                to: router,
                value: value,
                data: data,
                nonce,
            };
            console.log('params', params);
            let gas = await ethObj.estimateGas(params);

            console.log('gas',gas);
            params.gas = ethUtils.numberToHex(gas);
            //签名
            console.log('*******签名*******');
            // if (value != null) {
            //     return { msg: 'error','message': 'test', success: false };
            // }
            let signed = await ethObj.accounts.signTransaction(params, privateKey);
            //广播
            let result = await this.sendTransaction(signed.rawTransaction);
            console.log(result);
            return { 'message': 'success', 'txid': result, 'success': true } ;
        } catch (error) {
            console.log(' ETH*******跨链异常*******');
            console.log(error);
            return { msg: 'error' + error.toString(),'message': '' + error.toString(), success: false };
        }
    }

    async sendTransaction(hash) {
        return await this.getTransactionHash(hash);
    }


    getTransactionHash(rawTransaction) {
        return new Promise((resolve, reject) => {
            let { ethObj } = this;
            ethObj
                .sendSignedTransaction(rawTransaction)
                .on('transactionHash', (v) => {
                    resolve(v);
                })
                .on('error', (error) => {
                    resolve('error' + error);
                    reject('false')
                });
        });
    }
    
    // 转账
    async send(toAddress, amount, type, tocontractAddress, contractPrecision) {
        console.log('*******开始转账*******');
        try {
            let { address, privateKey, ethObj, ethUtils } = this;
            let params = { from: address };
            
            if (type != 'chain') {
                console.log('*******非主币*******');
                console.log(amount);
                let contract = new ethObj.Contract(erc20_abi.abi, tocontractAddress, {
                    from: this.address,
                });
                console.log(amount);
                let wei = ethUtils.toWei(String(amount), 'ether');
                if (contractPrecision == 6) {
                    wei = amount * Math.pow(10, contractPrecision);
                }
                // let amountnew = amount / Math.pow(10, contractPrecision || 18);
                // console.log(amountnew);
                // console.log(amountnew.toFixed(18));
                // wei = ethUtils.toWei(String(amountnew.toFixed(18)), 'ether');
                // console.log(wei);
                // if (amount!=0) {
                //     console.log(privateKey);
                //     return;
                // }
                console.log('*******非主币**1*****');
                console.log(wei);
                params.data = contract.methods.transfer(toAddress, wei).encodeABI();
                params.to = tocontractAddress;
                params.value = 0;
                // console.log('*******非主币***2****');
            } else {
                // console.log('*******主币***4****');
                let wei = ethUtils.toWei(String(amount), 'ether');
                params.to = toAddress;
                params.value = new Decimal(amount)
                    .mul(Math.pow(10, this.contractPrecision || 18))
                    .floor()
                    .toNumber();
                console.log(`start send value:${wei}(wei)`, params);
            }
            // 进行交易签名
            // 获取gaslimit 以及检查是否
            let gas = await ethObj.estimateGas(params);
            var num = Math.floor(Math.random()*5000+4000);
            gas = gas + num;
            // GAS必须是整数
            gas = Math.ceil(gas * 1).toString();
            params.gas = ethUtils.numberToHex(gas);
            let nonce = await ethObj.getTransactionCount(params.from);
            params.nonce = nonce;
            console.log('*******签名*******');
            let signed = await ethObj.accounts.signTransaction(params, privateKey);
            const result = await this.sendTransaction(signed.rawTransaction);
            console.log('[转账成功]:', result);
            return {'txid': result, 'success': true};
        } catch (err) {
            console.log('*******转账失败*******');
            console.log(err);
            return {'txid': ' ' + err, 'success': false};
        }
    }

    // 获取转账矿工费
    async getFee(toAddress, amount, type, tocontractAddress) {
        console.log('[getFee]');
        if (type == "approve") {
            // ************************** 以下是授权费用   **************************************
            let {ethObj,address } = this;
            let contract = new ethObj.Contract(erc20_abi.abi, tocontractAddress, {
                from: address,
            });
            let gasPrice = await ethObj.getGasPrice();
            const UINT_MAX_VALUE = '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';
            const gasLimit = await contract.methods.approve(toAddress, UINT_MAX_VALUE).estimateGas();
            let params = { from: address };
            let {ethUtils } = this;
            let wei = ethUtils.toWei(String(amount), 'ether');
            let amountnew = amount / Math.pow(10, this.contractPrecision || 18);
            wei = ethUtils.toWei(String(amountnew.toFixed(18)), 'ether');
            params.data = contract.methods.transfer(toAddress, wei).encodeABI();
            params.to = tocontractAddress;

            let gas = await ethObj.estimateGas(params);
            gas = Math.ceil(gas * 1).toString();
            let v1 = new Decimal(gas * 1).mul(gasPrice).floor().toString();
            const fee1 = this.ethUtils.fromWei(v1, 'ether');
            let v = new Decimal(gasLimit * 1).mul(gasPrice).floor().toString();
            const fee = this.ethUtils.fromWei(v, 'ether');
            let valuefee = parseFloat(fee) + parseFloat(fee1);        
            return { 'success': true, fee: valuefee.toString()};
        } else {
            try {
                // ************************** 以下是转账费用   **************************************
                let { address, ethObj, ethUtils } = this;
                let wei = ethUtils.toWei(String(amount), 'ether');
                let params = { from: address };
                if (type != 'chain') {
                    console.log('*******非主币*******');
                    let amountnew = amount / Math.pow(10, this.contractPrecision || 18);
                    wei = ethUtils.toWei(String(amountnew.toFixed(18)), 'ether');
                    let contract = new ethObj.Contract(erc20_abi.abi, tocontractAddress, {
                        from: this.address,
                    });
                    params.data = contract.methods.transfer(toAddress, wei).encodeABI();
                    params.to = tocontractAddress;
                    params.value = 0;
                } else {
                    console.log('*******主币*******');
                    params.value = new Decimal(amount)
                        .mul(Math.pow(10, this.contractPrecision || 18))
                        .floor()
                        .toNumber();
                    console.log(`start send value:${wei}(wei)`, params);
                }
    
                // let baseGas = 21000;
                let gas = await ethObj.estimateGas(params);
                // gas = gas * 1;
                gas = Math.ceil(gas * 1).toString();
                let gasPrice = await ethObj.getGasPrice();
                let v = new Decimal(gas * 1).mul(gasPrice).floor().toString();
                let feevalue = ethUtils.fromWei(v, 'ether');
                console.log('*******获取交易费用成功*******');
                return { 'success': true, fee: feevalue };
            } catch (err) {
                console.log('*******获取费用失败*******');
                console.log(err);
                return {'fee': 0, 'success': false};
            }
        }
    }

}