import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

sealed class CopyService {
  static void copyToClipboard({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    FlutterClipboard.copy(text);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Copied to clipboard: $text')));
  }
}
