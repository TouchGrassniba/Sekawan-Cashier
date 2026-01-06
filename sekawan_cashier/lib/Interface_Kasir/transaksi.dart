import 'package:flutter/material.dart';
import 'cek_produk.dart';
import 'riwayat.dart';
import 'package:sekawan_cashier/login.dart';

class KasirTransaksiPage extends StatelessWidget {
  const KasirTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: Row(
                      children: [
                        _cartSection(),
                        const SizedBox(width: 20),
                        _paymentSection(),
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

          _menu(
            context,
            Icons.shopping_cart,
            'Transaksi',
            const KasirTransaksiPage(),
            active: true,
          ),
          _menu(
            context,
            Icons.inventory,
            'Cek Produk',
            const CekProdukPage(),
          ),
          _menu(
            context,
            Icons.history,
            'Riwayat Transaksi',
            const RiwayatTransaksiPage(),
          ),

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Chip(label: Text('Kasir  Bemi')),
              SizedBox(width: 10),
              Chip(label: Text('No. Invoice  TRX-260106-0015')),
            ],
          ),
          const Icon(Icons.notifications_none),
        ],
      ),
    );
  }

  // ================= CART =================

  Widget _cartSection() {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _card(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daftar Belanjaan',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('1 item dalam transaksi',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                hintText: 'Scan atau ketik nama barang',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            const SizedBox(height: 16),
            _cartHeader(),
            const Divider(),
            _cartRow(),
            const Spacer(),
            const Divider(),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total Rp 55.000',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartHeader() {
    return const Row(
      children: [
        Expanded(child: Text('Produk', style: TextStyle(fontWeight: FontWeight.bold))),
        SizedBox(width: 120, child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold))),
        SizedBox(width: 40),
      ],
    );
  }

  Widget _cartRow() {
    return Row(
      children: [
        const Expanded(child: Text('Gergaji Besi')),
        SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.remove_circle_outline, size: 18),
              SizedBox(width: 8),
              Text('1'),
              SizedBox(width: 8),
              Icon(Icons.add_circle_outline, size: 18),
            ],
          ),
        ),
        const Expanded(child: Text('Rp 55.000')),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  // ================= PAYMENT =================

  Widget _paymentSection() {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _card(color: const Color(0xFFFFF4E0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ringkasan Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            const Text('Metode Pembayaran'),
            const SizedBox(height: 6),
            Row(
              children: const [
                Chip(label: Text('Qris')),
                SizedBox(width: 6),
                Chip(label: Text('Tunai')),
                SizedBox(width: 6),
                Chip(label: Text('BCA')),
              ],
            ),

            const SizedBox(height: 12),
            _rowText('Total', 'Rp 55.000'),
            _rowText('Uang diterima', '0'),
            _rowText('Kembalian', 'Rp 0'),

            const SizedBox(height: 10),
            _keypad(),
            const SizedBox(height: 10),

            const Text(
              'Pastikan angka sudah sesuai sebelum proses.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Proses'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowText(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left),
          Text(right, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _keypad() {
    final keys = [
      '1','2','3',
      '4','5','6',
      '7','8','9',
      '0','C','Max'
    ];

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 2,
      children: keys.map((k) {
        return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          child: Text(k),
        );
      }).toList(),
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

  // ================= UTIL =================

  BoxDecoration _card({Color color = Colors.white}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
      ],
    );
  }
}
