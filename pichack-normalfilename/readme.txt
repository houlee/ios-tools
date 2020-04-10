功能说明
1）替换PNG文件最后的IEND数据块，从而改变图片文件的MD5
2）对文件名做base64编码，= 改成 a
3）修改PNG文件的头，正常的PNG文件头：89	50 4e 47 0d 0a 1a 0a  ，修改为 89 55 4e	47 0d 0a 1a 0a 

数据块格式说明
http://dev.gameres.com/Program/Visual/Other/PNGFormat.htm

Length(长度)	4字节	指定数据块中数据域的长度，其长度不超过
(231－1)字节
Chunk Type Code(数据块类型码)	4字节	数据块类型码由ASCII字母(A-Z和a-z)组成
Chunk Data(数据块数据)	可变长度	存储按照Chunk Type Code指定的数据
CRC(循环冗余检测)	4字节	存储用来检测是否有错误的循环冗余码

CRC(cyclic redundancy check)域中的值是对Chunk Type Code域和Chunk Data域中的数据进行计算得到的。
CRC具体算法定义在ISO 3309和ITU-T V.42中，其值按下面的CRC码生成多项式进行计算：

x32+x26+x23+x22+x16+x12+x11+x10+x8+x7+x5+x4+x2+x+1

CRC线上校验数据获取
https://www.lammertbies.nl/comm/info/crc-calculation.html

base64的字符定义
const char * base64char = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-";
实际使用的字符串，会根据右移位数进行变化