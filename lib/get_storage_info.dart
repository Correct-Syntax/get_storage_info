import 'dart:async';

import 'package:flutter/services.dart';

/// Device storage type
enum DeviceStorageType {
  internal,
  external,
}

/// A class through which all methods can be statically accessed.
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
    final int totalSpace = await _channel.invokeMethod('getExternalStorageTotalSpace');
    return totalSpace;
  }

  /// Get external storage free space in bytes.
  static Future<int> get getExternalStorageFreeSpace async {
    final int freeSpace = await _channel.invokeMethod('getExternalStorageFreeSpace');
    return freeSpace;
  }

  /// Get external storage used space in bytes.
  static Future<int> get getExternalStorageUsedSpace async {
    final int usedSpace = await _channel.invokeMethod('getExternalStorageUsedSpace');
    return usedSpace;
  }

  /// Get internal storage free space in MB.
  static Future<double> get getStorageFreeSpaceInMB async {
    final double freeSpace = await _channel.invokeMethod('getStorageFreeSpaceInMB');
    return freeSpace;
  }

  /// Get internal storage used space in MB.
  static Future<double> get getStorageUsedSpaceInMB async {
    final double usedSpace = await _channel.invokeMethod('getStorageUsedSpaceInMB');
    return usedSpace;
  }

  /// Get internal storage total space in MB.
  static Future<double> get getStorageTotalSpaceInMB async {
    final double totalSpace = await _channel.invokeMethod('getStorageTotalSpaceInMB');
    return totalSpace;
  }

  /// Get internal storage free space in GB.
  static Future<double> get getStorageFreeSpaceInGB async {
    final double freeSpace = await _channel.invokeMethod('getStorageFreeSpaceInGB');
    return freeSpace;
  }

  /// Get internal storage used space in GB.
  static Future<double> get getStorageUsedSpaceInGB async {
    final double usedSpace = await _channel.invokeMethod('getStorageUsedSpaceInGB');
    return usedSpace;
  }

  /// Get internal storage total space in GB.
  static Future<double> get getStorageTotalSpaceInGB async {
    final double totalSpace = await _channel.invokeMethod('getStorageTotalSpaceInGB');
    return totalSpace;
  }

  /// Get external storage free space in MB.
  static Future<double> get getExternalStorageFreeSpaceInMB async {
    final double freeSpace = await _channel.invokeMethod('getExternalStorageFreeSpaceInMB');
    return freeSpace;
  }

  /// Get external storage used space in MB.
  static Future<double> get getExternalStorageUsedSpaceInMB async {
    final double usedSpace = await _channel.invokeMethod('getExternalStorageUsedSpaceInMB');
    return usedSpace;
  }

  /// Get external storage total space in MB.
  static Future<double> get getExternalStorageTotalSpaceInMB async {
    final double totalSpace = await _channel.invokeMethod('getExternalStorageTotalSpaceInMB');
    return totalSpace;
  }

  /// Get external storage free space in GB.
  static Future<double> get getExternalStorageFreeSpaceInGB async {
    final double freeSpace = await _channel.invokeMethod('getExternalStorageFreeSpaceInGB');
    return freeSpace;
  }

  /// Get external storage used space in GB.
  static Future<double> get getExternalStorageUsedSpaceInGB async {
    final double usedSpace = await _channel.invokeMethod('getExternalStorageUsedSpaceInGB');
    return usedSpace;
  }

  /// Get external storage total space in GB.
  static Future<double> get getExternalStorageTotalSpaceInGB async {
    final double totalSpace = await _channel.invokeMethod('getExternalStorageTotalSpaceInGB');
    return totalSpace;
  }

  /// Get whether the external storage device is mounted and writable.
  static Future<bool> get isExternalStorageWritable async {
    final bool isWritable = await _channel.invokeMethod('isExternalStorageWritable');
    return isWritable;
  }

  /// Get the size of [directory] in MB.
  static Future<double> getSizeOfDirectoryInMB(String directory) async {
    final double directorySize = await _channel.invokeMethod('getSizeOfDirectoryInMB', {'directory': directory});
    return directorySize;
  }

  /// Get the [DeviceStorageType] based on the given [path].
  static DeviceStorageType getStorageTypeFromPath(String path) {
    // Notice there is no end slash (that is important)
    return path.startsWith('/storage/emulated') == false ? DeviceStorageType.external : DeviceStorageType.internal;
  }

  /// Get a double from 0.0 to 1.0 representing the storage usage value based
  /// on [storageUsed] and [storageTotal]. This is useful for storage indicators.
  ///
  /// The [storageUsed] and [storageTotal] values should be in GB.
  static double getStorageUsageValue(double storageUsed, double storageTotal) {
    final double storageUsageValue = (((storageUsed / storageTotal) * 100.0) * 0.01);
    return storageUsageValue;
  }

  /// Get whether the given [storageType] is low on storage, based on the [threshold] (in MB).
  static Future<bool> getIsLowOnStorage(DeviceStorageType storageType, {double threshold = 500.0}) async {
    double storageFree = 0.0;
    if (storageType == DeviceStorageType.internal) {
      storageFree = await GetStorageInfo.getStorageFreeSpaceInMB;
    } else if (storageType == DeviceStorageType.external) {
      storageFree = await GetStorageInfo.getExternalStorageFreeSpaceInMB;
    } else {
      throw Exception('storageType must be a value of DeviceStorageType');
    }

    return getIsStorageBelowThreshold(storageFree, threshold);
  }

  /// Get whether [storageUsageValue] is below the storage usage threshold for low storage.
  static bool getIsStorageBelowThreshold(double storageFree, double threshold) {
    if (storageFree <= threshold) {
      return true;
    } else {
      return false;
    }
  }
}
