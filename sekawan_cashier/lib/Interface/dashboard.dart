import 'package:flutter/material.dart';
import 'laporan.dart';

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
                // LOGO
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

                _menuItem(
                  context,
                  Icons.dashboard,
                  'Dashboard',
                  true,
                ),

                _menuItem(
                  context,
                  Icons.receipt_long,
                  'Laporan Penjualan',
                  false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LaporanPenjualanPage(),
                      ),
                    );
                  },
                ),
                _menuItem(
                  context,
                  Icons.inventory,
                  'Manajemen Produk',
                  false,
                ),
                _menuItem(
                  context,
                  Icons.people,
                  'Manajemen User',
                  false,
                ),
                _menuItem(
                  context,
                  Icons.settings,
                  'Pengaturan',
                  false,
                ),
              ],
            ),
          ),

          // ================= MAIN CONTENT =================
          Expanded(
            child: Column(
              children: [
                // TOP BAR
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ringkasan aktivitas toko',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 20),
                          CircleAvatar(radius: 16),
                        ],
                      )
                    ],
                  ),
                ),

                // CONTENT
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // STAT CARDS
                        Row(
                          children: [
                            _statCard(
                              'Total Penjualan Hari Ini',
                              'Rp 12.540.000',
                              '▼ 2% dibanding kemarin',
                              Colors.red,
                            ),
                            _statCard(
                              'Jumlah Transaksi',
                              '82',
                              '▲ 4 dibanding kemarin',
                              Colors.green,
                            ),
                            _statCard(
                              'Rata-rata Nilai Transaksi',
                              'Rp 152.000',
                              '▼ 1% dibanding kemarin',
                              Colors.red,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // GRAFIK PLACEHOLDER
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Grafik Penjualan (Placeholder)',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
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

  // ================= WIDGET MENU =================
  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String text,
    bool active, {
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

  // ================= STAT CARD =================
  Widget _statCard(
    String title,
    String value,
    String change,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              change,
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
