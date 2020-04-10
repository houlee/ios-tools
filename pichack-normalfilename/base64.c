/**
 *  base64编码、解码实现
 *       C语言源代码
 *
 *   注意：请使用gcc编译
 *
 *             叶剑飞
 *
 * 
 *
 *  使用说明：
 *      命令行参数说明：若有“-d”参数，则为base64解码，否则为base64编码。
 *                      若有“-o”参数，后接文件名，则输出到标准输出文件。
 *      输入来自标准输入stdin，输出为标准输出stdout。可重定向输入输出流。
 *
 *        base64编码：输入任意二进制流，读取到文件读完了为止（键盘输入则遇到文件结尾符为止）。
 *                    输出纯文本的base64编码。
 *
 *        base64解码：输入纯文本的base64编码，读取到文件读完了为止（键盘输入则遇到文件结尾符为止）。
 *                    输出原来的二进制流。
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
//#include <io.h>
#include <fcntl.h>
#include <stdbool.h>
#include "base64.h"


#ifndef MAX_PATH
#define MAX_PATH 256
#endif


