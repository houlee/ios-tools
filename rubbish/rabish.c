#include <stdio.h>
#include <dirent.h>
void main(int argc, char * argv[])
{
    char ch,infile[50],outfile[50];
    struct dirent *ptr;    
     DIR *dir;
    dir=opendir("./one");
    while((ptr=readdir(dir))!=NULL)
    {
 
    //跳过'.'和'..'两个目录
        if(ptr->d_name[0] == '.')
            continue;
        printf("%s is ready...\n",ptr->d_name);
        sprintf(infile,"./one/%s",ptr->d_name);
     
     printf("<%s>\n",infile); 
    }
    closedir(dir);
}
