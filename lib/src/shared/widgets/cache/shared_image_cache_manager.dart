import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SharedImageCacheManager {
  SharedImageCacheManager._();
  static final CacheManager instance = CacheManager(
    Config(
      'shared_image_cache',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
      repo: JsonCacheInfoRepository(databaseName: 'sharedImageCache'),
      fileService: HttpFileService(),
    ),
  );
  static Future<void> clear() => instance.emptyCache();
}