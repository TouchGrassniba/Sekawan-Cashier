import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'laporan.dart';
import 'manajemen_produk.dart';
import '../login.dart';

class UserModel {
  String id;
  String nama;
  String role;
  bool aktif;
  String lastLogin;
  String catatan;

  UserModel({
    required this.id,
    required this.nama,
    required this.role,
    required this.aktif,
    required this.lastLogin,
    required this.catatan,
  });
}

class ManajemenUserPage extends StatefulWidget {
  const ManajemenUserPage({super.key});

  @override
  State<ManajemenUserPage> createState() => _ManajemenUserPageState();
}

class _ManajemenUserPageState extends State<ManajemenUserPage> {
  final List<UserModel> users = [
    UserModel(
        id: 'CH002',
        nama: 'Bemi',
        role: 'Cashier',
        aktif: true,
        lastLogin: 'Kemarin, 20:10',
        catatan: '-'),
    UserModel(
        id: 'CH001',
        nama: 'Blasius',
        role: 'Cashier',
        aktif: false,
        lastLogin: '7 hari lalu',
        catatan: '-'),
    UserModel(
        id: 'MG001',
        nama: 'Bemi',
        role: 'Manager',
        aktif: true,
        lastLogin: 'Hari ini, 08:12',
        catatan: '-'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _sidebar(context),
          Expanded(child: _content()),
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
                  Text('Manager', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          _menu(context, Icons.dashboard, 'Dashboard',
              () => _go(context, const DashboardPage())),
          _menu(context, Icons.receipt_long, 'Laporan Penjualan',
              () => _go(context, const LaporanPenjualanPage())),
          _menu(context, Icons.inventory, 'Manajemen Produk',
              () => _go(context, const ManajemenProdukPage())),
          _menu(context, Icons.people, 'Manajemen User', () {}, active: true),
          const Spacer(),
          _logout(context),
        ],
      ),
    );
  }

  // ================= CONTENT =================
  Widget _content() {
    return Column(
      children: [
        _topBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _filterBar(),
                const SizedBox(height: 20),
                _summaryRow(),
                const SizedBox(height: 20),
                _table(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _topBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Manajemen User',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
    );
  }

  Widget _filterBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari nama atau ID user',
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: _dialogTambahUser,
          icon: const Icon(Icons.add),
          label: const Text('Tambah User'),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF2C55C),
              foregroundColor: Colors.black),
        ),
      ],
    );
  }

  Widget _summaryRow() {
    return Row(
      children: [
        _summary('Total User', users.length.toString(), 'Berdasarkan data'),
        _summary('Kasir Aktif',
            users.where((u) => u.role == 'Cashier' && u.aktif).length.toString(),
            'Kasir aktif'),
        _summary(
            'Non Aktif',
            users.where((u) => !u.aktif).length.toString(),
            'User non aktif'),
      ],
    );
  }

  // ================= TABLE =================
  Widget _table() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
          ],
        ),
        child: Column(
          children: [
            _tableHeader(),
            const Divider(),
            Expanded(
              child: ListView(
                children: users.map((u) => _tableRow(u)).toList(),
              ),
            ),
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
        SizedBox(width: 80, child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _tableRow(UserModel u) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(u.id)),
          Expanded(child: Text(u.nama)),
          Expanded(child: Chip(label: Text(u.role))),
          Expanded(
              child: Chip(
                  label: Text(u.aktif ? 'Aktif' : 'Non-Aktif'),
                  backgroundColor:
                      u.aktif ? Colors.green.shade100 : Colors.grey.shade300)),
          Expanded(child: Text(u.lastLogin)),
          Expanded(
              child: GestureDetector(
                  onTap: () => _dialogCatatan(u),
                  child: const Text('Lihat',
                      style: TextStyle(color: Colors.blue)))),
          SizedBox(
            width: 80,
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.remove_red_eye, size: 18),
                    onPressed: () => _dialogDetail(u)),
                IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    onPressed: () => _dialogEdit(u)),
                if (u.role != 'Manager')
                  IconButton(
                      icon: const Icon(Icons.delete, size: 18),
                      onPressed: () => _dialogHapus(u)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= DIALOG =================
  void _dialogDetail(UserModel u) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Detail User'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${u.id}'),
                  Text('Nama: ${u.nama}'),
                  Text('Peran: ${u.role}'),
                  Text('Status: ${u.aktif ? 'Aktif' : 'Non-Aktif'}'),
                  Text('Terakhir Login: ${u.lastLogin}'),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup'))
              ],
            ));
  }

  void _dialogTambahUser() {
    final nama = TextEditingController();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Tambah User'),
              content: TextField(controller: nama, decoration: const InputDecoration(labelText: 'Nama')),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        users.add(UserModel(
                            id: 'CH00${users.length + 1}',
                            nama: nama.text,
                            role: 'Cashier',
                            aktif: true,
                            lastLogin: '-',
                            catatan: '-'));
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Simpan'))
              ],
            ));
  }

  void _dialogEdit(UserModel u) {
    final nama = TextEditingController(text: u.nama);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Edit User'),
              content: TextField(controller: nama),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                ElevatedButton(
                    onPressed: () {
                      setState(() => u.nama = nama.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Simpan'))
              ],
            ));
  }

  void _dialogHapus(UserModel u) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Hapus User'),
              content: const Text('Apakah yakin ingin menghapus user ini?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() => users.remove(u));
                      Navigator.pop(context);
                    },
                    child: const Text('Hapus'))
              ],
            ));
  }

  void _dialogCatatan(UserModel u) {
    final c = TextEditingController(text: u.catatan);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Catatan'),
              content: TextField(controller: c),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() => u.catatan = c.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Simpan'))
              ],
            ));
  }

  // ================= UTIL =================
  Widget _menu(BuildContext c, IconData i, String t, VoidCallback onTap,
      {bool active = false}) =>
      ListTile(
          leading: Icon(i),
          title: Text(t),
          tileColor: active ? Colors.white : null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onTap: onTap);

  Widget _summary(String t, String v, String n) => Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t, style: const TextStyle(color: Colors.grey)),
              Text(v,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(n, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );

  Widget _logout(BuildContext context) => ListTile(
        leading: const Icon(Icons.power_settings_new, color: Colors.red),
        title: const Text('Keluar', style: TextStyle(color: Colors.red)),
        onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (_) => false),
      );

  void _go(BuildContext c, Widget p) =>
      Navigator.pushReplacement(c, MaterialPageRoute(builder: (_) => p));
}
