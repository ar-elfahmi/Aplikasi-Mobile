import 'package:dashboard_mahasiswa/features/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';

class ModernProfileCard extends StatefulWidget {
  final ProfileModel profile;
  final List<Color>? gradientColors;

  const ModernProfileCard({
    super.key,
    required this.profile,
    this.gradientColors,
  });

  @override
  State<ModernProfileCard> createState() => _ModernProfileCardState();
}

class _ModernProfileCardState extends State<ModernProfileCard>
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
          const Color(0xFF9333EA),
          const Color(0xFFC084FC),
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
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                gradientColors.first.withOpacity(0.08),
              ],
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
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColors),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          widget.profile.nama.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.profile.nama,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'NIM ${widget.profile.nim}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: gradientColors.first.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        widget.profile.tahunLulus,
                        style: TextStyle(
                          color: gradientColors.first,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                    Icons.work_outline_rounded, widget.profile.pekerjaan),
                const SizedBox(height: 4),
                _buildInfoRow(Icons.business_outlined, widget.profile.instansi),
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
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}

class ProfileListView extends StatelessWidget {
  final List<ProfileModel> profileList;
  final VoidCallback? onRefresh;

  const ProfileListView({
    super.key,
    required this.profileList,
    this.onRefresh,
  });

  static const List<List<Color>> _cardGradients = [
    [Color(0xFF7E22CE), Color(0xFFA855F7)],
    [Color(0xFF0C4A6E), Color(0xFF0284C7)],
    [Color(0xFF14532D), Color(0xFF22C55E)],
    [Color(0xFF9A3412), Color(0xFFFB923C)],
  ];

  @override
  Widget build(BuildContext context) {
    if (profileList.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => onRefresh?.call(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 220),
            Center(
              child: Text(
                'Data profil lulusan belum tersedia',
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
        itemCount: profileList.length,
        itemBuilder: (context, index) {
          final profile = profileList[index];
          final gradient = _cardGradients[index % _cardGradients.length];

          return ModernProfileCard(
            profile: profile,
            gradientColors: gradient,
          );
        },
      ),
    );
  }
}
