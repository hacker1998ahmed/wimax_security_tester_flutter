import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ToolManager {
  static Future<String> _getToolsDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    final toolsDir = Directory('${appDir.path}/tools');
    
    if (!await toolsDir.exists()) {
      await toolsDir.create(recursive: true);
    }
    return toolsDir.path;
  }

  static Future<void> _extractTools() async {
    try {
      final data = await rootBundle.load('assets/tools/tools.zip');
      final bytes = data.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final zipFile = File('${tempDir.path}/tools.zip');
      
      await zipFile.writeAsBytes(bytes);
      await Process.run('unzip', ['-o', zipFile.path, '-d', await _getToolsDir()]);
    } catch (e) {
      throw Exception('Failed to extract tools: ${e.toString()}');
    }
  }

  static Future<String> getToolPath(String toolName) async {
    final toolsDir = await _getToolsDir();
    final toolPath = '$toolsDir/$toolName';
    
    if (!File(toolPath).existsSync()) {
      await _extractTools();
    }
    
    await Process.run('chmod', ['+x', toolPath]);
    return toolPath;
  }
}