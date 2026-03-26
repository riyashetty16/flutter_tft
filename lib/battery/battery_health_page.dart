import 'package:flutter/material.dart';

import '../home/home_page.dart';

class BatteryHealthPage extends StatelessWidget {
  const BatteryHealthPage({super.key});

  // Demo values (wire to real data later).
  static const int batteryPercent = 10;
  static const int limitPercent = 100;
  static const String batteryCondition = 'Poor';
  static const String batterySerialNo = 'A12024071900080';
  static const int batteryTempC = 48;

  @override
  Widget build(BuildContext context) {
    const designSize = Size(900, 500);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: designSize.width,
                height: designSize.height,
                child: Stack(
                  children: const [
                    _Bg(),
                    _HeaderRow(),
                    _BatteryBar(),
                    _BottomInfoRow(),
                    _LogoBackButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Bg extends StatelessWidget {
  const _Bg();

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.black),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 90,
      right: 90,
      top: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _HeaderMetric(label: 'Battery:', value: '${BatteryHealthPage.batteryPercent}%'),
          _HeaderMetric(label: 'Limit:', value: '${BatteryHealthPage.limitPercent}%'),
        ],
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  const _HeaderMetric({required this.label, required this.value});

  final String label;
  final String value;

  static const _panelText = Color(0xFFB8B8B8);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: _panelText,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

class _BatteryBar extends StatelessWidget {
  const _BatteryBar();

  @override
  Widget build(BuildContext context) {
    final pct = (BatteryHealthPage.batteryPercent / BatteryHealthPage.limitPercent).clamp(0.0, 1.0);

    return Positioned(
      left: 90,
      right: 90,
      top: 135,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF2A2A2A),
                      Color(0xFF5A5A5A),
                      Color(0xFF8A8A8A),
                      Color(0xFF1A1A1A),
                    ],
                    stops: [0.0, 0.35, 0.7, 1.0],
                  ),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: pct,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF5A0000),
                      Color(0xFFB30000),
                      Color(0xFFFF1A1A),
                    ],
                    stops: [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.14),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.2),
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomInfoRow extends StatelessWidget {
  const _BottomInfoRow();

  static const _warnRed = Color(0xFFB00020);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 90,
      right: 90,
      top: 250,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _InfoBlock(
            title: 'Battery Condition',
            value: BatteryHealthPage.batteryCondition,
            valueColor: _warnRed,
          ),
          SizedBox(width: 100),
          _InfoBlock(
            title: 'Battery Serial No:',
            value: BatteryHealthPage.batterySerialNo,
            valueColor: Colors.white,
          ),
          Spacer(),
          _InfoBlock(
            title: 'Battery Temp:',
            value: '${BatteryHealthPage.batteryTempC}°C',
            valueColor: _warnRed,
            alignEnd: true,
          ),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({
    required this.title,
    required this.value,
    required this.valueColor,
    this.alignEnd = false,
  });

  final String title;
  final String value;
  final Color valueColor;
  final bool alignEnd;

  static const _panelText = Color(0xFFB8B8B8);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _panelText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

class _LogoBackButton extends StatelessWidget {
  const _LogoBackButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12,
      top: 12,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (_) => const HomePage()),
              (route) => false,
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/images/logo.png',
              width: 44,
              height: 44,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

