import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:appbyflutter/core/theme/display_mode.dart';
import 'package:appbyflutter/core/theme/display_mode_controller.dart';

/// 首次启动（或未选过模式）时的「普通模式 / 长辈模式」选择页
/// 选择后进入登录页或首页（由登录状态决定）
class DisplayModeSelectionPage extends StatelessWidget {
  const DisplayModeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DisplayModeController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '请选择使用模式',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                '选择后可在设置中随时切换',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 48),
              _ModeCard(
                title: '普通模式',
                subtitle: '标准字体，适合日常使用',
                icon: Icons.text_fields,
                onTap: () => controller.selectAndConfirm(DisplayMode.normal),
              ),
              const SizedBox(height: 16),
              _ModeCard(
                title: '长辈模式',
                subtitle: '更大字体，阅读更轻松',
                icon: Icons.format_size,
                onTap: () => controller.selectAndConfirm(DisplayMode.elder),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.blue.shade700, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
