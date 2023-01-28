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
    'ripple': {
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
    'avalanche-2': {
      'name': 'Avalanche',
      'symbol': 'AVAX',
    },
    'cosmos': {
      'name': 'Cosmos',
      'symbol': 'ATOM',
    },
  };
  static const stocks = {
    'AAPL': {'name': 'Apple Inc.', 'symbol': 'AAPL'},
    'MSFT': {'name': 'Microsoft Corporation', 'symbol': 'MSFT'},
    'AMZN': {'name': 'Amazon.com, Inc.', 'symbol': 'AMZN'},
    'FB': {'name': 'Facebook, Inc.', 'symbol': 'FB'},
    'GOOGL': {'name': 'Alphabet Inc.', 'symbol': 'GOOGL'},
    'TSLA': {'name': 'Tesla, Inc.', 'symbol': 'TSLA'},
    'NFLX': {'name': 'Netflix, Inc.', 'symbol': 'NFLX'},
  };

  static List<String> getCryptocurrencyIds() {
    return cryptocurrencies.keys.toList();
  }

  static String getCryptocurrencyName(String id) {
    return cryptocurrencies[id]!['name']!;
  }

  static String getCryptocurrencySymbol(String id) {
    return cryptocurrencies[id]!['symbol']!;
  }

  static List<String> getStockIds() {
    return stocks.keys.toList();
  }

  static String getStockName(String id) {
    return stocks[id]!['name']!;
  }

  static String getStockSymbol(String id) {
    return stocks[id]!['symbol']!;
  }
}
