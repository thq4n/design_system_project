# 📋 Hướng dẫn tạo Pull Request

## ✅ Đã hoàn thành
- ✅ Branch `features/tooltip` đã được push lên GitHub
- ✅ File `PR_CONTENT.md` đã được tạo với đầy đủ nội dung PR
- ✅ Export ds_tooltip đã được thêm vào ds_components.dart

## 🚀 Cách 1: Tạo PR qua Web Interface (Khuyến nghị)

### Bước 1: Mở link tạo PR
GitHub đã tự động tạo link cho bạn:
👉 **https://github.com/thq4n/design_system_project/pull/new/features/tooltip**

### Bước 2: Điền thông tin PR
1. **Title**: `feat(tooltip): add DSTooltip component with theming support`
2. **Description**: Copy toàn bộ nội dung từ file `PR_CONTENT.md`
3. **Base branch**: Chọn `master`
4. **Labels**: Thêm các labels sau:
   - `feature`
   - `ui/ux`
   - `enhancement`
   - `design-system`

### Bước 3: Tạo PR
- Click nút "Create pull request"
- PR sẽ được tạo và bạn có thể assign reviewers

## 🔧 Cách 2: Tạo PR bằng Script (Cần GitHub Token)

### Bước 1: Lấy GitHub Token
1. Vào GitHub Settings → Developer settings → Personal access tokens
2. Tạo token mới với quyền `repo`
3. Copy token

### Bước 2: Chạy script
```bash
# Cách 1: Dùng Python script
python3 create_pr.py YOUR_GITHUB_TOKEN

# Cách 2: Dùng shell script (cần jq)
./create_pr.sh YOUR_GITHUB_TOKEN

# Cách 3: Dùng environment variable
export GITHUB_TOKEN=your_token
python3 create_pr.py
```

## 📊 Thông tin PR

- **Title**: `feat(tooltip): add DSTooltip component with theming support`
- **Source Branch**: `features/tooltip`
- **Target Branch**: `master`
- **Commits**: 3 commits
- **Files Changed**: 8 files (+117 insertions, -10 deletions)

## 📝 Nội dung PR

Xem file `PR_CONTENT.md` để xem đầy đủ nội dung PR description.

## 🏷️ Labels cần thêm

- `feature`
- `ui/ux`
- `enhancement`
- `design-system`

## 👥 Reviewers

Sau khi tạo PR, hãy assign reviewers phù hợp.

---

**Lưu ý**: File `PR_CONTENT.md` và các script chỉ để tham khảo, không cần commit vào repository.

