Word Wide Web
1 bài web dễ. thật ra mình nghĩ nó khá xàm zzz. nói nó dễ vì nó dễ thật + nhiều ng làm dc. nma cảm thấy bài nó k rõ ràng lắm. nchung mình cx gần gần đoán ra nma k nghĩ là nó kiểu content là k có href =)). mình lại nghĩ là tìm regex có cái href đấy nma ....

Thôi đây là wu
`
#!/usr/bin/env python3
import requests
import re

s = requests.Session()

url = 'http://web.chal.csaw.io:5010'
path = ''

while True:
    r = s.get(url + path)
    body = r.text

    pattern = '\<a href="(\/.+)"\>'
    m = re.search(pattern, body)
    if m is None:
        print(body)
        break
    path = m.group(1)
`

That's all. mình ngồi làm có 1 bài. cx lười à. giải sau cố hơn
