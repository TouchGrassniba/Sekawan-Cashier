import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'laporan.dart';
import 'manajemen_produk.dart';
import '../login.dart';

/// ================= MODEL =================
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

/// ================= PAGE =================
class ManajemenUserPage extends StatefulWidget {
  const ManajemenUserPage({super.key});

  @override
  State<ManajemenUserPage> createState() => _ManajemenUserPageState();
}

class _ManajemenUserPageState extends State<ManajemenUserPage> {
  final List<UserModel> users = [
    UserModel(id: 'CH002', nama: 'Bemi', role: 'Cashier', aktif: true, lastLogin: 'Kemarin, 20:10', catatan: 'Bekerja dengan sangat baik.'),
    UserModel(id: 'CH001', nama: 'Blasius', role: 'Cashier', aktif: false, lastLogin: '7 hari lalu', catatan: 'Akun ditangguhkan sementara.'),
    UserModel(id: 'MG001', nama: 'Bemi', role: 'Manager', aktif: true, lastLogin: 'Hari ini, 08:12', catatan: 'Admin pusat.'),
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

  /// ================= SIDEBAR =================
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
              Image.asset('images/logo.png', width: 40, errorBuilder: (c, e, s) => const Icon(Icons.store)),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SEKAWAN CASHIER', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Manager', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          _menu(context, Icons.dashboard, 'Dashboard', () => _go(context, const DashboardPage())),
          _menu(context, Icons.receipt_long, 'Laporan Penjualan', () => _go(context, const LaporanPenjualanPage())),
          _menu(context, Icons.inventory, 'Manajemen Produk', () => _go(context, const ManajemenProdukPage())),
          _menu(context, Icons.people, 'Manajemen User', () {}, active: true),
          const Spacer(),
          _logout(context),
        ],
      ),
    );
  }

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Manajemen User', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('Kelola akun user', style: TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              UserNotificationButton(users: users),
              const SizedBox(width: 12),
              const CircleAvatar(backgroundColor: Color(0xFFF2C55C), child: Text('J')),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () {}, 
          icon: const Icon(Icons.add),
          label: const Text('Tambah User'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF2C55C),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ],
    );
  }

  Widget _summaryRow() {
    return Row(
      children: [
        _summary('Total User', users.length.toString(), 'Berdasarkan data'),
        _summary('Kasir Aktif', users.where((u) => u.role == 'Cashier' && u.aktif).length.toString(), 'Kasir aktif'),
        _summary('Non Aktif', users.where((u) => !u.aktif).length.toString(), 'User non aktif'),
      ],
    );
  }

  Widget _table() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)],
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

  Widget _tableHeader() => const Row(
        children: [
          Expanded(flex: 1, child: Text('ID User', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Nama User', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('Peran', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Terakhir Login', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('Catatan', style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 120, child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      );

  Widget _tableRow(UserModel u) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(u.id)),
          Expanded(flex: 2, child: Text(u.nama)),
          Expanded(flex: 1, child: Text(u.role)),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: u.aktif ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                u.aktif ? 'Aktif' : 'Non-Aktif',
                textAlign: TextAlign.center,
                style: TextStyle(color: u.aktif ? Colors.green : Colors.red, fontSize: 12),
              ),
            ),
          ),
          Expanded(flex: 2, child: Text(u.lastLogin)),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => _dialogCatatan(u),
              child: const Text('Lihat', style: TextStyle(color: Colors.blue)),
            ),
          ),
          SizedBox(
            width: 120,
            child: Row(
              children: [
                _icon(Icons.remove_red_eye, Colors.blue, () => _dialogDetail(u)),
                const SizedBox(width: 8),
                _icon(Icons.edit, Colors.orange, () => _dialogEdit(u)),
                const SizedBox(width: 8),
                if (u.role != 'Manager')
                  _icon(Icons.delete, Colors.red, () => _dialogHapus(u)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, size: 20, color: color),
    );
  }

  /// ================= DIALOG IMPLEMENTATIONS =================

  void _dialogDetail(UserModel u) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informasi Detail User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailItem('ID User', u.id),
            _detailItem('Nama Lengkap', u.nama),
            _detailItem('Role / Peran', u.role),
            _detailItem('Status Akun', u.aktif ? 'Aktif' : 'Non-Aktif'),
            _detailItem('Login Terakhir', u.lastLogin),
            const Divider(),
            const Text('Catatan Internal:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 4),
            Text(u.catatan.isEmpty ? '-' : u.catatan, style: const TextStyle(color: Colors.black87)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
        ],
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  void _dialogCatatan(UserModel u) {
    TextEditingController catatanController = TextEditingController(text: u.catatan);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Catatan: ${u.nama}'),
        content: TextField(
          controller: catatanController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Tambahkan catatan di sini...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              setState(() => u.catatan = catatanController.text);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            child: const Text('Simpan Catatan'),
          ),
        ],
      ),
    );
  }

  void _dialogEdit(UserModel u) {
    TextEditingController nameController = TextEditingController(text: u.nama);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profil User'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Nama User', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              setState(() => u.nama = nameController.text);
              Navigator.pop(context);
            },
            child: const Text('Simpan Perubahan'),
          ),
        ],
      ),
    );
  }

  void _dialogHapus(UserModel u) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus User'),
        content: Text('Hapus user ${u.nama}? Tindakan ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              setState(() => users.removeWhere((element) => element.id == u.id));
              Navigator.pop(context);
            },
            child: const Text('Hapus Sekarang', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// ================= UTILS =================
  Widget _menu(BuildContext c, IconData i, String t, VoidCallback onTap, {bool active = false}) => ListTile(
        leading: Icon(i, color: active ? Colors.black : Colors.black54),
        title: Text(t, style: TextStyle(fontWeight: active ? FontWeight.bold : FontWeight.normal)),
        tileColor: active ? Colors.white : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: onTap,
      );

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
              Text(v, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(n, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      );

  Widget _logout(BuildContext context) => ListTile(
        leading: const Icon(Icons.power_settings_new, color: Colors.red),
        title: const Text('Keluar', style: TextStyle(color: Colors.red)),
        onTap: () => Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false),
      );

  void _go(BuildContext c, Widget p) => Navigator.pushReplacement(c, MaterialPageRoute(builder: (_) => p));
}

/// ================= NOTIFICATION COMPONENTS =================
class UserNotificationButton extends StatefulWidget {
  final List<UserModel> users;
  const UserNotificationButton({super.key, required this.users});

  @override
  State<UserNotificationButton> createState() => _UserNotificationButtonState();
}

class _UserNotificationButtonState extends State<UserNotificationButton> {
  OverlayEntry? _overlay;

  void _toggle() {
    if (_overlay == null) {
      _overlay = _createOverlay();
      Overlay.of(context).insert(_overlay!);
    } else {
      _overlay!.remove();
      _overlay = null;
    }
  }

  OverlayEntry _createOverlay() {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (_) => GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              top: offset.dy + 45,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: _NotificationCard(users: widget.users),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.users.where((u) => !u.aktif).length;
    return Stack(
      children: [
        IconButton(icon: const Icon(Icons.notifications_none), onPressed: _toggle),
        if (count > 0)
          Positioned(
            right: 8,
            top: 8,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: Colors.red,
              child: Text(count.toString(), style: const TextStyle(fontSize: 8, color: Colors.white)),
            ),
          )
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final List<UserModel> users;
  const _NotificationCard({required this.users});

  @override
  Widget build(BuildContext context) {
    final nonAktif = users.where((u) => !u.aktif).toList();

    return Container(
      width: 320,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Status User', style: TextStyle(fontWeight: FontWeight.bold)),
          const Divider(),
          if (nonAktif.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('Semua user aktif', style: TextStyle(color: Colors.grey)),
            )
          else
            ...nonAktif.map((u) => _NotifItem(
                  icon: Icons.person_off,
                  color: Colors.red,
                  title: 'User Non-Aktif',
                  subtitle: '${u.nama} sedang non-aktif.',
                )),
        ],
      ),
    );
  }
}

class _NotifItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, subtitle;

  const _NotifItem({required this.icon, required this.color, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}