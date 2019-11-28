#include<iostream>

#include<string>

#include<io.h>
using namespace std;


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

void filesearch(char* path,int layer,char* codeFile)

{

    struct _finddata_t filefind;
	char  ext[20];
    char curr[100];
    strcpy(curr,path);
    strcat(curr,"\\*.*");

    int done=0,i,handle;
	
	FILE *fp; 
	char *pBuf;  //�����ļ�ָ��
	fp=fopen(codeFile,"r"); //��ȡ�ļ���ָ��
	fseek(fp,0,SEEK_END); //��ָ���ƶ����ļ��Ľ�β ����ȡ�ļ�����
	int len=ftell(fp); //��ȡ�ļ�����
	fseek(fp,0L,SEEK_SET);	
	//cout<<len<<endl;

	pBuf=new char[len+1]; //�������鳤��
	memset(pBuf,0,sizeof(char)*(len+1));	
	rewind(fp); //��ָ���ƶ����ļ���ͷ ��Ϊ����һ��ʼ��ָ���ƶ�����β��������ƶ����� �����
	fread(pBuf,1,len,fp); //���ļ�
	pBuf[len]=0; //�Ѷ������ļ����һλ дΪ0 Ҫ��Ȼϵͳ��һֱѰ�ҵ�0��Ž���
	//cout<<pBuf<<endl;  //��ʾ����������
	fclose(fp); // �ر��ļ�


    if((handle=_findfirst(curr.c_str(),&filefind))==-1)return;

    while(!(done=_findnext(handle,&filefind)))

    {

        if(!strcmp(filefind.name,".."))continue;

        for(i=0;i<layer;i++)cout<<" ";

        if ((_A_SUBDIR==filefind.attrib))

        {     

            //cout<<filefind.name<<"(dir)"<<endl;
            printf("%s dir\n",filefind.name);

            curr=path+"\\"+filefind.name;

            filesearch(curr,layer+1,codeFile);

        }

        else

        {
        	get_extension(filefind.name,ext);
        	//printf("%s",ext); 
        	//if((strcmp(ext,"h") != 0) && (strcmp(ext,"m") != 0)) continue;   //ֻ��.h �� .m�ļ������� 
        	if((strcmp(ext,"m") != 0)) continue;   //ֻ��.h �� .m�ļ������� 
				  curr=path+"\\"+filefind.name;
				  printf("%s\n",curr);
            //cout<<curr<<endl;
			
			if((fp=fopen(curr.data(),"a"))==NULL) 
			
			{ 
			
				printf("Cannot open file %s!",curr.data()); 
				
				exit(1); 
			
			} 
//			fseek(fp, 0, SEEK_END);
//			char sz_add[] = "\nint aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;\n";
//			fwrite(sz_add, strlen(sz_add), 1, fp);
			fwrite(pBuf, len, 1, fp);
			fclose(fp);
          

        }

    }   

    _findclose(handle);     

}

int main()

{   

    char path[50],codeFile[50];

    printf("������Ŀ¼��\n");
    
    //cout<<"������Ŀ¼��"<<endl;

    //cin>>path;
		scanf("%s",path);
		
    //cout<<"����������ļ���"<<endl;
    printf("����������ļ���\n");

    //cin>>codeFile;
    scanf("%s",codeFile);
    
    filesearch(path,0,codeFile);

    system("PAUSE");

    return 0;

}
