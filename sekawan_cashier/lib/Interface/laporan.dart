import 'package:flutter/material.dart';
import 'dashboard.dart'; // sesuaikan path file dashboard

class LaporanPenjualanPage extends StatelessWidget {
  const LaporanPenjualanPage({super.key});

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

                _menuItem(
                  Icons.dashboard,
                  'Dashboard',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardPage(),
                      ),
                    );
                  },
                ),
                _menuItem(
                  Icons.receipt_long,
                  'Laporan Penjualan',
                  active: true,
                ),
                _menuItem(Icons.inventory, 'Manajemen Produk'),
                _menuItem(Icons.people, 'Manajemen User'),
                _menuItem(Icons.settings, 'Pengaturan'),
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
                      Text(
                        'Laporan Penjualan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 20),
                          CircleAvatar(radius: 16),
                        ],
                      ),
                    ],
                  ),
                ),

                // ================= CONTENT =================
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // ================= FILTER BAR =================
                        Row(
                          children: [
                            _filterBox('1 - 31 Dec'),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF2C55C),
                              ),
                              child: const Text(
                                'Search',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF2C55C),
                              ),
                              icon: const Icon(Icons.download, color: Colors.black),
                              label: const Text(
                                'Download',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ================= SUMMARY =================
                        Row(
                          children: [
                            _summaryCard('Total Penjualan', 'Rp xx.xxx.xxx'),
                            _summaryCard('Jumlah Transaksi', 'XXX'),
                            _summaryCard('Margin', 'Rp xx.xxx.xxx'),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ================= TABLE =================
                        Expanded(
                          child: Container(
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
                              children: [
                                _tableHeader(),
                                const Divider(),

                                // ===== TABLE BODY (SCROLLABLE) =====
                                Expanded(
                                  child: ListView(
                                    children: [
                                      _tableRow('15 Dec 2025', 'TRX-00215', 'Cashier', 'Rp. xx.xxx.xxx'),
                                      _tableRow('13 Dec 2025', 'TRX-00214', 'Cashier', 'Rp. xx.xxx'),
                                      _tableRow('12 Dec 2025', 'TRX-00213', 'Cashier', 'Rp. x.xxx.xxx'),
                                      _tableRow('12 Dec 2025', 'TRX-00212', 'Cashier', 'Rp. x.xxx.xxx'),
                                      _tableRow('11 Dec 2025', 'TRX-00211', 'Cashier', 'Rp. x.xxx.xxx'),
                                    ],
                                  ),
                                ),

                                const Divider(),

                                // ===== PAGINATION =====
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.first_page, color: Colors.grey),
                                    SizedBox(width: 10),
                                    Icon(Icons.chevron_left, color: Colors.grey),
                                    SizedBox(width: 10),
                                    Text('1 of 1'),
                                    SizedBox(width: 10),
                                    Icon(Icons.chevron_right, color: Colors.grey),
                                    SizedBox(width: 10),
                                    Icon(Icons.last_page, color: Colors.grey),
                                  ],
                                ),
                              ],
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

  static Widget _filterBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 16),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  static Widget _summaryCard(String title, String value) {
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _tableHeader() {
    return const Row(
      children: [
        Expanded(flex: 2, child: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(flex: 2, child: Text('No. Transaksi', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(flex: 2, child: Text('Kasir', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(flex: 2, child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: SizedBox()),
      ],
    );
  }

  static Widget _tableRow(String date, String trx, String cashier, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(date)),
          Expanded(flex: 2, child: Text(trx)),
          Expanded(flex: 2, child: Text(cashier)),
          Expanded(flex: 2, child: Text(total)),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text('Lihat'),
            ),
          ),
        ],
      ),
    );
  }
}
