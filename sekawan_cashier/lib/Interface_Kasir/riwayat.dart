import 'package:flutter/material.dart';
import 'transaksi.dart';
import 'cek_produk.dart';
import 'package:sekawan_cashier/login.dart';

class RiwayatTransaksiPage extends StatelessWidget {
  const RiwayatTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'tanggal': '3 Des 2025',
        'trx': 'TRX-00215',
        'metode': 'Qris',
        'total': 'Rp 1.900.000',
        'kasir': 'Cas Hier',
        'items': [
          {'nama': 'Semen Tiga Roda', 'qty': 2, 'harga': 'Rp 500.000'},
          {'nama': 'Gergaji', 'qty': 1, 'harga': 'Rp 900.000'},
        ],
      },
      {
        'tanggal': '3 Des 2025',
        'trx': 'TRX-00214',
        'metode': 'Cash',
        'total': 'Rp 1.850.000',
        'kasir': 'Cas Hier',
        'items': [
          {'nama': 'Aquaproof 20kg', 'qty': 3, 'harga': 'Rp 600.000'},
        ],
      },
      {
        'tanggal': '3 Des 2025',
        'trx': 'TRX-00213',
        'metode': 'BCA',
        'total': 'Rp 1.700.000',
        'kasir': 'Cas Hier',
        'items': [
          {'nama': 'Semen Tiga Roda', 'qty': 1, 'harga': 'Rp 700.000'},
          {'nama': 'Cat Tembok', 'qty': 2, 'harga': 'Rp 500.000'},
        ],
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
                            'Detail Transaksi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          _header(),
                          const Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final trx = data[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      _cell(trx['tanggal']),
                                      _cell(trx['trx']),
                                      _cell(trx['metode']),
                                      _cell(trx['total']),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  _detailDialog(context, trx),
                                            );
                                          },
                                          child: const Text(
                                            'Detail',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
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

  // ================= HEADER =================

  Widget _header() => const Row(
        children: [
          Expanded(child: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text('No. Transaksi', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text('Metode', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      );

  Widget _cell(dynamic value) =>
      Expanded(child: Text(value.toString()));

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
          Text('Riwayat Transaksi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Icon(Icons.notifications_none),
        ],
      ),
    );
  }

  // ================= DETAIL DIALOG =================

  Widget _detailDialog(BuildContext context, Map<String, dynamic> trx) {
    final List items = trx['items'];

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Transaksi : ${trx['trx']}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Tanggal : ${trx['tanggal']}'),
            Text('Kasir : ${trx['kasir']}'),
            const Divider(height: 30),

            const Row(
              children: [
                Expanded(flex: 3, child: Text('Nama Produk', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const Divider(),

            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(item['nama'])),
                  Expanded(child: Text(item['qty'].toString())),
                  Expanded(child: Text(item['harga'])),
                ],
              ),
            )),

            const Divider(height: 30),

            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Total : ${trx['total']}'),
                  Text('Metode : ${trx['metode']}'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2C55C)),
                  onPressed: () {},
                  child: const Text('Cetak Ulang Struk'),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ================= CARD =================

  BoxDecoration _card() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)],
      );

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
              const CekProdukPage()),
          _menu(context, Icons.history, 'Riwayat Transaksi',
              const RiwayatTransaksiPage(),active: true),

          const Spacer(),
          _logout(context),
        ],
      ),
    );
  }

  // ================= MENU =================

  Widget _menu(
    BuildContext context,
    IconData icon,
    String title,
    Widget page, {
    bool active = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon,
            color: active ? Colors.black : Colors.black54),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: active
            ? null
            : () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => page),
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
}
