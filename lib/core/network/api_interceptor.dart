part of 'network.dart';

class ApiInterceptor extends Interceptor {
  factory ApiInterceptor() => _instance;
  static final ApiInterceptor _instance = ApiInterceptor._internal();

  ApiInterceptor._internal();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Retrieve the token (this function could get the token from secure storage or elsewhere)
      final box = Hive.box('userBox'); // Replace 'authBox' with your box name

      // Retrieve the token from Hive using the 'token' key
      final token = box.get('userKey', defaultValue: '');

      if (token != null && token.isNotEmpty) {
        // Add the Bearer token to the Authorization header
        options.headers['Authorization'] = 'Bearer ${token['token']}';
      }
    } catch (e) {
      // Handle errors if retrieving the token fails
      print("Error fetching token: $e");
    }

    return super.onRequest(options, handler); // Proceed with the request
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
