import 'package:flutter/material.dart';
import '../login.dart';
import 'laporan.dart';
import 'manajemen_produk.dart';
import 'manajemen_user.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
                _menuItem(Icons.dashboard, 'Dashboard', active: true),
                _menuItem(Icons.receipt_long, 'Laporan Penjualan', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LaporanPenjualanPage()));
                }),
                _menuItem(Icons.inventory, 'Manajemen Produk', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ManajemenProdukPage()));
                }),
                _menuItem(Icons.people, 'Manajemen User', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ManajemenUserPage()));
                }),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          Text('Ringkasan aktivitas toko', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          const NotificationButton(), // Menggunakan widget notifikasi fungsional
                          const SizedBox(width: 20),
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFFF2C55C),
                            child: Text('J'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ================= CONTENT BODY =================
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // SUMMARY CARDS
                        Row(
                          children: const [
                            Flexible(
                              child: _SummaryCard(
                                title: 'Total Penjualan Hari Ini',
                                value: 'Rp 12.540.000',
                                note: '▼ 2% dibanding kemarin',
                                noteColor: Colors.red,
                              ),
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              child: _SummaryCard(
                                title: 'Jumlah Transaksi',
                                value: '7',
                                note: '▲ 1 transaksi dibanding kemarin',
                                noteColor: Colors.green,
                              ),
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              child: _SummaryCard(
                                title: 'Rata-rata Nilai Transaksi',
                                value: 'Rp 1.792.000',
                                note: '▼ 1% dibanding kemarin',
                                noteColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // GRAPH
                        _card(
                          title: 'Data Penjualan Mingguan',
                          child: const SizedBox(height: 220, child: SalesBarChart()),
                        ),
                        const SizedBox(height: 20),
                        // ACTIVITIES
                        _card(
                          title: 'Aktivitas Terbaru',
                          child: Column(
                            children: const [
                              ActivityItem(text: 'Kasir Beni menutup transaksi Rp 1.250.000', time: '2 menit lalu'),
                              ActivityItem(text: 'Kasir Beni menutup transaksi Rp 500.000', time: '30 menit lalu'),
                              ActivityItem(text: 'Stok Semen 50kg diperbarui oleh Gudang', time: '58 menit lalu'),
                              ActivityItem(text: 'Kasir Beni menutup transaksi Rp 2.000.000', time: '1 jam lalu'),
                            ],
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
    );
  }

  static Widget _menuItem(IconData icon, String text, {bool active = false, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: active ? Colors.black : Colors.black54),
        title: Text(text, style: TextStyle(fontWeight: active ? FontWeight.bold : FontWeight.normal)),
        onTap: onTap,
      ),
    );
  }

  Widget _logoutMenu(BuildContext context) => ListTile(
        leading: const Icon(Icons.power_settings_new, color: Colors.red),
        title: const Text('Keluar', style: TextStyle(color: Colors.red)),
        onTap: () => Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false),
      );
}

// ================= SUB-WIDGETS =================

Widget _card({required String title, required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

class _SummaryCard extends StatelessWidget {
  final String title, value, note;
  final Color noteColor;
  const _SummaryCard({required this.title, required this.value, required this.note, required this.noteColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(note, style: TextStyle(color: noteColor, fontSize: 11)),
        ],
      ),
    );
  }
}

class SalesBarChart extends StatelessWidget {
  const SalesBarChart({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [12, 18, 10, 22, 15, 25, 14];
    final labels = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final maxVal = data.reduce((a, b) => a > b ? a : b);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(data.length, (i) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${data[i]}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 4),
              Container(
                height: (data[i] / maxVal) * 140,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2C55C),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              Text(labels[i], style: const TextStyle(fontSize: 11)),
            ],
          ),
        );
      }),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String text, time;
  const ActivityItem({super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(fontSize: 13)),
                Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= NOTIFICATION SYSTEM =================

class NotificationButton extends StatefulWidget {
  const NotificationButton({super.key});
  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
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
              right: 24,
              child: const Material(
                color: Colors.transparent,
                child: NotificationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: _toggle,
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: const Text('4', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _NotifItem(Icons.error, Colors.red, 'Stok Habis!', 'Semen Tiga Roda telah habis.'),
          _NotifItem(Icons.warning, Colors.orange, 'Stok Menipis!', 'Gergaji tinggal tersisa 2 Unit.'),
          _NotifItem(Icons.error, Colors.red, 'Stok Habis!', 'Aqua Proof telah habis.'),
          _NotifItem(Icons.info, Colors.blue, 'Info Sistem', 'Pembaruan data berhasil dilakukan.'),
        ],
      ),
    );
  }
}

class _NotifItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, subtitle;
  const _NotifItem(this.icon, this.color, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.circle, size: 6, color: Colors.orange),
        ],
      ),
    );
  }
}