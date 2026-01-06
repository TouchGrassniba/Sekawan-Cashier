import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'laporan.dart';
import '../login.dart';
import 'manajemen_user.dart';

/// ================= MODEL =================
class Product {
  String id;
  String nama;
  String kategori;
  int harga;
  int stok;

  Product(this.id, this.nama, this.kategori, this.harga, this.stok);
}

class ManajemenProdukPage extends StatefulWidget {
  const ManajemenProdukPage({super.key});

  @override
  State<ManajemenProdukPage> createState() => _ManajemenProdukPageState();
}

class _ManajemenProdukPageState extends State<ManajemenProdukPage> {
  List<Product> products = [
    Product('M00001', 'Semen Tiga Roda 50kg', 'Material', 65000, 0),
    Product('T00001', 'Gergaji', 'Tool', 45000, 20),
    Product('P00001', 'Aquaproof 20kg', 'Paint', 120000, 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          /// ================= SIDEBAR =================
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

                _menuItem(context, Icons.dashboard, 'Dashboard',
                    () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const DashboardPage()))),
                _menuItem(context, Icons.receipt_long, 'Laporan Penjualan',
                    () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LaporanPenjualanPage()))),
                _menuItem(context, Icons.inventory, 'Manajemen Produk', null,
                    active: true),
                _menuItem(context, Icons.people, 'Manajemen User',
                    () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const ManajemenUserPage()))),

                const Spacer(),
                _logoutMenu(context),
              ],
            ),
          ),

          /// ================= MAIN =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _topBar(),
                  const SizedBox(height: 20),

                  /// SUMMARY
                  Row(
                    children: [
                      _summaryCard('Total Produk', products.length.toString()),
                      _summaryCard(
                          'Produk Aktif',
                          products.where((e) => e.stok > 0).length.toString()),
                      _summaryCard(
                          'Stok Rendah',
                          products.where((e) => e.stok == 0).length.toString()),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// TABLE
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: _box(),
                      child: Column(
                        children: [
                          _tableHeader(),
                          const Divider(),
                          Expanded(
                            child: ListView(
                              children: products
                                  .map((p) => _tableRow(p))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),

      /// ================= CREATE =================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createProduct(),
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Produk'),
      ),
    );
  }

  /// ================= CRUD =================
  void _createProduct() {
    _productForm();
  }

  void _editProduct(Product p) {
    _productForm(edit: p);
  }

  void _productForm({Product? edit}) {
    final id = TextEditingController(text: edit?.id);
    final nama = TextEditingController(text: edit?.nama);
    final harga = TextEditingController(text: edit?.harga.toString());
    final stok = TextEditingController(text: edit?.stok.toString());
    String kategori = edit?.kategori ?? 'Material';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(edit == null ? 'Tambah Produk' : 'Edit Produk'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: id, decoration: const InputDecoration(labelText: 'ID')),
          TextField(controller: nama, decoration: const InputDecoration(labelText: 'Nama')),
          TextField(controller: harga, decoration: const InputDecoration(labelText: 'Harga')),
          TextField(controller: stok, decoration: const InputDecoration(labelText: 'Stok')),
          DropdownButton<String>(
            value: kategori,
            items: ['Material', 'Tool', 'Paint']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => kategori = v!),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (edit == null) {
                  products.add(Product(id.text, nama.text, kategori,
                      int.parse(harga.text), int.parse(stok.text)));
                } else {
                  edit
                    ..id = id.text
                    ..nama = nama.text
                    ..kategori = kategori
                    ..harga = int.parse(harga.text)
                    ..stok = int.parse(stok.text);
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _detail(Product p) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Detail Produk'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('ID: ${p.id}'),
          Text('Nama: ${p.nama}'),
          Text('Kategori: ${p.kategori}'),
          Text('Harga: Rp ${p.harga}'),
          Text('Stok: ${p.stok}'),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
            _editProduct(p);
          }, child: const Text('Edit')),
        ],
      ),
    );
  }

  /// ================= TABLE =================
  Widget _tableRow(Product p) {
    final ready = p.stok > 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Expanded(child: Text(p.id)),
        Expanded(child: Text(p.nama)),
        Expanded(child: Text(p.kategori)),
        Expanded(child: Text('Rp ${p.harga}')),
        Expanded(child: Text(p.stok.toString())),
        Expanded(
          child: Chip(
            label: Text(ready ? 'Ready' : 'Habis'),
            backgroundColor:
                ready ? Colors.green.shade100 : Colors.red.shade100,
          ),
        ),
        SizedBox(
          width: 80,
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.remove_red_eye, size: 18),
                  onPressed: () => _detail(p)),
              IconButton(icon: const Icon(Icons.edit, size: 18),
                  onPressed: () => _editProduct(p)),
              IconButton(icon: const Icon(Icons.delete, size: 18),
                  onPressed: () => setState(() => products.remove(p))),
            ],
          ),
        )
      ]),
    );
  }

  /// ================= UI HELPER =================
  Widget _topBar() => const SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Manajemen Product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            CircleAvatar(child: Text('J')),
          ],
        ),
      );

  Widget _summaryCard(String t, String v) => Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(16),
          decoration: _box(),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t, style: const TextStyle(color: Colors.grey)),
            Text(v,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
          ]),
        ),
      );

  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      );

  Widget _menuItem(BuildContext c, IconData i, String t, VoidCallback? f,
          {bool active = false}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(leading: Icon(i), title: Text(t), onTap: f),
      );

  Widget _tableHeader() => const Row(children: [
        Expanded(child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Nama', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Stok', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
        SizedBox(width: 80),
      ]);

  Widget _logoutMenu(BuildContext context) => ListTile(
        leading: const Icon(Icons.power_settings_new, color: Colors.red),
        title: const Text('Keluar', style: TextStyle(color: Colors.red)),
        onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (_) => false),
      );
}
