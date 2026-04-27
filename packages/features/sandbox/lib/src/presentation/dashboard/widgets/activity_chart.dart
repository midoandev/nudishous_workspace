import 'package:core_i18n/core_i18n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/activity_filter.dart';
import '../../../domain/entities/day_nutrition_summary.dart';

class ActivityChart extends StatelessWidget {
  final List<DayNutritionSummary> data;
  final ActivityFilter currentFilter;
  final Function(ActivityFilter) onFilterChanged;

  const ActivityChart({
    super.key,
    required this.data,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          // Modern API: withValues
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.s.sandbox.activity.title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildFilterMenu(context),
            ],
          ),
          const SizedBox(height: 24),
          _buildChartActivity(context),
        ],
      ),
    );
  }

  Widget _buildChartActivity(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final primaryColor = context.colorScheme.primary;

    return AspectRatio(
      aspectRatio: 1.8,
      child: LineChart(
        LineChartData(
          // 1. Interaktivitas Klik/Sentuh
          lineTouchData: _buildLineTouchData(context),

          gridData: const FlGridData(show: false),
          // Clean background
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(sideTitles: _bottomTitles(context)),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),

          // Kalkulasi Y-axis otomatis berdasarkan Kalori tertinggi
          minY: 0,
          maxY:
              data
                  .map((e) => e.totalCalories)
                  .fold(0.0, (max, v) => v > max ? v : max) *
              1.1,

          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value.totalCalories);
              }).toList(),
              isCurved: true,
              // Smooth curve like in image
              // curveShape: Curves.easeInOut,
              color: primaryColor,
              barWidth: 4,
              // Thick line
              isStrokeCapRound: true,

              // Styling Titik (Dot)
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 6,
                      color: context.colorScheme.surface, // Inside color
                      strokeWidth: 3,
                      strokeColor: primaryColor, // Border color
                    ),
              ),

              // Area Fill Gradasi di bawah garis
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor.withValues(alpha: 0.2), // Top color
                    primaryColor.withValues(alpha: 0.0), // Bottom transparent
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desain Tooltip saat titik di-klik
  LineTouchData _buildLineTouchData(BuildContext context) {
    final s = context.s.sandbox;

    return LineTouchData(
      handleBuiltInTouches: true,
      touchSpotThreshold: 20,
      getTouchedSpotIndicator:
          (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                // Garis vertikal tipis saat titik diklik
                FlLine(
                  color: context.colorScheme.primary.withValues(alpha: 0.3),
                  strokeWidth: 2,
                  dashArray: [5, 5],
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                        radius: 8, // Sedikit membesar saat diklik
                        color: context.colorScheme.primary,
                        strokeWidth: 2,
                        strokeColor: context.colorScheme.surface,
                      ),
                ),
              );
            }).toList();
          },
      touchTooltipData: LineTouchTooltipData(
        // Modern API Implementation
        getTooltipColor: (touchedSpot) =>
            context.colorScheme.surfaceContainerHighest,
        tooltipBorderRadius: const BorderRadius.all(Radius.circular(12)),
        tooltipPadding: const EdgeInsets.all(12),
        tooltipMargin: 8,
        // Memastikan tooltip tidak terpotong layar
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        getTooltipItems: (List<LineBarSpot> touchedSpots) {
          return touchedSpots.map((LineBarSpot touchedSpot) {
            final index = touchedSpot.x.toInt();
            final summary = data[index];

            final textStyle = context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            );

            // Tampilkan Detail Atribut saat di-klik
            return LineTooltipItem(
              '${context.getDayName(summary.date.weekday)}\n\n',
              context.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: '${s.calories}: ', style: textStyle),
                TextSpan(
                  text: '${summary.totalCalories.toInt()} kcal\n',
                  style: textStyle?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                TextSpan(text: '${s.protein}: ', style: textStyle),
                TextSpan(
                  text: '${summary.totalProtein.toInt()}g\n',
                  style: textStyle?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${s.carbs}: ', style: textStyle),
                TextSpan(
                  text: '${summary.totalCarbs.toInt()}g\n',
                  style: textStyle?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${s.fat}: ', style: textStyle),
                TextSpan(
                  text: '${summary.totalFat.toInt()}g',
                  style: textStyle?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildFilterMenu(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) => TextButton.icon(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
        label: Text(_getLabel(context, currentFilter)),
        style: TextButton.styleFrom(
          visualDensity: VisualDensity.compact,
          foregroundColor: context.colorScheme.primary,
        ),
      ),
      menuChildren: ActivityFilter.values.map((f) {
        return MenuItemButton(
          onPressed: () => onFilterChanged(f),
          child: Text(_getLabel(context, f)),
        );
      }).toList(),
    );
  }

  String _getLabel(BuildContext context, ActivityFilter f) {
    final s = context.s.sandbox.activity;
    return switch (f) {
      ActivityFilter.last7Days => s.filter_7_days,
      ActivityFilter.last30Days => s.filter_30_days,
      ActivityFilter.currentMonth => s.filter_month,
    };
  }

  double _getMaxY() =>
      data
          .map((e) => e.totalCalories)
          .fold(0, (max, v) => v.toInt() > max ? v.toInt() : max) *
      1.2;

  List<BarChartGroupData> _generateGroups(BuildContext context) {
    return data.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.totalCalories,
            color: context.colorScheme.primary,
            width: 12,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _getMaxY(),
              // Modern API: withValues
              color: context.colorScheme.primaryContainer.withValues(
                alpha: 0.2,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  SideTitles _bottomTitles(BuildContext context) => SideTitles(
    showTitles: true,
    reservedSize: 40,
    interval: 1,
    getTitlesWidget: (value, meta) {
      final index = value.toInt();

      // Guard clause: pastikan index valid dalam range data
      if (index < 0 || index >= data.length) {
        return const SizedBox.shrink();
      }

      final date = data[index].date;

      // Logika pemilihan title: Jika data banyak (> 7), gunakan angka tanggal
      // Gunakan extension context.getDayNameShort yang sudah kita buat sebelumnya
      final String title = data.length > 7
          ? date.day.toString()
          : context.getDayName(date.weekday).substring(0, 3);

      return SideTitleWidget(
        space: 16,
        meta: meta,
        child: Text(
          title,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.outline,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    },
  );
}
