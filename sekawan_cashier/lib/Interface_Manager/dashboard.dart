import 'package:flutter/material.dart';
import '../login.dart';
import 'laporan.dart';
import 'manajemen_produk.dart';
import 'manajemen_user.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ================= SIDEBAR =================
          Container(
            width: 260,
            color: const Color(0xFFF2C55C),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('images/logo.png', width: 40),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SEKAWAN CASHIER',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Manager', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                _menuItem(Icons.dashboard, 'Dashboard', active: true),
                _menuItem(
                  Icons.receipt_long,
                  'Laporan Penjualan',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LaporanPenjualanPage(),
                      ),
                    );
                  },
                ),
                _menuItem(
                  Icons.inventory,
                  'Manajemen Produk',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ManajemenProdukPage(),
                      ),
                    );
                  },
                ),
                _menuItem(Icons.people,
                 'Manajemen User',
                onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ManajemenUserPage(),
                      ),
                    );
                  },
                ),

                const Spacer(),
                _logoutMenu(context),
              ],
            ),
          ),

          // ================= MAIN CONTENT =================
          Expanded(
            child: Column(
              children: [
                // ================= TOP BAR =================
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Dashboard',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Ringkasan aktivitas toko • Sabtu, 19 Desember 2025',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.notifications_none),
                          const SizedBox(width: 20),
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFFF2C55C),
                            child: Text('J'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ================= CONTENT =================
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // ================= SUMMARY =================
                        Row(
                          children: const [
                            _summaryCard(
                              title: 'Total Penjualan Hari Ini',
                              value: 'Rp 12.540.000',
                              note: '▼ 2% dibanding kemarin',
                              noteColor: Colors.red,
                            ),
                            _summaryCard(
                              title: 'Jumlah Transaksi',
                              value: '7',
                              note: '▲ 1 transaksi dibanding kemarin',
                              noteColor: Colors.green,
                            ),
                            _summaryCard(
                              title: 'Rata-rata Nilai Transaksi',
                              value: 'Rp 1.792.000',
                              note: '▼ 1% dibanding kemarin',
                              noteColor: Colors.red,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ================= GRAPH =================
                        _card(
                          title: 'Data Penjualan',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text(
                                    '📈 Grafik Penjualan (Placeholder)',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ================= ACTIVITY =================
                        _card(
                          title: 'Aktivitas Terbaru',
                          child: Column(
                            children: const [
                              _activityItem(
                                'Kasir Beni menutup transaksi sebesar Rp 1.250.000',
                                '2 menit lalu',
                              ),
                              _activityItem(
                                'Kasir Beni menutup transaksi sebesar Rp 500.000',
                                '30 menit lalu',
                              ),
                              _activityItem(
                                'Stok Semen 50kg diupdate oleh Gudang',
                                '58 menit lalu',
                              ),
                              _activityItem(
                                'Kasir Beni menutup transaksi sebesar Rp 2.000.000',
                                '1 jam lalu',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= WIDGETS =================

  static Widget _menuItem(
    IconData icon,
    String text, {
    bool active = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }

   Widget _logoutMenu(BuildContext context) => ListTile(
        leading: const Icon(Icons.power_settings_new, color: Colors.red),
        title: const Text('Keluar', style: TextStyle(color: Colors.red)),
        onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (_) => false),
      );
}

// ================= COMPONENTS =================

class _summaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String note;
  final Color noteColor;

  const _summaryCard({
    required this.title,
    required this.value,
    required this.note,
    required this.noteColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              value,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(note, style: TextStyle(color: noteColor, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _card extends StatelessWidget {
  final String title;
  final Widget child;

  const _card({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _activityItem extends StatelessWidget {
  final String text;
  final String time;

  const _activityItem(this.text, this.time);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.receipt_long, size: 20),
      title: Text(text),
      subtitle: Text(time),
    );
  }
}
