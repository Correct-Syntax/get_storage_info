## 0.4.0

- Compile and target sdk is now 36 (Android 16).
- Dropped support for Android 6.

## 0.3.0

- Added ``isExternalStorageWritable`` method.
- Improved documentation.

## 0.2.2

- Fixes bug where assuming the internal storage path could cause a crash on some devices. 

## 0.2.1

- Defaults to ``DeviceStorageType.internal`` to avoid potential ``ArrayIndexOutOfBoundsException`` errors.

## 0.2.0

- Operations are now run on a separate thread via a coroutine.

## 0.1.0

#### **Breaking changes** to getIsLowOnStorage and getIsStorageBelowThreshold

- ``getIsLowOnStorage`` now uses the free storage to determine whether the device is low on storage. 
- The ``threshold`` param for ``getIsLowOnStorage`` and ``getIsStorageBelowThreshold`` is now in MB instead of percent.

## 0.0.2

* Improved documentation.

## 0.0.1

* Initial release.
