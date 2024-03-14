# get_storage_info

A Flutter plugin to get information about storage on Android. Get free, used, and total internal and external (SD card) storage space, and more.

This is a friendly fork of [storage_info](https://github.com/aakashkondhalkar/storage_info).


## Installing

Add ``get_storage_info`` to your pubspec.yaml:
```yaml
dependencies:
  get_storage_info: ^0.0.1
```

## Usage

### Importing

```dart
import 'package:get_storage_info/get_storage_info.dart';
```

### Using the methods

All methods can be statically accessed via the ``GetStorageInfo`` class.

#### Get internal storage info

```dart

// Get internal storage total space in bytes, MB and GB
await StorageInfo.getStorageTotalSpace; // return int
await StorageInfo.getStorageTotalSpaceInMB; // return double
await StorageInfo.getStorageTotalSpaceInGB; // return double

// Get internal storage free space in bytes, MB and GB
await StorageInfo.getStorageFreeSpace; // return int
await StorageInfo.getStorageFreeSpaceInMB; // return double
await StorageInfo.getStorageFreeSpaceInGB; // return double

// Get internal storage used space in bytes, MB and GB
await StorageInfo.getStorageUsedSpace; // return int
await StorageInfo.getStorageUsedSpaceInMB; // return double
await StorageInfo.getStorageUsedSpaceInGB; // return double
```

#### Get external (SD card) storage info

```dart
// Get external storage total space in bytes, MB, and GB
return await StorageInfo.getExternalStorageTotalSpace; // return int
return await StorageInfo.getExternalStorageTotalSpaceInMB; // return double
return await StorageInfo.getExternalStorageTotalSpaceInGB; // return double

// Get external storage free space in bytes, MB, and GB
return await StorageInfo.getExternalStorageFreeSpace; // return int
return await StorageInfo.getExternalStorageFreeSpaceInMB; // return double
return await StorageInfo.getExternalStorageFreeSpaceInGB; // return double

// Get external storage used space in bytes, MB, and GB
return await StorageInfo.getExternalStorageUsedSpace; // return int
return await StorageInfo.getExternalStorageUsedSpaceInMB; // return double
return await StorageInfo.getExternalStorageUsedSpaceInGB; // return double
```

#### Get the size of a given directory in MB

```dart
String directoryPath = '/storage/emulated/0/Movies/MyFolder/';
double directorySize = await GetStorageInfo.getSizeOfDirectoryInMB(directoryPath);
>> 12.98790
```

#### Get storage type from path

```dart
String path = '/storage/emulated/0/Android';
DeviceStorageType storageType = GetStorageInfo.getStorageTypeFromPath(path);
>> DeviceStorageType.internal
```

#### Get storage usage value

Get a value from 0.0 to 1.0 representing the storage usage. Useful for storage indicators.

```dart
double storageTotal = await GetStorageInfo.getExternalStorageTotalSpaceInGB;
double storageUsed = await GetStorageInfo.getExternalStorageUsedSpaceInGB;

double storageUsageValue = GetStorageInfo.getStorageUsageValue(storageUsed, storageTotal);
>> 0.95
```

#### Get whether the storage type is low on storage

This method calls the above methods internally to get the storage info, so if you already get the info in your code it may be more optimized to use ``getIsStorageBelowThreshold`` instead.

```dart
DeviceStorageType storageType = DeviceStorageType.internal;

// Optionally set the threshold. The default is 0.98 (98%)
double threshold = 0.96;

bool isLowOnStorage = await GetStorageInfo.getIsLowOnStorage(storageType, threshold);
>> false
```

#### Get whether the storage is above the low storage threshold

```dart
double storageTotal = await GetStorageInfo.getExternalStorageTotalSpaceInGB;
double storageUsed = await GetStorageInfo.getExternalStorageUsedSpaceInGB;

double threshold = 0.96;
double storageUsageValue = GetStorageInfo.getStorageUsageValue(storageUsed, storageTotal);

bool isBelowThreshold = GetStorageInfo.getIsStorageBelowThreshold(storageUsageValue, threshold);
>> true
```

