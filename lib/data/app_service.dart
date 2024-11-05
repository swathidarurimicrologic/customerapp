import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class AppClientService extends GetConnect {
  final appStorage = Get.find<AppStorage>();
  @override
  void onInit() {
    var token = (appStorage.loggedInUser != null)
        ? appStorage.loggedInUser['token'] != ''
            ? appStorage.loggedInUser['token']
            : ''
        : '';
    allowAutoSignedCert = true;
    httpClient.baseUrl = ""; //TODO: base url
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.addResponseModifier((request, response) async {
      return dataAndErrorHandler(response);
    });
    var headers = {'Authorization': "Bearer $token"};
    httpClient.addRequestModifier((Request request) {
      request.headers.addAll(headers);
      print('${request.url} request object');
      return request;
    });

    httpClient.addAuthenticator((Request request) async {
      request.headers.addAll(headers);
      return request;
    });

    super.onInit();
  }

  Response dataAndErrorHandler(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return response;
      case 400:
        if (response.body != null) {
          throw response.body['errorMessage'];
        } else {
          throw 'Something went wrong please trying again  StatusCode: ${response.statusCode}';
        }
      case 403:
        if (Get.currentRoute != Routes.LOGIN) {
          appStorage.resetStorage();
          Get.offAndToNamed(Routes.LOGIN);
        }
        throw 'Error occurred retry StatusCode: ${response.statusCode}';

      case 500:
        print(response.body);
        throw "Internal Server Error pls retry later StatusCode: ${response.statusCode}";
      case 404:
        throw "Requesting url not found in the server StatusCode: ${response.statusCode}";
      default:
        throw 'Error occurred retry StatusCode: ${response.statusCode}';
    }
  }
}
