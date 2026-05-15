class AssetFile {
  final String name;
  final String pdfUrl;
  final String fileSize;
  final String fileType;
  // Safe local filename used for temp storage after download
  final String localFileName;

  const AssetFile({
    required this.name,
    required this.pdfUrl,
    required this.fileSize,
    required this.fileType,
    required this.localFileName,
  });
}

class AssetFolder {
  final String name;
  final List<AssetFile> files;

  const AssetFolder({required this.name, required this.files});

  String get fileCountLabel {
    final count = files.length;
    return '$count ${count == 1 ? 'file' : 'files'}';
  }
}

class AssetsData {
  static const List<AssetFolder> folders = [
    AssetFolder(
      name: 'Nestle',
      files: [
        AssetFile(
          name: 'Nestlé Policy on implementing the WHO Code',
          pdfUrl: 'https://ahmmedthanveer-appdeveloper-cv-rest-apisfirebase-dart.tiiny.site',
          fileSize: '4.9 MB',
          fileType: 'PDF',
          localFileName: 'nestle_who_policy.pdf',
        ),
        AssetFile(
          name: 'Nestlé Congress Programme Guide 2026',
          pdfUrl: 'https://ahmmedthanveer-appdeveloper-cv-rest-apisfirebase-dart.tiiny.site',
          fileSize: '2.1 MB',
          fileType: 'PDF',
          localFileName: 'nestle_congress_programme.pdf',
        ),
      ],
    ),
    AssetFolder(
      name: 'Clinical Resources',
      files: [
        AssetFile(
          name: 'Infant Nutrition Guidelines 2026',
          pdfUrl: 'https://ahmmedthanveer-appdeveloper-cv-rest-apisfirebase-dart.tiiny.site',
          fileSize: '3.3 MB',
          fileType: 'PDF',
          localFileName: 'infant_nutrition_guidelines.pdf',
        ),
      ],
    ),
  ];
}
