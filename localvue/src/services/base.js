
const WalletInfo = {
    address: "",
    address_P2PKH: "",
    witness_P2WPKH: "",
    privateKey: ""
};

export default class WalletBase {
    createSeed(index, mnemonic){
        console.log(index)
        console.log(mnemonic)
        return WalletInfo;
    }
    getBalance(symbol, isChain){
        console.log(symbol)
        console.log(isChain)
    }
}