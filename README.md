# xubi-server-demo
demo example server

File Dockerfile dành cho luồng build Dockerfile của Xubi; compose.yaml dành cho Portainer Git Stack. Chỉ triển khai bằng một trong hai cách trên cùng máy để tránh trùng cổng.





# Bài thực hành 01: Tạo server từ GitHub bằng Xubi Server Manager

Mục tiêu: kiểm tra bản Xubi Server Manager Windows v0.7.11, triển khai một web server bằng Docker và truy cập từ Internet bên ngoài.

Cấu hình bài thử

Example 01

| Thành phần     | Thiết lập          |
| -------------- | ------------------ |
| Tên server     | `xubi-demo`        |
| GitHub         | `xubi-server-demo` |
| Nhánh          | `main`             |
| Docker         | HTTP Echo          |
| Cổng host      | `18081`            |
| Cổng container | `5678`             |
| Giao thức      | TCP                |

## Bước 1. Tạo GitHub repository

Vào [GitHub – New repository](https://github.com/new?utm_source=chatgpt.com) và tạo repository Public tên `xubi-server-demo`.

Tạo 2 file sau:

File 1 — Dockerfile

```

FROM hashicorp/http-echo:1.0

EXPOSE 5678

CMD ["-listen=:5678", "-text=XUBI SERVER ONLINE"]

```

File 2 — compose.yaml

```

services:
  xubi-demo:
    image: hashicorp/http-echo:1.0
    container_name: xubi-demo
    command:
      - "-listen=:5678"
      - "-text=XUBI SERVER ONLINE"
    ports:
      - "18081:5678"
    restart: unless-stopped

```

File Dockerfile dành cho luồng build Dockerfile của Xubi; `compose.yaml` dành cho Portainer Git Stack. Chỉ triển khai bằng một trong hai cách trên cùng máy để tránh trùng cổng.

## Bước 2. Điền trong Xubi Server Manager Windows

Mở bản EXE v0.7.11, chọn Servers → Thêm máy chủ.

Cấu hình ví dụ

Tên server

GitHub Public

Nhánh

Dockerfile

Cổng host

Cổng container

Giao thức

&#x20;Sao chép cấu hình

Sau khi điền, chọn Lưu cấu hình → Deployments để triển khai nếu Docker trên máy Windows đã được cấu hình và Xubi nhận diện được.

Lưu ý: Chạy Xubi trên Windows không đồng nghĩa với việc nó tự triển khai tới Pi 5. Nếu mục tiêu là Pi 5, hãy thực hiện bước 3.

## Bước 3. Triển khai trên Portainer Pi 5

Vào Portainer đang chạy trên Pi 5:

1. Chọn Stacks → Add stack.
2. Đặt tên `xubi-demo`.
3. Chọn Git Repository.
4. Nhập URL repository GitHub vừa tạo.
5. Điền `refs/heads/main` và đường dẫn `compose.yaml`.
6. Bấm Deploy the stack.

Khi thành công, vào Containers sẽ thấy:

xubi-demo

Running (mong đợi)

Image

`hashicorp/http-echo:1.0`

Published Ports

18081:5678

## Bước 4. Kiểm tra truy cập

Nếu container chạy trên Pi 5, nhập địa chỉ này trên trình duyệt Pi:

`http://127.0.0.1:18081`

Kết quả mong đợi:

XUBI SERVER ONLINE

Để truy cập từ điện thoại 4G, vào router VNPT tạo NAT chuyển tiếp TCP `18081` đến IP LAN Pi 5, cổng `18081`. Sau đó tắt Wi-Fi điện thoại và truy cập:

`http://IP_PUBLIC:18081`

Nếu Windows là máy chạy container thì NAT phải trỏ đến IP LAN Windows, không phải Pi 5. Đồng thời kiểm tra firewall Windows.

Chỉ mở NAT khi đã kiểm tra server nội bộ hoạt động và xác nhận router có IPv4 public.

## Tiêu chí hoàn thành

- GitHub chứa Dockerfile và compose.yaml.
- Server được triển khai thành công.
- Portainer hiển thị container Running.
- Truy cập HTTP trong LAN thành công.
- Truy cập HTTP từ 4G thành công.

Sau bài này, bạn sẽ kiểm chứng được quá trình triển khai GitHub → Docker → Portainer và kết nối Internet. Riêng khả năng Xubi Windows điều khiển Docker trên Pi 5 vẫn cần kiểm thử kết nối remote của ứng dụng.
