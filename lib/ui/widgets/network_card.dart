import 'package:flutter/material.dart';
import 'package:wimax_pentest_flutter/models/network_model.dart';

class NetworkCard extends StatelessWidget {
  final NetworkInfo network;
  final VoidCallback onAttackPressed;

  const NetworkCard({
    required this.network,
    required this.onAttackPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onAttackPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wifi,
                    color: _getSignalColor(network.signalStrength),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      network.ssid,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Chip(
                    label: Text('${network.signalStrength}dBm'),
                    backgroundColor: _getSignalColor(network.signalStrength).withOpacity(0.2),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                network.bssid,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Encryption: ${network.encryption}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSignalColor(int strength) {
    if (strength >= -50) return Colors.green;
    if (strength >= -70) return Colors.orange;
    return Colors.red;
  }
}