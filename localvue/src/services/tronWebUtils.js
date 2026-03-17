import * as TronWeb from 'tronweb'
import ERC20 from "../assets/tron/ERC20.json";
import BigNumber from 'bignumber.js';
import Decimal from 'decimal.js';
import { tronPostRequest, tronRequest } from "./request";
// import * as TronStationSDK from 'tron-station-sdk'


const tmp = {};

// 计算基础消耗
const SIGNATURE_LENGTH = 65;
const TX_RESULT_SIZE = 64;
const TX_SIZE_OVERHEAD = 5;


// let lastUpdateTime;

// 带宽和能量单价
let lastValue = { bandwidth: 1000, energy: 420 };

export default class TronWallet {

  server;
  chain = '';
  address = '';
  privateKey = '';
  contractAddress = '';
  contractPrecision = 0;
  node = '';
  trc20 = [];


  constructor(node) {
    const [nodeAddress] = node.split(';');
    this.node = node;
    const HttpProvider = TronWeb.providers.HttpProvider;
    let server = tmp[nodeAddress];
    // 缓存
    if (!server) {
      server = new TronWeb({
        fullNode: new HttpProvider(nodeAddress),
        solidityNode: new HttpProvider(nodeAddress),
        eventServer: new HttpProvider(nodeAddress),
        headers: {"TRON-PRO-API-KEY":"79bca3d7-3c52-4838-b689-a638fe9b9dfa"}
        // fullNode: 'https://nile.trongrid.io',
        // solidityNode: 'https://nile.trongrid.io',
        // eventServer: 'https://nile.trongrid.io'
      });
      tmp[nodeAddress] = server;
    }
    this.server = server;
  }

  // 根据私钥获取地址
  static getAddressWithPrivateKey(pKey) {
    try {
      const address = TronWeb.address.fromPrivateKey(pKey);
      return { 'address': address, "success": true};
    } catch (error) {
      console.log('获取地址error: ', error)
      return { 'address': "", "success": false };
    }
  }

  // 根据私钥获取地址 带hex
  getAddressWithPrivateKeyWithHex(pKey) {
    try {
      console.log('pKey: ', pKey)
      const address = TronWeb.address.fromPrivateKey(pKey);
      console.log('address: ', address)
      let addresshex = TronWeb.address.toHex(address);
      return { 'address': address == false ? '' : address, "success": address != false, 'addresshex': addresshex };
    } catch (error) {
      console.log('获取地址error: ', error)
      return { 'address': "", "success": false };
    }
  }


  // 获取波场余额
  async getBalance(node,symbol, address, contractAddress) {
    try {
      this.tohex(contractAddress);
      let balance = 0.00;
      console.log('*******获取余额*******',symbol);
      if (symbol === 'TRX') {
        
        let result = await tronPostRequest(`/wallet/getaccount`, {
          "address": address,
          "visible": true
        }, {}, node);
        let resData = result.data;
        if (resData == undefined){
          return {"success": false,'address':address,'contractAddress':contractAddress,'symbol': symbol,'balance': "0.00", 'trc20': []};
        }
        balance = resData.balance || 0;
        balance = new Decimal(balance)
          .div(Math.pow(10, this.contractPrecision || 6))
          .toString();
        // return balance.length <= 0 ? "0.00" : balance;
        return {"success": true,'address':address,'contractAddress':contractAddress,'symbol': symbol, 'balance': balance.length <= 0 ? "0.00" : balance, 'trc20': []};
      } else {
        let { data } = await tronRequest(`/v1/accounts/${this.address}`, {}, node);
        console.log(this.address);
        console.log(node);
        console.log(data);
        let result = data.data;
        this.trc20 = result[0].trc20;
        for (const key in result[0].trc20) {
          const element = result[0].trc20[key];
          if (element[contractAddress] != undefined) {
            balance = element[contractAddress] || 0;
            break;
          }
        }
      }
      balance = new Decimal(balance)
        .div(Math.pow(10, this.contractPrecision || 6))
        .toString();
        // return balance.length <= 0 ? "0.00" : balance;
      return {"success": true,'address':address,'contractAddress':contractAddress,'symbol': symbol,'balance': balance.length <= 0 ? "0.00" : balance, 'trc20': this.trc20};
    } catch (ex) {
      return {"success": false,'address':address,'contractAddress':contractAddress,'symbol': symbol,'balance': "0.00", 'trc20': []};
    }
  }

  

  // 转账
  async sendTRX(toAddress, amount, type, tocontractAddress) {
    console.log('*******开始转账*******');
    try {
        let tronWeb = await this.getServer();
        tronWeb.setPrivateKey(this.privateKey);
        let { privateKey, address} = this;
        let value = this.decimalsHandle(amount);
        let tonew = toAddress;
        let addressnew = address;
        let txObj;
        if (type == 'chain') {
          console.log('*******非主币*******');
          txObj = await tronWeb.transactionBuilder.sendTrx(tonew, value, addressnew);
          const signed = await tronWeb.trx.sign(txObj, privateKey);
          const result = await tronWeb.trx.sendRawTransaction(signed);
          result['success'] = true;
          console.log('*******交易成功*******');
          return result;
        }
        console.log('*******交易非主币*******');
        var parameter = [
          { type: 'address', value: toAddress },
          { type: 'uint256', value: value },
        ];
        console.log('*******交易构建*******');
        txObj = await tronWeb.transactionBuilder.triggerSmartContract(
            tocontractAddress,
            'transfer(address,uint256)',
            {},
            parameter,
            tronWeb.address.toHex(this.address)
        );
        txObj = txObj.transaction;
        const signed = await tronWeb.trx.sign(txObj, privateKey);
        const result = await tronWeb.trx.sendRawTransaction(signed);
        result['success'] = true;
        console.log('*******交易成功*******');
        return result;
    } catch (err) {
        console.log('*******交易失败*******');
        console.log(err);
        return {success : false, 'fee': 0};
    }
}


// 获取转账费用   特指转账费用
async getFee(toAddress, amount, type, tocontractAddress) {
  console.log('*******开始获取交易费用*******');
  try {
      let tronWeb = await this.getServer();
      tronWeb.setPrivateKey(this.privateKey);
      let {address} = this;
      let value = this.decimalsHandle(amount);
      let tonew = toAddress;
      let addressnew = address;
      let txObj;
      if (type == 'chain') {
        console.log('*******主币*******');
        txObj = await tronWeb.transactionBuilder.sendTrx(tonew, value, addressnew);
        const fee = (await this.fetchMainCoinFeeInfo(txObj));
        console.log('*******获取交易费用成功*******');
        fee.success = true;
        return fee;
      } else {
        console.log('*******非主币*******');
        var parameter = [
          { type: 'address', value: toAddress },
          { type: 'uint256', value: value },
        ];
        console.log('*******交易构建*******');
        txObj = await tronWeb.transactionBuilder.triggerSmartContract(
            tocontractAddress,
            'transfer(address,uint256)',
            {},
            parameter,
            tronWeb.address.toHex(this.address)
        );
        txObj = txObj.transaction;
        const fee = (await this.fetchFeeInfo(txObj)).fee;
        console.log('*******获取交易费用成功*******');
        console.log(fee);
        return {success : true, 'fee': fee};
      }
  } catch (err) {
      console.log('*******获取交易费用失败*******');
      console.log(err);
      return {success : false, 'fee': 0, 'msg': err, 'message': err};
  }
}

async fetchMainCoinFeeInfo(uncastedEncodedTx) {
  console.log('[fetchMainCoinFeeInfo]');
  const encodedTx = uncastedEncodedTx;
  const { freeBandwidth, stakedBandwidth } = await this.getConsumableResource(
    this.address
  );

  const requiredBandwidth =
    encodedTx.raw_data_hex.length / 2 +
    SIGNATURE_LENGTH +
    TX_RESULT_SIZE +
    TX_SIZE_OVERHEAD;

    // console.log('-----');
    // console.log(requiredBandwidth) // 268000
    // console.log(freeBandwidth)

    // console.log(stakedBandwidth)
    let mainFee = requiredBandwidth - freeBandwidth;
    mainFee = mainFee * stakedBandwidth;
    mainFee = mainFee/Math.pow(10, this.contractPrecision || 6);
    return {"fee": mainFee, "bandwidth": requiredBandwidth,"freeBandwidth": freeBandwidth};
}



  // hex解码
  async getHexFromAddress(address) {
    try {
      let tronWeb = await this.getServer();
      const addressHex = tronWeb.address.fromPrivateKey(address);
      return addressHex;
    } catch (error) {
      console.log('获取地址error: ', error)
      return '';
    }
  }

  // 解码
  async tohex(contractAddress){
    try {
      let tronWeb = await this.getServer();
      let value = tronWeb.address.toHex(contractAddress)
      // console.log("成功");
      // console.log(value);
      return value;
    } catch (error) {
      console.log("失败");
      return '';
    }
  }

  

  // 检查授权
  async checkAllowed(contractAddress, transit) {
    console.log('检查授权: TRON', contractAddress, transit);
    try {
      let { privateKey, address } = this;
      let tronWeb = await this.getServer();
      tronWeb.setPrivateKey(privateKey);
      const contract = await tronWeb.contract(ERC20.abi, contractAddress)
      let res = await contract.methods.allowance(address, transit).call();
      res = res.toNumber()
      return { needApprove: res <= 0, success: true,approveAmount: res}
    } catch (error) {
      console.log('error', error);
      // 检查授权成功,  无限制导致的  0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff无法解析成功
      return { needApprove: false, success: true ,approveAmount: 9999}
    }
  }

  // 授权
  // const spender = '0x...'; // 需要授权的地址 
  async getApproveX(spender, contractAddress,contract, value, privateKey) {
    try {
      // console.log('授权开始:------------------------1----------');
      let tronWeb = await this.getServer();
      tronWeb.setPrivateKey(this.privateKey);
      const approveAmount = tronWeb
          .toBigNumber('0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff')
          .toFixed();
      const parameter = [
          { type: 'address', value: tronWeb.address.toHex(contract) },
          { type: 'uint256', value: approveAmount},
      ];
      // console.log('授权开始:----------------------2------------');
      const txObj = await tronWeb.transactionBuilder.triggerSmartContract(
          contractAddress,
          'approve(address,uint256)',
          {},
          parameter,
          tronWeb.address.toHex(this.address)
      );

      // 授权 10.659
      // 实例化合约对象
      console.log('实例化合约对象:*********************');
      const contractApprove = await tronWeb.contract(ERC20.abi, contractAddress);
      console.log(txObj);
      console.log('开始授权:*********************');
      // 调用合约的 approve 方法，执行授权操作
      const approveTxId = await contractApprove.approve(spender, value).send({
          shouldPollResponse: true,
          // 发送者的私钥
          privateKey: privateKey, 
          // 设置当前交易的冻结时间
          // num:冻结秒数
          // unit:冻结时间单位
          // 要求 0 <= num <= MAX uint256
          // 要求 unit = "s"
          // 例如: 10s
          frozenDuration: 0, 
          // 冻结余额价格
          // 10trx / kBandwidth
          frozenBalance: 0, 
          // 给这个交易设置一个 memo-附言
          memo: contractAddress + ' approve transaction',
          // 不同条件下的优先级别
          // 不同条件+优先级别组合，将决定交易以及被打包入区块内的顺序
          // 以下数值请自行根据实际设置
          expiration: 0,
          feeLimit: 100_000_000,
          timestamp: Date.now(),
          // 选填参数的默认值:
          // blockNum 和 visible 不需要设置
      });

      console.log('授权结果如下:*********************');
      console.log(approveTxId);
      return { "token": contract,'message': 'success', 'success': true };

      // let fee = (await this.fetchFeeInfo(txObj.transaction)).fee;
      // return {"fee": fee, "token": contract,'message': 'success', 'success': true };
    } catch (error) {
      console.log('授权结果为失败:*********************');
      console.log(error);
      return {'message': '' + error.toString(), 'success': false };
    }
}

  static async sendTransaction(hash) {
    let tronWeb = await this.getServer();
    const result = await tronWeb.trx.sendRawTransaction(hash);
    return result.txid;
  }

  static async checkAllowed(contractAddress, transit) {
    console.log('[CheckAllowed]');
    let { privateKey, address } = this;
    let tronWeb = await this.getServer();
    tronWeb.setPrivateKey(privateKey);
    const contract = tronWeb.contract(ERC20.abi, contractAddress)
    return await contract.methods.allowance(address, transit).call();
  }

  hexToString(str) {
    var rawStr = str.trim()
    //将中文部分转成中文
    rawStr = decodeURI(rawStr)
    var len = rawStr.length
    var curCharCode
    var resultStr = []
    var re = /[\u4E00-\u9FA5]/
    for (var i = 0; i < len; i = i + 2) {
      if (re.test(rawStr.charAt(i))) {
        //中文
        resultStr.push(rawStr.charAt(i))
        i = i - 1
      } else {
        curCharCode = parseInt(rawStr.substr(i, 2), 16)
        resultStr.push(String.fromCharCode(curCharCode))
      }
    }
    return resultStr.join('')
  }


  // 获取交易费用  费用处理过程
  async tradeNetworkFeeEvent(uncastedEncodedTx,tocontract, toAddress,value,contract) {
    console.log('[ tradeNetworkFeeEvent ]');
    let baseFee = 0;
    const encodedTx = uncastedEncodedTx;
    const parameters = await this.getChainParameters();
    const { freeBandwidth, stakedBandwidth } = await this.getConsumableResource(
      this.address
    );
    var getTransactionFee = 0;
    for (const key in parameters) {
      const element = parameters[key];
      const keyStr = element['key'];
      if (keyStr == 'getTransactionFee') {
        getTransactionFee = element['value']
      }
    }
    const requiredBandwidth =
      encodedTx.raw_data_hex.length / 2 +
      SIGNATURE_LENGTH +
      TX_RESULT_SIZE +
      TX_SIZE_OVERHEAD;
    baseFee +=
      (requiredBandwidth > freeBandwidth && requiredBandwidth > stakedBandwidth
        ? requiredBandwidth
        : 0) * getTransactionFee;
        console.log('14');
    if (encodedTx.raw_data.contract[0].type === 'TransferContract') {
      console.log('[TransferContract]');
      baseFee = parameters.getCreateNewAccountFeeInSystemContract == undefined ? 0 : parameters.getCreateNewAccountFeeInSystemContract;
      console.log(baseFee);
      baseFee +=
        parameters.getCreateAccountFee > stakedBandwidth
          ? parameters.getCreateAccountFee
          : 0;
          console.log(baseFee);
      // }
    } else if (encodedTx.raw_data.contract[0].type === 'TriggerSmartContract') {
      console.log('[TriggerSmartContract]');
      const {
        contract_address: contractAddressHex,
        data,
        call_value,
        owner_address: fromAddressHex,
      } = encodedTx.raw_data.contract[0].parameter.value;
      try {
        let tronWeb = await this.getServer();
        console.log('contract', contractAddressHex);
        console.log('value', call_value);
        const params = [
          {
            from: fromAddressHex,
            to: tronWeb.address.toHex(contract),
            gas: '0x01',
            gasPrice: '0x01',
            value: tronWeb.toHex(call_value),
            data: data,
          },
        ];
        var result = await tronWeb.fullNode.request(
          'jsonrpc',
          {
            jsonrpc: '2.0',
            id: 1,
            method: 'eth_estimateGas',
            params: params,
          },
          'post'
        );
        if (result["error"] != null) {
          console.log(result["error"]);
          return {"success": false, data: result["error"]}
        }
        if (result["result"]!=null) {
          result = result["result"];
        }
        const requiredEnergy = parseInt(result);
        if (requiredEnergy > 0) {
          let getEnergyFee1 = 0;
          for (let index = 0; index < parameters.length; index++) {
            const element = parameters[index];
            if (element['key'] == 'getEnergyFee') {
              getEnergyFee1 = element['value'];
              baseFee += requiredEnergy * getEnergyFee1;
              break;
            }
          }
          // baseFee += requiredEnergy * parameters.getEnergyFee;
        }
      } catch (e) {
        console.log('****************2x');
        console.log(e);
      }
    }
    const a = {
      fee: new BigNumber(baseFee.toString()).shiftedBy(-6).toFixed(),
    };
    console.log(a);
    return a;
  }

  // 交易费用- 网费 --同链链
  async tradeNetworkFee(contract,fun, options, parameter, issuer,from,to,value) {
    try {
      console.log('开始计算同链兑换的网费');

      console.log('开始兑换');
      let tronWeb = await this.getServer();
      tronWeb.setPrivateKey(this.privateKey);
      let parameternew = parameter;
      if (parameternew.indexOf('&') != -1) {
        parameternew = parameter.replace( new RegExp('&','g'), '"');
      }
      console.log('\n合约: ', parameternew);
      let optionsnew = options;
      if (optionsnew.indexOf('&') != -1) {
        optionsnew = options.replace( new RegExp('&','g'), '"');
      }
      
      let paramete = parameternew == "" ? parameternew : JSON.parse(parameternew);
      let option = optionsnew == "" ? optionsnew : JSON.parse(optionsnew);
      console.log('*******构建交易*******');
      console.log(paramete);
      let txObj = await tronWeb.transactionBuilder.triggerSmartContract(
          tronWeb.address.toHex(contract),
          fun,
          option,
          paramete,
          issuer
        );

        console.log(txObj);
   

    let feeObj = await this.tradeNetworkFeeEvent(txObj.transaction,to, from,value, contract);
      console.log("2");
      console.log(feeObj);
      let fee = feeObj.fee;
      return {"fee": fee, "token": contract,'message': 'success123', 'success': true };
    } catch (error) {
        console.log('****失败1*****');
        console.log('' + error);
        return {'message': '' + error.toString(), 'success': false}
    }
  }


  // 交易费用- 网费 --跨链
  async tradeNetworkFee1(contract,fun, options, parameter, issuer,tocontract, toAddress,value, cross) {
    try {
      console.log('开始跨链兑换');

      console.log(cross);
      console.log(contract);
      console.log(fun);
      console.log(options);
      console.log(parameter);
      console.log(issuer);
      console.log(issuer);
      let tronWeb = await this.getServer();
      tronWeb.setPrivateKey(this.privateKey);
      let parameternew = parameter;
      if (parameternew.indexOf('&') != -1) {
        parameternew = parameter.replace( new RegExp('&','g'), '"');
      }
      console.log('\n合约: ', parameternew);
      let optionsnew = options;
      if (optionsnew.indexOf('&') != -1) {
        optionsnew = options.replace( new RegExp('&','g'), '"');
      }
      // console.log('\n合约1: ', optionsnew);
      
      let paramete = parameternew == "" ? parameternew : JSON.parse(parameternew);
      let option = optionsnew == "" ? optionsnew : JSON.parse(optionsnew);
      let txObj = await tronWeb.transactionBuilder.triggerSmartContract(
          tronWeb.address.toHex(contract),
          fun,
          option,
          paramete,
          issuer
        );
        console.log("21212");
      console.log(txObj);
      let feeObj = await this.tradeNetworkFeeEvent(txObj.transaction,tocontract, toAddress,value);
      console.log("2");
      console.log(feeObj);
      let fee = feeObj.fee;
      return {"fee": fee, "token": contract,'message': 'success123', 'success': true };
    } catch (error) {
        console.log('****失败1*****');
        console.log('' + error);
        return {'message': '' + error.toString(), 'success': false}
    }
  }


  // 跨链
  async crossSwap(contract,fun, options, parameter, issuer) {
    try {
      console.log('开始跨链兑换');
      let tronWeb = await this.getServer();
      tronWeb.setPrivateKey(this.privateKey);
      let parameternew = parameter;
      if (parameternew.indexOf('&') != -1) {
        parameternew = parameter.replace( new RegExp('&','g'), '"');
      }
      console.log('\n合约: ', parameternew);
      let optionsnew = options;
      if (optionsnew.indexOf('&') != -1) {
        optionsnew = options.replace( new RegExp('&','g'), '"');
      }
      // console.log('\n合约1: ', optionsnew);
      
      let paramete = parameternew == "" ? parameternew : JSON.parse(parameternew);
      let option = optionsnew == "" ? optionsnew : JSON.parse(optionsnew);
      console.log('*******构建交易*******');
      let txObj = await tronWeb.transactionBuilder.triggerSmartContract(
          tronWeb.address.toHex(contract),
          fun,
          option,
          paramete,
          issuer
        );

        if (txObj != undefined) {
          //签名
          console.log('*******签名*******');
          const signedtxn = await tronWeb.trx.sign(txObj.transaction, this.privateKey);
          //广播
          console.log('*******广播*******');
          const receipt = await tronWeb.trx.sendRawTransaction(signedtxn);
          console.log(receipt);
          console.log(receipt.message);
          if (receipt.message != undefined) {
            receipt.message = this.hexToString(receipt.message);
          } else {
            receipt['message'] = 'success';
          }
          receipt['success'] = true;
          return receipt;
        }
    } catch (error) {
        console.log('****失败1*****');
        console.log('' + error);
        return {'message': '' + error.toString(), 'success': false}
    }
  }

   // 兑换
   async signOnlySwap(contract,fun, options, parameter, issuer) {
    try {
      console.log('开始兑换');
      let tronWeb = await this.getServer();
      tronWeb.setPrivateKey(this.privateKey);
      let parameternew = parameter;
      if (parameternew.indexOf('&') != -1) {
        parameternew = parameter.replace( new RegExp('&','g'), '"');
      }
      console.log('\n合约: ', parameternew);
      let optionsnew = options;
      if (optionsnew.indexOf('&') != -1) {
        optionsnew = options.replace( new RegExp('&','g'), '"');
      }
      // console.log('\n合约1: ', optionsnew);
      
      let paramete = parameternew == "" ? parameternew : JSON.parse(parameternew);
      let option = optionsnew == "" ? optionsnew : JSON.parse(optionsnew);
      console.log('*******构建交易*******');
      let txObj = await tronWeb.transactionBuilder.triggerSmartContract(
          tronWeb.address.toHex(contract),
          fun,
          option,
          paramete,
          issuer
        );
      if (txObj != undefined) {
        //签名
        console.log('*******签名*******');
        const signedtxn = await tronWeb.trx.sign(txObj.transaction, this.privateKey);
        //广播
        console.log('*******广播*******');
        const receipt = await tronWeb.trx.sendRawTransaction(signedtxn);
        console.log(receipt);
        console.log(receipt.message);
        if (receipt.message != undefined) {
          receipt.message = this.hexToString(receipt.message);
        } else {
          receipt['message'] = 'success';
        }
        receipt['success'] = true;
        return receipt;
      }
    } catch (error) {
      console.log('****失败1*****');
      console.log('' + error);
      return {'message': '' + error.toString(), 'success': false}
    }
  }


  // 交易
  async signApprove(send, fromContractAddress, contract, value, toCAddress, exchangeModel) {
    try {
      console.log('[signApprove]');
      let tronWeb = await this.getServer();
      let { privateKey, address } = this;
      console.log('\n地址: ', address);
      console.log('\n私钥: ', privateKey);
      tronWeb.setPrivateKey(this.privateKey);
      const parameter = [
        { type: 'address', value: TronWeb.address.toHex(toCAddress) },
        { type: 'uint256', value: value },
      ];

      var options = {
        feeLimit: 150000000,
        callValue: 0
      };
      if (exchangeModel != undefined && exchangeModel.indexOf(';') != -1) {
        let list = exchangeModel.split(';')
        let feeLimit = list[0].split(':');
        let callValue = list[1].split(':');
        options[feeLimit[0]] = feeLimit[1];
        options[callValue[0]] = callValue[1];
      }
      let txObj;
      console.log('*******构建交易*******');
      console.log('\nfrom: ', fromContractAddress);
      console.log('\nto: ', toCAddress);
      console.log('\n参数: ', parameter);
      console.log('\n配置:  ', options);
      txObj = await tronWeb.transactionBuilder.triggerSmartContract(
        tronWeb.address.toHex(toCAddress),
        "deposit()",
        // 'transfer(address,uint256)',
        options,
        parameter,
        tronWeb.address.toHex(fromContractAddress)
      );
      
      console.log('*******获取费用*******');
      if (txObj != undefined) {
        //签名
        console.log('*******签名*******');
        const signedtxn = await tronWeb.trx.sign(txObj.transaction, this.privateKey);
        //广播
        console.log('*******广播*******');
        const receipt = await tronWeb.trx.sendRawTransaction(signedtxn);
        return receipt;
      }
    } catch (error) {
      console.log('****失败2*****');
      console.log(error);
      return {'message': '' + error.toString(), 'success': false}
    }
  }

  async getServer() {
    return this.server;
  }

  async getChainParameters() {
    let tronWeb = await this.getServer();
    let result = await tronWeb.trx.getChainParameters();
    return result;
  }


  getSplitValue(str) {
    let splits = str.split(',');
    if (splits.length > 0) {
      let v = splits[splits.length - 1].split(':')[1];
      return Number(v);
    } else {
      return 0;
    }
  }

  async getPrice() {
    return lastValue;
    // try {
    //   console.log("=============as=================");
    //   // console.log(lastValue);
    //   if (!lastUpdateTime || Date.now() - lastUpdateTime > 60 * 10000) {
    //     console.log("=============as=======1==========");
    //     let v1 = await tronRequest('/wallet/getenergyprices', {}, this.node);
    //     if (v1==null || v1==undefined || v1.data.prices==null ||v1.data.prices==undefined ||v1.data.prices=='') {
    //       return lastValue;
    //     }
    //     let v2 = await tronRequest('/wallet/getbandwidthprices', {}, this.node);
    //     if (v2==null || v2==undefined || v2.data.prices==null ||v2.data.prices==undefined||v2.data.prices=='') {
    //       return lastValue;
    //     }
    //     lastValue.energy = this.getSplitValue(v1.data.prices || '');
    //     lastValue.bandwidth = this.getSplitValue(v2.data.prices || '');
    //     lastUpdateTime = Date.now();
    //   }
    //   console.log("=============as=======2==问我========");
    //   console.log(lastValue);
    //   return lastValue;
    // } catch (error) {
    //   console.log("=============as=======2==问我===1=====");
    //   return lastValue;
    // }
  }


  async getConsumableResource(address) {
    console.log(address);
    let tronWeb = await this.getServer();
    let a = await tronWeb.trx.getBandwidth(address);
    let p = await this.getPrice()
    return {
      freeBandwidth: a,
      stakedBandwidth: p['bandwidth'],
      stakedEnergy: p['energy']
    }
  }




  async fetchFeeInfo(uncastedEncodedTx) {
    console.log('[fetchFeeInfo]');
    let baseFee = 0;
    const encodedTx = uncastedEncodedTx;
    const parameters = await this.getChainParameters();
    const { freeBandwidth, stakedBandwidth } = await this.getConsumableResource(
      this.address
    );
    var getTransactionFee = 0;
    
    for (const key in parameters) {
      const element = parameters[key];
      const keyStr = element['key'];
      if (keyStr == 'getTransactionFee') {
        getTransactionFee = element['value']
      }
    }

    const requiredBandwidth =
      encodedTx.raw_data_hex.length / 2 +
      SIGNATURE_LENGTH +
      TX_RESULT_SIZE +
      TX_SIZE_OVERHEAD;

      console.log('-----');
      console.log(requiredBandwidth) // 268000
      console.log(freeBandwidth)

      // https://api.trongrid.io/wallet/getaccount?address=TVgvmmkm2pjvuurr48DzMkWjNdHHB88888&visible=true
      // https://api.trongrid.io/wallet/getaccount?address=TUkFnAjt1sHCfM2EXmQZPqGLXmic3PavJj&visible=true

      console.log(stakedBandwidth)
    baseFee +=
      (requiredBandwidth > freeBandwidth && requiredBandwidth > stakedBandwidth
        ? requiredBandwidth
        : 0) * getTransactionFee;
        console.log(baseFee)

        console.log(getTransactionFee)
    if (encodedTx.raw_data.contract[0].type === 'TransferContract') {
      console.log('[TransferContract]');
      baseFee = parameters.getCreateNewAccountFeeInSystemContract == undefined ? 0 : parameters.getCreateNewAccountFeeInSystemContract;
      baseFee +=
        parameters.getCreateAccountFee > stakedBandwidth
          ? parameters.getCreateAccountFee
          : 0;
          console.log(baseFee);
      // }
    } else if (encodedTx.raw_data.contract[0].type === 'TriggerSmartContract') {
      console.log('[TriggerSmartContract]');
      const {
        contract_address: contractAddressHex,
        data,
        call_value,
        owner_address: fromAddressHex,
      } = encodedTx.raw_data.contract[0].parameter.value;
      try {
        let tronWeb = await this.getServer();
        const params = [
          {
            from: fromAddressHex,
            to: contractAddressHex,
            gas: '0x01',
            gasPrice: '0x01',
            value: tronWeb.toHex(call_value),
            data,
          },
        ];
        // 能量消耗
        const { result } = await tronWeb.fullNode.request(
          'jsonrpc',
          {
            jsonrpc: '2.0',
            id: 1,
            method: 'eth_estimateGas',
            params: params,
          },
          'post'
        );
        const requiredEnergy = parseInt(result);
        if (requiredEnergy > 0) {
          let getEnergyFee1 = 0;
          console.log("-----------------1--------")
          console.log(parameters)
          for (let index = 0; index < parameters.length; index++) {
            const element = parameters[index];
            if (element['key'] == 'getEnergyFee') {
              getEnergyFee1 = element['value'];
              baseFee += requiredEnergy * getEnergyFee1;
              break;
            }
          }
          // baseFee += requiredEnergy * parameters.getEnergyFee;
        }
      } catch (e) {
        console.log(e);
      }
    }
    const a = {
      fee: new BigNumber(baseFee.toString()).shiftedBy(-6).toFixed(),
    };
    console.log(a);
    return a;
  }

  decimalsHandle(v, l = 6) {
    let n = '' + v;
    if (n.indexOf('.') == -1) {
      n = n + new Array(l).fill(0).join('');
    } else {
      let h = n.split('.')[0];
      let e = n.split('.')[1];
      if (e.length >= l) {
        e = e.substr(0, l);
      } else {
        e = e + new Array(l - e.length).fill(0).join('');
      }
      if (parseInt(h)) {
        n = h + e;
      } else {
        n = e;
      }
    }
    return n;
  }

}



export async function initTronWeb() {
  var address = "";
  var number = 0;
  var contractAddress = "TRC-20 合约";
  //选择合约⽅法
  let functionSelector = "transfer(address,uint256)";
  //根据⽅法构造参数
  let parameter = [
    {
      type: "address",
      value: address
    },
    {
      type: "uint256",
      value: Math.ceil(number)
    }
  ];
  //额外参数
  let options = {
    shouldPollResponse: false,
    feeLimit: 1000000 //1Trx
  };
  // 构造智能合约交易信息
  let res = await TronWeb.transactionBuilder
    .triggerSmartContract(contractAddress, functionSelector, options, parameter);
  // .catch(() {
  //     // 构建交易信息失败
  //     return false;
  // }
  // );
  // 向转账交易信息中追加备注信息
  await TronWeb.transactionBuilder.addUpdateData(res.transaction, "备注信息", 'utf8');
  // 对已经添加备注的交易信息进⾏签名
  let sign = await TronWeb.trx.sign(res.transaction);
  // .catch(err2 => {
  //     //签名失败
  //     return false;
  // });
  // 将签名交易⼴播上链
  return await TronWeb.trx.sendRawTransaction(sign).catch(outputErr => {
    //交易⼴播出错
    console.log(outputErr);
    return false;
  });
}

