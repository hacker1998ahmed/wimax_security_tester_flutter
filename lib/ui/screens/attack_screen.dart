import 'package:flutter/material.dart';
import 'package:wimax_security_tester/core/security_attacks.dart';

class AttackScreen extends StatefulWidget {
  final String targetBSSID;

  const AttackScreen({required this.targetBSSID, Key? key}) : super(key: key);

  @override
  _AttackScreenState createState() => _AttackScreenState();
}

class _AttackScreenState extends State<AttackScreen> {
  bool _isAttacking = false;
  String _attackResult = '';

  Future<void> _runDeauthAttack() async {
    setState(() {
      _isAttacking = true;
      _attackResult = '';
    });

    try {
      final result = await SecurityAttacks.launchDeauthAttack(widget.targetBSSID);
      setState(() {
        _attackResult = result;
      });
    } catch (e) {
      setState(() {
        _attackResult = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isAttacking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attack ${widget.targetBSSID}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isAttacking ? null : _runDeauthAttack,
              child: _isAttacking 
                  ? const CircularProgressIndicator()
                  : const Text('Launch Deauth Attack'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_attackResult),
            ),
          ],
        ),
      ),
    );
  }
}