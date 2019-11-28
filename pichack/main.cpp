#include<iostream>

#include<string>
#include<stdlib.h>
#include<io.h>
#include <direct.h>
#include <windows.h>

using namespace std;

//#define MD5_ONLY

	int total=0;
#define oriCodeLen 12		//00 00 00 00 49 45 4E 44 AE 42 60 82   PNG�ļ��Ľ�β���ݿ�  IEND

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
	
	//��ȡcode�ļ����ݲ�ת��Ϊhex 
	FILE *fp; 
	char *pBuf;  
	unsigned char *pHexBuf;
	
	fp=fopen(codeFile.data(),"r"); //��ȡ�ļ���ָ��
	fseek(fp,0,SEEK_END); //��ָ���ƶ����ļ��Ľ�β ����ȡ�ļ�����
	int len=ftell(fp); //��ȡ�ļ�����
	fseek(fp,0L,SEEK_SET);	
	//cout<<len<<endl;

	pBuf=new char[len+1]; //�������鳤��
	memset(pBuf,0,sizeof(char)*(len+1));	
	rewind(fp); //��ָ���ƶ����ļ���ͷ ��Ϊ����һ��ʼ��ָ���ƶ�����β��������ƶ����� �����
	fread(pBuf,1,len,fp); //���ļ�
	pBuf[len]=0; //�Ѷ������ļ����һλ дΪ0 Ҫ��Ȼϵͳ��һֱѰ�ҵ�0��Ž���
	cout<<pBuf<<endl;  //��ʾ����������
	fclose(fp); // �ر��ļ�

	int lenHex =len/2;
	pHexBuf=new unsigned char[lenHex]; //�������鳤��
	StringN2Hex(pBuf,len,pHexBuf);		//asciiת��ʮ������
	cout<<lenHex<<endl;  //��ʾhex���ݳ��� 
	delete []pBuf;

//ѭ������Ŀ¼�µ��ļ������д��� 
    if((handle=_findfirst(curr.c_str(),&filefind))==-1)return;

    while(!(done=_findnext(handle,&filefind)))

    {

        if(!strcmp(filefind.name,".."))continue;

        for(i=0;i<layer;i++)cout<<" ";

        if ((_A_SUBDIR==filefind.attrib))
//Ŀ¼ 
        {     
            cout<<filefind.name<<"(dir)"<<endl;

            curr=path+"\\"+filefind.name;
			dstCurr= dstPath+"\\"+filefind.name;
			_mkdir(dstCurr.data());

            filesearch(curr,dstCurr,layer+1,codeFile);
        }
        else
//�ļ� 
        {
			get_extension(filefind.name,ext);
			//printf("%s",ext); 
			//if((strcmp(ext,"h") != 0) && (strcmp(ext,"m") != 0)) continue;   //ֻ��.h �� .m�ļ������� 
			if((strcmp(ext,"png") != 0)) continue;   //ֻ��.png �ļ������� 
			curr=path+"\\"+filefind.name;
		//���ļ���base64���룬�������ļ��� 
		#if 0
			//�ӿ��ַ���ת��խ�ַ���
		    //��ȡת�������Ŀ�껺���С
		    DWORD dBufSize=WideCharToMultiByte(CP_OEMCP, 0, (LPCWCH)filefind.name, -1, NULL,0,NULL, FALSE);
		
		    //����Ŀ�껺��
		    char *dBuf = new char[dBufSize];
		    memset(dBuf, 0, dBufSize);
		
		    //ת��
		    int nRet=WideCharToMultiByte(CP_OEMCP, 0, (LPCWCH)filefind.name, -1, dBuf, dBufSize, NULL, FALSE);
		    
		    if(nRet<=0)
		    {
		        printf("ת��ʧ��\n");
		    }
		    else
		    {
		        printf("ת���ɹ�\nAfter Convert: %s\n", dBuf);
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
			//�����ļ���Ŀ���ļ���
		//	char cmd[500];
		//	sprintf(cmd,"cp %s %s",curr,dstCurr);
		//	system(cmd);

			//�ļ�����
			if((fp=fopen(curr.data(),"rb"))==NULL) 
			{ 
				printf("Cannot open file %s!",curr.data()); 
				exit(1); 
			} 
		//	Sleep(10000);
			fseek(fp,0,SEEK_END); //��ָ���ƶ����ļ��Ľ�β ����ȡ�ļ�����
			len=ftell(fp); //��ȡ�ļ�����
			fseek(fp,0L,SEEK_SET);	
			//cout<<len<<endl;
			unsigned char *pSrcBuf=new unsigned char[len+10]; //�������鳤��
			memset(pSrcBuf,0,sizeof(unsigned char)*(len+10));	
			rewind(fp); //��ָ���ƶ����ļ���ͷ ��Ϊ����һ��ʼ��ָ���ƶ�����β��������ƶ����� �����
			fread(pSrcBuf,1,len,fp); //���ļ�
			fclose(fp);
		//	cout<<pSrcBuf<<endl;
			//cout<<"read "<<curr<<" ok"<<endl;
			//�޸�IEND���ݿ�   MD5
			int i;
			for (i=0;i<lenHex;i++)	
			{
				pSrcBuf[len-oriCodeLen+i]=pHexBuf[i];
			}
			
		#ifndef MD5_ONLY	
		// �޸�PNGͷ  ������PNG�ļ�ͷ��89	50	4e	47	0d	0a	1a	0a  ���޸�Ϊ 89	55	4e	47	0d	0a	1a	0a 
			pSrcBuf[1] = 0x55; 
		#endif
		 
		//д�����ļ�	
			if((fp=fopen(dstCurr.data(),"wb"))==NULL) 
			{ 
				printf("Cannot open file %s!",dstCurr.data()); 
				exit(1); 
			} 
	//Sleep(5000);
			fwrite(pSrcBuf, len-oriCodeLen+lenHex, 1, fp);	//д���µ�IEND ���ݿ�
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

    cout<<"������ԴĿ¼��"<<endl;

    cin>>srcPath;

    cout<<"������Ŀ��Ŀ¼��"<<endl;

    cin>>dstPath;
	
    cout<<"����������ļ���"<<endl;

    cin>>codeFile;

    cout<<"������base64��λλ������Χ��0-63"<<endl;

    cin>>count;
    
    
//base64char ������λ count���ַ� 
	RightLoopMove(base64char,atoi(count.data()));
	cout<<base64char<<endl;
    filesearch(srcPath,dstPath,0,codeFile);
	cout<<"Total: "<<total<<" !"<<endl;
    system("PAUSE");

    return 0;

}

