class UserFacingErrorMessage {
  UserFacingErrorMessage._();

  static const String serviceUnavailable =
      'سرویس مورد نظر در دسترس نیست. لطفاً دوباره تلاش کنید یا با پشتیبانی تماس بگیرید.';

  static const String generic = 'عملیات با خطا مواجه شد.';

  static String serviceUnavailableFor(String serviceTitle) {
    final title = serviceTitle.trim();
    return title.isEmpty
        ? serviceUnavailable
        : 'سرویس $title در دسترس نیست. لطفاً دوباره تلاش کنید.';
  }

  static String resolve(
    String? message, {
    String fallback = generic,
    int maxLength = 280,
  }) {
    final normalized = message?.trim() ?? '';
    if (normalized.isEmpty) return fallback;

    if (isTechnical(normalized)) return serviceUnavailable;

    if (normalized.length <= maxLength) return normalized;
    return '${normalized.substring(0, maxLength).trim()}...';
  }

  static bool isTechnical(String message) {
    final normalized = message.trimLeft();
    final lower = normalized.toLowerCase();
    final lineCount = '\n'.allMatches(normalized).length + 1;

    return normalized.length > 600 ||
        lineCount > 8 ||
        normalized.startsWith('{') ||
        normalized.startsWith('[') ||
        lower.contains('exception') ||
        lower.contains('stack trace') ||
        lower.contains('system.') ||
        lower.contains('microsoft.') ||
        lower.contains('entityframework') ||
        lower.contains('sql') ||
        lower.contains(' at ') ||
        lower.contains('line ') ||
        lower.contains('https://') ||
        lower.contains('http://') ||
        lower.contains('<!doctype html') ||
        lower.contains('<html') ||
        lower.contains('socketexception') ||
        lower.contains('dioexception') ||
        lower.contains('formatexception') ||
        lower.contains('typeerror') ||
        lower.contains('null check operator') ||
        lower.contains('failed host lookup') ||
        lower.contains('internal server error') ||
        lower.contains('bad gateway') ||
        lower.contains('service unavailable') ||
        lower.contains('gateway timeout') ||
        lower.contains('response status code') ||
        lower.contains('traceid') ||
        lower.contains('is not a subtype of') ||
        lower.contains('invalid json') ||
        lower.contains('unexpected character') ||
        lower.contains('connection refused');
  }
}
