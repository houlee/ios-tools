/**
 *  base64���롢����ʵ��
 *       C����Դ����
 *
 *   ע�⣺��ʹ��gcc����
 *
 *             Ҷ����
 *
 * 
 *
 *  ʹ��˵����
 *      �����в���˵�������С�-d����������Ϊbase64���룬����Ϊbase64���롣
 *                      ���С�-o������������ļ��������������׼����ļ���
 *      �������Ա�׼����stdin�����Ϊ��׼���stdout�����ض��������������
 *
 *        base64���룺�������������������ȡ���ļ�������Ϊֹ�����������������ļ���β��Ϊֹ����
 *                    ������ı���base64���롣
 *
 *        base64���룺���봿�ı���base64���룬��ȡ���ļ�������Ϊֹ�����������������ļ���β��Ϊֹ����
 *                    ���ԭ���Ķ���������
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


