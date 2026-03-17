<template>
  <div class="hello">
    <div id="__next">
      <div class="title">
        {{ hexValue }}
      </div>
      <!-- <div class="title">address: {{ address }}</div>
      <div class="title">balance: {{ balance }}</div>  -->
      <!-- <button
        class="and"
        style="
          margin-bottom: 30px;
          background-color: burlywood;
          margin-right: 10px;
        "
        @click="getSupportChain"
      >
        {{ mobileMessage }}
      </button> -->
      <!-- <button
        class="and"
        style="
          margin-bottom: 30px;
          background-color: burlywood;
          margin-right: 10px;
        "
        @click="getQuoteCrossTokens"
      >
        BTC转账
      </button> -->
      <!-- <button
        class="and"
        style="
          margin-bottom: 30px;
          background-color: burlywood;
          margin-right: 10px;
        "
        @click="hexToString"
      >
        检查授权
      </button> -->
    </div>
    <div v-for="item in noparamList" :key="item.id" class="progress-body">
      <div style="float: left; margin-bottom: 30px; margin-right: 10px;">
        <div>{{ item.chain }}</div>
        <img style="width: 60px; height: 60px;" :src="item.icon" />
      </div>
    </div>
    <div v-for="item in chainList" :key="item.id" class="progress-body">
      <div style="float: left; margin-bottom: 30px; margin-right: 10px;">
        <div>{{ item.chain + ':' + item.chainId }}</div>
        <!-- <div style="width: 60px; height: 60px;"/> -->
      </div>
    </div>
  </div>
</template>

<script>
import * as transitSwap from '@transitswap/js-sdk'
// import Web3 from 'web3';
import { Buffer } from 'buffer'
import {
  tronCheckAllowed,
  tradeNetworkFee,
  crossSwap,
  checkAllowed,
  getApprove,
  getNetWorkFee,
  signApprove,
  quoteCrossTransferLimit,
  createAccount,
  balanceEvent,
  signOnlySwap,
  swapQuete,
  send,
  getFee,
  chainApiKeys,
} from '../services/index'

export default {
  name: 'HelloWorld',
  props: {
    msg: String,
  },
  data() {
    return {
      noparamList: [],
      mobileMessage: '等待flutter调用',
      contractAddress: 'TRC-20 合约',
      functionSelector: 'transfer(address,uint256)',
      walletAddress: '0xc9e90f88932827c32065a5e0ddbf077e01cfa1ac',
      privateKey:
        '4fa2ce0741a6b031eb67abb8855a965c2dc3be2a9febc3c9bde3bc1841d39481',
      address: '',
      balance: '',
      isM: true, // 收否是手机
      chainList: [],
      hexValue: '',
      trc20Balance: []
    }
  },
  mounted() {
    // 将方法注册在window上
    window.Buffer = Buffer
    // 获取信息
    window.flutterCreateAccount = this.flutterCreateAccount
    // 获取余额
    window.flutterCoinBalance = this.flutterCoinBalance
    // 查看授权
    window.flutterCheckApprove = this.flutterCheckApprove
    // 获取授权
    window.flutterGetApprove = this.flutterGetApprove
    // 仅兑换
    window.flutterSignOnlySwap = this.flutterSignOnlySwap
    // 获取费用
    window.flutterGetFee = this.flutterGetFee
    // 转账
    window.flutterSend = this.flutterSend
    // 兑换
    window.flutterSignApprove = this.flutterSignApprove
    // 跨链限制
    window.flutterQuoteCrossTransferLimit = this.flutterQuoteCrossTransferLimit
    // 交易网费
    window.tradeNetworkFee = this.tradeNetworkFee
    // 跨链兑换
    window.flutterCrossSwap = this.flutterCrossSwap
    // 获取报价
    window.flutterSwapQuete = this.flutterSwapQuete
    // 获取报价
    window.flutterChainApiKeys = this.flutterChainApiKeys

    window.callJsFunction = this.callJsFunction
    if (window.tronWeb) {
      let walletAddress = window.tronWeb.defaultAddress.base58
      console.log(walletAddress)
    }
  },
  created() {
    this.isM = true;
  },
  methods: {
    // 移动端获取报价
    flutterSwapQuete(v){
      this.swapQuete(v)
    },
    // 获取所有的APIKey
    flutterChainApiKeys(data){

      window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'account',
            chain: '',
            symbol: '',
            balance: '',
            address: '传递API',
            isfrom: true,
            // result: result,
          }),
        )

      console.log('传递API Key1:', data);
      chainApiKeys(data);
    },
    // 移动端获取费用
    flutterGetFee(series,chain,node,fromAddress,fromPrivateKey,toAddress,value,type,tocontractAddress){
      this.getFee(series,chain,node,fromAddress,fromPrivateKey,toAddress,value,type,tocontractAddress);
    },
    // 移动端转账
    flutterSend(series,chain,node,fromAddress,fromPrivateKey,toAddress,value,type,tocontractAddress,contractPrecision){
      this.send(series,chain,node,fromAddress,fromPrivateKey,toAddress,value,type,tocontractAddress,contractPrecision);
    },
    
    // 移动端跨链限制查询
    flutterQuoteCrossTransferLimit(token0, token1, fchain, tochain) {
      this.quoteCrossTransferLimit(token0, token1, fchain, tochain)
    },
    // 移动端兑换
    flutterSignOnlySwap(series,chain,node,address,privateKey,contract,fun,options,parameter,issuer,from,to,value,data) {
      this.signOnlySwap(series,chain,node,address,privateKey,contract,fun,options,parameter,issuer,from,to,value,data)
    },
    // 移动端跨链兑换
    flutterCrossSwap(series,fchain,fnode,faddress,fprivateKey, toChain, fcontract,tofcontract, toAddress, router,value,data,fun, options, parameter, issuer) {
      this.crossSwap(series,fchain,fnode,faddress,fprivateKey, toChain, fcontract,tofcontract, toAddress, router,value,data,fun, options, parameter, issuer)
    },
    // 移动端获取余额
    flutterCoinBalance(
      series,
      node,
      chain,
      symbol,
      isChain,
      address,
      contractAddress,
      isfrom,
      privateKey,
      contractPrecision,
    ) {
      this.balanceEvent(
        series,
        privateKey,
        symbol,
        node,
        chain,
        isChain,
        address,
        contractAddress,
        isfrom,
        contractPrecision,
      )
    },
    // 移动端签名交易
    flutterSignApprove(
      series,
      node,
      chain,
      address,
      privateKey,
      toCAddress,
      fCAddress,
      precision,
      value,
      exchangeModel
    ) {
      this.signApprove(
        series,
        node,
        chain,
        address,
        privateKey,
        toCAddress,
        fCAddress,
        precision,
        value,
        exchangeModel
      )
    },
    // 移动端检查授权
    flutterCheckApprove(node, chain, address, privateKey, cAddress, precision) {
      this.checkAllowed(node, chain, address, privateKey, cAddress, precision)
    },
    // 移动端获取授权信息
    flutterGetApprove(
      node,
      chain,
      address,
      privateKey,
      cAddress,
      precision,
      value,
      exchangeModel,
      aggregator
    ) {
      this.getApprove(
        node,
        chain,
        address,
        privateKey,
        cAddress,
        precision,
        value,
        exchangeModel,
        aggregator
      )
    },
    async checkAllowed(node, chain, address, privateKey, cAddress, precision) {
      let needApprove = await checkAllowed(node, chain, {
        address: address,
        privateKey: privateKey,
        contractAddress: cAddress,
        contractPrecision: precision,
      })
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'checkApprove',
            chain: chain,
            symbol: '',
            balance: '',
            address: address,
            isfrom: true,
            result: needApprove,
          }),
        )
      }

      console.log(needApprove == true ? '需要授权' : '不需要授权')
      this.address = needApprove == true ? '需要授权' : '不需要授权'
    },
    flutterCreateAccount(privateKey, series,index, mnemonic) {
      this.flutterCreateAccountEvent(privateKey, series,index, mnemonic)
    },
    async flutterCreateAccountEvent(privateKey, series,index, mnemonic) {
      let result = await createAccount(privateKey, series,index, mnemonic)
      console.log('获取地址addressresult: ', result)
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'account',
            chain: '',
            symbol: '',
            balance: '',
            address: '',
            isfrom: true,
            result: result,
          }),
        )
      }
    },
    isMobile() {
      let flag = navigator.userAgent.match(
        /(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i,
      )
      if (flag.indexOf('phone')) {
        return '1'
      }
      return flag
    },
    // 获取授权
    async getApprove(
      node,
      chain,
      address,
      privateKey,
      cAddress,
      precision,
      value,
      exchangeModel,
      aggregator
    ) {
      let da = []
      da['address'] = address
      da['privateKey'] = privateKey
      da['contractAddress'] = cAddress
      da['contractPrecision'] = precision
      let res = await getApprove(
        node,
        chain,
        da,
        cAddress,
        value,
        exchangeModel,
        aggregator
      )
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'getApprove',
            chain: chain,
            symbol: '',
            balance: '',
            address: address,
            isfrom: true,
            result: res,
          }),
        )
      }
    },
    // 获取网络费用
    async fluttergetNetWorkFee(node, chain, fromAddress,toAddress,value,privateKey){
      let res = await getNetWorkFee(node, chain, fromAddress,toAddress,value,privateKey)
      window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'getNetWorkFee',
            chain: chain,
            symbol: '',
            balance: '',
            address: fromAddress,
            isfrom: true,
            result: res,
          }),
        )
    },
    // signOnlySwap
    async signOnlySwap(series,chain,node,address,privateKey,contract,fun,options,parameter,issuer,from,to,value,data
    ) {
      let swap = await signOnlySwap(series,chain,node,address,privateKey,contract,fun,options,parameter,issuer,from,to,value,data);
      console.log('****兑换完成*****');
      console.log(swap);
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'signApprove',
            chain: chain,
            symbol: '',
            balance: '',
            address: address,
            isfrom: true,
            result: swap,
          }),
        )
      }
    },
    // 同链兑换
    async signApprove(
      series,
      node,
      chain,
      address,
      privateKey,
      toCAddress,
      fCAddress,
      precision,
      value,
      exchangeModel
    ) {
      console.log('********交易开始******')
      // 去签名授权
      let sign = await signApprove(
        series,
        node,
        chain,
        {
          address: address,
          privateKey: privateKey,
          contractAddress: toCAddress,
          toCAddress: toCAddress,
          contractPrecision: precision,
        },
        fCAddress,
        value,
        exchangeModel
      )
      let res
      if (sign == undefined || sign.txid == undefined) {
        res = sign;
        res['success'] = false;
      } else {
        res = sign
        res['success'] = true
        res['message'] = 'success'
      }
      console.log('********交易完成******',res)
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'signApprove',
            chain: chain,
            symbol: '',
            balance: '',
            address: address,
            isfrom: true,
            result: res,
          }),
        )
      }
    },
    // 跨链限制
    async quoteCrossTransferLimit(token0, token1, fchain, tochain) {
      let res = await quoteCrossTransferLimit(token0, token1, fchain, tochain)
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'limit',
            chain: fchain,
            symbol: '',
            balance: '',
            address: '',
            isfrom: true,
            result: res,
          }),
        )
      }
    },
    // 获取费用
    async getFee(series,chain,node,fromAddress,fromPrivateKey,toAddress,value,type,tocontractAddress){
      let res = await getFee(series,chain,node,fromAddress,fromPrivateKey,toAddress,value,type,tocontractAddress)
      if (this.isM == true) {
        console.log('交易费用');
        console.log(res);
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'getFee',
            chain: chain,
            symbol: '',
            balance: '',
            address: '',
            isfrom: true,
            result: res,
          }),
        )
      }
    },
    // 转账
    async send(series,chain,node,fromAddress,fromPrivateKey,toAddress,value,type,tocontractAddress,contractPrecision){
      let res = await send(series,chain,node,fromAddress,fromPrivateKey,toAddress,value,type,tocontractAddress,contractPrecision)
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'send',
            chain: chain,
            symbol: '',
            balance: '',
            address: '',
            isfrom: true,
            result: res,
          }),
        )
      }
    },
    async swapQuete(v){
       let res = await swapQuete(v)
      if (this.isM == true) {
        console.log('--------成功---------')
        console.log(res)
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'quete',
            chain: res,
            symbol: '',
            balance: '',
            address: '',
            isfrom: true,
            result: res,
          }),
        )
      }
    },
    
    async tradeNetworkFee(isChain,series,chain,node,address,privateKey,contract,fun,options,parameter,issuer,from,to,value,data,toAddress) {
      let res = await tradeNetworkFee(isChain,series,chain,node,address,privateKey,contract,fun,options,parameter,issuer,from,to,value,data,toAddress)
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'tradeNetworkFee',
            chain: chain,
            symbol: '',
            balance: '',
            fchain: chain,
            tochain: chain,
            isfrom: true,
            result: res,
          }),
        )
      }
    },

    // 跨链交易
    // token0, token1, decimal0, decimal1,fromw, tow, amountIn, fromPrivateKey,toPrivateKey, fchain, tochain
    async crossSwap(series,fchain,fnode,faddress,fprivateKey, toChain, fcontract,tocontract, toAddress, router,value,data,fun, options, parameter, issuer) {
      let res = await crossSwap(series,fchain,fnode,faddress,fprivateKey, toChain, fcontract,tocontract, toAddress, router,value,data,fun, options, parameter, issuer)
      if (this.isM == true) {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'signApprove',
            chain: fchain,
            symbol: '',
            balance: '',
            fchain: fchain,
            tochain: toChain,
            isfrom: true,
            result: res,
          }),
        )
      }
    },

    // 获取支持的链
    async getSupportChain() {
      this.mobileMessage = '1232323';
      window.ethereum.wallet = {address: "0xc9e90f88932827c32065a5e0ddbf077e01cfa1ac"};

      console.log(window.document);

      window.handlerName.postMessage('window');

      // window.handlerName.postMessage(wallet);

    },
    // 获取支持的跨链的链
    async getQuoteCrossTokens() {
    
    },
    async quoteDetails() {
      const hash =
        '0x0cec30133c4362c9053266e3bc67a5f2d25aac5d0a75a5a46e3cbc37a9a91573'
      const res = await transitSwap.swapV1.quoteDetails(hash)
      console.log('res out:', res)
      console.log('amount out:', res.getAmountOut())
    },
    callJsFunction(str) {
      this.mobileMessage = str
      return 'js调用成功'
    },
    callFlutter() {},
    callJS() {
      this.isMobileDes = '223'
      this.$message.error('存储失败')
    },
    async doSwap(
      defaultSwap,
      currentChainId,
      fromItem,
      toItem,
      slipValue,
      currentSymbolItem,
      fromAmount,
      amountOutMin,
    ) {
      this.mobileMessage = fromAmount
      try {
        console.log('======开始兑换======')
        const { resp, respx } = await transitSwap.doSwap(
          defaultSwap,
          currentChainId,
          fromItem,
          toItem,
          slipValue,
          currentSymbolItem,
          fromAmount,
          amountOutMin,
        )
        console.log('======兑换完成======')
        var item = {
          type: 4,
          txId: respx.transactionHash,
          toAddress: resp.tx.to,
          slippage: Number(slipValue.value),
          fromSymbol: fromItem.value.symbol,
          fromAmount: resp.fromTokenAmount,
          toSymbol: toItem.value.symbol,
          toAmount: resp.toTokenAmount,
        }
        return item
      } catch (error) {
        return 'swap fail'
      }
    },

    async balanceEvent(
      series,
      privateKey,
      symbol,
      node,
      chain,
      isChain,
      address,
      contractAddress,
      isfrom,
      contractPrecision,
    ) {
      let balanceCount;
        balanceCount = await balanceEvent(
          series,
          privateKey,
          symbol,
          node,
          chain,
          isChain,
          address,
          contractAddress,
          isfrom,
          contractPrecision,
        );
      if (series == 'TRX' || series == 'ETH') {
        window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'balance',
            chain: chain,
            contractAddress: balanceCount['contractAddress'],
            symbol: balanceCount['symbol'],
            balance:balanceCount['balance'],
            address:balanceCount['address'],
            trc20: series == 'TRX' ? balanceCount['trc20'] : [],
            isfrom: isfrom == '1' ? true : false,
            success: balanceCount['success']
          }),
        )
      } else {
         window.handlerName.postMessage(
          JSON.stringify({
            code: 2000,
            key: 'balance',
            chain: chain,
            contractAddress: series == 'TRX' ?  balanceCount['symbol'] : contractAddress,
            symbol: series == 'TRX' ?  balanceCount['symbol'] : symbol,
            balance:series == 'TRX' ? balanceCount['balance'] : balanceCount,
            address:series == 'TRX' ?  balanceCount['address'] :  address,
            trc20: series == 'TRX' ? balanceCount['trc20'] : [],
            isfrom: isfrom == '1' ? true : false,
            success: balanceCount['success']
          }),
        )
      }
    },
    hexToString(){
     this.flutterCoinBalance('ETH','https://rpc.ankr.com/eth','ETH','ETH','1','0xba32afFA5a76f48F657835604401A5405D98318E','0x0000000000000000000000000000000000000000','1','a84d12f1831976c597f012fdae4a31656427df6958e7028025800918c799b42b','18');
    },
    // tronCheckAllowed
    tronCheckAllowed() {
      tronCheckAllowed()
    },
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
title1 {
  color: aquamarine;
  width: 500px;
  height: 40px;
  color: #42b983;
  font-size: 30px;
  border-left: 1px solid #000;
}
and {
  color: aquamarine;
  width: 500px;
  height: 40px;
  color: #42b983;
  background-color: burlywood;
  background-color: #42b983;
  font-size: 30px;
  border-left: 1px solid #000;
  margin-bottom: 30px;
}
btn_style {
  margin-left: 10px;
  margin-right: 10px;
  margin-top: 20px;
  width: 60px;
  height: 40px;
  font-size: 30px;
  border-left: 1px solid #000;
  background-color: burlywood;
  text-align: center;
  align-items: center;
}
</style>
