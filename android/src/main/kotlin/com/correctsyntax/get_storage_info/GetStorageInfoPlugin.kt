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
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File

class GetStorageInfoPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    
    private var coroutineScope: CoroutineScope? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        coroutineScope = CoroutineScope(Dispatchers.Default)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "get_storage_info")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getStorageFreeSpace" -> result.success(getStorageFreeSpace())
            "getStorageTotalSpace" -> result.success(getStorageTotalSpace())
            "getStorageUsedSpace" -> result.success(getStorageUsedSpace())
            
            "getExternalStorageFreeSpace" -> result.success(getExternalStorageFreeSpace())
            "getExternalStorageTotalSpace" -> result.success(getExternalStorageTotalSpace())
            "getExternalStorageUsedSpace" -> result.success(getExternalStorageUsedSpace())
            
            "isExternalStorageWritable" -> result.success(isExternalStorageWritable())

            "getSizeOfDirectory" -> {
                val directoryPath: String? = call.argument("directory")
                if (directoryPath == null) {
                    result.error("INVALID_ARGUMENT", "Directory path cannot be null", null)
                    return
                }
                
                coroutineScope?.launch {
                    val size = getSizeOfDirectory(directoryPath)
                    withContext(Dispatchers.Main) {
                        result.success(size)
                    }
                } ?: result.error("DISPOSED", "Plugin scope is inactive", null)
            }

            else -> result.notImplemented()
        }
    }

    private fun getStorageTotalSpace(): Long {
        val path: File = Environment.getExternalStorageDirectory()
        return StatFs(path.path).totalBytes
    }

    private fun getStorageFreeSpace(): Long {
        val path: File = Environment.getExternalStorageDirectory()
        return StatFs(path.path).availableBytes
    }

    private fun getStorageUsedSpace(): Long = getStorageTotalSpace() - getStorageFreeSpace()

    private fun getExternalStorageTotalSpace(): Long {
        val dirs: Array<File> = getExternalFilesDirs(context, null)
        if (dirs.size < 2) return 0L // Guard against missing secondary SD card
        return StatFs(getBaseStoragePath(dirs[1])).totalBytes
    }

    private fun getExternalStorageFreeSpace(): Long {
        val dirs: Array<File> = getExternalFilesDirs(context, null)
        if (dirs.size < 2) return 0L // Guard against missing secondary SD card
        return StatFs(getBaseStoragePath(dirs[1])).availableBytes
    }

    private fun getExternalStorageUsedSpace(): Long {
        val total = getExternalStorageTotalSpace()
        return if (total == 0L) 0L else total - getExternalStorageFreeSpace()
    }

    private fun isExternalStorageWritable(): Boolean {
        return Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED
    }

    // Heavy I/O Operation (Returns raw bytes to Dart)
    private fun getSizeOfDirectory(directory: String): Long {
        return try {
            File(directory)
                .walkTopDown()
                .filter { it.isFile }
                .map { it.length() }
                .sum()
        } catch (e: Exception) {
            0L
        }
    }

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
        coroutineScope?.cancel()
        coroutineScope = null
    }
}
