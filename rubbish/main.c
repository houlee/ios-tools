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
	char *pBuf;  //定义文件指针
	fp=fopen(codeFile,"r"); //获取文件的指针
	fseek(fp,0,SEEK_END); //把指针移动到文件的结尾 ，获取文件长度
	int len=ftell(fp); //获取文件长度
	fseek(fp,0L,SEEK_SET);	
	//cout<<len<<endl;

	pBuf=new char[len+1]; //定义数组长度
	memset(pBuf,0,sizeof(char)*(len+1));	
	rewind(fp); //把指针移动到文件开头 因为我们一开始把指针移动到结尾，如果不移动回来 会出错
	fread(pBuf,1,len,fp); //读文件
	pBuf[len]=0; //把读到的文件最后一位 写为0 要不然系统会一直寻找到0后才结束
	//cout<<pBuf<<endl;  //显示读到的数据
	fclose(fp); // 关闭文件


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
        	//if((strcmp(ext,"h") != 0) && (strcmp(ext,"m") != 0)) continue;   //只对.h 和 .m文件做处理 
        	if((strcmp(ext,"m") != 0)) continue;   //只对.h 和 .m文件做处理 
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

    printf("请输入目录名\n");
    
    //cout<<"请输入目录名"<<endl;

    //cin>>path;
		scanf("%s",path);
		
    //cout<<"请输入代码文件名"<<endl;
    printf("请输入代码文件名\n");

    //cin>>codeFile;
    scanf("%s",codeFile);
    
    filesearch(path,0,codeFile);

    system("PAUSE");

    return 0;

}
