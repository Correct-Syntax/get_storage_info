# get_storage_info

A Flutter plugin to get information about storage on Android. Get free, used, and total internal and external (SD card) storage space, and more.

This is a friendly fork of [storage_info](https://github.com/aakashkondhalkar/storage_info) with additional useful methods and improvements.


## Installing

Add ``get_storage_info`` to your pubspec.yaml:
```yaml
dependencies:
  get_storage_info: ^0.3.0
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
await GetStorageInfo.getStorageTotalSpace; // return int
await GetStorageInfo.getStorageTotalSpaceInMB; // return double
await GetStorageInfo.getStorageTotalSpaceInGB; // return double

// Get internal storage free space in bytes, MB and GB
await GetStorageInfo.getStorageFreeSpace; // return int
await GetStorageInfo.getStorageFreeSpaceInMB; // return double
await GetStorageInfo.getStorageFreeSpaceInGB; // return double

// Get internal storage used space in bytes, MB and GB
await GetStorageInfo.getStorageUsedSpace; // return int
await GetStorageInfo.getStorageUsedSpaceInMB; // return double
await GetStorageInfo.getStorageUsedSpaceInGB; // return double
```

#### Get external (SD card) storage info

```dart
// Get external storage total space in bytes, MB, and GB
return await GetStorageInfo.getExternalStorageTotalSpace; // return int
return await GetStorageInfo.getExternalStorageTotalSpaceInMB; // return double
return await GetStorageInfo.getExternalStorageTotalSpaceInGB; // return double

// Get external storage free space in bytes, MB, and GB
return await GetStorageInfo.getExternalStorageFreeSpace; // return int
return await GetStorageInfo.getExternalStorageFreeSpaceInMB; // return double
return await GetStorageInfo.getExternalStorageFreeSpaceInGB; // return double

// Get external storage used space in bytes, MB, and GB
return await GetStorageInfo.getExternalStorageUsedSpace; // return int
return await GetStorageInfo.getExternalStorageUsedSpaceInMB; // return double
return await GetStorageInfo.getExternalStorageUsedSpaceInGB; // return double
```

#### Get whether the external storage is mounted and writable

```dart
bool isWritable = await GetStorageInfo.isExternalStorageWritable; // return bool
>> true
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

// Optionally set the threshold. The default is 500MB.
double threshold = 600.0;

bool isLowOnStorage = await GetStorageInfo.getIsLowOnStorage(storageType, threshold);
>> false
```

#### Get whether the storage is below the low storage threshold

```dart
double threshold = 600.0; // in MB
double storageFree = await GetStorageInfo.getExternalStorageFreeSpaceInMB;

bool isBelowThreshold = GetStorageInfo.getIsStorageBelowThreshold(storageFree, threshold);
>> true
```

