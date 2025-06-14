import 'package:wimax_security_tester/core/attack_tools.dart';

class SecurityAttacks {
  static Future<String> launchDeauthAttack(String targetBSSID) async {
    try {
      return await AttackTools.deauthAttack(targetBSSID);
    } catch (e) {
      throw Exception('Deauth attack failed: ${e.toString()}');
    }
  }

  static Future<String> launchBruteForceAttack(
    String targetBSSID, 
    String wordlist,
  ) async {
    try {
      return await AttackTools.bruteForceAttack(targetBSSID, wordlist);
    } catch (e) {
      throw Exception('Brute force attack failed: ${e.toString()}');
    }
  }

  static Future<String> launchMdk3Attack(
    String interface, 
    String mode,
  ) async {
    try {
      return await AttackTools._executeAttackTool(
        'mdk3',
        [interface, mode],
      );
    } catch (e) {
      throw Exception('MDK3 attack failed: ${e.toString()}');
    }
  }
}