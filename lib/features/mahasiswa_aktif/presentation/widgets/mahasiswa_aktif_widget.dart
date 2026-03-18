import 'package:dashboard_mahasiswa/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:flutter/material.dart';

class ModernMahasiswaAktifCard extends StatefulWidget {
  final MahasiswaAktifModel mahasiswa;
  final List<Color>? gradientColors;

  const ModernMahasiswaAktifCard({
    super.key,
    required this.mahasiswa,
    this.gradientColors,
  });

  @override
  State<ModernMahasiswaAktifCard> createState() =>
      _ModernMahasiswaAktifCardState();
}

class _ModernMahasiswaAktifCardState extends State<ModernMahasiswaAktifCard>
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
          const Color(0xFF059669),
          const Color(0xFF10B981),
        ];

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                gradientColors.first.withOpacity(0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: gradientColors.first.withOpacity(0.15)),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColors),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Post #${widget.mahasiswa.id}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'User ${widget.mahasiswa.userId}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gradientColors.first,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.mahasiswa.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                    Icons.badge_outlined, 'ID: ${widget.mahasiswa.id}'),
                const SizedBox(height: 4),
                _buildInfoRow(
                  Icons.description_outlined,
                  widget.mahasiswa.body,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {int maxLines = 1}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[700], fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class MahasiswaAktifListView extends StatelessWidget {
  final List<MahasiswaAktifModel> mahasiswaAktifList;
  final VoidCallback? onRefresh;

  const MahasiswaAktifListView({
    super.key,
    required this.mahasiswaAktifList,
    this.onRefresh,
  });

  static const List<List<Color>> _cardGradients = [
    [Color(0xFF047857), Color(0xFF10B981)],
    [Color(0xFF0369A1), Color(0xFF0EA5E9)],
    [Color(0xFF7C3AED), Color(0xFFA855F7)],
    [Color(0xFFBE123C), Color(0xFFE11D48)],
  ];

  @override
  Widget build(BuildContext context) {
    if (mahasiswaAktifList.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => onRefresh?.call(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 220),
            Center(
              child: Text(
                'Data posts belum tersedia',
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
        itemCount: mahasiswaAktifList.length,
        itemBuilder: (context, index) {
          final mahasiswa = mahasiswaAktifList[index];
          final gradient = _cardGradients[index % _cardGradients.length];

          return ModernMahasiswaAktifCard(
            mahasiswa: mahasiswa,
            gradientColors: gradient,
          );
        },
      ),
    );
  }
}
