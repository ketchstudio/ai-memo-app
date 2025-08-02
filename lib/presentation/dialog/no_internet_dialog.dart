import 'package:flutter/material.dart';

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => NoInternetDialog(
      onRetry: () {
        Navigator.pop(context);
        // trigger your retry logic here
      },
      onContinueOffline: () {
        Navigator.pop(context);
        // proceed offline
      },
    ),
  );
}

class NoInternetDialog extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onContinueOffline;

  const NoInternetDialog({
    super.key,
    required this.onRetry,
    required this.onContinueOffline,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.wifi_off, size: 48, color: Colors.pink),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please check your internet connection and try again. Some features may not be available offline.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, height: 1.4),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.offline_bolt_outlined),
                label: const Text('Continue Offline'),
                onPressed: onContinueOffline,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
