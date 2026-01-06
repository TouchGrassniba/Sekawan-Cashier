import 'package:flutter/material.dart';
import 'transaksi.dart';
import 'cek_produk.dart';
import 'package:sekawan_cashier/login.dart';

class RiwayatTransaksiPage extends StatelessWidget {
  const RiwayatTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      ['3 Des 2025', 'TRX-00215', 'Qris', 'Rp 1.900.000'],
      ['3 Des 2025', 'TRX-00214', 'Cash', 'Rp 1.850.000'],
      ['3 Des 2025', 'TRX-00213', 'BCA', 'Rp 1.700.000'],
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
                          const Text('Detail Transaksi',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const Divider(),
                          _header(),
                          const Divider(),
                          Expanded(
                            child: ListView(
                              children: data.map((e) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      _cell(e[0]),
                                      _cell(e[1]),
                                      _cell(e[2]),
                                      _cell(e[3]),
                                      const Expanded(
                                        child: Text('Detail',
                                            style: TextStyle(
                                                color: Colors.blue)),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
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

  Widget _header() => const Row(
        children: [
          Expanded(child: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text('No. Transaksi', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text('Metode', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      );

  Widget _cell(String t) => Expanded(child: Text(t));

  Widget _topbar() => AppBar(
        title: const Text('Riwayat Transaksi'),
        automaticallyImplyLeading: false,
      );

  BoxDecoration _card() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
        ],
      );

  Widget _sidebar(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xFFF2C55C),
      child: Column(
        children: [
          _nav(context, 'Transaksi', const KasirTransaksiPage()),
          _nav(context, 'Cek Produk', const CekProdukPage()),
          _nav(context, 'Riwayat Transaksi', const RiwayatTransaksiPage(),
              active: true),
        ],
      ),
    );
  }

  Widget _nav(BuildContext c, String t, Widget p, {bool active = false}) {
    return Container(
      color: active ? Colors.white : Colors.transparent,
      child: ListTile(
        title: Text(t),
        onTap: () =>
            Navigator.pushReplacement(c, MaterialPageRoute(builder: (_) => p)),
      ),
    );
  }
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
