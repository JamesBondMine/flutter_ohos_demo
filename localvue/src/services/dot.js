
// import Decimal from 'decimal.js';
// import UUID from 'short-uuid';
// const networkMap = {
//     KSM: 2,
//     DOT: 0,
//     WND: 42,
// };

// function callWebview(method, params) {
//     console.log('start webview call');
//     const id = UUID.generate();
//     const instance = plus.webview.create(
//         '_www/static/tools/empty.html',
//         'dot_platform_hd',
//         {
//             top: '0px',
//             bottom: '0px',
//         },
//         {
//             params,
//             method,
//             callId: id,
//         }
//     );
//     instance.appendJsFile('_www/static/tools/dotTool.js');
//     console.log('start webview inject');
//     return new Promise((resolve, reject) => {
//         function callback(data) {
//             console.log('finish webview call:', data);
//             resolve(data);
//             instance.close();
//         }
//         uni.$once('$webview:' + id, callback);
//         // 超时取消
//         setTimeout(() => {
//             uni.$off('$webview:' + id, callback);
//             reject('fail');
//             instance.close();
//         }, 10000);
//     });
// }

// export default class DOTWallet {
//     waitload = false;
//     instance = false;
//     privateKey = '';
//     address = '';
//     node = '';
//     chainType = 0;
//     chain = '';
//     constructor(node) {
//         this.node = node;
//     }

//     getNetwork() {
//         return this.chainType;
//     }

//     async getBalance(symbol) {
//         console.log('开始获取DOT余额');
//         const network = this.getNetwork();
//         const result = await callWebview('getBalance', [this.address, network, this.node]);
//         return new Decimal(result.data.free).div(Math.pow(10, 12)).toString();
//     }
//     async createSeed(index, mnemonic) {
//         const network = this.getNetwork();
//         const result = await callWebview('createAddress', [mnemonic, index, network]);
//         return result;
//     }
//     async send(to, value, options = { send: true }) {
//         console.log('开始转账');
//         const network = this.getNetwork();
//         const result = await callWebview('sendTransaction', [
//             this.address,
//             this.privateKey,
//             to,
//             value,
//             network,
//             this.node,
//         ]);
//         return result;
//     }

//     async recoverAddress(privateKey) {
//         return {};
//     }

// }