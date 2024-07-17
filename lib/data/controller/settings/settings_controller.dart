
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  ApiClient apiClient;
  SettingsController({required this.apiClient});

  bool submitLoading = false;

  bool isSoundEnable = false;
  bool isVibrationEnable = false;

  void loadSetting() async {

    isSoundEnable =  apiClient.getSoundStatus();
    isVibrationEnable =  apiClient.getVibrationStatus();

    update();

  }

  setSound(bool soundStatus){
    isSoundEnable = soundStatus;
    apiClient.setSoundStatus(soundStatus);
    update();
  }

  setVibration(bool vibrationStatus){
    isVibrationEnable = vibrationStatus;
    apiClient.setSoundStatus(vibrationStatus);
    update();
  }


}
