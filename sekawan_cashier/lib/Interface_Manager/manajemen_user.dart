import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'laporan.dart';
import 'manajemen_produk.dart';
import 'login.dart';

class ManajemenUserPage extends StatelessWidget {
  const ManajemenUserPage({super.key});

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
                        Text('SEKAWAN CASHIER',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Manager', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                _menu(context, Icons.dashboard, 'Dashboard', () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardPage()),
                  );
                }),
                _menu(context, Icons.receipt_long, 'Laporan Penjualan', () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LaporanPenjualanPage()),
                  );
                }),
                _menu(context, Icons.inventory, 'Manajemen Produk', () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ManajemenProdukPage()),
                  );
                }),
                _menu(context, Icons.people, 'Manajemen User', () {},
                    active: true),
                const Spacer(),
                _logout(context),
              ],
            ),
          ),

          // ================= MAIN CONTENT =================
          Expanded(
            child: Column(
              children: [
                // ================= TOPBAR =================
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Manajemen User',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text('Kelola akun user',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 16),
                          CircleAvatar(child: Text('J')),
                        ],
                      )
                    ],
                  ),
                ),

                // ================= CONTENT =================
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // ===== FILTER =====
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      'Cari nama, ID, atau kategori barang',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            _dropdown('Peran: Semua'),
                            const SizedBox(width: 10),
                            _dropdown('Status: Semua'),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              child: const Text('Terapkan'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              label: const Text('Tambah User'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF2C55C),
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ===== SUMMARY =====
                        Row(
                          children: [
                            _summary('Total User', '3',
                                'Berdasarkan filter'),
                            _summary('Kasir Aktif', '1',
                                'Kasir yang mempunyai akses'),
                            _summary(
                                'Stok Rendah', '1', 'Segera lakukan pembelian'),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ===== TABLE =====
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Colors.black.withOpacity(0.08),
                                    blurRadius: 10),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Daftar User',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                _tableHeader(),
                                const Divider(),
                                _tableRow(
                                    'CH002',
                                    'Bemi',
                                    'Cashier',
                                    true,
                                    'Kemarin, 20:10'),
                                _tableRow(
                                    'CH001',
                                    'Blasius',
                                    'Cashier',
                                    false,
                                    '7 hari lalu'),
                                _tableRow(
                                    'MG001',
                                    'Bemi',
                                    'Manager',
                                    true,
                                    'Hari ini, 08:12',
                                    showDelete: false),
                                const Spacer(),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.chevron_left,
                                          color: Colors.grey),
                                      SizedBox(width: 8),
                                      Text('1'),
                                      SizedBox(width: 8),
                                      Text('Next'),
                                    ],
                                  ),
                                )
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

  // ================= COMPONENT =================

  Widget _menu(BuildContext context, IconData icon, String text,
      VoidCallback onTap,
      {bool active = false}) {
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

  Widget _dropdown(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: text,
          items: [DropdownMenuItem(value: text, child: Text(text))],
          onChanged: (_) {},
        ),
      ),
    );
  }

  Widget _summary(String title, String value, String note) {
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
                blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(note,
                style:
                    const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _tableHeader() {
    return const Row(
      children: [
        Expanded(child: Text('ID User', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Nama User', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Peran', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Terakhir Login', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Catatan', style: TextStyle(fontWeight: FontWeight.bold))),
        SizedBox(width: 80),
      ],
    );
  }

  Widget _tableRow(String id, String nama, String role, bool aktif,
      String lastLogin,
      {bool showDelete = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(id)),
          Expanded(child: Text(nama)),
          Expanded(
            child: Chip(
              label: Text(role),
              backgroundColor:
                  role == 'Manager' ? Colors.blue.shade100 : Colors.orange.shade100,
            ),
          ),
          Expanded(
            child: Chip(
              label: Text(aktif ? 'Aktif' : 'Non-Aktif'),
              backgroundColor:
                  aktif ? Colors.green.shade100 : Colors.grey.shade300,
            ),
          ),
          Expanded(child: Text(lastLogin)),
          const Expanded(child: Text('Lihat', style: TextStyle(color: Colors.blue))),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.remove_red_eye, size: 18),
                const Icon(Icons.edit, size: 18),
                if (showDelete)
                  const Icon(Icons.delete, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.power_settings_new, color: Colors.red),
      title: const Text('Keluar', style: TextStyle(color: Colors.red)),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Konfirmasi Logout'),
            content:
                const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text('Keluar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
