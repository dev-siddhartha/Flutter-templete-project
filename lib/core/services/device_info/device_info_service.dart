import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_template/core/model/device_info_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:unique_identifier/unique_identifier.dart';


class DeviceInfoService {
  DeviceInfoService._();

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<DeviceInfoModel> getDeviceInfo() async {
    String? identifier = await UniqueIdentifier.serial;
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    late DeviceInfoModel deviceInfoModel;

    String appName = packageInfo.appName;
    String appInstallerStore = packageInfo.installerStore ?? "";
    String appPackageName = packageInfo.packageName;
    String appBuildSignature = packageInfo.buildSignature;
    String appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      deviceInfoModel = DeviceInfoModel(
        deviceModel: androidInfo.model,
        deviceOs: "Android",
        deviceFingerPrint: identifier ?? androidInfo.id,
        deviceName: androidInfo.name,
        deviceOsName: androidInfo.version.baseOS ?? "",
        deviceOsVersion: androidInfo.version.release,
        deviceSDKVersion: androidInfo.version.sdkInt.toString(),
        deviceBrand: androidInfo.brand,
        isPhysicalDevice: androidInfo.isPhysicalDevice,
        appInstallerStore: appInstallerStore,
        appPackageName: appPackageName,
        appName: appName,
        appBuildSignature: appBuildSignature,
        appVersion: appVersion,
      );

      return deviceInfoModel;
    } else {
      IosDeviceInfo iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
      deviceInfoModel = DeviceInfoModel(
        deviceModel: iosDeviceInfo.model,
        deviceOs: "iOS",
        deviceFingerPrint: identifier ?? iosDeviceInfo.systemVersion,
        deviceName: iosDeviceInfo.modelName,
        deviceOsName: iosDeviceInfo.systemName,
        deviceOsVersion: iosDeviceInfo.systemVersion,
        deviceSDKVersion: iosDeviceInfo.utsname.release,
        deviceBrand: "apple",
        isPhysicalDevice: iosDeviceInfo.isPhysicalDevice,
        appInstallerStore: appInstallerStore,
        appPackageName: appPackageName,
        appName: appName,
        appBuildSignature: appBuildSignature,
        appVersion: appVersion,
      );

      return deviceInfoModel;
    }
  }
}
