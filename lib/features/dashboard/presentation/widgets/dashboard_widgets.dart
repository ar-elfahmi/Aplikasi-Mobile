import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../data/models/dashboard_model.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateLabel = '${now.day}/${now.month}/${now.year}';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, $userName',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              'Update terakhir: $dateLabel',
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    Key? key,
    required this.stats,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final DashboardStats stats;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final trendColor =
        stats.isIncrease ? AppTheme.successColor : AppTheme.errorColor;

    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  stats.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                stats.isIncrease ? Icons.trending_up : Icons.trending_down,
                color: trendColor,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            stats.value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            stats.subtitle,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingSmall,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: (isSelected ? AppTheme.primaryColor : trendColor)
                  .withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
            ),
            child: Text(
              '${stats.isIncrease ? '+' : '-'}${stats.percentage.toStringAsFixed(1)}%',
              style: TextStyle(
                color: isSelected ? AppTheme.primaryColor : trendColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
