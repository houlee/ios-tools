#include<iostream>

#include<string>
#include<stdlib.h>
#include<io.h>
#include <direct.h>
#include <windows.h>

using namespace std;

//#define MD5_ONLY

	int total=0;
#define oriCodeLen 12		//00 00 00 00 49 45 4E 44 AE 42 60 82   PNG文件的结尾数据块  IEND

	char  base64char[65] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-";

char * base64_encode(const unsigned char * bindata, char * base64, int binlength )
{
    int i, j;
    unsigned char current;

    for ( i = 0, j = 0 ; i < binlength ; i += 3 )
    {
        current = (bindata[i] >> 2) ;
        current &= (unsigned char)0x3F;
        base64[j++] = base64char[(int)current];

        current = ( (unsigned char)(bindata[i] << 4 ) ) & ( (unsigned char)0x30 ) ;
        if ( i + 1 >= binlength )
        {
            base64[j++] = base64char[(int)current];
            base64[j++] = '=';
            base64[j++] = '=';
            break;
        }
        current |= ( (unsigned char)(bindata[i+1] >> 4) ) & ( (unsigned char) 0x0F );
        base64[j++] = base64char[(int)current];

        current = ( (unsigned char)(bindata[i+1] << 2) ) & ( (unsigned char)0x3C ) ;
        if ( i + 2 >= binlength )
        {
            base64[j++] = base64char[(int)current];
            base64[j++] = '=';
            break;
        }
        current |= ( (unsigned char)(bindata[i+2] >> 6) ) & ( (unsigned char) 0x03 );
        base64[j++] = base64char[(int)current];

        current = ( (unsigned char)bindata[i+2] ) & ( (unsigned char)0x3F ) ;
        base64[j++] = base64char[(int)current];
    }
    base64[j] = '\0';
    return base64;
}

int base64_decode( char * base64, unsigned char * bindata )
{
    int i, j;
    unsigned char k;
    unsigned char temp[4];
    for ( i = 0, j = 0; base64[i] != '\0' ; i += 4 )
    {
        memset( temp, 0xFF, sizeof(temp) );
        for ( k = 0 ; k < 64 ; k ++ )
        {
            if ( base64char[k] == base64[i] )
                temp[0]= k;
        }
        for ( k = 0 ; k < 64 ; k ++ )
        {
            if ( base64char[k] == base64[i+1] )
                temp[1]= k;
        }
        for ( k = 0 ; k < 64 ; k ++ )
        {
            if ( base64char[k] == base64[i+2] )
                temp[2]= k;
        }
        for ( k = 0 ; k < 64 ; k ++ )
        {
            if ( base64char[k] == base64[i+3] )
                temp[3]= k;
        }

        bindata[j++] = ((unsigned char)(((unsigned char)(temp[0] << 2))&0xFC)) |
                ((unsigned char)((unsigned char)(temp[1]>>4)&0x03));
        if ( base64[i+2] == '=' )
            break;

        bindata[j++] = ((unsigned char)(((unsigned char)(temp[1] << 4))&0xF0)) |
                ((unsigned char)((unsigned char)(temp[2]>>2)&0x0F));
        if ( base64[i+3] == '=' )
            break;

        bindata[j++] = ((unsigned char)(((unsigned char)(temp[2] << 6))&0xF0)) |
                ((unsigned char)(temp[3]&0x3F));
    }
    return j;
}


 int StringN2Hex(char *src, int len,unsigned char *dest)  
{  
    unsigned char hb;  
    unsigned char lb;  
    int i, j;
 
    if(len%2 != 0)  
        return -1;  
 
    for(i=0, j=0; i< len; i++)  
    {  
        hb=src[i];  
        if( hb>='A' && hb<='F' )  
            hb = hb - 'A' + 10;  
        else if( hb>='0' && hb<='9' )  
            hb = hb - '0';  
        else 
            return -1;  
 
        i++;  
        lb=src[i];  
        if( lb>='A' && lb<='F' )  
            lb = lb - 'A' + 10;  
        else if( lb>='0' && lb<='9' )  
            lb = lb - '0';  
        else 
            return -1;  
 
        dest[j++]=(hb<<4)|(lb);  
    }
    return 0;  
}

unsigned long get_file_size(const char *path)  
{  
    unsigned long filesize = -1;  
    FILE *fp;  
    fp = fopen(path, "r");  
    if(fp == NULL)  
        return filesize;  
    fseek(fp, 0L, SEEK_END);  
    filesize = ftell(fp);  
    fclose(fp);  
    return filesize;  
}  

void get_extension(const char *file_name,char *extension)  
{  
    int i=0,length;  
    length=strlen(file_name);  
        while(file_name[i])  
    {  
        if(file_name[i]=='.')  
        break;  
        i++;  
    }  
    if(i<length)  
    strcpy(extension,file_name+i+1);  
    else  
    strcpy(extension,"\0");  
}  

void filesearch(string path,string dstPath,int layer,string codeFile)

{

    struct _finddata_t filefind;
	char  ext[20];
    string curr=path+"\\*.*";
    string dstCurr=dstPath+"\\*.*";
	char dstName[500] = { 0 };
    int done=0,i,handle;
	
	//获取code文件内容并转换为hex 
	FILE *fp; 
	char *pBuf;  
	unsigned char *pHexBuf;
	
	fp=fopen(codeFile.data(),"r"); //获取文件的指针
	fseek(fp,0,SEEK_END); //把指针移动到文件的结尾 ，获取文件长度
	int len=ftell(fp); //获取文件长度
	fseek(fp,0L,SEEK_SET);	
	//cout<<len<<endl;

	pBuf=new char[len+1]; //定义数组长度
	memset(pBuf,0,sizeof(char)*(len+1));	
	rewind(fp); //把指针移动到文件开头 因为我们一开始把指针移动到结尾，如果不移动回来 会出错
	fread(pBuf,1,len,fp); //读文件
	pBuf[len]=0; //把读到的文件最后一位 写为0 要不然系统会一直寻找到0后才结束
	cout<<pBuf<<endl;  //显示读到的数据
	fclose(fp); // 关闭文件

	int lenHex =len/2;
	pHexBuf=new unsigned char[lenHex]; //定义数组长度
	StringN2Hex(pBuf,len,pHexBuf);		//ascii转换十六进制
	cout<<lenHex<<endl;  //显示hex数据长度 
	delete []pBuf;

//循环查找目录下的文件并进行处理 
    if((handle=_findfirst(curr.c_str(),&filefind))==-1)return;

    while(!(done=_findnext(handle,&filefind)))

    {

        if(!strcmp(filefind.name,".."))continue;

        for(i=0;i<layer;i++)cout<<" ";

        if ((_A_SUBDIR==filefind.attrib))
//目录 
        {     
            cout<<filefind.name<<"(dir)"<<endl;

            curr=path+"\\"+filefind.name;
			dstCurr= dstPath+"\\"+filefind.name;
			_mkdir(dstCurr.data());

            filesearch(curr,dstCurr,layer+1,codeFile);
        }
        else
//文件 
        {
			get_extension(filefind.name,ext);
			//printf("%s",ext); 
			//if((strcmp(ext,"h") != 0) && (strcmp(ext,"m") != 0)) continue;   //只对.h 和 .m文件做处理 
			if((strcmp(ext,"png") != 0)) continue;   //只对.png 文件做处理 
			curr=path+"\\"+filefind.name;
		//对文件名base64编码，生成新文件名 
		#if 0
			//从宽字符串转换窄字符串
		    //获取转换所需的目标缓存大小
		    DWORD dBufSize=WideCharToMultiByte(CP_OEMCP, 0, (LPCWCH)filefind.name, -1, NULL,0,NULL, FALSE);
		
		    //分配目标缓存
		    char *dBuf = new char[dBufSize];
		    memset(dBuf, 0, dBufSize);
		
		    //转换
		    int nRet=WideCharToMultiByte(CP_OEMCP, 0, (LPCWCH)filefind.name, -1, dBuf, dBufSize, NULL, FALSE);
		    
		    if(nRet<=0)
		    {
		        printf("转换失败\n");
		    }
		    else
		    {
		        printf("转换成功\nAfter Convert: %s\n", dBuf);
		    }
		#endif    
			memset(dstName,0,500);
			base64_encode((const unsigned char*)filefind.name, dstName,strlen(filefind.name));	
	//		base64_decode((const char*)filefind.name, (unsigned char*)dstName);	
		//	delete []dBuf;
			
	#ifdef MD5_ONLY
			dstCurr= dstPath+"\\"+filefind.name;	
	#else
			dstCurr= dstPath+"\\"+dstName;
	#endif
			cout<<filefind.name<<endl;
			cout<<dstCurr<<endl;
			//拷贝文件到目标文件夹
		//	char cmd[500];
		//	sprintf(cmd,"cp %s %s",curr,dstCurr);
		//	system(cmd);

			//文件处理
			if((fp=fopen(curr.data(),"rb"))==NULL) 
			{ 
				printf("Cannot open file %s!",curr.data()); 
				exit(1); 
			} 
		//	Sleep(10000);
			fseek(fp,0,SEEK_END); //把指针移动到文件的结尾 ，获取文件长度
			len=ftell(fp); //获取文件长度
			fseek(fp,0L,SEEK_SET);	
			//cout<<len<<endl;
			unsigned char *pSrcBuf=new unsigned char[len+10]; //定义数组长度
			memset(pSrcBuf,0,sizeof(unsigned char)*(len+10));	
			rewind(fp); //把指针移动到文件开头 因为我们一开始把指针移动到结尾，如果不移动回来 会出错
			fread(pSrcBuf,1,len,fp); //读文件
			fclose(fp);
		//	cout<<pSrcBuf<<endl;
			//cout<<"read "<<curr<<" ok"<<endl;
			//修改IEND数据块   MD5
			int i;
			for (i=0;i<lenHex;i++)	
			{
				pSrcBuf[len-oriCodeLen+i]=pHexBuf[i];
			}
			
		#ifndef MD5_ONLY	
		// 修改PNG头  正常的PNG文件头：89	50	4e	47	0d	0a	1a	0a  ，修改为 89	55	4e	47	0d	0a	1a	0a 
			pSrcBuf[1] = 0x55; 
		#endif
		 
		//写入新文件	
			if((fp=fopen(dstCurr.data(),"wb"))==NULL) 
			{ 
				printf("Cannot open file %s!",dstCurr.data()); 
				exit(1); 
			} 
	//Sleep(5000);
			fwrite(pSrcBuf, len-oriCodeLen+lenHex, 1, fp);	//写入新的IEND 数据块
			fclose(fp);
			//cout<<"write "<<dstCurr<<" ok"<<endl;
			delete []pSrcBuf;
			total++;
	    }
		
    }   
	delete []pHexBuf;
	
    _findclose(handle);     

}

void RightLoopMove(char *pStr, unsigned short steps)  
{  
    int i = 0;  
    int len = strlen(pStr); 
    cout<<steps<<endl;
    cout<<len<<endl;
    for (i = 0; i < steps; i++)  
    {  
        char *pend = pStr + len - 1;  
        char tmp = *(pStr + len - 1);  
        while (pStr <= pend)  
        {  
            *pend = *(pend - 1);  
            pend--;  
        }  
        *pStr = tmp;  
    }  
}  

int main()

{   

    string srcPath,dstPath,codeFile,count;

    cout<<"请输入源目录名"<<endl;

    cin>>srcPath;

    cout<<"请输入目标目录名"<<endl;

    cin>>dstPath;
	
    cout<<"请输入代码文件名"<<endl;

    cin>>codeFile;

    cout<<"请输入base64移位位数，范围：0-63"<<endl;

    cin>>count;
    
    
//base64char 向右移位 count个字符 
	RightLoopMove(base64char,atoi(count.data()));
	cout<<base64char<<endl;
    filesearch(srcPath,dstPath,0,codeFile);
	cout<<"Total: "<<total<<" !"<<endl;
    system("PAUSE");

    return 0;

}

