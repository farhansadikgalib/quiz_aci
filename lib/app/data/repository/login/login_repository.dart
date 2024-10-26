
import '../../../service/networkService/api_client.dart';
import '../../model/login/login_response.dart';

class LoginRepository {
  Future<LoginResponse> getLogin(phoneNumber) async {
    var response =
    await ApiClient(customBaseUrl: "https://apps.acibd.com/apps/kbdt/home/").get(
      "getquiz1?userid=$phoneNumber",
      getLogin,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return loginResponseFromJson(response.toString());
  }

}