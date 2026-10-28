import 'package:flutter/material.dart';

import 'ds_empty_state.dart';

const _emptyStateDemoSamples = <(DSEmptyStateType, String, String?)>[
  (DSEmptyStateType.question, 'Không có dữ liệu', null),
  (DSEmptyStateType.empty, 'Chưa có đơn hàng', 'Thử kéo để làm mới'),
  (DSEmptyStateType.search, 'Không tìm thấy kết quả', 'Thử từ khóa khác'),
  (DSEmptyStateType.error, 'Đã có lỗi xảy ra', 'Vui lòng thử lại'),
  (DSEmptyStateType.ok, 'Hoàn tất', null),
  (
    DSEmptyStateType.comingSoon,
    'Tính năng đang phát triển',
    'Vui lòng quay lại sau',
  ),
  (DSEmptyStateType.offline, 'Không có kết nối mạng', 'Kiểm tra Wi-Fi hoặc 4G'),
  (DSEmptyStateType.noAccess, 'Không có quyền truy cập', null),
  (DSEmptyStateType.location, 'Cần quyền vị trí', 'Bật GPS để tiếp tục'),
  (DSEmptyStateType.wait, 'Chưa đến giờ hiển thị', 'Vui lòng đợi thêm'),
];

class EmptyStateDemo extends StatelessWidget {
  const EmptyStateDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _emptyStateDemoSamples.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Empty State',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Placeholder illustrations for empty, error, search, '
                'coming soon, and related states. Pick a type via '
                'DSEmptyStateType.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          );
        }

        final sample = _emptyStateDemoSamples[index - 1];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sample.$1.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DSEmptyState(
              type: sample.$1,
              message: sample.$2,
              subMessage: sample.$3,
              padding: EdgeInsets.zero,
              imageSize: 160,
            ),
          ],
        );
      },
    );
  }
}
