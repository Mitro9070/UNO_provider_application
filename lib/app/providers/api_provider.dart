import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';

import '../../common/custom_trace.dart';
import '../services/auth_service.dart';
import '../services/global_service.dart';
import 'dio_client.dart';

mixin ApiClient {
  final globalService = Get.find<GlobalService>();
  final authService = Get.find<AuthService>();
  String baseUrl = '';
  late DioClient _httpClient;
  late dio.Options _optionsNetwork;
  late dio.Options _optionsCache;

  DioClient get httpClient => _httpClient;

  dio.Options get optionsNetwork => _optionsNetwork;

  dio.Options get optionsCache => _optionsCache;

  Future<ApiClient> init() async {
    _httpClient = DioClient(this.baseUrl, new dio.Dio());
    _optionsNetwork = _httpClient.optionsNetwork;
    _optionsCache = _httpClient.optionsCache;
    return this;
  }

  bool isLoading({String? task, List<String>? tasks}) {
    return _httpClient.isLoading(task: task, tasks: tasks);
  }

  void setLocale(String locale) {
    _optionsNetwork.headers?['Accept-Language'] = locale;
    _optionsCache.headers?['Accept-Language'] = locale;
  }

  void forceRefresh() {
    if (!foundation.kIsWeb && !foundation.kDebugMode) {
      _optionsCache = dio.Options(headers: _optionsCache.headers);
      _optionsNetwork = dio.Options(headers: _optionsNetwork.headers);
    }
  }

  void unForceRefresh() {
    if (!foundation.kIsWeb && !foundation.kDebugMode) {
      _optionsNetwork = buildCacheOptions(Duration(days: 3), forceRefresh: true, options: _optionsNetwork);
      _optionsCache = buildCacheOptions(Duration(minutes: 10), forceRefresh: false, options: _optionsCache);
    }
  }

  String getBaseUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    if (!baseUrl.endsWith('/')) {
      return baseUrl + '/' + path;
    }
    return baseUrl + path;
  }

  String getApiBaseUrl(String path) {
    String _apiPath = globalService.global.value.apiPath ?? '';
    if (path.startsWith('/')) {
      return getBaseUrl(_apiPath) + path.substring(1);
    }
    return getBaseUrl(_apiPath) + path;
  }

  Uri getApiBaseUri(String path) {
    return Uri.parse(getApiBaseUrl(path));
  }

  Uri getBaseUri(String path) {
    return Uri.parse(getBaseUrl(path));
  }

  void printUri(StackTrace stackTrace, Uri uri) {
    Get.log(CustomTrace(stackTrace, message: uri.toString()).toString());
  }
}
