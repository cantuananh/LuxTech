# Mẫu Bug Report — The Code Craft Arena: Bug Hunt & Fix

Mỗi lỗi tìm được, đội thi điền 1 mục theo mẫu dưới đây (copy vào Google Sheet/Form chung của BTC, hoặc file này).

## Mẫu 1 mục bug

- **Tên đội:**
- **Tên lỗi (ngắn gọn):**
- **Nhóm lỗi:** [ ] Logic  [ ] UI/UX  [ ] Performance/Async  [ ] Security
- **URL/endpoint bị ảnh hưởng:**
- **Vai trò cần để tái hiện:** (Không cần đăng nhập / Customer / Staff / Admin)
- **Các bước tái hiện:**
  1.
  2.
  3.
- **Kết quả thực tế (sai):**
- **Kết quả mong đợi (theo Spec Document):**
- **Ảnh chụp màn hình / log minh chứng:** (đính kèm link hoặc file)
- **Đội tự đánh giá mức độ:** [ ] Dễ  [ ] Trung bình  [ ] Khó
- **Đề xuất hướng sửa (không bắt buộc, cộng điểm nếu đúng):**

---

## Gợi ý các điểm nên thử khi săn bug (không đảm bảo đây là toàn bộ)
- Thử nhập ký tự đặc biệt (`'`, `"`, `<script>`, số âm...) vào MỌI ô nhập liệu: tìm kiếm, số lượng, tên, địa chỉ.
- Thử đổi các tham số `id` trên URL khi đã đăng nhập (đơn hàng, hồ sơ...) xem có xem được dữ liệu của người khác không.
- Thử các thao tác xóa/sửa bằng cách gọi thẳng URL (không qua nút bấm trên giao diện).
- Kiểm tra JSESSIONID trước/sau khi đăng nhập.
- Thử đăng nhập sai liên tục xem có bị khóa/giới hạn không.
- Kiểm tra giao diện ở nhiều kích thước màn hình (DevTools responsive mode).
- Nếu có quyền Admin: thử tải lên các loại tệp khác ngoài ảnh.
- Đọc kỹ source code các file cấu hình (properties, .env mẫu...) — đôi khi bí mật (secret/key) bị lộ ngay trong mã nguồn.
