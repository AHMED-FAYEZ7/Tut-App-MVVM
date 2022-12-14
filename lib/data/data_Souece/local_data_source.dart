import 'package:advance_course_flutter/data/network/error_handler.dart';
import 'package:advance_course_flutter/data/responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000; // 1 MINUTE IN MILLIS

const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000; // 30s in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeToCache(HomeResponse homeResponse);

  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse storeDetailsResponse);

  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource{
  // run time cache
  Map<String , CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHome() async{
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if(cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)){
      // return response from cache
      return cachedItem.data;
    }else{
      // return error that cache is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async{
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if(cachedItem != null && cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)){
      // return response from cache
      return cachedItem.data;
    }else{
      // return error that cache is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse storeDetailsResponse) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(storeDetailsResponse);
  }

}

class CachedItem{
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem{
  bool isValid(int expirationTime){
    // expirationTime is 60 sec
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch; // 1:00:00

    bool isCacheValid = currentTimeInMillis - expirationTime < cacheTime; // 12:59:30
    // false if current time > 1:00:30
    // true if current time < 1:00:30
    return isCacheValid;
  }
}