import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'laporan.dart';
import 'login.dart';
import 'manajemen_user.dart';

class ManajemenProdukPage extends StatelessWidget {
  const ManajemenProdukPage({super.key});

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

                _menuItem(context, Icons.dashboard, 'Dashboard', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardPage()),
                  );
                }),
                _menuItem(context, Icons.receipt_long, 'Laporan Penjualan',
                    onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LaporanPenjualanPage()),
                  );
                }),
                _menuItem(context, Icons.inventory, 'Manajemen Produk',
                    active: true),
                _menuItem(context, Icons.people, 'Manajemen User',
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
                            'Manajemen Product',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text('Kelola daftar barang',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 20),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFFF2C55C),
                            child: Text('J'),
                          ),
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
                        // ===== FILTER BAR =====
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      'Cari nama, ID, atau kategori barang',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            _dropdown('Semua Kategori'),
                            const SizedBox(width: 10),
                            _dropdown('Status: Semua'),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: const Text('Terapkan'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ===== SUMMARY CARD =====
                        Row(
                          children: [
                            _summaryCard('Total Produk', '3',
                                'Berdasarkan filter'),
                            _summaryCard(
                                'Produk Aktif', '2', 'Digunakan di kasir'),
                            _summaryCard(
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
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Daftar Produk',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                _tableHeader(),
                                const Divider(),
                                _tableRow(
                                  'M00001',
                                  'Semen Tiga Roda 50kg',
                                  'Material',
                                  'Rp 65.000',
                                  '0',
                                  false,
                                ),
                                _tableRow(
                                  'T00001',
                                  'Gergaji',
                                  'Tool',
                                  'Rp 45.000',
                                  '20',
                                  true,
                                ),
                                _tableRow(
                                  'P00001',
                                  'Aquaproof 20kg',
                                  'Paint',
                                  'Rp 120.000',
                                  '7',
                                  true,
                                ),
                                const Spacer(),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.chevron_left,
                                          color: Colors.grey),
                                      SizedBox(width: 10),
                                      Text('1'),
                                      SizedBox(width: 10),
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

      // ===== FLOAT BUTTON =====
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Produk'),
      ),
    );
  }

  // ================= WIDGET =================

  Widget _menuItem(BuildContext context, IconData icon, String text,
      {bool active = false, VoidCallback? onTap}) {
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

  Widget _summaryCard(String title, String value, String note) {
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
            const SizedBox(height: 6),
            Text(value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(note,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _tableHeader() {
    return const Row(
      children: [
        Expanded(child: Text('ID Barang', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Nama Produk', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Harga Jual', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Stok', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
        SizedBox(width: 80),
      ],
    );
  }

  Widget _tableRow(String id, String nama, String kategori, String harga,
      String stok, bool ready) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(id)),
          Expanded(child: Text(nama)),
          Expanded(child: Text(kategori)),
          Expanded(child: Text(harga)),
          Expanded(child: Text(stok)),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: ready ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                ready ? 'Ready' : 'Habis',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ready ? Colors.green : Colors.red, fontSize: 12),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.remove_red_eye, size: 18),
                Icon(Icons.edit, size: 18),
                Icon(Icons.delete, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoutMenu(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.power_settings_new, color: Colors.red),
      title: const Text('Keluar', style: TextStyle(color: Colors.red)),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Konfirmasi Logout'),
            content: const Text('Apakah Anda yakin ingin keluar?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
