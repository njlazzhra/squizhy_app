import 'package:flutter/material.dart';

/// Menampilkan dialog konfirmasi keluar kuis.
/// Mengembalikan true jika pengguna memilih keluar.
Future<bool> confirmExitQuiz(BuildContext context) async {
  final leave = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Keluar dari kuis?'),
      content: const Text('Yakin ingin keluar dari kuis ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Lanjut'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Keluar'),
        ),
      ],
    ),
  );
  return leave ?? false;
}