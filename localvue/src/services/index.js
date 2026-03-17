

import TronWallet from '../services/tronWebUtils'
import EthWallet from '../services/ethtWebUtils'
import BTCWallet from './btcWebUtils'
import COSMOSWallet from './cosmos'
// import * as TronWeb from 'tronweb'
import * as transitSwap from '@transitswap/js-sdk'
// import { requestCrossSwap } from "./request";
import Decimal from 'decimal.js';

// 传递API Key
export function chainApiKeys(data) {
    console.log('传递API Key:', data);
    localStorage.setItem('chainApiKey', data)
}

// 生成账号
export function createAccount(privateKey, series, index, mnemonic) {
    console.log('生成账号:', series)
    console.log(privateKey);
    console.log(index);
    console.log(mnemonic);
    try {
        if (series == "BTC" || series == "BTCTest") {
            const instance = new BTCWallet();
            instance.chain = series;
            instance.addressType = 'P2PKH';
            let res = instance.getAddressWithPrivateKey(privateKey, series);
            console.log('获取地址res: ', res)
            return res;
        }
        if (series == "TRX") {
            let instance = new TronWallet('https://api.trongrid.io');
            let res = instance.getAddressWithPrivateKeyWithHex(privateKey);
            console.log('获取TRX地址res: ', res)
            return res;
        }
        if (series == "COSMOS") {
            let instance = new COSMOSWallet('');
            instance.privateKey = privateKey;
            let res = instance.getAddressWithMemonic(index, mnemonic);
            console.log('获取地址res: ', res)
            return res;
        }
    } catch (error) {
        console.log('error: ', error)
        return { "message": error.toString };
    }

}

// 获取余额
export async function balanceEvent(series, privateKey, symbol, node, chain, isChain, address, contractAddress, isfrom, contractPrecision) {
    if (series == "BTC") {
        const instance = new BTCWallet(node + ';');
        let bs = await instance.getBalanceX(symbol, address, chain);
        return bs;
    }
    if (series == "TRX") {
        if (symbol == 'TRX') {
            address = TronWallet.getAddressWithPrivateKey(privateKey)
        }
        let instance
        instance = new TronWallet(node, privateKey)
        instance.chain = chain
        instance.address = address
        instance.privateKey = privateKey
        instance.contractAddress = contractAddress
        instance.contractPrecision = contractPrecision
        let bs = await instance.getBalance(node, symbol, symbol == 'TRX' ? address.address : address, contractAddress)
        return bs;
    }
    if (series == "ETH") {
        let nodenew = node;
        const instance = new EthWallet(nodenew + ';')
        instance.nodeAddress = nodenew
        instance.chain = chain;
        instance.address = address;
        instance.contractAddress = contractAddress;
        instance.contractPrecision = contractPrecision;
        let bs = await instance.getBalance(
            symbol,
            isChain,
            address,
            contractAddress,
        )
        return bs
    }
    if (series == "COSMOS") {
        const instance = new COSMOSWallet(node);
        instance.loadChain(chain);
        instance.address = address;
        instance.contractAddress = contractAddress;
        instance.privateKey = privateKey;
        let bs = await instance.getBalance(
            symbol,
            isChain,
            address,
            contractAddress,
        )
        return bs
    }

    COSMOSWallet

}



// 授权检查
export async function checkAllowed(node, chain, walletData) {
    const contract = await getApproveAddress(chain);
    let instance;
    if (chain === 'ETH' || chain === 'BSC' || chain === 'GOERLIETH') {
        instance = new EthWallet(node + ';')
        instance.nodeAddress = node
        instance.chain = chain;
        instance.address = walletData.address;
        instance.privateKey = walletData.privateKey;
        instance.contractAddress = walletData.contractAddress;
        instance.contractPrecision = walletData.contractPrecision;
        const needApprove = await instance.checkAllowed(walletData.contractAddress)
        console.log('checkAllowed', needApprove)
        return needApprove;
    } else console.log(chain);
    if (chain === 'TRX') {
        instance = new TronWallet(node);
        instance.chain = chain;
        instance.address = walletData.address;
        instance.privateKey = walletData.privateKey;
        instance.contractAddress = walletData.address;
        instance.contractPrecision = walletData.contractPrecision;
        const needApprove = await instance.checkAllowed(walletData.contractAddress, contract);
        return needApprove;
    } else {
        throw new Error('not support');
    }
}

// 获得授权
export async function getApprove(node, chain, walletData, contractAddress, value, exchangeModel, aggregator) {
    let instance;
    if (chain === 'ETH' || chain === 'BSC' || chain === 'GOERLIETH') {
        // const contract = await getApproveAddress(chain);
        instance = new EthWallet(node);
        instance.chain = chain;
        instance.address = walletData.address;
        instance.privateKey = walletData.privateKey;
        instance.contractAddress = walletData.address;
        instance.contractPrecision = walletData.contractPrecision;
        const approve = await instance.getApproveX(contractAddress, contractAddress, walletData.address, walletData.privateKey,value);
        return approve;
    } else if (chain === 'TRX') {
        const contract = await getApproveAddress(chain);
        instance = new TronWallet(node);
        instance.chain = chain;
        instance.address = walletData.address;
        instance.privateKey = walletData.privateKey;
        instance.contractAddress = walletData.address;
        instance.contractPrecision = walletData.contractPrecision;
        // const checkAllowed = await instance.getApprove(walletData.contractAddress, value, exchangeModel);
        console.log(value);
        console.log(exchangeModel);
        const checkAllowed = await instance.getApproveX(aggregator, walletData.contractAddress, contract, value, walletData.privateKey);
        return checkAllowed;
    }  else {
        throw new Error('not support');
    }
}

// 计算网络费用
export async function getNetWorkFee(node, chain, fromAddress,toAddress,value,privateKey) {
    let instance;
    if (chain === 'ETH' || chain === 'BSC' || chain === 'GOERLIETH') {
        // const contract = await getApproveAddress(chain);
        // instance = new EthWallet(node);
        // instance.chain = chain;
        // instance.address = walletData.address;
        // instance.privateKey = walletData.privateKey;
        // instance.contractAddress = walletData.address;
        // instance.contractPrecision = walletData.contractPrecision;
        // const approve = await instance.getApproveX(contractAddress, contractAddress, walletData.address, walletData.privateKey,value);
        // return approve;
    } else if (chain === 'TRX') {
        instance = new TronWallet(node);
        instance.chain = chain;
        instance.address = fromAddress;
        instance.privateKey = privateKey;
        const checkAllowed = await instance.calculateFee(fromAddress,toAddress,value);
        return checkAllowed;
    }  else {
        throw new Error('not support');
    }
}


// swap
export async function signOnlySwap(series,chain,node,address,privateKey,contract,fun, options, parameter, issuer,from,to,value,data) {
    let instance;
    if (series == 'TRON' || series == 'TRX') {
        // const contract = await getApproveAddress(chain);
        instance = new TronWallet(node);
        instance.chain = chain;
        instance.address = address;
        instance.privateKey = privateKey;
        instance.contractAddress = address;
        return instance.signOnlySwap(contract,fun, options, parameter, issuer);
    } else if (series == 'ETH') {
        // const contract = await getApproveAddress(chain);
        instance = new EthWallet(node);
        instance.chain = chain;
        instance.address = address;
        instance.privateKey = privateKey;
        instance.contractAddress = from;
        instance.contractPrecision = 18
        let resultApprove = await instance.signOnlySwap(to,value, data, issuer);
        return resultApprove;
    }

}

// 进行授权
export async function signApprove(series, node, chain, walletData, fromcontractAddress, value,exchangeModel) {
    console.log('signApprove');
    let instance;
    console.log(exchangeModel);
    if (series === 'ETH' || series === 'BSC') {
        const contract = await getApproveAddress(chain);
        instance = new EthWallet(node);
        instance.chain = chain;
        instance.address = walletData.address;
        instance.privateKey = walletData.privateKey;
        instance.contractAddress = walletData.address;
        instance.contractPrecision = walletData.contractPrecision;
        let resultApprove = await instance.signApprove(true, fromcontractAddress, contract, value);
        let receipt = await instance.getTransactionReceipt("0x9fc76417374aa880d4449a1f7f31ec597f00b1f6f3dd2d66f4c9c6c445836d8b");
        console.log('walletData');
        console.log(receipt);
        return resultApprove;
    } else if (series == 'TRON' || series == 'TRX') {
        const contract = await getApproveAddress(chain);
        instance = new TronWallet(node);
        instance.chain = chain;
        instance.address = walletData.address;
        instance.privateKey = walletData.privateKey;
        instance.contractAddress = walletData.address;
        instance.contractPrecision = walletData.contractPrecision;
        // return instance.signOnlySwap(contract,fun, options, parameter, issuer);
        return await instance.signApprove(true, fromcontractAddress, contract, value, walletData.toCAddress, exchangeModel);
    } else if (series == 'BTC') {
        const contract = await getApproveAddress(chain);
        instance = new BTCWallet(node);
        instance.chain = chain;
        instance.address = walletData.address;
        instance.privateKey = walletData.privateKey;
        instance.contractAddress = walletData.contractAddress;
        instance.contractPrecision = walletData.contractPrecision;
        return await instance.signApprove(true, fromcontractAddress, contract, value);
    }

}

// 获取合约地址
export async function getApproveAddress(chain) {
    const ApproveAddress = {
        ETH: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        OP: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        BSC: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        OEC: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        HECO: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        MATIC: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        FTM: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        KCC: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        KLAY: '0x5e6B23f33E1a6653B1DD7aDfE89996028b3aFee6',
        AVAX: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        CFX: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        GLMR: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        ARB: '0xb45A2DDA996C32E93B8c47098E90Ed0E7ab18E39',
        TRON: 'TKqQ7zuL7yKp1NWuhGpoXTDiE3j2qiAbRE',
        TRX: 'TKqQ7zuL7yKp1NWuhGpoXTDiE3j2qiAbRE',
    };
    return ApproveAddress[chain];

}

// 获取跨链ID
export async function getCrossChainID(chain) {
    const CrossChainID = {
        'AVAX': '43114',
        'KCC': '321',
        'BSC': '56',
        'ETH': '1',
        'HECO': '128',
        'MATIC': '137',
        'OkExchain': '66',
        'Fantom': '250',
        'TRON': '95500',
        'TRX': '95500'
    };
    return CrossChainID[chain];

}

// 查询跨链限制
export async function quoteCrossTransferLimit(token0, token1, fchain, tochain) {

    const data = {
        token0: token0,
        token1: token1,
        fromChainID: await getCrossChainID(fchain),
        toChainID: await getCrossChainID(tochain),
        bridge: "METAPATH"
    }
    const res = await transitSwap.swapV1.quoteCrossTransferLimit(data)
    if (res.isSuccess) {
        const min = new Decimal(res.getMinimumSwap())
            .div(Math.pow(10, 18))
        const max = new Decimal(res.getMaximumSwap())
            .div(Math.pow(10, 18))
            .toString();
        var mv = min.toFixed(5);
        return { 'min': mv, 'max': max, 'success': true };
    } else {
        console.log("query failure:", res.msg)
        return res;
    }
}

// 获取交易网费
export async function tradeNetworkFee(isChain,series,chain,node,fromAddress,privateKey,toContract,fun, options, parameter, issuer,from,to,value,data,toAddress) {
    console.log('*********同链交易网费*********');
    let instance;
    let result;
    // 处理逻辑按照from来处理
    if (series == "ETH") {
        instance = new EthWallet(node)
        instance.chain = chain
        instance.address = fromAddress
        instance.privateKey = privateKey
        instance.contractAddress = toContract
        instance.contractPrecision = 18
        result = await instance.tradeNetworkFee(isChain,issuer,value, data, parameter, issuer,to,from,toAddress,fun,issuer);
    } else if (series == "TRX") {
        instance = new TronWallet(node);
        instance.chain = chain;
        instance.address = fromAddress;
        instance.privateKey = privateKey;
        instance.contractAddress = fromAddress;
        result = await instance.tradeNetworkFee(toContract,fun, options, parameter, issuer,from,to,value);
    }
    try {
        return result;
    } catch (ex) {
        console.log('>>> get tron fail:' + ex);
        throw ex;
    }
}



// 跨链交易
/*********
 * tow: "The recipient wallet",
 * fromw: "The signer wallet"
 * fromPrivateKey: "The recipient PrivateKey",
 * toPrivateKey: "The signer PrivateKey"
 */
export async function crossSwap(fromSeries,fchain,fnode,faddress,fprivateKey, toChain, fcontract, tocontract, toAddress, router, value, data,fun, options, parameter, issuer) {
    // 处理TRON的address

    console.log('crossSwap');
    console.log(tocontract);
    console.log(toAddress);
    // let toAddress = '';
    console.log('*********跨链开始组合信息*********');
    let instance;
    let result;
    console.log('*********跨链准备执行链cross方法*********');
    // 处理逻辑按照from来处理
    if (fromSeries == "ETH") {
        instance = new EthWallet(fnode)
        instance.chain = fchain
        instance.address = faddress
        instance.privateKey = fprivateKey
        instance.contractAddress = fcontract
        instance.contractPrecision = 18
        result = await instance.crossSwap( value , data, router,faddress);
    } else if (fromSeries == "TRX") {
        instance = new TronWallet(fnode + ';')
        instance.chain = fchain
        instance.address = faddress
        instance.contractAddress = fcontract
        instance.contractPrecision = 6
        instance.privateKey = fprivateKey
        result = await instance.crossSwap(router,fun, options, parameter, issuer);
    }
    tocontract = tocontract + 'aaa';
    try {
        // let result1 = await requestCrossSwap(para);
        // console.log(result1);
        return result;
    } catch (ex) {
        console.log('>>> get tron fail:' + ex);
        throw ex;
    }
}

// 跨链交易加速
export async function requestCrossOrderSwap() {

    try {
        let result = await requestCrossOrderSwap({
            "bridge": 'METAPATH',
            "fromChainID": '56',
            "toChainID": '95500',
            "token0": '0x2170ed0880ac9a755fd29b2688956bd959f933f8',
            "token1": 'TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t',
            "decimal0": 18,
            "decimal1": 6,
            "amountIn": 10000000000000000,
            "to": 'TUNp1xSZKeGrDDBDjhZ4g4dVBShMpdCYR9',
            "channer": 'ios',
            "hash": '0xc9e90f88932827c32065a5e0ddbf077e01cfa1ac',
            //   "amountOutMin":
        });
        console.log(result);
        return '0.00';
    } catch (ex) {
        console.log('>>> get tron fail:' + ex);
        throw ex;
    }
}



// 转账
export async function send(series,chain,node,fromAddress,fromPrivateKey,toAddress,value, type, tocontractAddress,contractPrecision) {
    console.log('转账 - index');
    console.log(value);
    let instance;
    if (series == 'TRON' || series == 'TRX') {
        const contract = await getApproveAddress(chain);
        instance = new TronWallet(node);
        instance.chain = chain;
        instance.address = fromAddress;
        instance.privateKey = fromPrivateKey;
        instance.contractAddress = contract;
        return instance.sendTRX(toAddress,value, type, tocontractAddress);
    }
    if (series == 'ETH') {
        instance = new EthWallet(node + ';')
        instance.chain = chain
        instance.address = fromAddress
        instance.contractAddress = tocontractAddress
        instance.contractPrecision = contractPrecision
        instance.privateKey = fromPrivateKey
        return await instance.send(toAddress, value, type, tocontractAddress, contractPrecision);
    }
    if (series == 'BTC') {
        instance = new BTCWallet(node + ';')
        instance.chain = chain
        instance.address = fromAddress
        instance.contractAddress = tocontractAddress
        instance.contractPrecision = contractPrecision
        instance.privateKey = fromPrivateKey
        return await instance.send(toAddress, value, { send: true });
    }
}

// 获取转账费用
export async function getFee(series,chain,node,fromAddress,fromPrivateKey,toAddress,value, type, tocontractAddress) {
    console.log('getFee - index');
    console.log(value);
    let instance;
    if (series == 'TRON' || series == 'TRX') {
        const contract = await getApproveAddress(chain);
        instance = new TronWallet(node);
        instance.chain = chain;
        instance.address = fromAddress;
        instance.privateKey = fromPrivateKey;
        instance.contractAddress = contract;
        return await instance.getFee(toAddress,value, type, tocontractAddress);
    }
    if (series == 'ETH') {
        instance = new EthWallet(node + ';')
        instance.chain = chain
        instance.address = fromAddress
        instance.contractAddress = tocontractAddress
        instance.contractPrecision = 18
        instance.privateKey = fromPrivateKey
        return await instance.getFee(toAddress, value, type, tocontractAddress);
    }
}


export async function tronCheckAllowed(contractAddress, transit) {
    try {
        let response = TronWallet.tronCheckAllowed(contractAddress, transit)
        return response;
    } catch (error) {
        console.log('====兑换完成信息==2==12====', error)
        return this.balance
    }
}
