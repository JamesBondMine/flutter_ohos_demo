enum ChainType {
  trc20,
  erc20;

  @override
  toString() {
    return switch (this) {
      trc20 => 'TRC20',
      erc20 => 'ERC20',
    };
  }
}
