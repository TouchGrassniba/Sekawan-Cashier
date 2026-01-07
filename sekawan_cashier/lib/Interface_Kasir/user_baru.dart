import 'package:flutter/material.dart';
import 'transaksi.dart';

class SetPasswordPage extends StatelessWidget {
  const SetPasswordPage({super.key});

  void _goToTransaksi(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const KasirTransaksiPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [

          // ================= LEFT (FORM) =================
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('images/logo.png', width: 36),
                      const SizedBox(width: 10),
                      const Text(
                        'SEKAWAN CASHIER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  const Chip(label: Text('Setel password baru')),
                  const SizedBox(height: 20),

                  const Text(
                    'Halo, Bemi',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Sebelum mulai memakai kasir, silakan buat password baru.',
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  const Text('Password baru'),
                  const SizedBox(height: 6),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan password baru',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  const Text(
                    '• Minimal 8 karakter\n'
                    '• Ada huruf kapital (A-Z)\n'
                    '• Ada angka (0-9)\n'
                    '• Ada simbol (!@#?)',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 20),
                  const Text('Konfirmasi password'),
                  const SizedBox(height: 6),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Ketik ulang password baru',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () => _goToTransaksi(context),
                        child: const Text('Nanti saja'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _goToTransaksi(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                        ),
                        child: const Text('Simpan password & lanjut'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ================= RIGHT (IMAGE) =================
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFF2C55C),
              child: Center(
                child: Image.asset(
                  'images/masuk.png',
                  width: 420,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
