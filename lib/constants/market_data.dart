class MarketData {
  static const cryptocurrencies = {
    'bitcoin': {
      'name': 'Bitcoin',
      'symbol': 'BTC',
    },
    'ethereum': {
      'name': 'Ethereum',
      'symbol': 'ETH',
    },
    'tether': {
      'name': 'Tether',
      'symbol': 'USDT',
    },
    'solana': {
      'name': 'Solana',
      'symbol': 'SOL',
    },
    'shiba-inu': {
      'name': 'Shiba Inu',
      'symbol': 'SHIB',
    },
    'dogecoin': {
      'name': 'Dogecoin',
      'symbol': 'DOGE',
    },
    'xrp': {
      'name': 'Ripple',
      'symbol': 'XRP',
    },
    'cardano': {
      'name': 'Cardano',
      'symbol': 'ADA',
    },
    'stellar': {
      'name': 'Stellar',
      'symbol': 'XLM',
    },
    'matic-network': {
      'name': 'Polygon',
      'symbol': 'MATIC',
    },
    'chainlink': {
      'name': 'Chainlink',
      'symbol': 'LINK',
    },
    'tron': {
      'name': 'Tron',
      'symbol': 'TRX',
    },
    'avalanche': {
      'name': 'Avalanche',
      'symbol': 'AVAX',
    },
    'cosmos': {
      'name': 'Cosmos',
      'symbol': 'ATOM',
    },
  };
  static const stocks = {};

  static getCryptocurrencyIds() {
    return cryptocurrencies.keys.toList();
  }

  static getCryptocurrencyName(String id) {
    return cryptocurrencies[id]!['name'];
  }

  static getCryptocurrencySymbol(String id) {
    return cryptocurrencies[id]!['symbol'];
  }

  static getStockIds() {
    return stocks.keys.toList();
  }

  static getStockName(String id) {
    return stocks[id]!['name'];
  }

  static getStockSymbol(String id) {
    return stocks[id]!['symbol'];
  }
}
