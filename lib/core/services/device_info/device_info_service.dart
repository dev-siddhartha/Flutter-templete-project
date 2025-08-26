import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/core/model/device_info_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:unique_device_identifier/unique_device_identifier.dart';

class DeviceInfoService {
  DeviceInfoService._();

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<DeviceInfoModel> getDeviceInfo() async {
    String? identifier = await UniqueDeviceIdentifier.getUniqueIdentifier();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    late DeviceInfoModel deviceInfoModel;

    String appName = packageInfo.appName;
    String appInstallerStore = packageInfo.installerStore ?? "";
    String appPackageName = packageInfo.packageName;
    String appBuildSignature = packageInfo.buildSignature;
    String appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await _deviceInfoPlugin.webBrowserInfo;

      deviceInfoModel = DeviceInfoModel(
        deviceModel: webBrowserInfo.browserName.name,
        deviceOs: "Flutter Web",
        deviceFingerPrint: identifier ?? webBrowserInfo.userAgent ?? "",
        deviceName: webBrowserInfo.browserName.name,
        deviceOsName: webBrowserInfo.appName ?? "",
        deviceOsVersion: webBrowserInfo.appCodeName ?? "",
        deviceSDKVersion: webBrowserInfo.appVersion ?? "",
        deviceBrand: webBrowserInfo.browserName.name,
        isPhysicalDevice: false,
        appInstallerStore: appInstallerStore,
        appPackageName: appPackageName,
        appName: appName,
        appBuildSignature: appBuildSignature,
        appVersion: appVersion,
      );
      return deviceInfoModel;
    } else if (Platform.isAndroid) {
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

class DeviceParserModel {
  String? deviceName;
  String? deviceOsName;
  String? deviceBrand;

  DeviceParserModel({
    this.deviceName,
    this.deviceOsName,
    this.deviceBrand,
  });

  factory DeviceParserModel.fromCustomString(String raw) {
    final parts = raw.split('%%');
    final Map<String, String> map = {};

    for (final part in parts) {
      final kv = part.split(':');
      if (kv.length == 2) {
        map[kv[0]] = kv[1];
      }
    }

    return DeviceParserModel(
      deviceName: map['deviceName'] ?? '',
      deviceOsName: map['deviceOsName'] ?? '',
      deviceBrand: map['deviceBrand'] ?? '',
    );
  }
}
