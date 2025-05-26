class Country {
  final String name;
  final String flagUrl;
  final String currency;
  final String language;
  final String region;
  final String subregion;

  Country({
    required this.name,
    required this.flagUrl,
    required this.currency,
    required this.language,
    required this.region,
    required this.subregion,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'N/A',
      flagUrl: json['flags']['png'] ?? '',
      currency: json['currencies']?.entries.first.value['name'] ?? 'Desconhecida',
      language: json['languages']?.entries.first.value ?? 'Desconhecido',
      region: json['region'] ?? 'N/A',
      subregion: json['subregion'] ?? 'N/A',
    );
  }
}
