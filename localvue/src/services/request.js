import request from './http'
import axios from 'axios'
// import { async } from 'utils.js';

const nowNodeMap = {
    BTC: 'btc',
    BTCTest: 'btcbook-testnet',
    ETH: 'eth-blockbook',
    BCH: 'bch',
    BSC: 'bsc-blockbook',
    TRX: 'trx',
    LTC: 'ltc',
    LTCTest: 'ltcbook-testnet',
    DOGE: 'doge',
    DOGETest: 'doge-testnet',
};

export function nowNodeRequest(chain, url, opt = {}) {
    const headers = { 'api-key': "06bcdd62-7945-44ec-9e26-cb2cc4711415" };
    const prefix = nowNodeMap[chain];
    const root = `https://${prefix}.nownodes.io`;
    opt = { ...opt, ignore: true, headers: { ...headers, ...opt.headers } };
    return request(root + url, opt);
}

export async function get(url) {
    try {
       let res = await axios.get(url);
        return res.data;
    } catch (error) {
        console.log('-------get--error------');
        console.log(error);
        return undefined;
    }
}


/**
 *
 *
 * @export
 * @param {*} url
 * @returns
 */
export async function requestBtc(requestOptions) {
    console.log(requestOptions);
    try {
       let res = await axios.get('');
        return res.data;
    } catch (error) {
        console.log('-------get--error------');
        console.log(error);
        return undefined;
    }
}




export async function tronRequest(url, opt = {}, node) {
    let headers = { 'TRON-PRO-API-KEY': "79bca3d7-3c52-4838-b689-a638fe9b9dfa" };
    headers = {};
    let root = `https://api.trongrid.io`;
    // 获取余额时测试链  正式链的地址不同
    root = node
    let response = await axios.get(root + url);
    if (response != undefined) {
        return response;
    }
    opt = { ...opt, ignore: true, headers: { ...headers, ...opt.headers } };
    console.log(opt);
    return request(root + url);
}

export async function tronPostRequest(url, data, opt = {}, node) {
    console.log(opt);
    // let headers = { 'TRON-PRO-API-KEY': "79bca3d7-3c52-4838-b689-a638fe9b9dfa" };
    let root = `https://api.trongrid.io`;
    root = node
    let response = await axios.post(root + url, data);
    return response;
}

// 跨链交易
export async function requestCrossSwap(data) {
    let pstr = '';
    if (data != undefined) {
        for (const key in data) {
                const element = data[key];
                pstr += key + '=' + element + '&'
        }
    }
    let root = `https://aggserver.transit.finance/v3/cross/swap?` + pstr;
    console.log('requestCrossSwaproot:  ', root);
    let response = await axios.get(root);
    return response;
}

// 跨链交易加速
export async function requestCrossOrderSwap(data) {
    let pstr = '';
    if (data != undefined) {
        for (const key in data) {
                const element = data[key];
                pstr += key + '=' + element + '&'
        }
    }
    let root = `https://aggserver.transit.finance/v3/cross/order?` + pstr;
    console.log('requestCrossSwaproot:  ', root);
    let response = await axios.get(root);
    return response;
}




