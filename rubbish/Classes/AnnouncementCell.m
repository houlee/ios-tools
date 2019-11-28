//
//  AnnouncementCell.m
//  caibo
//
//  Created by  on 12-5-4.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "AnnouncementCell.h"
#import "caiboAppDelegate.h"
#import "NSStringExtra.h"

@implementation AnnouncementCell
@synthesize receiver;
@synthesize imageUrl;
@synthesize headnum;
@synthesize helabel;
@synthesize baimage;
@synthesize imagebool;
@synthesize headbool;
@synthesize ishemai;
@synthesize isdiyi;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self.contentView addSubview:[self returnViewCell]];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (AnnouncementData *)annou{
    return annou;
}

- (void)setAnnou:(AnnouncementData *)_annou{
    if (annou != _annou) {
        [annou release];
        annou = [_annou retain];
    }
    userName.text = _annou.user;
    moneyLabel.text = [NSString stringWithFormat:@"%d",  [_annou.money intValue]];
    levLabel1.text = _annou.level1;
    levLabel2.text = _annou.level2;
    levLabel3.text = _annou.level3;
    levLabel4.text = _annou.level4;
    levLabel5.text = _annou.level5;
    levLabel6.text = _annou.level6;

//    levLabel4.text = @"0";
//    levLabel5.text = @"0";
//    levLabel6.text = @"0";
    helabel.text = _annou.headna;
    headnum = _annou.num;
    imageUrl = _annou.imagestr;
    [headImage setImageWithURL:imageUrl];
//    headImage.image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage:imageUrl Delegate:receiver Big:YES];
    NSLog(@"num = %@", imageUrl);
    
    if (headnum == 0) {
       
            view.frame = CGRectMake(-2, 0, 290, 73);
            headImage.frame = CGRectMake(17, 33, 31, 33);//
            userName.frame = CGRectMake(55, 26, 150, 25);
            //  moneyLabel.frame = CGRectMake(140, 35, 50, 20);
            //        level1.frame = CGRectMake(55, 53, 11, 11);
            //        level2.frame = CGRectMake(76, 53, 11, 11);
            //        level3.frame = CGRectMake(97, 53, 11, 11);
            headima.frame = CGRectMake(0, 0 , 291, 30);
            baimage.frame = CGRectMake(0, 30, 291, 43);
            helabel.frame = CGRectMake(30, -2, 200, 33);
            moneyimage.frame = CGRectMake(170, 39, 104, 24);
            moneyLabel.frame = CGRectMake(140, 39, 104, 24);
            yuanlabel.frame = CGRectMake(246, 39, 20, 24);
            line.frame = CGRectMake(0, 82, 290, 1);

                
    }else{
        view.frame = CGRectMake(-2, 0, 290, 43);
        headImage.frame = CGRectMake(17, 3, 33, 33);
        userName.frame = CGRectMake(55, -4, 150, 25);
        // moneyLabel.frame = CGRectMake(140, 5, 50, 20);
//        level1.frame = CGRectMake(55, 23, 11, 11);
//        level2.frame = CGRectMake(76, 23, 11, 11);
//        level3.frame = CGRectMake(97, 23, 11, 11);
        headima.frame = CGRectMake(0, 0, 0, 0);
        baimage.frame = CGRectMake(0, 0, 291, 43);
        helabel.frame = CGRectMake(0, 0, 0, 0);
        moneyimage.frame = CGRectMake(170, 9, 104, 24);
        moneyLabel.frame = CGRectMake(140, 9, 104, 24);
        yuanlabel.frame = CGRectMake(246, 9, 20, 24);
        line.frame = CGRectMake(0, 49, 290, 1);
    }
    
    if (imagebool) {//最后一行的图片
        baimage.image = UIImageGetImageFromName(@"gc_red_down.png") ;
        baimage.frame = CGRectMake(0, 0, 291, 45);
    }else{
        baimage.image = UIImageGetImageFromName(@"gc_red_cell.png") ;
        
    }
    
    if (headbool) {//最后一行的图片
        baimage.image = UIImageGetImageFromName(@"gc_red_down.png") ;
        baimage.frame = CGRectMake(0, 0, 291, 74);
    }
    if (ishemai) {
        if (isdiyi) {
            baimage.image = UIImageGetImageFromName(@"gc_red_cell_1.png") ;
            userName.frame = CGRectMake(55, 0, 150, 25);
             headImage.frame = CGRectMake(17, 7, 33, 33);
        }
        
    }
    
    
   
    
//    if ([levLabel1.text isEqualToString:@"0"] || _annou.level1 == nil|| [_annou.level1 isEqualToString:@"null"]) {
//        level1.hidden = YES;
//        if (headnum == 0) {
//            level2.frame = CGRectMake(55, 53, 11, 11);
//            level3.frame = CGRectMake(76, 53, 11, 11);
//        }else{
//            level2.frame = CGRectMake(55, 23, 11, 11);
//            level3.frame = CGRectMake(76, 23, 11, 11);
//        }
//    }
//    if ([levLabel2.text isEqualToString:@"0"]|| _annou.level2 == nil|| [_annou.level2 isEqualToString:@"null"]) {
//        level2.hidden = YES;
//        if (headnum == 0) {
//            level1.frame = CGRectMake(55, 53, 11, 11);
//            level3.frame = CGRectMake(76, 53, 11, 11);
//        }else{
//            level1.frame = CGRectMake(55, 23, 11, 11);
//            level3.frame = CGRectMake(76, 23, 11, 11);
//        }
//    }
//    if ([levLabel3.text isEqualToString:@"0"]|| _annou.level3 == nil|| [_annou.level3 isEqualToString:@"null"]) {
//        level3.hidden = YES;
//        if (headnum == 0) {
//            level1.frame = CGRectMake(55, 53, 11, 11);
//            level2.frame = CGRectMake(76, 53, 11, 11);
//        }else{
//            level1.frame = CGRectMake(55, 23, 11, 11);
//            level2.frame = CGRectMake(76, 23, 11, 11);
//        }
//    }
//    
//    if (([levLabel1.text isEqualToString:@"0"] || _annou.level1 == nil|| [_annou.level1 isEqualToString:@"null"]) && ([levLabel3.text isEqualToString:@"0"]|| _annou.level3 == nil|| [_annou.level3 isEqualToString:@"null"])) {
//        level1.hidden = YES;
//        level3.hidden = YES;
//        if (headnum == 0) {
//            level2.frame = CGRectMake(55, 53, 11, 11);
//            
//        }else{
//            level2.frame = CGRectMake(55, 23, 11, 11);
//            
//            
//        }
//    }
//    
//    
//    if (([levLabel1.text isEqualToString:@"0"] || _annou.level1 == nil|| [_annou.level1 isEqualToString:@"null"]) && ([levLabel2.text isEqualToString:@"0"]|| _annou.level2 == nil|| [_annou.level2 isEqualToString:@"null"])) {
//        level1.hidden = YES;
//        level2.hidden = YES;
//        if (headnum == 0) {
//            level3.frame = CGRectMake(55, 53, 11, 11);
//            
//        }else{
//            level3.frame = CGRectMake(55, 23, 11, 11);
//            
//        }
//    }
//    
//    if (([levLabel2.text isEqualToString:@"0"] || _annou.level2 == nil|| [_annou.level2 isEqualToString:@"null"]) && ([levLabel3.text isEqualToString:@"0"]|| _annou.level3 == nil|| [_annou.level3 isEqualToString:@"null"])) {
//        level3.hidden = YES;
//        level2.hidden = YES;
//        if (headnum == 0) {
//            level1.frame = CGRectMake(55, 53, 11, 11);
//            
//        }else{
//            level1.frame = CGRectMake(55, 23, 11, 11);
//            
//        }
//    }
//    if (([levLabel2.text isEqualToString:@"0"] || _annou.level2 == nil|| [_annou.level2 isEqualToString:@"null"]) && ([levLabel3.text isEqualToString:@"0"]|| _annou.level3 == nil|| [_annou.level3 isEqualToString:@"null"])&&([levLabel1.text isEqualToString:@"0"] || _annou.level1 == nil|| [_annou.level1 isEqualToString:@"null"])){
//        
//        level1.hidden = YES;
//        level2.hidden = YES;
//        level3.hidden = YES;
//        if (headnum == 0) {
//            level1.frame = CGRectMake(55, 53, 11, 11);
//            level2.frame = CGRectMake(76, 53, 11, 11);
//            level3.frame = CGRectMake(97, 53, 11, 11);
//        }else{
//            level1.frame = CGRectMake(55, 23, 11, 11);
//            level2.frame = CGRectMake(76, 23, 11, 11);
//            level3.frame = CGRectMake(97, 23, 11, 11);
//        }
//    }
    
    //6个等级图标显示
        NSArray * levalarr = [NSArray arrayWithObjects:levLabel1, levLabel2, levLabel3, levLabel4, levLabel5, levLabel6, nil];
        NSArray * levaimage  = [NSArray arrayWithObjects:level1, level2, level3, level4, level5, level6, nil];
        NSInteger count = 0;
        for (int i = 0; i < 6; i++) {
            UILabel * le = [levalarr objectAtIndex:i];
            UIImageView * ima = [levaimage objectAtIndex:i];
            if ([le.text isAllNumber]) {
                if ([le.text isEqualToString:@"0"]) {
                    ima.hidden = YES;
                }else{
                    if (headnum == 0) {
                        ima.frame = CGRectMake(55 + (count*18), 53, 11, 11);
                    }else{
                        ima.frame = CGRectMake(55 + (count*18), 23, 11, 11);
                    }
                    
                    ima.hidden = NO;
                    count++;
                }

            }else{
                ima.hidden = YES;
            }
                        
        }

}


- (UIView *)returnViewCell{
    
    view = [[UIView alloc] initWithFrame:CGRectMake(-2, 0, 304, 73)];
    view.backgroundColor = [UIColor clearColor];
    
    
    
    // view.backgroundColor = [UIColor purpleColor];
    baimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 304, 73)];
    baimage.backgroundColor = [UIColor clearColor];
    baimage.image = UIImageGetImageFromName(@"gc_red_cell.png") ;
    [view addSubview:baimage];
    //[baimage release];
    //头像
    headImage = [[DownLoadImageView alloc] initWithFrame:CGRectMake(10, 35, 33, 33)];
    headImage.backgroundColor = [UIColor grayColor];
//    ImageStoreReceiver *tmpReceiver = [[ImageStoreReceiver alloc] init];
//    self.receiver = tmpReceiver;
//    receiver.imageContainer = self;
//    [tmpReceiver release];
    
    //用户名
    userName = [[UILabel alloc] initWithFrame:CGRectMake(48, 18, 70, 25)];
    userName.backgroundColor = [UIColor clearColor];
    userName.textAlignment = NSTextAlignmentLeft;
    userName.font = [UIFont systemFontOfSize:14];
    
    //钱数
    
    moneyimage = [[UIImageView alloc] initWithFrame:CGRectMake(150, 39, 104, 24)];
    moneyimage.image = UIImageGetImageFromName(@"red_cloud.png");
    
    
    moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 39, 80, 24)];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.textColor = [UIColor colorWithRed:250/255.0 green:105/255.0 blue:45/255.0 alpha:1];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.font = [UIFont systemFontOfSize:12];
    //  [moneyimage addSubview:moneyLabel];
    yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(232, 0, 20, 24)];
    yuanlabel.backgroundColor = [UIColor clearColor];
    yuanlabel.textAlignment = NSTextAlignmentLeft;
    yuanlabel.textColor = [UIColor colorWithRed:15/255.0 green:104/255.0 blue:144/255.0 alpha:1];
    yuanlabel.text = @"元";
    yuanlabel.font = [UIFont systemFontOfSize:11];
    //[moneyimage addSubview:yuanlabel];
    
    
    //等级图片
    level1 = [[UIImageView alloc] initWithFrame:CGRectMake(55, 35, 11, 11)];
    level1.backgroundColor = [UIColor clearColor];
    level1.image = UIImageGetImageFromName(@"gc_jg.png");
    
    
    level2 = [[UIImageView alloc] initWithFrame:CGRectMake(73, 35, 11, 11)];
    level2.backgroundColor = [UIColor clearColor];
    level2.image = UIImageGetImageFromName(@"gc_zs.png");
    
    level3 = [[UIImageView alloc] initWithFrame:CGRectMake(91, 35, 11, 11)];
    level3.backgroundColor = [UIColor clearColor];
    level3.image = UIImageGetImageFromName(@"gc_jx.png");
    
    level4 = [[UIImageView alloc] initWithFrame:CGRectMake(109, 35, 11, 11)];
    level4.backgroundColor = [UIColor clearColor];
    level4.image = UIImageGetImageFromName(@"gc_lg.png");
    
    level5 = [[UIImageView alloc] initWithFrame:CGRectMake(127, 35, 11, 11)];
    level5.backgroundColor = [UIColor clearColor];
    level5.image = UIImageGetImageFromName(@"gc_ls.png");
    
    level6 = [[UIImageView alloc] initWithFrame:CGRectMake(145, 35, 11, 11)];
    level6.backgroundColor = [UIColor clearColor];
    level6.image = UIImageGetImageFromName(@"gc_lx.png");
    //    CGRect frame = CGRectMake(0, 0, 11, 11);
    //    frame.size = [UIImage imageNamed:@"gc_jg.gif"].size;
    //    // 读取gif图片数据
    //    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"gc_jg" ofType:@"gif"]];
    //    // view生成
    //    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    //    webView.backgroundColor = [UIColor clearColor];
    //    webView.userInteractionEnabled = NO;//用户不可交互
    //    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    //    [level1 addSubview:webView];
    //    [webView release];
    
    
    //等级数
    levLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel1.textAlignment = NSTextAlignmentRight;
    levLabel1.backgroundColor = [UIColor clearColor];
    levLabel1.font = [UIFont systemFontOfSize:6];
    levLabel1.textColor = [UIColor colorWithRed:294/255.0 green:95/255.0 blue:0/255.0 alpha:1];
    
    levLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel2.textAlignment = NSTextAlignmentRight;
    levLabel2.backgroundColor = [UIColor clearColor];
    levLabel2.font = [UIFont systemFontOfSize:6];
    levLabel2.textColor = [UIColor colorWithRed:294/255.0 green:95/255.0 blue:0/255.0 alpha:1];
    
    levLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel3.textAlignment = NSTextAlignmentRight;
    levLabel3.backgroundColor = [UIColor clearColor];
    levLabel3.font = [UIFont systemFontOfSize:6];
    levLabel3.textColor = [UIColor colorWithRed:294/255.0 green:95/255.0 blue:0/255.0 alpha:1];
    
    levLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel4.textAlignment = NSTextAlignmentRight;
    levLabel4.backgroundColor = [UIColor clearColor];
    levLabel4.font = [UIFont boldSystemFontOfSize:6];
    levLabel4.textColor = [UIColor colorWithRed:28/255.0 green:112/255.0 blue:200/255.0 alpha:1];
    
    levLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel5.textAlignment = NSTextAlignmentRight;
    levLabel5.backgroundColor = [UIColor clearColor];
    levLabel5.font = [UIFont boldSystemFontOfSize:6];
    levLabel5.textColor = [UIColor colorWithRed:28/255.0 green:112/255.0 blue:200/255.0 alpha:1];
    //levLabel5.text = @"1";//假
    
    levLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel6.textAlignment = NSTextAlignmentRight;
    levLabel6.backgroundColor = [UIColor clearColor];
    levLabel6.font = [UIFont boldSystemFontOfSize:6];
    levLabel6.textColor = [UIColor colorWithRed:28/255.0 green:112/255.0 blue:200/255.0 alpha:1];
    
    
    
    //[view addSubview:moneyimage];
    [level1 addSubview:levLabel1];
    [level2 addSubview:levLabel2];
    [level3 addSubview:levLabel3];
    [level4 addSubview:levLabel4];
    [level5 addSubview:levLabel5];
    [level6 addSubview:levLabel6];
    
    [view addSubview:headImage];
    [view addSubview:userName];
    //  [view addSubview:moneyLabel];
    [view addSubview:moneyLabel];
    [view addSubview:yuanlabel];
    [view addSubview:level1];
    [view addSubview:level2];
    [view addSubview:level3];
    [view addSubview:level4];
    [view addSubview:level5];
    [view addSubview:level6];
    
    
    headima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 291, 30)];
    headima.image = UIImageGetImageFromName(@"red_titBg3.png");
    
    helabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, 30)];
    helabel.backgroundColor = [UIColor clearColor];
    helabel.textAlignment = NSTextAlignmentLeft;
    helabel.textColor = [UIColor whiteColor];
    helabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    helabel.shadowColor = [UIColor grayColor];
    helabel.shadowOffset = CGSizeMake(0, 1.0);
    
    [headima addSubview:helabel];
    
    [view addSubview:headima];
    
    
    line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 304, 1)];
    line.image = UIImageGetImageFromName(@"red_line2.png");
    //   [view addSubview:line];
    return view;
    
    
    //    }else{
    //        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 304, 50)];
    //        view.backgroundColor = [UIColor clearColor];
    //        // view.backgroundColor = [UIColor purpleColor];
    //        UIImageView * baimage = [[UIImageView alloc] initWithFrame:view.bounds];
    //        baimage.backgroundColor = [UIColor clearColor];
    //        baimage.image = [UIImageGetImageFromName(@"red_texBg_m.png") stretchableImageWithLeftCapWidth:60 topCapHeight:6];
    //        [view addSubview:baimage];
    //        [baimage release];
    //        //头像
    //        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    //        headImage.backgroundColor = [UIColor grayColor];
    //        ImageStoreReceiver *tmpReceiver = [[ImageStoreReceiver alloc] init];
    //        self.receiver = tmpReceiver;
    //        receiver.imageContainer = self;
    //        [tmpReceiver release];
    //        
    //        //用户名
    //        userName = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 70, 20)];
    //        userName.backgroundColor = [UIColor clearColor];
    //        userName.textAlignment = NSTextAlignmentLeft;
    //        userName.font = [UIFont systemFontOfSize:14];
    //        
    //        //钱数
    //        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 50, 20)];
    //        moneyLabel.backgroundColor = [UIColor clearColor];
    //        moneyLabel.textAlignment = NSTextAlignmentCenter;
    //        moneyLabel.font = [UIFont systemFontOfSize:11];
    //        
    //        //等级图片
    //        level1 = [[UIImageView alloc] initWithFrame:CGRectMake(205, 5, 15, 15)];
    //        level1.backgroundColor = [UIColor redColor];
    //        
    //        
    //        level2 = [[UIImageView alloc] initWithFrame:CGRectMake(225, 5, 15, 15)];
    //        level2.backgroundColor = [UIColor yellowColor];
    //        
    //        level3 = [[UIImageView alloc] initWithFrame:CGRectMake(245, 5, 15, 15)];
    //        level3.backgroundColor = [UIColor blueColor];
    //        
    //        //等级数
    //        levLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    //        levLabel1.textAlignment = NSTextAlignmentRight;
    //        levLabel1.backgroundColor = [UIColor clearColor];
    //        levLabel1.font = [UIFont systemFontOfSize:10];
    //        
    //        levLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    //        levLabel2.textAlignment = NSTextAlignmentRight;
    //        levLabel2.backgroundColor = [UIColor clearColor];
    //        levLabel2.font = [UIFont systemFontOfSize:10];
    //        
    //        levLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    //        levLabel3.textAlignment = NSTextAlignmentRight;
    //        levLabel3.backgroundColor = [UIColor clearColor];
    //        levLabel3.font = [UIFont systemFontOfSize:10];
    //        
    //        
    //        [level1 addSubview:levLabel1];
    //        [level2 addSubview:levLabel2];
    //        [level3 addSubview:levLabel3];
    //        
    //        [view addSubview:headImage];
    //        [view addSubview:userName];
    //        [view addSubview:moneyLabel];
    //        [view addSubview:level1];
    //        [view addSubview:level2];
    //        [view addSubview:level3];
    //        
    //        return view;
    //
    //        }
}

- (void)dealloc{
    [yuanlabel release];
    [moneyimage release];
    [helabel release];
    [baimage release];
    [headima release];
    [imageUrl release];
    [levLabel1 release];
    [levLabel2 release];
    [levLabel3 release];
    [levLabel4 release];
    [levLabel5 release];
    [levLabel6 release];
    [view release];
    [userName release];
    [moneyLabel release];
    [level1 release];
    [level2 release];
    [level3 release];
    [level4 release];
    [level5 release];
    [level6 release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    