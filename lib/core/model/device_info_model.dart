
class DeviceInfoModel {
  String deviceModel;
  String deviceOs;
  String deviceFingerPrint;
  String deviceName;
  String deviceOsName;

  /// android 15 or ios 18
  String deviceOsVersion;

  /// API 34 or 24.1.0
  String deviceSDKVersion;
  String deviceBrand;
  bool isPhysicalDevice;

  // ============= Required for security purpose =============
  String appInstallerStore;
  String appPackageName;
  String appName;
  String appBuildSignature;
  String appVersion;

  DeviceInfoModel({
    required this.deviceModel,
    required this.deviceOs,
    required this.deviceFingerPrint,
    required this.deviceName,
    required this.deviceOsName,
    required this.deviceOsVersion,
    required this.deviceSDKVersion,
    required this.deviceBrand,
    required this.isPhysicalDevice,
    required this.appInstallerStore,
    required this.appPackageName,
    required this.appName,
    required this.appBuildSignature,
    required this.appVersion,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'deviceModel': deviceModel,
  //     'deviceOs': deviceOs,
  //     'deviceFingerPrint': deviceFingerPrint,
  //     'deviceName': deviceName,
  //     'deviceOsName': deviceOsName,
  //     'deviceOsVersion': deviceOsVersion,
  //     'deviceBrand': deviceBrand,
  //     'isPhysicalDevice': isPhysicalDevice,
  //     'appInstallerStore': appInstallerStore,
  //     'appPackageName': appPackageName,
  //     'appName': appName,
  //     'appBuildSignature': appBuildSignature,
  //     'appVersion': appVersion,
  //   };
  // }

  // factory DeviceInfoModel.fromMap(Map<String, dynamic> map) {
  //   return DeviceInfoModel(
  //     deviceModel: map['deviceModel'] as String,
  //     deviceOs: map['deviceOs'] as String,
  //     deviceFingerPrint: map['deviceFingerPrint'] as String,
  //     deviceName: map['deviceName'] as String,
  //     deviceOsName: map['deviceOsName'] as String,
  //     deviceOsVersion: map['deviceOsVersion'] as String,
  //     deviceBrand: map['deviceBrand'] as String,
  //     isPhysicalDevice: map['isPhysicalDevice'] ?? false,
  //     appInstallerStore: map['appInstallerStore'] as String,
  //     appPackageName: map['appPackageName'] as String,
  //     appName: map['appName'] as String,
  //     appBuildSignature: map['appBuildSignature'] as String,
  //     appVersion: map['appVersion'] as String,
  //   );
  // }
}
