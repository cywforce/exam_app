import 'package:exam_app/sdk/api/getSettings.dart';
import 'package:meta/meta.dart';
import 'package:exam_app/utils/Utils.dart';

class SplashScreenController  {
  final SplashScreenListener listener;
  final PreferenceManager preferenceManager;

  SplashScreenController({@required this.listener})
      : preferenceManager = PreferenceManager();

  void callApi() async {
    try {
      GetSettingsModel getSettings = await getSettingsAPI(
          {"Client-Service": "frontend-client", "Auth-Key" : "simplerestapi"},
          {"module" : "settings", "service" : "getSettings"}
          );
      listener.onApiSuccess(model: getSettings);
      await new Future.delayed(const Duration(milliseconds: 3000));
      listener.routeTo(route: Routes.LOGIN);
    }catch (e){
      listener.onApiFailure(failure: Failures.NO_INTERNET);
    }
  }

}

abstract class SplashScreenListener {
  void onApiFailure({@required Failures failure});
  void onApiSuccess({@required GetSettingsModel model});
  void routeTo({@required Routes route});
}

enum Failures { NO_INTERNET, UNKNOWN }

enum Routes { LOGIN, HOME, MY_DOWNLOADS }


