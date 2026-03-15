import 'package:dashboard_mahasiswa/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:flutter/material.dart';

class ModernMahasiswaCard extends StatefulWidget {
  final MahasiswaModel mahasiswa;
  final List<Color>? gradientColors;
  final VoidCallback? onTap;

  const ModernMahasiswaCard({
    super.key,
    required this.mahasiswa,
    this.gradientColors,
    this.onTap,
  });

  @override
  State<ModernMahasiswaCard> createState() => _ModernMahasiswaCardState();
}

class _ModernMahasiswaCardState extends State<ModernMahasiswaCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = widget.gradientColors ??
        [
          const Color(0xFF2563EB),
          const Color(0xFF3B82F6),
        ];

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                gradientColors.first.withOpacity(0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: gradientColors.first.withOpacity(0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: gradientColors.first.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColors),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      widget.mahasiswa.nama.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mahasiswa.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                          Icons.badge_outlined, 'NIM: ${widget.mahasiswa.nim}'),
                      const SizedBox(height: 4),
                      _buildInfoRow(Icons.groups_rounded,
                          'Kelas: ${widget.mahasiswa.kelas}'),
                      const SizedBox(height: 4),
                      _buildInfoRow(Icons.calendar_today_outlined,
                          'Angkatan: ${widget.mahasiswa.angkatan}'),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: gradientColors.first),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}

class MahasiswaListView extends StatelessWidget {
  final List<MahasiswaModel> mahasiswaList;
  final VoidCallback? onRefresh;

  const MahasiswaListView({
    super.key,
    required this.mahasiswaList,
    this.onRefresh,
  });

  static const List<List<Color>> _cardGradients = [
    [Color(0xFF1E40AF), Color(0xFF2563EB)],
    [Color(0xFF0F766E), Color(0xFF14B8A6)],
    [Color(0xFF9A3412), Color(0xFFEA580C)],
    [Color(0xFF7E22CE), Color(0xFFA855F7)],
  ];

  @override
  Widget build(BuildContext context) {
    if (mahasiswaList.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => onRefresh?.call(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 220),
            Center(
              child: Text(
                'Data mahasiswa belum tersedia',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          final mahasiswa = mahasiswaList[index];
          final gradient = _cardGradients[index % _cardGradients.length];

          return ModernMahasiswaCard(
            mahasiswa: mahasiswa,
            gradientColors: gradient,
          );
        },
      ),
    );
  }
}
