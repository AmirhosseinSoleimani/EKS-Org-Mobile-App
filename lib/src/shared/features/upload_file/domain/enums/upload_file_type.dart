enum UploadFileType {
  image,
  pdf,
  document,
  archive,
  attachment,
}

extension UploadFileTypeConfig on UploadFileType {
  List<String> get allowedExtensions {
    return switch (this) {
      UploadFileType.image => const ['png', 'jpg', 'jpeg'],
      UploadFileType.pdf => const ['pdf'],
      UploadFileType.document => const ['pdf', 'doc', 'docx'],
      UploadFileType.archive => const ['zip'],
      UploadFileType.attachment => const ['png', 'jpg', 'jpeg', 'pdf', 'zip'],
    };
  }

  int get maxFileSizeInBytes {
    return switch (this) {
      UploadFileType.image => 2 * 1024 * 1024,
      UploadFileType.pdf ||
      UploadFileType.document ||
      UploadFileType.attachment => 5 * 1024 * 1024,
      UploadFileType.archive => 10 * 1024 * 1024,
    };
  }

  int get maxFileSizeInMegabytes => maxFileSizeInBytes ~/ (1024 * 1024);

  String get allowedExtensionsText {
    return allowedExtensions.map((item) => item.toUpperCase()).join('، ');
  }

  String get pickerDescription {
    return 'فرمت‌های مجاز: $allowedExtensionsText '
        '(حداکثر $maxFileSizeInMegabytes مگابایت)';
  }
}
