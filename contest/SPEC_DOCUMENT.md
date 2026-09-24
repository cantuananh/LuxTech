# LuxTech — Spec Document (Tài liệu đặc tả tính năng chuẩn)

Tài liệu này mô tả **hành vi đúng** của hệ thống LuxTech để đội thi dùng làm mốc so sánh khi săn bug. Bất kỳ hành vi nào khác với mô tả dưới đây (làm được điều KHÔNG nên làm được, hoặc KHÔNG làm được điều NÊN làm được) đều là ứng viên bug hợp lệ.

## 1. Vai trò & quyền hạn

| Vai trò | Được phép | Không được phép |
|---|---|---|
| **ADMIN** | Toàn quyền: quản lý sản phẩm, danh mục, khách hàng, đơn hàng, tài khoản người dùng | — |
| **STAFF** | Xem/tìm sản phẩm, danh mục (không tạo/sửa/xóa); xem/thêm/sửa khách hàng (không xóa); xem/xử lý đơn hàng | Không được vào `/users` (quản lý tài khoản); không được tạo/sửa/xóa sản phẩm, danh mục; không được xóa khách hàng; không dùng khu vực mua sắm (`/cart`, `/checkout`, `/my-orders`, `/profile`) |
| **CUSTOMER** | Xem sản phẩm, mua hàng (giỏ hàng, thanh toán), xem đơn hàng **của chính mình**, xem/sửa hồ sơ **của chính mình** | Không được vào khu vực quản trị (`/dashboard`, `/products`, `/categories`, `/customers`, `/orders`, `/users`); **không được xem/thao tác dữ liệu của khách hàng khác** (đơn hàng, hồ sơ) |

Tài khoản demo có sẵn (đổi mật khẩu sau khi thi thử nếu triển khai thật): `admin/123456`, `staff/123456`, `customer/123456`.

## 2. Nghiệp vụ giỏ hàng & đặt hàng
- Số lượng mỗi sản phẩm trong giỏ hàng phải là **số nguyên dương** (tối thiểu 1) và không vượt quá tồn kho hiện có.
- Tổng tiền đơn hàng = tổng (đơn giá × số lượng) của từng dòng, **không bao giờ được thấp hơn** tổng khi mọi số lượng đều hợp lệ (dương).
- Giá tính tiền phải luôn lấy từ dữ liệu sản phẩm mới nhất trong database tại thời điểm đặt hàng (không tin vào giá trị client gửi lên).
- Khách hàng chỉ được xem/hủy đơn hàng **do chính mình đặt**. ADMIN/STAFF được xem tất cả.

## 3. Thanh toán VNPay
- Đơn hàng chỉ được đánh dấu "đã thanh toán" khi có xác nhận hợp lệ **thực sự đến từ VNPay** (chữ ký hợp lệ VÀ số tiền xác nhận khớp đúng tổng đơn hàng trong hệ thống).
- Không ai (kể cả người có source code) được tự tạo ra một xác nhận thanh toán hợp lệ nếu không thực sự thanh toán qua cổng VNPay.

## 4. Đầu vào & hiển thị dữ liệu
- Mọi dữ liệu người dùng nhập (tên, địa chỉ, từ khóa tìm kiếm, ghi chú...) khi hiển thị lại trên bất kỳ trang nào (kể cả trang quản trị) phải hiển thị **đúng nguyên văn dưới dạng text**, không được thực thi như mã HTML/JavaScript.
- Truy vấn tìm kiếm không được làm lộ cấu trúc dữ liệu hoặc cho phép truy xuất dữ liệu ngoài phạm vi sản phẩm (vd: không được trả về TOÀN BỘ sản phẩm bất kể từ khóa nhập, không được gây lỗi hệ thống khi nhập ký tự đặc biệt).

## 5. Thao tác thay đổi dữ liệu (tạo/sửa/xóa)
- Các thao tác xóa/sửa dữ liệu (sản phẩm, danh mục, khách hàng, đơn hàng...) chỉ được thực hiện khi có **hành động xác nhận chủ đích** từ đúng người có quyền — không được thực hiện chỉ vì người dùng mở một đường link/hình ảnh do người khác gửi.

## 6. Tải lên tệp
- Chỉ được tải lên các tệp ảnh hợp lệ (jpg/png/webp...) cho hình ảnh sản phẩm. Không được phép tải lên và thực thi mã nguồn (jsp, php, html chứa script...) trên server.

## 7. Phiên đăng nhập & xác thực
- Sau khi đăng nhập thành công, định danh phiên (session) phải được cấp mới — không được tái sử dụng session ID có từ trước khi đăng nhập.
- Hệ thống nên có giới hạn hợp lý với việc thử sai mật khẩu liên tục.

## 8. Giao diện
- Toàn bộ trang phải hiển thị đúng, đầy đủ chức năng ở độ rộng màn hình điện thoại phổ thông (từ ~375px), không có phần tử quan trọng (nút bấm, form) bị tràn/lệch/khuất khỏi khung nhìn.

---
*Tài liệu này KHÔNG liệt kê danh sách lỗi cụ thể — đó là nhiệm vụ của đội thi. Đây chỉ là mô tả "hệ thống nên hoạt động như thế nào".*
