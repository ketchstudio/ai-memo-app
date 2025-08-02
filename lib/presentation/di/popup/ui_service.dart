import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:flutter/material.dart';

import '../../dialog/no_internet_dialog.dart';

abstract class UiService {
  Future<void> showErrorDialog({
    required BuildContext context,
    required AppError error,
    VoidCallback? onDismissed,
    VoidCallback? onRetry,
    VoidCallback? onContinueOffline,
  });
}

class UiServiceImpl implements UiService {
  Future<void> showNoInternetDialog({
    required BuildContext context,
    VoidCallback? onRetry,
    VoidCallback? onContinueOffline,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => NoInternetDialog(
        onRetry: () {
          Navigator.pop(context);
          onRetry?.call();
        },
        onContinueOffline: () {
          Navigator.pop(context);
          onContinueOffline?.call();
        },
      ),
    );
  }

  @override
  Future<void> showErrorDialog({
    required BuildContext context,
    required AppError error,
    VoidCallback? onDismissed,
    VoidCallback? onRetry,
    VoidCallback? onContinueOffline,
  }) async {
    if (error is NetworkError) {
      return showNoInternetDialog(
        context: context,
        onRetry: onRetry,
        onContinueOffline: onContinueOffline,
      );
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(error.message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDismissed?.call();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
