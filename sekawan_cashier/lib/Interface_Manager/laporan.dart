import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'manajemen_produk.dart';
import 'manajemen_user.dart';
import '../login.dart';

class LaporanPenjualanPage extends StatelessWidget {
  const LaporanPenjualanPage({super.key});

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
                    // Pastikan file image ada di pubspec.yaml
                    Image.asset('images/logo.png', width: 40, errorBuilder: (context, error, stackTrace) => const Icon(Icons.store)),
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
                _menuItem(Icons.dashboard, 'Dashboard', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardPage()),
                  );
                }),
                _menuItem(Icons.receipt_long, 'Laporan Penjualan', active: true),
                _menuItem(Icons.inventory, 'Manajemen Produk', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ManajemenProdukPage()),
                  );
                }),
                _menuItem(Icons.people, 'Manajemen User', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ManajemenUserPage()),
                  );
                }),
                const Spacer(),
                _logoutMenu(context),
              ],
            ),
          ),

          // ================= MAIN =================
          Expanded(
            child: Column(
              children: [
                // ================= TOP BAR =================
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Laporan Penjualan',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            'Laporan penjualan toko pada semua periode',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          NotificationButton(),
                          const SizedBox(width: 20),
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFFF2C55C),
                            child: Text('J'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // ================= CONTENT =================
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _chip('Hari ini', false),
                            _chip('7 Hari', false),
                            _chip('30 Hari', false),
                            _chip('Custom', true),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _filterBox('03/12/2025 - 03/12/2025'),
                            const SizedBox(width: 10),
                            _dropdown('Semua Kasir'),
                            const SizedBox(width: 10),
                            _dropdown('Semua Metode'),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Terapkan'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            _summaryCard('Total Penjualan',
                                'Rp 12.540.000', 'Berdasarkan filter'),
                            _summaryCard('Jumlah Transaksi', '7',
                                'Total struk pada periode ini'),
                            _summaryCard('Rata-rata per transaksi',
                                'Rp 1.792.000', 'Rata-rata pada periode ini'),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // ================= TABLE =================
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Detail Transaksi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Periode 3/12/2025 s/d 3/12/2025',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 16),
                              _tableHeader(),
                              const Divider(),
                              _tableRow('3 Des 2025', 'TRX-00215', 'Beni', 'QRIS', 'Rp 1.900.000'),
                              _tableRow('3 Des 2025', 'TRX-00214', 'Beni', 'Cash', 'Rp 1.850.000'),
                              _tableRow('3 Des 2025', 'TRX-00213', 'Beni', 'BCA', 'Rp 1.700.000'),
                              _tableRow('3 Des 2025', 'TRX-00212', 'Beni', 'BCA', 'Rp 1.650.000'),
                              _tableRow('3 Des 2025', 'TRX-00211', 'Beni', 'BCA', 'Rp 1.800.000'),
                              const SizedBox(height: 12),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.black,
                                    child: Text('1',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12)),
                                  ),
                                  SizedBox(width: 6),
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.white,
                                    child: Text('2'),
                                  ),
                                  SizedBox(width: 6),
                                  Text('Next'),
                                ],
                              )
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

  // ================= UTIL METHODS =================

  static Widget _menuItem(IconData icon, String text,
      {bool active = false, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: active ? Colors.black : Colors.black87),
        title: Text(text, style: TextStyle(fontWeight: active ? FontWeight.bold : FontWeight.normal)),
        onTap: onTap,
      ),
    );
  }

  Widget _logoutMenu(BuildContext context) => ListTile(
        leading: const Icon(Icons.power_settings_new, color: Colors.red),
        title: const Text('Keluar', style: TextStyle(color: Colors.red)),
        onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (_) => false),
      );

  static Widget _chip(String text, bool active) => Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text,
            style: TextStyle(
                color: active ? Colors.white : Colors.black)),
      );

  static Widget _filterBox(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      );

  static Widget _dropdown(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Text(text),
      );

  static Widget _summaryCard(String title, String value, String note) => Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 6),
              Text(value,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(note,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      );

  static Widget _tableHeader() => const Row(
        children: [
          Expanded(flex: 2, child: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Kode', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Kasir', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Metode', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      );

  static Widget _tableRow(String date, String code, String cashier, String method, String total) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(flex: 2, child: Text(date)),
            Expanded(flex: 2, child: Text(code)),
            Expanded(flex: 2, child: Text(cashier)),
            Expanded(flex: 2, child: Text(method)),
            Expanded(flex: 2, child: Text(total, style: const TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {},
                child: const Text('Detail', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      );
}

// ================= NOTIFICATION COMPONENTS =================

class NotificationButton extends StatefulWidget {
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
    return IconButton(
      icon: const Icon(Icons.notifications_none),
      onPressed: _toggle,
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15),
        ],
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NotifItem(Icons.error, Colors.red, 'Stok Habis!', 'Semen Tiga Roda telah habis.'),
          _NotifItem(Icons.warning, Colors.orange, 'Stok Menipis!', 'Gergaji tersisa 2 unit.'),
          _NotifItem(Icons.info, Colors.blue, 'Info', 'Promo aktif hari ini.'),
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
      padding: const EdgeInsets.symmetric(vertical: 6),
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
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}