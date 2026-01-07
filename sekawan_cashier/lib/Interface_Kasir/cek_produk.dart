import 'package:flutter/material.dart';
import 'transaksi.dart';
import 'riwayat.dart';
import 'package:sekawan_cashier/login.dart';

class CekProdukPage extends StatelessWidget {
  const CekProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'id': 'M00001',
        'nama': 'Semen Tiga Roda 50kg',
        'kategori': 'Material',
        'harga': 'Rp 65.000',
        'stok': 0,
        'satuan': 'Zak',
        'ready': false,
      },
      {
        'id': 'T00001',
        'nama': 'Gergaji',
        'kategori': 'Tool',
        'harga': 'Rp 45.000',
        'stok': 20,
        'satuan': 'Unit',
        'ready': true,
      },
      {
        'id': 'P00001',
        'nama': 'Aquaproof 20kg',
        'kategori': 'Paint',
        'harga': 'Rp 120.000',
        'stok': 7,
        'satuan': 'Pail',
        'ready': true,
      },
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 16),

                          _tableHeader(),
                          const Divider(),

                          Expanded(
                            child: ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final p = products[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      _cell(p['id']),
                                      _cell(p['nama']),
                                      _cell(p['kategori']),
                                      _cell(p['harga']),
                                      _cell(p['stok']),
                                        _status(p['ready'] as bool),
                                      _action(context, p),
                                    ],
                                  ),
                                );
                              },
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
       Row(
            children: [
              Image.asset('images/logo.png', width: 40),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SEKAWAN CASHIER',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Cashier', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
                  const SizedBox(height: 30,),
          _menu(context, Icons.shopping_cart, 'Transaksi',
              const KasirTransaksiPage()),
          _menu(context, Icons.inventory, 'Cek Produk',
              const CekProdukPage(),active: true),
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

  /// FIX ERROR BOOL -> STRING
  Widget _cell(dynamic value) {
    return Expanded(
      child: Text(value.toString()),
    );
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

  Widget _action(BuildContext context, Map<String, dynamic> product) {
    return Expanded(
      child: IconButton(
        icon: const Icon(Icons.remove_red_eye),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => _detailDialog(context, product),
          );
        },
      ),
    );
  }

  // ================= DETAIL DIALOG =================

  Widget _detailDialog(BuildContext context, Map<String, dynamic> p) {
    return AlertDialog(
      title: const Text('Detail Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailRow('ID Barang', p['id']),
          _detailRow('Nama Produk', p['nama']),
          _detailRow('Harga', p['harga']),
          _detailRow('Kategori', p['kategori']),
          _detailRow('Stok', p['stok'].toString()),
          _detailRow('Satuan', p['satuan']),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child:
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value)),
        ],
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
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
