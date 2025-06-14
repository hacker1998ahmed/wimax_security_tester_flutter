import 'package:flutter/material.dart';
import 'package:wimax_pentest_flutter/core/wimax_scanner.dart';
import 'package:wimax_pentest_flutter/models/network_model.dart';
import 'package:wimax_pentest_flutter/ui/screens/attack_screen.dart';
import 'package:wimax_pentest_flutter/ui/widgets/network_card.dart';
import 'package:wimax_pentest_flutter/utils/logger.dart';
import 'package:wimax_pentest_flutter/services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WimaxScanner _scanner = WimaxScanner();
  List<NetworkInfo> _networks = [];
  bool _isScanning = false;
  String _errorMessage = '';

  Future<void> _scanNetworks() async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
      _errorMessage = '';
    });

    try {
      final results = await _scanner.scanNetworks();
      
      if (results.isEmpty) {
        NotificationService.showNotification(
          title: 'Scan Completed',
          body: 'No WiMax networks found',
        );
      }

      setState(() => _networks = results);
    } catch (e) {
      AppLogger.error('Network scan failed', e);
      setState(() => _errorMessage = 'Failed to scan: ${e.toString()}');
      NotificationService.showNotification(
        title: 'Scan Failed',
        body: 'Error scanning networks',
      );
    } finally {
      setState(() => _isScanning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WiMax Pentest Tool'),
        actions: [
          IconButton(
            icon: _isScanning
                ? const CircularProgressIndicator()
                : const Icon(Icons.refresh),
            onPressed: _scanNetworks,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanNetworks,
        backgroundColor: _isScanning ? Colors.grey : Theme.of(context).primaryColor,
        child: _isScanning
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.wifi_find),
      ),
    );
  }

  Widget _buildBody() {
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          _errorMessage,
          style: TextStyle(
            color: Theme.of(context).errorColor,
            fontSize: 16,
          ),
        ),
      );
    }

    if (_networks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 64,
              color: Theme.of(context).disabledColor,
            ),
            const SizedBox(height: 16),
            Text(
              _isScanning ? 'Scanning for WiMax networks...' : 'No networks found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (!_isScanning)
              TextButton(
                onPressed: _scanNetworks,
                child: const Text('Tap to scan'),
              ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _scanNetworks,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _networks.length,
        itemBuilder: (ctx, idx) => NetworkCard(
          network: _networks[idx],
          onAttackPressed: () => _navigateToAttackScreen(_networks[idx]),
        ),
      ),
    );
  }

  void _navigateToAttackScreen(NetworkInfo network) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttackScreen(targetNetwork: network),
      ),
    );
  }
}