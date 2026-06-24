import 'dart:async';
import 'package:flutter/services.dart';

/// Device storage type
enum DeviceStorageType { internal, external }

/// A class through which all methods can be statically accessed.
class GetStorageInfo {
  static const MethodChannel _channel = MethodChannel('get_storage_info');

  // Multipliers for raw byte unit conversion
  static const int _bytesInMB = 1024 * 1024;
  static const int _bytesInGB = 1024 * 1024 * 1024;

  // BASE BYTE METHODS (Native)

  /// Get internal storage free space in bytes.
  static Future<int> get getStorageFreeSpace async {
    return (await _channel.invokeMethod<int>('getStorageFreeSpace')) ?? 0;
  }

  /// Get internal storage total space in bytes.
  static Future<int> get getStorageTotalSpace async {
    return (await _channel.invokeMethod<int>('getStorageTotalSpace')) ?? 0;
  }

  /// Get internal storage used space in bytes.
  static Future<int> get getStorageUsedSpace async {
    return (await _channel.invokeMethod<int>('getStorageUsedSpace')) ?? 0;
  }

  /// Get external storage total space in bytes.
  static Future<int> get getExternalStorageTotalSpace async {
    return (await _channel.invokeMethod<int>('getExternalStorageTotalSpace')) ?? 0;
  }

  /// Get external storage free space in bytes.
  static Future<int> get getExternalStorageFreeSpace async {
    return (await _channel.invokeMethod<int>('getExternalStorageFreeSpace')) ?? 0;
  }

  /// Get external storage used space in bytes.
  static Future<int> get getExternalStorageUsedSpace async {
    return (await _channel.invokeMethod<int>('getExternalStorageUsedSpace')) ?? 0;
  }

  /// Get whether the external storage device is mounted and writable.
  static Future<bool> get isExternalStorageWritable async {
    return (await _channel.invokeMethod<bool>('isExternalStorageWritable')) ?? false;
  }

  /// Get the size of [directory] in MB.
  static Future<double> getSizeOfDirectoryInMB(String directory) async {
    // Invoke Native call passing raw directory bytes, convert locally
    final int? bytes = await _channel.invokeMethod<int>('getSizeOfDirectory', {'directory': directory});
    if (bytes == null) return 0.0;
    return bytes / _bytesInMB;
  }

  // LOCAL DART MATH CONVERSIONS

  /// Get internal storage free space in MB.
  static Future<double> get getStorageFreeSpaceInMB async => (await getStorageFreeSpace) / _bytesInMB;

  /// Get internal storage used space in MB.
  static Future<double> get getStorageUsedSpaceInMB async => (await getStorageUsedSpace) / _bytesInMB;

  /// Get internal storage total space in MB.
  static Future<double> get getStorageTotalSpaceInMB async => (await getStorageTotalSpace) / _bytesInMB;

  /// Get internal storage free space in GB.
  static Future<double> get getStorageFreeSpaceInGB async => (await getStorageFreeSpace) / _bytesInGB;

  /// Get internal storage used space in GB.
  static Future<double> get getStorageUsedSpaceInGB async => (await getStorageUsedSpace) / _bytesInGB;

  /// Get internal storage total space in GB.
  static Future<double> get getStorageTotalSpaceInGB async => (await getStorageTotalSpace) / _bytesInGB;

  /// Get external storage free space in MB.
  static Future<double> get getExternalStorageFreeSpaceInMB async => (await getExternalStorageFreeSpace) / _bytesInMB;

  /// Get external storage used space in MB.
  static Future<double> get getExternalStorageUsedSpaceInMB async => (await getExternalStorageUsedSpace) / _bytesInMB;

  /// Get external storage total space in MB.
  static Future<double> get getExternalStorageTotalSpaceInMB async => (await getExternalStorageTotalSpace) / _bytesInMB;

  /// Get external storage free space in GB.
  static Future<double> get getExternalStorageFreeSpaceInGB async => (await getExternalStorageFreeSpace) / _bytesInGB;

  /// Get external storage used space in GB.
  static Future<double> get getExternalStorageUsedSpaceInGB async => (await getExternalStorageUsedSpace) / _bytesInGB;

  /// Get external storage total space in GB.
  static Future<double> get getExternalStorageTotalSpaceInGB async => (await getExternalStorageTotalSpace) / _bytesInGB;

  // UTILITIES & STATICS

  /// Get the [DeviceStorageType] based on the given [path].
  static DeviceStorageType getStorageTypeFromPath(String path) {
    // Notice there is no end slash (that is important)
    return path.startsWith('/storage/emulated') == false ? DeviceStorageType.external : DeviceStorageType.internal;
  }

  /// Get a double from 0.0 to 1.0 representing the storage usage value based
  /// on [storageUsed] and [storageTotal]. This is useful for storage indicators.
  static double getStorageUsageValue(double storageUsed, double storageTotal) {
    if (storageTotal <= 0) return 0.0;
    return storageUsed / storageTotal;
  }

  /// Get whether the given [storageType] is low on storage, based on the [threshold] (in MB).
  static Future<bool> getIsLowOnStorage(DeviceStorageType storageType, {double threshold = 500.0}) async {
    final double storageFree = storageType == DeviceStorageType.internal
        ? await getStorageFreeSpaceInMB
        : await getExternalStorageFreeSpaceInMB;

    return getIsStorageBelowThreshold(storageFree, threshold);
  }

  /// Get whether [storageFree] is below the storage usage threshold for low storage.
  static bool getIsStorageBelowThreshold(double storageFree, double threshold) {
    return storageFree <= threshold;
  }
}
