# Serialization
Insecure Deserialization: Lỗ hổng này ảnh hưởng đến Ngôn ngữ lập trình hướng đối tượng (OOP).
# Serialization la gi?
Object serialization (marshalling) là quá trình chuyển trạng thái của object (object-state) trong 1 form có cấu trúc phức tạp thành dạng message dễ đọc, lưu trong csdl hoặc save dưới dạng file text. Quá trình ngược lại là Deserialization (unmarshalling).
Các ngôn ngữ hiện tại có quá trình này:

* Java
* .NET
* PHP
* Python
* NodeJS
* Ruby

Kết quả của quá trình serialization gọi là "archive". Có 3 lọai dữ liệu:
* Text-based: dạng text (text thường, json, xml)
* Binary: bytes
* Hybrid: ví dụ như PHP serialization hoặc python pickle

# Deserialization
Deserialiazation k pải là nguyên nhân bị khai thác, mà là Insecure Deserialization.
Ý tưởng chính của Insecure Deserialization là dưới 1 số điều kiện nhất định, user có thể bắt buộc ứng dụng load 1 object tùy ý trong suốt quá trình unmarshalling. 1 số output có thể kể đến như là DoS, RCE, ....

Vậy điều kiện để exploit là j? Thật ra điều kiện này sẽ thay đổi theo ngôn ngữ lập trình và hoàn cảnh.

# POP Gadget
1 gadget là 1 đoạn code (property hoặc method), được thực hiện bởi class, có thể được gọi trong quá trình deser. Nhiều gadget có thể được kết hợp (chained) để gọi các class khác, hoặc thực thi code khác. 1 tập của gadget có thể là quá đủ để gọi 1 chức năng tùy ý được cung cấp bởi ngôn ngữ. Trong trường hợp đó, attacker có thể RCE trên ứng dụng mục tiêu thông qua POP chain.

POP gadget là nhiều class hoặc 1 phần của class với các đặc điểm:
* có thể được serialized
* có thuộc tính puclic/có thể truy cập (các biến).
* thực hiện các method chứa lỗ hổng
* có thể gọi được đến các "callable" class khác.

# Cấu trúc chung của 1 deser exploit

1. Tìm 1 endpoint của ứng dụng mà dữ liệu deser của người dùng có thể control được.
2. Tìm 1 gadget để exploit
3. Xây dựng 1 serializer để build payload.
4. Sử dụng payload

# Ví dụ
## Java
### Java: Binary Archive Format
Trong Java, mỗi đối tượng có thể dc serialize nếu class của nó implements java.io.Serializable interface.
ac ed 00 05 là signature của java object.
readObject() là function có thể khai thác.
Khai thác bằng cách truyền 1 object lồng nhau vào readObject(), buộc ứng dụng khởi tạo 1 chuỗi POP -> RCE. 
POP chain  sử dụng 1 thứ tự lớp không rõ ràng. bằng cách sử dụng ** Reflection ** (cho phép tải các method hoặc ứng dụng mà k cần có kiến thức trước về class này). Hình dung:
giả sử có 1 đối tượng nhưng không hề biết kiểu của đối tượng này và bạn muốn gọi 1 phương thức dosomething() -> reflection sẽ giúp bạn
1 trong số class khác rất quan trọng trong việc kích hoạt RCE là `ChainedTransformer`.
Transformer là 1 class trong java có thể lấy 1 object và trả về 1 object instance mới. <đọc code>
partern cuối cùng LazyMap. khó hỉu quá :<
