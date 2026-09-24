# Hướng dẫn chạy LuxTech trên máy local (macOS + Homebrew)

Dùng ở **Giai đoạn 2** để tự sửa lỗi và kiểm thử lại trên máy của đội. Quy trình này đã được kiểm chứng chạy thành công.

## 1. Cài đặt công cụ (chỉ cần làm 1 lần)

```bash
brew install maven tomcat mysql
```

Cần JDK 17 (kiểm tra bằng `/usr/libexec/java_home -V`; nếu chưa có, cài Temurin/Corretto 17 qua `brew install --cask temurin17` hoặc trang chủ Adoptium).

## 2. Khởi động MySQL & tạo database

```bash
brew services start mysql
# Đặt mật khẩu root (nếu MySQL mới cài, ví dụ thành 123456):
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';"

mysql -u root -p123456 -e "CREATE DATABASE IF NOT EXISTS electronic_store CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -u root -p123456 electronic_store < database/schema.sql
```

## 3. Cấu hình kết nối

Sửa `src/main/resources/db.properties` cho khớp mật khẩu MySQL của máy bạn (mặc định đã để `123456`), hoặc dùng biến môi trường (ưu tiên hơn, không cần sửa file):

```bash
export DB_HOST=localhost
export DB_PORT=3306
export DB_NAME=electronic_store
export DB_USERNAME=root
export DB_PASSWORD=123456
```

## 4. Build

```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
mvn clean package -DskipTests
```
→ Tạo ra `target/lux_tech.war`.

## 5. Deploy & chạy Tomcat

```bash
TOMCAT_HOME=$(brew --prefix tomcat)/libexec
cp target/lux_tech.war $TOMCAT_HOME/webapps/lux_tech.war
$TOMCAT_HOME/bin/catalina.sh start
```

Truy cập: `http://localhost:8080/lux_tech/`

Tài khoản demo: `admin/123456`, `staff/123456`, `customer/123456`.

## 6. Sau khi sửa code — build & deploy lại

```bash
$TOMCAT_HOME/bin/catalina.sh stop
mvn clean package -DskipTests
cp target/lux_tech.war $TOMCAT_HOME/webapps/lux_tech.war
$TOMCAT_HOME/bin/catalina.sh start
```

Xem log nếu có lỗi: `tail -f $TOMCAT_HOME/logs/catalina.out`

## 7. Nộp bài
Push code đã sửa lên nhánh/repo được BTC chỉ định trước deadline, kèm 1 file `FIXES.md` ngắn liệt kê các lỗi đội đã sửa và cách sửa.
