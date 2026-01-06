import 'package:flutter/material.dart';
import 'transaksi.dart';
import 'riwayat.dart';
import 'package:sekawan_cashier/login.dart';

class CekProdukPage extends StatelessWidget {
  const CekProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      ['M00001', 'Semen Tiga Roda 50kg', 'Material', 'Rp 65.000', '0', false],
      ['T00001', 'Gergaji', 'Tool', 'Rp 45.000', '20', true],
      ['P00001', 'Aquaproof 20kg', 'Paint', 'Rp 120.000', '7', true],
    ];

    return Scaffold(
      body: Row(
        children: [
          _sidebar(context),
          Expanded(
            child: Column(
              children: [
                _topbar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: _card(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Daftar Produk',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          _tableHeader(),
                          const Divider(),
                          Expanded(
                            child: ListView(
                              children: products.map((p) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      _cell(p[0]),
                                      _cell(p[1]),
                                      _cell(p[2]),
                                      _cell(p[3]),
                                      _cell(p[4]),
                                      _status(p[5]),
                                      _action(context),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= SIDEBAR =================

  Widget _sidebar(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xFFF2C55C),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SEKAWAN CASHIER',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Cashier'),
          const SizedBox(height: 30),
          _menu(context, Icons.shopping_cart, 'Transaksi',
              const KasirTransaksiPage()),
          _menu(context, Icons.inventory, 'Cek Produk',
              const CekProdukPage(),
              active: true),
          _menu(context, Icons.history, 'Riwayat Transaksi',
              const RiwayatTransaksiPage()),
          const Spacer(),
          _logout(context),
        ],
      ),
    );
  }

  Widget _menu(BuildContext context, IconData icon, String text, Widget page,
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
        onTap: () {
          if (!active) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          }
        },
      ),
    );
  }

  // ================= TOPBAR =================

  Widget _topbar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Cek Produk',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Icon(Icons.notifications_none),
        ],
      ),
    );
  }

  // ================= TABLE =================

  Widget _tableHeader() {
    return const Row(
      children: [
        _Header('ID Barang'),
        _Header('Nama Produk'),
        _Header('Kategori'),
        _Header('Harga'),
        _Header('Stok'),
        _Header('Status'),
        _Header('Aksi'),
      ],
    );
  }

  Widget _cell(String text) {
    return Expanded(child: Text(text));
  }

  Widget _status(bool ready) {
    return Expanded(
      child: Chip(
        label: Text(ready ? 'Ready' : 'Habis'),
        backgroundColor:
            ready ? Colors.green.shade100 : Colors.red.shade100,
      ),
    );
  }

  Widget _action(BuildContext context) {
    return Expanded(
      child: IconButton(
        icon: const Icon(Icons.remove_red_eye),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              title: Text('Detail Produk'),
              content: Text('Detail produk ditampilkan di sini'),
            ),
          );
        },
      ),
    );
  }

  // ================= LOGOUT =================

  Widget _logout(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.power_settings_new, color: Colors.red),
      title: const Text('Keluar', style: TextStyle(color: Colors.red)),
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (_) => false,
        );
      },
    );
  }

  BoxDecoration _card() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
      ],
    );
  }
}

// ================= HEADER CELL =================

class _Header extends StatelessWidget {
  final String text;
  const _Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
