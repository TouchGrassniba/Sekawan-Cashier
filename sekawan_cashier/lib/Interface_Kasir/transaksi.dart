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
                        _paymentSection(context),
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
          const SizedBox(height: 30),

          _menu(context, Icons.shopping_cart, 'Transaksi',
              const KasirTransaksiPage(), active: true),
          _menu(context, Icons.inventory, 'Cek Produk',
              const CekProdukPage()),
          _menu(context, Icons.history, 'Riwayat Transaksi',
              const RiwayatTransaksiPage()),

          const Spacer(),
          _logout(context),
        ],
      ),
    );
  }

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
        leading:
            Icon(icon, color: active ? Colors.black : Colors.black54),
        title: Text(
          title,
          style: TextStyle(
              fontWeight:
                  active ? FontWeight.bold : FontWeight.normal),
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

  Widget _logout(BuildContext context) {
    return ListTile(
      leading:
          const Icon(Icons.power_settings_new, color: Colors.red),
      title:
          const Text('Keluar', style: TextStyle(color: Colors.red)),
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (_) => false,
        );
      },
    );
  }

  // ================= TOPBAR =================

  Widget _topbar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5)
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Chip(label: Text('Kasir Bemi')),
              SizedBox(width: 10),
              Chip(label: Text('No. Invoice TRX-260106-0015')),
            ],
          ),
          Icon(Icons.notifications_none),
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
            const Text('1 item dalam transaksi',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                hintText: 'Scan atau ketik nama barang',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),

            const SizedBox(height: 16),
            const Divider(),
            _cartRow(),
            const Spacer(),
            const Divider(),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('Total Rp 55.000',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
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

  Widget _paymentSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _card(color: const Color(0xFFFFF4E0)),
        child: SingleChildScrollView(
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

              const SizedBox(height: 12),
              _keypad(),

              const SizedBox(height: 12),
              const Text(
                'Pastikan angka sudah sesuai sebelum proses.',
                style:
                    TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      _showSuccessDialog(context),
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
          Text(right,
              style:
                  const TextStyle(fontWeight: FontWeight.bold)),
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
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 6,
    mainAxisSpacing: 6,
    childAspectRatio: 3,
    children: keys.map((k) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: EdgeInsets.zero, // 🔥 hilangkan padding default
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          k,
          style: const TextStyle(
            fontSize: 14, // 🔥 font diperkecil
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }).toList(),
  );
}


  // ================= SUCCESS DIALOG =================

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(20),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Transaksi Berhasil',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              const Icon(Icons.check_circle,
                  color: Colors.green, size: 64),
              const SizedBox(height: 16),

              _infoRow('Transaksi ID', '5031221530'),
              _infoRow('Tanggal', 'DD MM YYYY'),

              const Divider(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Pembayaran Info',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),

              _infoRow('Total Paid', 'Rp. 55.000'),
              _infoRow('Metode Pembayaran', 'Debit Card - BCA'),
              _infoRow('Nomor Kartu', '**** **** **** 5678'),
              _infoRow('Approval Code', '856743'),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2C55C),
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cetak Struk'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left),
          Text(right,
              style:
                  const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
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
