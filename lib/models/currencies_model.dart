class Currencies {
  final String base;
  final Rates rates;

  Currencies({ this.base, this.rates });

  factory Currencies.fromJson(Map<String, dynamic> json) {
    return Currencies(
      base: json['base'] ?? '',
      rates: Rates.fromMap(json['rates'])
    );
  }
}

class Base {
  final String base;
  
  Base({ this.base });

  factory Base.fromMap(Map data) {
    return Base(
      base: data['base'] ?? '',
    );
  }
}

class Rates {
  final double ils;
  final double eur;
  final double usd;
  final double gbp;
  
  Rates({ this.ils, this.eur, this.gbp, this.usd });

  factory Rates.fromMap(Map data) {
    return Rates(
      ils: data['ILS'] ?? 0,
      eur: data['EUR'] ?? 0,
      usd: data['USD'] ?? 0,
      gbp: data['GBP'] ?? 0,
    );
  }
}
