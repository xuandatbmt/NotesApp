class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  const Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, '🇬🇧', 'English', 'en'),
      Language(2, '🇻🇳', 'Việt Nam', 'vi'),
      Language(3, '🇫🇷', 'France', 'fr'),
    ];
  }
}
