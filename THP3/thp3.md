# Hello

Vì Ippsec recommend quyển này nên mình sẽ start từ quyển này (not 1 và 2). Tuy nhiên thỉnh thoảng vẫn sẽ check lại 1 và 2. OK let's go.

## Intro
### Penetration Testing Teams vs Red Teams
Bình thường intro sẽ skip nhanh nhưng thấy cái này khá hay.
#### Penetration Testing: kiểm tra mạng, ứng dụng, phần cứng, v.v. có phương pháp và nghiêm ngặt hơn.
Recommend book: Penetration Testing Execution Standard (PTES: http://www.pentest-standard.org)
. 
Tóm lại, bạn trải qua tất cả
các chuyển động của Xác định phạm vi, Thu thập Intel, Phân tích lỗ hổng bảo mật, Khai thác, Đăng
Khai thác và Báo cáo. Trong thử nghiệm mạng truyền thống, chúng tôi thường quét tìm
lỗ hổng bảo mật, tìm và tận dụng một hệ thống hoặc ứng dụng có thể khai thác được, có thể
khai thác một chút bài đăng, tìm quản trị viên miền và viết báo cáo.

#### Redteam
Nhiệm vụ là tìm ra TTP của đối thủ. Không bài bản như pentest, họ mô phỏng lại các sự kiện trong thế giới thực.

| Penetration Tests     | Red Teams        | 
| ------------- |:-------------:| 
| Methodical Security Assessments: |Flexible Security Assessments:|
|Pre-engagement Interactions |Intelligence Gathering|
|Intelligence Gathering|Initial Foothold
|Vulnerability Analysis|Persistence/Local Privilege
|Exploitation|Escalation
|Post Exploitation|Local/Network Enumeration
|Reporting      |Lateral Movement
||Data Identification/Exfiltration
				||Domain Privilege
				||Escalation/Dumping Hashes
				||Reporting |
|Scope:  | Scope:
|Restrictive Scope |No Rules*
|1-2 Week Engagement|1 Week – 6 Month
|Generally Announced|Engagement
|Identify vulnerabilities  | No announcement
||Test Blue teams on program,
||policies, tools, and skills
||*Can’t be illegal…   | 

## Pregame

Redteam không cần quan tâm tới nguồn gốc 1 cuộc tấn công. Thay vào đó ta sẽ học TTP. Ví dụ là 1 cuộc tấn công APT đã được phân tích của FireEye(https://www2.fireeye.com/rs/848-DID-242/images/rpt-apt29-hammertoss.pdf). (đã đọc khá hay)

### Note: nguồn các tổ chức APT(http://bit.ly/2GZb8eW) (rất hay)

### cài đặt chiến dịch

Cần đề ra các mục tiêu (objectives): muốn có j, techniques nào, tools j.
### Setting server
 Khuyến nghị sử dụng VPS
 Các bước:
 B1: khi cài xong server và đăng nhập, cần tải các tool hiệu quả (setting iptable rule, ssl, ...). recommend sử dụng e TrustedSec's The PenTesters Framework (PTF).
  This collection of scripts (https://github.com/trustedsec/ptf) 
1 lưu ý quan trọng nữa là set IPTable rule (tránh bị attack ngược lại)
### Note: Red Baron: một tập hợp các mô-đun và nhà cung cấp tùy chỉnh / bên thứ ba cho Terraform,
cố gắng tự động hóa việc tạo ra cơ sở hạ tầng linh hoạt, dùng một lần, an toàn và nhanh nhẹn
dành cho Red Teams [https://github.com/Coalfire-Research/Red-Baron]. Cho dù bạn muốn
để xây dựng máy chủ lừa đảo, cơ sở hạ tầng Cobalt Strike hoặc tạo máy chủ DNS C2, bạn
có thể làm tất cả với Terraform. 
### Tools of the trade
#### metasploit framework
+ Note: obfuscated PowerShell Meterpreter payloads: Unicorn
(https://github.com/trustedsec/unicorn)

#### Cobalt Strike
Mất tiền nên thui tạm skip cái này nhé (mực dù nhiều ng dùng)
Luưu ý Domain fronting:
- CyberArk blog :  http://bit.ly/2Hn7RW4 (vẫn là colba)
- Vincent Yiu wrote an article on how to use Alibaba CDN to support his domain
fronting attacks: http://bit.ly/2HjM3eH (1 BÀI trên medium)
-  Meterpreter Domain fronting https://bitrot.sh/post/30-11-2017-domainfronting-with-meterpreter/.

#### PowerShell Empire
#### dnscat2

1 số tool khác nhưng thôi chúng ta sẽ next nhanh qua phần 2 đó là phần recon 

## Recon 
1. Monitoring an Environment

### Regular Nmap Diffing

port diffing cron

```
#!/bin/bash 
mkdir /opt/nmap_diff 
d=$(date +%Y-%m-%d) 
y=$(date -d yesterday +%Y-%m-%d) 
/usr/bin/nmap -T4 -oX /opt/nmap_diff/scan_$d.xml 10.100.100.0/24 > /dev/null 2>&1 
if [ -e /opt/nmap_diff/scan_$y.xml ]; then
    /usr/bin/ndiff /opt/nmap_diff/scan_$y.xml /opt/nmap_diff/scan_$d.xml > /opt/nmap_diff/diff.txt 
fi 
``` 
Đây là đoạn script cơ bản để chạy nmap mỗi ngày, sau đó dụng ndiff để so sánh kết quả. ta có thể sử dụng kết quả của đoạn script để xem các port mới dc mở. (lưu ý thay IP bằng IP mục tiêu)

###  Web Screenshots

HTTPScreenshot (https://github.com/breenmachine/httpscreenshot)
Eyewitness (https://github.com/ChrisTruncer/EyeWitness)

### Cloud Scanning

how do we search on different cloud environments? 

Đầu tiên, điều quan trọng là xác định được khoảng IP được sở hữu bởi các nhà cung cấp khác nhau. VD:\

- Amazon: http://bit.ly/2vUSjED 
- Azure: http://bit.ly/2r7rHeR 
- Google Cloud: http://bit.ly/2HAsZFm
 
### Network/Service Search Engines

#### Shodan

scan port, internet, ... + vulnerabilities information (Heartbleed)

### Censys.io

[https://censys.io/]. \


censys-subdomain-finder:
https://github.com/christophetd/censys-subdomain-finder

### Manually Parsing SSL Certificates 
a