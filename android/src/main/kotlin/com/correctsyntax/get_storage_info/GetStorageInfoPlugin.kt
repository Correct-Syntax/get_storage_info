package com.correctsyntax.get_storage_info

import android.content.Context
import android.os.Environment
import android.os.StatFs
import androidx.core.content.ContextCompat.getExternalFilesDirs
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** GetStorageInfoPlugin */
class GetStorageInfoPlugin : FlutterPlugin, MethodCallHandler {
    // / The MethodChannel that will the communication between Flutter and native Android
    // /
    // / This local reference serves to register the plugin with the Flutter Engine and unregister it
    // / when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "get_storage_info")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result,
    ) {
        when (call.method) {
            "getStorageFreeSpace" -> result.success(getStorageFreeSpace())
            "getStorageUsedSpace" -> result.success(getStorageUsedSpace())
            "getStorageTotalSpace" -> result.success(getStorageTotalSpace())

            "getExternalStorageTotalSpace" -> result.success(getExternalStorageTotalSpace())
            "getExternalStorageFreeSpace" -> result.success(getExternalStorageFreeSpace())
            "getExternalStorageUsedSpace" -> result.success(getExternalStorageUsedSpace())

            "getStorageFreeSpaceInMB" -> result.success(getStorageFreeSpaceInMB())
            "getStorageUsedSpaceInMB" -> result.success(getStorageUsedSpaceInMB())
            "getStorageTotalSpaceInMB" -> result.success(getStorageTotalSpaceInMB())

            "getStorageFreeSpaceInGB" -> result.success(getStorageFreeSpaceInGB())
            "getStorageUsedSpaceInGB" -> result.success(getStorageUsedSpaceInGB())
            "getStorageTotalSpaceInGB" -> result.success(getStorageTotalSpaceInGB())

            "getExternalStorageTotalSpaceInMB" -> result.success(getExternalStorageTotalSpaceInMB())
            "getExternalStorageFreeSpaceInMB" -> result.success(getExternalStorageFreeSpaceInMB())
            "getExternalStorageUsedSpaceInMB" -> result.success(getExternalStorageUsedSpaceInMB())

            "getExternalStorageTotalSpaceInGB" -> result.success(getExternalStorageTotalSpaceInGB())
            "getExternalStorageFreeSpaceInGB" -> result.success(getExternalStorageFreeSpaceInGB())
            "getExternalStorageUsedSpaceInGB" -> result.success(getExternalStorageUsedSpaceInGB())

            "getSizeOfDirectoryInMB" -> {
                val directory: String? = call.argument("directory")
                result.success(getSizeOfDirectoryInMB(directory!!))
            }

            else -> result.notImplemented()
        }
    }

    private fun getStorageTotalSpace(): Long {
        val path: File = Environment.getExternalStorageDirectory()
        val stat = StatFs(path.path)
        return stat.totalBytes
    }

    private fun getStorageFreeSpace(): Long {
        val path: File = Environment.getExternalStorageDirectory()
        val stat = StatFs(path.path)
        return stat.availableBytes
    }

    private fun getStorageUsedSpace(): Long {
        val usedSpace: Long = getStorageTotalSpace() - getStorageFreeSpace()
        return usedSpace
    }

    private fun getExternalStorageTotalSpace(): Long {
        val dirs: Array<File> = getExternalFilesDirs(context, null)
        val stat = StatFs(getBaseStoragePath(dirs[1]))
        return stat.totalBytes
    }

    private fun getExternalStorageFreeSpace(): Long {
        val dirs: Array<File> = getExternalFilesDirs(context, null)
        val stat = StatFs(getBaseStoragePath(dirs[1]))
        return stat.availableBytes
    }

    private fun getExternalStorageUsedSpace(): Long {
        val usedSpace: Long = getExternalStorageTotalSpace() - getExternalStorageFreeSpace()
        return usedSpace
    }

    // Storage space in MB
    private fun getStorageFreeSpaceInMB(): Double {
        val freeSpace: Double = getStorageFreeSpace().toDouble() / 1024 / 1024
        return freeSpace
    }

    private fun getStorageUsedSpaceInMB(): Double {
        val usedSpace: Double = getStorageUsedSpace().toDouble() / 1024 / 1024
        return usedSpace
    }

    private fun getStorageTotalSpaceInMB(): Double {
        val totalSpace: Double = getStorageTotalSpace().toDouble() / 1024 / 1024
        return totalSpace
    }

    // Storage space in GB
    private fun getStorageFreeSpaceInGB(): Double {
        val freeSpace: Double = getStorageFreeSpace().toDouble() / 1024 / 1024 / 1024
        return freeSpace
    }

    private fun getStorageUsedSpaceInGB(): Double {
        val usedSpace: Double = getStorageUsedSpace().toDouble() / 1024 / 1024 / 1024
        return usedSpace
    }

    private fun getStorageTotalSpaceInGB(): Double {
        val totalSpace: Double = getStorageTotalSpace().toDouble() / 1024 / 1024 / 1024
        return totalSpace
    }

    // External storage in MB
    private fun getExternalStorageFreeSpaceInMB(): Double {
        val freeSpace: Double = getExternalStorageFreeSpace().toDouble() / 1024 / 1024
        return freeSpace
    }

    private fun getExternalStorageUsedSpaceInMB(): Double {
        val usedSpace: Double = getExternalStorageUsedSpace().toDouble() / 1024 / 1024
        return usedSpace
    }

    private fun getExternalStorageTotalSpaceInMB(): Double {
        val totalSpace: Double = getExternalStorageTotalSpace().toDouble() / 1024 / 1024
        return totalSpace
    }

    // External storage in GB
    private fun getExternalStorageFreeSpaceInGB(): Double {
        val freeSpace: Double = getExternalStorageFreeSpace().toDouble() / 1024 / 1024 / 1024
        return freeSpace
    }

    private fun getExternalStorageUsedSpaceInGB(): Double {
        val usedSpace: Double = getExternalStorageUsedSpace().toDouble() / 1024 / 1024 / 1024
        return usedSpace
    }

    private fun getExternalStorageTotalSpaceInGB(): Double {
        val totalSpace: Double = getExternalStorageTotalSpace().toDouble() / 1024 / 1024 / 1024
        return totalSpace
    }

    // Directory size
    private fun getSizeOfDirectoryInMB(directory: String): Double {
        val dirSize =
            File(directory)
                .walkTopDown()
                .map { it.length() }
                .sum().toDouble() / 1024 / 1024
        return dirSize
    }

    // Utils
    private fun getBaseStoragePath(directory: File): String {
        // Handle cases where this is already the root dir
        return if (!directory.path.contains("Android")) {
            directory.path
        } else {
            directory.path.split("Android")[0]
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
