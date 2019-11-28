//
//  calculateCell.m
//  caibo
//
//  Created by houchenguang on 12-11-5.
//
//

#import "calculateCell.h"
#import "caiboAppDelegate.h"

@implementation calculateCell
@synthesize textqihao;
@synthesize delegate;
@synthesize issuestr;
@synthesize beishustr;
@synthesize yuanlabel;
@synthesize row;
@synthesize haolabel;
@synthesize  labelqihao;
@synthesize issuearr;
@synthesize qianshu;
@synthesize zhuijiaBOOL;
@synthesize imageViewkey;

- (void)setButtonBool:(BOOL)_buttonBool{
    buttonBool = _buttonBool;
    
    if (buttonBool) {
        textqihao.textColor = [UIColor lightGrayColor];
    }else{
        
        textqihao.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    }
    
}

- (BOOL)buttonBool{
    return buttonBool;
}


//- (void)setRow:(NSInteger)_row{
//    row = _row;
//    if (row < 9) {
//         haolabel.text = [NSString stringWithFormat:@"0%d", row+1];
//    }else{
//         haolabel.text = [NSString stringWithFormat:@"%d.", row+1];
//    }
//    yuanlabel.text = [NSString stringWithFormat:@"%d", [textqihao.text intValue]*2];
//}
//
//- (NSInteger)row{
//
//    return row;
//}

- (void)presspickview:(UIButton *)sender{
    if (row == 0) {
        return;
    }
    if ([issuearr count] >= 21) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        NSString  * str15 = [issuearr objectAtIndex:14];
        NSString  * str16 = [issuearr objectAtIndex:15];
        NSString  * str17 = [issuearr objectAtIndex:16];
        NSString  * str18 = [issuearr objectAtIndex:17];
        NSString  * str19 = [issuearr objectAtIndex:18];
        NSString  * str20 = [issuearr objectAtIndex:19];
        NSString  * str21 = [issuearr objectAtIndex:20];
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, str18, str19 , str20,str21, nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, str18, str19 , str20,str21,nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
#endif
        
        
        
    }else if ([issuearr count] == 20) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        NSString  * str15 = [issuearr objectAtIndex:14];
        NSString  * str16 = [issuearr objectAtIndex:15];
        NSString  * str17 = [issuearr objectAtIndex:16];
        NSString  * str18 = [issuearr objectAtIndex:17];
        NSString  * str19 = [issuearr objectAtIndex:18];
        NSString  * str20 = [issuearr objectAtIndex:19];
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, str18, str19 , str20, nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, str18, str19 , str20,nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
    }else if ([issuearr count] == 19) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        NSString  * str15 = [issuearr objectAtIndex:14];
        NSString  * str16 = [issuearr objectAtIndex:15];
        NSString  * str17 = [issuearr objectAtIndex:16];
        NSString  * str18 = [issuearr objectAtIndex:17];
        NSString  * str19 = [issuearr objectAtIndex:18];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, str18, str19 , nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, str18, str19 ,nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
        
    }else if ([issuearr count] == 17) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        NSString  * str15 = [issuearr objectAtIndex:14];
        NSString  * str16 = [issuearr objectAtIndex:15];
        NSString  * str17 = [issuearr objectAtIndex:16];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
        
    }else if ([issuearr count] == 18) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        NSString  * str15 = [issuearr objectAtIndex:14];
        NSString  * str16 = [issuearr objectAtIndex:15];
        NSString  * str17 = [issuearr objectAtIndex:16];
        NSString  * str18 = [issuearr objectAtIndex:17];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, str18, nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, str18,nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
        
        
        
    }else if ([issuearr count] == 16) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        NSString  * str15 = [issuearr objectAtIndex:14];
        NSString  * str16 = [issuearr objectAtIndex:15];
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
        
        
    }else if ([issuearr count] == 15) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        NSString  * str15 = [issuearr objectAtIndex:14];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
        
        
    }else if ([issuearr count] == 14) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14,  nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14,  nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
        
        
        
    }else if ([issuearr count] == 13) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13,  nil]];
        [lb show];
        [lb release];
#else
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
        
        
    }else if ([issuearr count] == 17) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
        
#endif
        
        
        
    }else if ([issuearr count] == 11) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11,  nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
#endif
        
        
        
        
    }else if ([issuearr count] == 10) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, nil];
        [actionSheet showInView:self];
        [actionSheet release];
#endif
        
        
        
        
        
    }else if ([issuearr count] == 17) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        NSString  * str9 = [issuearr objectAtIndex:8];
        NSString  * str10 = [issuearr objectAtIndex:9];
        
        NSString  * str11 = [issuearr objectAtIndex:10];
        NSString  * str12 = [issuearr objectAtIndex:11];
        NSString  * str13 = [issuearr objectAtIndex:12];
        NSString  * str14 = [issuearr objectAtIndex:13];
        NSString  * str15 = [issuearr objectAtIndex:14];
        NSString  * str16 = [issuearr objectAtIndex:15];
        NSString  * str17 = [issuearr objectAtIndex:16];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8, str9 , str10, str11, str12, str13, str14, str15, str16, str17, nil];
        [actionSheet showInView:self];
        [actionSheet release];
#endif
        
        
        
        
    }else if ([issuearr count] == 8) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        NSString  * str8 = [issuearr objectAtIndex:7];
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6, str7, str8,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6, str7, str8,nil];
        [actionSheet showInView:self];
        [actionSheet release];
#endif
        
        
    }else if ([issuearr count] == 7) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        NSString  * str7 = [issuearr objectAtIndex:6];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6,  str7,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6,  str7, nil];
        [actionSheet showInView:self];
        [actionSheet release];
#endif
        
        
        
    }else if ([issuearr count] == 6) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        NSString  * str6 = [issuearr objectAtIndex:5];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5, str6,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, str5, str6,nil];
        [actionSheet showInView:self];
        [actionSheet release];
#endif
        
        
        
    }else if ([issuearr count] == 5) {
        
        
        
        
        
        
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        NSString  * str5 = [issuearr objectAtIndex:4];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4, str5,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4,str5,nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
#endif
        
        
        
        
    }else if ([issuearr count] == 4) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        NSString  * str4 = [issuearr objectAtIndex:3];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3, str4,  nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, str4, nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
#endif
        
        
        
    }else if ([issuearr count] == 3) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        NSString  * str3 = [issuearr objectAtIndex:2];
        
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, str3,   nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, str3, nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
#endif
        
        
    }else if ([issuearr count] == 2) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        NSString  * str2 = [issuearr objectAtIndex:1];
        
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, str2, nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1, str2, nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
#endif
        
        
        
    }   else if ([issuearr count] == 1) {
        NSString  * str1 = [issuearr objectAtIndex:0];
        
#ifdef isCaiPiaoForIPad
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 101;
        [lb LoadButtonName:[NSArray arrayWithObjects: str1, nil]];
        [lb show];
        [lb release];
#else
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: str1,  nil];
        [actionSheet showInView:self];
        [actionSheet release];
        
#endif
        
        
    }
    
}

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:0]];
        if ([issuearr count] == 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
        
    }else if (buttonIndex == 1){
        
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:1]];
        if ([issuearr count] == 2) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 2){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:2]];
        if ([issuearr count] == 3) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 3){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:3]];
        if ([issuearr count] == 4) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 4){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:4]];
        if ([issuearr count] == 5) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 5){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:5]];
        if ([issuearr count] == 6) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 6){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:6]];
        if ([issuearr count] == 7) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 7){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:7]];
        if ([issuearr count] == 8) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 8){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:8]];
        if ([issuearr count] == 9) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 9){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:9]];
        if ([issuearr count] >= 10) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 10) {
        
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:10]];
        if ([issuearr count] == 11) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
        
    }else if (buttonIndex == 11){
        
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:11]];
        if ([issuearr count] == 12) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 12){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:12]];
        if ([issuearr count] == 13) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 13){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:13]];
        if ([issuearr count] == 14) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 14){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:14]];
        if ([issuearr count] == 15) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 15){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:15]];
        if ([issuearr count] == 16) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 16){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:16]];
        if ([issuearr count] == 17) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 17){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:17]];
        if ([issuearr count] == 18) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 18){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:18]];
        if ([issuearr count] == 19) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 19){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:19]];
        if ([issuearr count] == 20) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 20){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:20]];
        if ([issuearr count] >= 21) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }
    
    
    NSString  * qistr = [labelqihao.text substringToIndex:[labelqihao.text length]-1];
    [self returnRow:row beishu:textqihao.text qihao:qistr];
    
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:0]];
        if ([issuearr count] == 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
        
    }else if (buttonIndex == 1){
        
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:1]];
        if ([issuearr count] == 2) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 2){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:2]];
        if ([issuearr count] == 3) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 3){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:3]];
        if ([issuearr count] == 4) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 4){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:4]];
        if ([issuearr count] == 5) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 5){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:5]];
        if ([issuearr count] == 6) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 6){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:6]];
        if ([issuearr count] == 7) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 7){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:7]];
        if ([issuearr count] == 8) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 8){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:8]];
        if ([issuearr count] == 9) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 9){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:9]];
        if ([issuearr count] >= 10) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 10) {
        
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:10]];
        if ([issuearr count] == 11) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
        
    }else if (buttonIndex == 11){
        
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:11]];
        if ([issuearr count] == 12) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 12){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:12]];
        if ([issuearr count] == 13) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 13){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:13]];
        if ([issuearr count] == 14) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 14){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:14]];
        if ([issuearr count] == 15) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 15){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:15]];
        if ([issuearr count] == 16) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 16){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:16]];
        if ([issuearr count] == 17) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 17){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:17]];
        if ([issuearr count] == 18) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 18){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:18]];
        if ([issuearr count] == 19) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 19){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:19]];
        if ([issuearr count] == 20) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }else if (buttonIndex == 20){
        labelqihao.text =  [NSString stringWithFormat:@"%@期", [issuearr objectAtIndex:20]];
        if ([issuearr count] >= 21) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
        }
    }
    
    
    NSString  * qistr = [labelqihao.text substringToIndex:[labelqihao.text length]-1];
    [self returnRow:row beishu:textqihao.text qihao:qistr];
    
    
}


- (UIView *)tableViewCellRetrun{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    
    
    
    
    UIImageView * cellbgimage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,50)] autorelease];
    cellbgimage.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];

    //cellbgimage.backgroundColor = [UIColor clearColor];
    //cellbgimage.image = [UIImageGetImageFromName(@"zhuihaocellimage.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    cellbgimage.userInteractionEnabled = YES;
    
    
    
    
    haolabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 43)];
    haolabel.backgroundColor = [UIColor clearColor];
    haolabel.text = @"01.";
    haolabel.font = [UIFont systemFontOfSize:14];
    haolabel.textAlignment = NSTextAlignmentCenter;
    haolabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [cellbgimage addSubview:haolabel];
    [haolabel release];
    
    //    UIImageView * qihaobg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 1, 68, 31)];
    //    qihaobg.backgroundColor = [UIColor clearColor];
    //    qihaobg.image = UIImageGetImageFromName(@"AXBG960.png");
    //    [cellbgimage addSubview:qihaobg];
    
    //    UIButton * qihaobg = [UIButton buttonWithType:UIButtonTypeCustom];
    //    qihaobg.backgroundColor = [UIColor clearColor];
    //    qihaobg.frame = CGRectMake(30, 1, 68, 31);
    //    [qihaobg setImage:UIImageGetImageFromName(@"AXBG960.png") forState:UIControlStateNormal];
    //    [qihaobg addTarget:self action:@selector(presspickview:) forControlEvents:UIControlEventTouchUpInside];
    //    [cellbgimage addSubview:qihaobg];
    
    
    labelqihao = [[UILabel alloc] initWithFrame:CGRectMake(27+5, 0, 78+3, 43)];
    labelqihao.backgroundColor = [UIColor clearColor];
    labelqihao.text = @"";
    labelqihao.font = [UIFont systemFontOfSize:14];
    labelqihao.textAlignment = NSTextAlignmentLeft;
    labelqihao.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [cellbgimage addSubview:labelqihao];
    [labelqihao release];
    
    
    
    UIImageView * textimage = [[UIImageView alloc] initWithFrame:CGRectMake(109, 7, 55, 30)];
    textimage.backgroundColor = [UIColor clearColor];
    textimage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
    textimage.userInteractionEnabled = YES;
    [cellbgimage addSubview:textimage];
    [textimage release];
    
    
    
    textqihao = [[UITextField alloc] initWithFrame:CGRectMake(7-4, 6, 35+8, 20)];
    textqihao.textAlignment = NSTextAlignmentCenter;
    textqihao.keyboardType = UIKeyboardTypeNumberPad;
    textqihao.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    textqihao.delegate = self;
    textqihao.text = @"1";
    textqihao.font = [UIFont systemFontOfSize:14];
    textqihao.backgroundColor = [UIColor clearColor];
    [textimage addSubview:textqihao];
    
    UIButton * zhuiQiButton = [[UIButton alloc] initWithFrame:textimage.bounds];
    [textimage addSubview:zhuiQiButton];
    [zhuiQiButton addTarget:self action:@selector(pressBetTouButton:) forControlEvents:UIControlEventTouchUpInside];
    [zhuiQiButton release];
    
    UILabel * beila = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 27, 43)];
    beila.backgroundColor = [UIColor clearColor];
    beila.text = @"倍";
    beila.font = [UIFont systemFontOfSize:14];
    beila.textAlignment = NSTextAlignmentCenter;
    beila.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [cellbgimage addSubview:beila];
    [beila release];
    
    
    UIImageView *jiaJianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(185, 7, 60, 30)];
    jiaJianImageView.image = [UIImage imageNamed:@"zhuiqi.png"];
    jiaJianImageView.userInteractionEnabled = YES;
    [cellbgimage addSubview:jiaJianImageView];
    [jiaJianImageView release];
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(175, 0, 40, 44);
//    addButton.backgroundColor = [UIColor redColor];
    //    [addButton setImage:[UIImage imageNamed:@"jiahao-anxia.png"] forState:UIControlStateSelected];
    [addButton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *jiaImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(17, 14, 16, 16)] autorelease];
    jiaImageView.image = [UIImageGetImageFromName(@"jiahao-zhengchang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
//    jiaImageView.userInteractionEnabled = YES;
    [addButton addSubview:jiaImageView];
    [cellbgimage addSubview:addButton];
    UIButton *jianButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jianButton.frame = CGRectMake(215, 0, 40, 44);
//    jianButton.backgroundColor = [UIColor yellowColor];
    //    [addButton setImage:[UIImage imageNamed:@"jiahao-anxia.png"] forState:UIControlStateSelected];
    [jianButton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *jianImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(7, 14, 16, 16)] autorelease];
    jianImageView.image = [UIImageGetImageFromName(@"jianhao-zhengchang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
//    jiaImageView.userInteractionEnabled = YES;
    [jianButton addSubview:jianImageView];
    [cellbgimage addSubview:jianButton];
//    [jiaJianImageView addSubview:jianButton];
    
//    UIButton * addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    addbutton.frame = CGRectMake(166, 7, 29, 29);
//    [addbutton setImage:UIImageGetImageFromName(@"zhuihaojiajian.png") forState:UIControlStateNormal];
//    [addbutton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel * jiala = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 29, 29)];
//    jiala.backgroundColor = [UIColor clearColor];
//    jiala.text = @"+";
//    jiala.textAlignment = NSTextAlignmentCenter;
//    jiala.textColor = [UIColor whiteColor];
//    jiala.font = [UIFont systemFontOfSize:15];
//    [addbutton addSubview:jiala];
//    [jiala release];
//    
//    UIButton * jianbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    jianbutton.frame = CGRectMake(199, 7, 29, 29);
//    [jianbutton setImage:UIImageGetImageFromName(@"zhuihaojiajian.png") forState:UIControlStateNormal];
//    [jianbutton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel * jianla = [[UILabel alloc] initWithFrame:CGRectMake(0, -2, 29, 29)];
//    jianla.backgroundColor = [UIColor clearColor];
//    jianla.text = @"-";
//    jianla.textAlignment = NSTextAlignmentCenter;
//    jianla.textColor = [UIColor whiteColor];
//    jianla.font = [UIFont systemFontOfSize:15];
//    [jianbutton addSubview:jianla];
//    [jianla release];
//    
//    [cellbgimage addSubview:addbutton];
//    [cellbgimage addSubview:jianbutton];
    
  
    
    NSString *str =[NSString stringWithFormat:@"%@",yuanlabel.text];
    CGSize numText = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(192, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(285-numText.width, 7, 38, 29)];
    yuanlabel.backgroundColor = [UIColor clearColor];
    if (zhuijiaBOOL) {
        yuanlabel.text = @"3";
    }else{
        yuanlabel.text = @"2";
    }
    
    
    
    yuanlabel.textAlignment = NSTextAlignmentCenter;
    yuanlabel.textColor = [UIColor redColor];
    yuanlabel.font = [UIFont systemFontOfSize:12];
    [cellbgimage addSubview:yuanlabel];
    [yuanlabel release];
    
    UILabel * yuanzilab = [[UILabel alloc] initWithFrame:CGRectMake(285, 7, 24, 29)];
    yuanzilab.backgroundColor = [UIColor clearColor];
    yuanzilab.text = @"元";
    yuanzilab.textAlignment = NSTextAlignmentCenter;
    yuanzilab.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    yuanzilab.font = [UIFont systemFontOfSize:14];
    [cellbgimage addSubview:yuanzilab];
    [yuanzilab release];
    
    UIImageView * allView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] autorelease];
    allView.backgroundColor = [UIColor clearColor];
    allView.userInteractionEnabled = YES;
    [allView addSubview:cellbgimage];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cellbgimage addSubview:lineView];
    [lineView release];
    
    [cellbgimage insertSubview:addButton atIndex:10000];
    [cellbgimage insertSubview:jianButton atIndex:10001];
    
    return allView;
    
}

- (void)openKeyboard{
    if ([delegate respondsToSelector:@selector(openCellKeyboard:)]) {
        [delegate openCellKeyboard:self];
    }
}

- (void)returnTextField:(NSString *)fieldText row:(NSInteger)rowte{
    
    if ([delegate respondsToSelector:@selector(returnTextField:row:)]) {
        
        [delegate returnTextField:fieldText row:rowte];
    }
    
}

- (void)updateData{
    if ([textqihao.text intValue] <= 1) {
        textqihao.text = @"1";
    }
    if([textqihao.text intValue] >= 10000){
        textqihao.text = @"10000";
    }
    // ***textqihao.text
    [self returnTextField:textqihao.text row:row];
    
}

- (void)pressaddbutton:(UIButton *)sender{
    if ([textqihao.text intValue] >= 10000) {
        textqihao.text = @"10000";
        
    }else{
        NSString * str = [NSString stringWithFormat:@"%d", (int)[textqihao.text intValue]+1 ];
        textqihao.text = str;
    }
    if (zhuijiaBOOL) {
        yuanlabel.text = [NSString stringWithFormat:@"%d", (int)[textqihao.text intValue]*3*(int)qianshu];
        NSString *str =[NSString stringWithFormat:@"%@",yuanlabel.text];
        CGSize numText = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(192, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
        yuanlabel.frame = CGRectMake(285-numText.width,7 , 38, 29);
    }else{
        yuanlabel.text = [NSString stringWithFormat:@"%d", (int)[textqihao.text intValue]*2*(int)qianshu];
    }
    
    
    //   NSString  * qistr = [labelqihao.text substringToIndex:[labelqihao.text length]-1];
    [self returnRow:row beishu:textqihao.text qihao:nil];
    
}

- (void)pressjianbutton:(UIButton *)sender{
    if ([textqihao.text intValue] <= 1) {
        textqihao.text = @"1";
    }else{
        
        NSString * str = [NSString stringWithFormat:@"%d",[textqihao.text intValue] - 1];
        textqihao.text = str;
    }
    if (zhuijiaBOOL) {
        yuanlabel.text = [NSString stringWithFormat:@"%d", (int)[textqihao.text intValue]*3*(int)qianshu];
    }else{
        yuanlabel.text = [NSString stringWithFormat:@"%d", (int)[textqihao.text intValue]*2*(int)qianshu];
    }
    
    // yuanlabel.text = [NSString stringWithFormat:@"%d", [textqihao.text intValue]*2];
    // NSString  * qistr = [labelqihao.text substringToIndex:[labelqihao.text length]-1];
    [self returnRow:row beishu:textqihao.text qihao:nil];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [textqihao resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self performSelector:@selector(updateData) withObject:nil afterDelay:1];
    return YES;
}
- (void)keyboardWillShow:(NSNotification *)note
{
    
    // create custom button

#ifdef isCaiPiaoForIPad
#else
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    //    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
    //    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    doneButton.backgroundColor = [UIColor clearColor];
    
    UILabel * quedingla = [[UILabel alloc] initWithFrame:doneButton.bounds];
    quedingla.backgroundColor = [UIColor clearColor];
    quedingla.text = @"确定";
    quedingla.textAlignment = NSTextAlignmentCenter;
    quedingla.textColor = [UIColor blackColor];
    quedingla.font = [UIFont systemFontOfSize:15];
    [doneButton addSubview:quedingla];
    [quedingla release];
#endif
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        //if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)// OS 3.0
        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) ||(([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES))){
            if ([textqihao isFirstResponder]) {
#ifdef isCaiPiaoForIPad
#else
                [keyboard addSubview:doneButton];
#endif
            }
        }
        
        return;
    }
    
    
}

#pragma mark 点击done事件
- (void)doneButton:(id)sender {
    
    // ***textqihao.text
    [self returnTextField:textqihao.text row:row];
    [self returnjianpan:YES];
   
//    changeBeiShu = YES;
}

- (void)pressBetTouButton:(UIButton *)sender{
    BOOL yesorno = NO;
    if (buttonBool == NO) {
//        buttonBool = YES;
        yesorno = YES;
        textqihao.textColor = [UIColor lightGrayColor];
    }else{
//        buttonBool = NO;
        yesorno = NO;
        textqihao.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    }
    if (delegate && [delegate respondsToSelector:@selector(returnButtonSelectBool:row:)]) {
        [delegate returnButtonSelectBool:yesorno row:row];
    }
    
    [self doneButton2:nil];
}

- (void)doneButton2:(id)sender {
    
    // ***textqihao.text
    [self returnTextField:textqihao.text row:row];
    [self returnjianpan:YES];
    [self openKeyboard];
//    changeBeiShu = YES;
}

- (void)returnjianpan:(BOOL)yesorno{
    if ([delegate respondsToSelector:@selector(returnjianpan:)]) {
        [delegate returnjianpan:yesorno];
    }
    
}

- (void)returnRow:(NSInteger)rerow beishu:(NSString *)beishus qihao:(NSString *)issue{
    
    if ([delegate respondsToSelector:@selector(returnRow:beishu:qihao:)]) {
        [delegate returnRow:rerow beishu:beishus qihao:issue];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //    if (textField == baifenTextField) {
    //        baifenTextField.tag = 1;
    //    }else{
    //        baifenTextField.tag = 0;
    //    }
    if ([textqihao isFirstResponder]) {
        [self returnjianpanjiaodian:YES];
    }
    
}
- (void)returnjianpanjiaodian:(BOOL)yesorno{
    
    if ([delegate respondsToSelector:@selector(returnjianpanjiaodian:)]) {
        [delegate returnjianpanjiaodian:yesorno];
    }
}

- (void)dealloc{
    [issuearr release];
    [textqihao release];
    [beishustr release];
    [imageViewkey release];
    [super dealloc];
}

- (UIImageView *)tableViewCellKeyboard
{
    imageViewkey = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    imageViewkey.backgroundColor = [UIColor darkGrayColor];
    imageViewkey.userInteractionEnabled = YES;
    //imageViewkey.image = UIImageGetImageFromName(@"ZHBBG960.png");
    [imageViewkey.layer setMasksToBounds:YES];
    
    CGFloat widthFloat = 320. / 3;
    CGFloat sizehight = (54*4)/4.0;
    self.backgroundColor = [UIColor whiteColor];
    NSInteger tagcount = 1;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            
            float xf = widthFloat*j;
            
            UIButton * numButton = [UIButton buttonWithType:UIButtonTypeCustom];
            numButton.frame = CGRectMake(xf, sizehight*i, widthFloat, sizehight);//CGRectMake(xf, 0.5+54*i+0.5*i, widthFloat, 54);
            //                [numButton setBackgroundImage:nil forState:UIControlStateNormal];
            numButton.tag = tagcount;
            
            [imageViewkey addSubview:numButton];
            numButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            numButton.titleLabel.font = [UIFont systemFontOfSize:24];
            
            
            if (tagcount == 10) {
                numButton.tag = 11;
                //                   numButton.titleLabel.textColor = [UIColor blackColor];
                [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhuqueding.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhuqueding_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
                [numButton setTitle:@"确定" forState:UIControlStateNormal];
                [numButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [numButton addTarget:self action:@selector(doneButton2:) forControlEvents:UIControlEventTouchUpInside];
                
            }else if (tagcount == 11) {
                numButton.tag = 0;
                [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukey.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukey_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
                [numButton setTitle:@"0" forState:UIControlStateNormal];
                [numButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [numButton addTarget:self action:@selector(jianPanClicke:) forControlEvents:UIControlEventTouchUpInside];
            }else if (tagcount == 12) {
                UIImageView * deleteImage = [[UIImageView alloc] initWithFrame:CGRectMake((widthFloat - 24)/2, (sizehight - 16)/2, 24, 16)];
                deleteImage.backgroundColor = [UIColor clearColor];
                deleteImage.image = UIImageGetImageFromName(@"deleteimagekey.png");
                [numButton addSubview:deleteImage];
                [deleteImage release];
                numButton.tag = 10;
                [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhudelete.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhudelete_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
                [numButton setTitle:@"" forState:UIControlStateNormal];
                [numButton addTarget:self action:@selector(jianPanClicke:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                //                   numButton.titleLabel.textColor = [UIColor blackColor];
                [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukey.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
                [numButton setBackgroundImage:[UIImageGetImageFromName(@"touzhukey_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
                [numButton setTitle:[NSString stringWithFormat:@"%ld", (long)tagcount] forState:UIControlStateNormal];
                [numButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [numButton addTarget:self action:@selector(jianPanClicke:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            tagcount += 1;
        }
        
    }


  
    
    return imageViewkey;
}

- (void)jianPanClicke:(UIButton *)sender {
//    changeBeiShu = NO;
    
    if (sender.tag == 10) {
        textqihao.text = [NSString stringWithFormat:@"%d",[textqihao.text intValue]/10];
        if ([textqihao.text isEqualToString:@"0"]||[textqihao.text isEqualToString:@""]) {
            textqihao.text = @"";
        }
    }else if(sender.tag == 11){
        [self openKeyboard];
        
    }else{
        
        if (textqihao.textColor == [ UIColor lightGrayColor]) {
            textqihao.text = [NSString stringWithFormat:@"%ld", (long)sender.tag];
        }
        else {
            textqihao.text = [NSString stringWithFormat:@"%d",(int)[textqihao.text intValue] * 10 + (int)sender.tag];
        }

//        if ([textqihao.text isEqualToString:@"1"]) {
//            if (sender.tag < 2) {
//                textqihao.text = [textqihao.text stringByAppendingString:[NSString stringWithFormat:@"%d",sender.tag]];
//            }else{
//                textqihao.text = [NSString stringWithFormat:@"%d",sender.tag];
//            }
//        }else{
//            textqihao.text = [textqihao.text stringByAppendingString:[NSString stringWithFormat:@"%d",sender.tag]];
//        }
        
    }
    
    if ([textqihao.text intValue] < 1) {
        textqihao.text = @"1";
    }
    if([textqihao.text intValue] > 10000){
        textqihao.text = @"10000";
    }
    
    
    [self returnTextField:textqihao.text row:row];
    // ***textqihao.text
//    if (changeBeiShu == YES) {
        [self returnTextField:textqihao.text row:row];
        lastBeiShu = textqihao.text;

//    }else{
//        if (![lastBeiShu isEqual:@"1"]) {
//            [self returnTextField:lastBeiShu row:row];
//
//        }else{
//        
//            [self returnTextField:@"1" row:row];
//        }
//    
//   }
 
    textqihao.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    buttonBool = NO;
    if (delegate && [delegate respondsToSelector:@selector(returnButtonSelectBool:row:)]) {
        [delegate returnButtonSelectBool:buttonBool row:row];
    }
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        lastBeiShu = @"1";
        // Initialization code
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:[self tableViewCellKeyboard]];
        [self.contentView addSubview:[self tableViewCellRetrun]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    