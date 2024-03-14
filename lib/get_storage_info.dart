import 'dart:async';

import 'package:flutter/services.dart';

enum DeviceStorageType {
  internal,
  external,
}

class GetStorageInfo {
  static const MethodChannel _channel = MethodChannel('get_storage_info');

  /// Get internal storage free space in bytes.
  static Future<int> get getStorageFreeSpace async {
    final int freeSpace = await _channel.invokeMethod('getStorageFreeSpace');
    return freeSpace;
  }

  /// Get internal storage total space in bytes.
  static Future<int> get getStorageTotalSpace async {
    final int totalSpace = await _channel.invokeMethod('getStorageTotalSpace');
    return totalSpace;
  }

  /// Get internal storage used space in bytes.
  static Future<int> get getStorageUsedSpace async {
    final int usedSpace = await _channel.invokeMethod('getStorageUsedSpace');
    return usedSpace;
  }

  /// Get external storage total space in bytes.
  static Future<int> get getExternalStorageTotalSpace async {
    final int totalSpace =
        await _channel.invokeMethod('getExternalStorageTotalSpace');
    return totalSpace;
  }

  /// Get external storage free space in bytes.
  static Future<int> get getExternalStorageFreeSpace async {
    final int freeSpace =
        await _channel.invokeMethod('getExternalStorageFreeSpace');
    return freeSpace;
  }

  /// Get external storage used space in bytes.
  static Future<int> get getExternalStorageUsedSpace async {
    final int usedSpace =
        await _channel.invokeMethod('getExternalStorageUsedSpace');
    return usedSpace;
  }

  /// Get internal storage free space in MB.
  static Future<double> get getStorageFreeSpaceInMB async {
    final double freeSpace =
        await _channel.invokeMethod('getStorageFreeSpaceInMB');
    return freeSpace;
  }

  /// Get internal storage used space in MB.
  static Future<double> get getStorageUsedSpaceInMB async {
    final double usedSpace =
        await _channel.invokeMethod('getStorageUsedSpaceInMB');
    return usedSpace;
  }

  /// Get internal storage total space in MB.
  static Future<double> get getStorageTotalSpaceInMB async {
    final double totalSpace =
        await _channel.invokeMethod('getStorageTotalSpaceInMB');
    return totalSpace;
  }

  /// Get internal storage free space in GB.
  static Future<double> get getStorageFreeSpaceInGB async {
    final double freeSpace =
        await _channel.invokeMethod('getStorageFreeSpaceInGB');
    return freeSpace;
  }

  /// Get internal storage used space in GB.
  static Future<double> get getStorageUsedSpaceInGB async {
    final double usedSpace =
        await _channel.invokeMethod('getStorageUsedSpaceInGB');
    return usedSpace;
  }

  /// Get internal storage total space in GB.
  static Future<double> get getStorageTotalSpaceInGB async {
    final double totalSpace =
        await _channel.invokeMethod('getStorageTotalSpaceInGB');
    return totalSpace;
  }

  /// Get external storage free space in MB.
  static Future<double> get getExternalStorageFreeSpaceInMB async {
    final double freeSpace =
        await _channel.invokeMethod('getExternalStorageFreeSpaceInMB');
    return freeSpace;
  }

  /// Get external storage used space in MB.
  static Future<double> get getExternalStorageUsedSpaceInMB async {
    final double usedSpace =
        await _channel.invokeMethod('getExternalStorageUsedSpaceInMB');
    return usedSpace;
  }

  /// Get external storage total space in MB.
  static Future<double> get getExternalStorageTotalSpaceInMB async {
    final double totalSpace =
        await _channel.invokeMethod('getExternalStorageTotalSpaceInMB');
    return totalSpace;
  }

  /// Get external storage free space in GB.
  static Future<double> get getExternalStorageFreeSpaceInGB async {
    final double freeSpace =
        await _channel.invokeMethod('getExternalStorageFreeSpaceInGB');
    return freeSpace;
  }

  /// Get external storage used space in GB.
  static Future<double> get getExternalStorageUsedSpaceInGB async {
    final double usedSpace =
        await _channel.invokeMethod('getExternalStorageUsedSpaceInGB');
    return usedSpace;
  }

  /// Get external storage total space in GB.
  static Future<double> get getExternalStorageTotalSpaceInGB async {
    final double totalSpace =
        await _channel.invokeMethod('getExternalStorageTotalSpaceInGB');
    return totalSpace;
  }

  /// Get the size of [directory] in MB.
  static Future<double> getSizeOfDirectoryInMB(String directory) async {
    final double directorySize = await _channel
        .invokeMethod('getSizeOfDirectoryInMB', {'directory': directory});
    return directorySize;
  }

  /// Get the [DeviceStorageType] based on the given [path].
  static DeviceStorageType getStorageTypeFromPath(String path) {
    // Notice there is no end slash (that is important)
    return path.startsWith('/storage/emulated/0') == true
        ? DeviceStorageType.internal
        : DeviceStorageType.external;
  }

  /// Get a double from 0.0 to 1.0 representing the storage usage value based
  /// on [storageUsed] and [storageTotal]. This is useful for storage indicators.
  ///
  /// The [storageUsed] and [storageTotal] values should be in GB.
  static double getStorageUsageValue(double storageUsed, double storageTotal) {
    final double storageUsageValue =
        (((storageUsed / storageTotal) * 100.0) * 0.01);
    return storageUsageValue;
  }

  /// Get whether the given [storageType] is low on storage, based on the [threshold].
  static Future<bool> getIsLowOnStorage(DeviceStorageType storageType,
      {double threshold = 0.98}) async {
    double storageTotal = 0.0;
    double storageUsed = 0.0;
    if (storageType == DeviceStorageType.internal) {
      storageTotal = await GetStorageInfo.getStorageTotalSpaceInGB;
      storageUsed = await GetStorageInfo.getStorageUsedSpaceInGB;
    } else if (storageType == DeviceStorageType.external) {
      storageTotal = await GetStorageInfo.getExternalStorageTotalSpaceInGB;
      storageUsed = await GetStorageInfo.getExternalStorageUsedSpaceInGB;
    } else {
      throw Exception('storageType must be a value of DeviceStorageType');
    }

    double storageUsageValue = getStorageUsageValue(storageUsed, storageTotal);

    return getIsStorageBelowThreshold(storageUsageValue, threshold);
  }

  /// Get whether [storageUsageValue] is above the storage usage threshold for low storage.
  static bool getIsStorageBelowThreshold(
      double storageUsageValue, double threshold) {
    if (storageUsageValue <= 0.0 || storageUsageValue >= 1.0) {
      throw Exception(
          'storageUsageValue must be within the range of 0.0 and 1.0');
    }
    if (threshold <= 0.0 || threshold >= 1.0) {
      throw Exception('threshold must be within the range of 0.0 and 1.0');
    }

    if (storageUsageValue >= threshold) {
      return true;
    } else {
      return false;
    }
  }
}
