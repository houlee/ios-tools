//
//  HongRenBangCell.m
//  caibo
//
//  Created by houchenguang on 13-3-8.
//
//

#import "HongRenBangCell.h"
#import "caiboAppDelegate.h"
#import "NSStringExtra.h"
#import "QuartzCore/QuartzCore.h"

@implementation HongRenBangCell
@synthesize receiver;
@synthesize imageUrl;
@synthesize headnum;
@synthesize helabel;
@synthesize baimage;
@synthesize imagebool;
@synthesize headbool;
@synthesize ishemai;
@synthesize isdiyi;

- (AnnouncementData *)annou{
    return annou;
}

- (void)setAnnou:(AnnouncementData *)_annou{
    if (annou != _annou) {
        [annou release];
        annou = [_annou retain];
    }
    userName.text = _annou.user;
    moneyLabel.text = [NSString stringWithFormat:@"%@",  _annou.money ];
    CGSize moneyMSize = CGSizeMake(200, 30);
    CGSize expectedMoneySize = [moneyLabel.text sizeWithFont:moneyLabel.font constrainedToSize:moneyMSize lineBreakMode:UILineBreakModeWordWrap];
    moneyLabel.frame = CGRectMake(yuanlabel.frame.origin.x - expectedMoneySize.width-10, 35, expectedMoneySize.width, expectedMoneySize.height);

    
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
                
                    ima.frame = CGRectMake(70 + (count*23), 38, 11, 11);
                
                ima.hidden = NO;
                count++;
            }
            
        }else{
            ima.hidden = YES;
        }
        
    }
    
}


//- (UIView *)returnTableViewCell{
//
//    UIView * cellView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 54)] autorelease];
//    
//    UIImageView * cellbgimage = [[UIImageView alloc] initWithFrame:cellView.bounds];
//    cellbgimage.backgroundColor = [UIColor clearColor];
//    cellbgimage.image = [UIImageGetImageFromName(@"LBT960.png") stretchableImageWithLeftCapWidth:160 topCapHeight:6];;
//    [cellView addSubview:cellbgimage];
//    [cellbgimage release];
//    
//    return cellView;
//
//}
- (UIView *)returnTableViewCell{
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
//    view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:238.0/255.0 blue:226.0/255.0 alpha:1];
    view.backgroundColor = [UIColor colorWithRed:252.0/255.0 green:251.0/255.0 blue:243.0/255.0 alpha:1];
    UIView *cellLine = [[[UIView alloc] init] autorelease];
    cellLine.frame = CGRectMake(0, 59.5, 320, 0.5);
    cellLine.backgroundColor =[UIColor colorWithRed:224.0/255.0 green:218.0/255.0 blue:203.0/255.0 alpha:1];
    [view addSubview:cellLine];
    

    //头像
    headImage = [[DownLoadImageView alloc] initWithFrame:CGRectMake(15, 9, 42, 42)];
    headImage.layer.cornerRadius = 3;
    [headImage.layer setMasksToBounds:YES];
    headImage.backgroundColor = [UIColor grayColor];
    //    ImageStoreReceiver *tmpReceiver = [[ImageStoreReceiver alloc] init];
    //    self.receiver = tmpReceiver;
    //    receiver.imageContainer = self;
    //    [tmpReceiver release];
    
    
    //用户名
    userName = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 25)];
    userName.backgroundColor = [UIColor clearColor];
    userName.textAlignment = NSTextAlignmentLeft;
    userName.font = [UIFont systemFontOfSize:15];
    userName.textColor = [UIColor colorWithRed:3.0/255.0 green:3.0/255.0 blue:3.0/255.0 alpha:1];
 
    
//    钱数
//    moneyimage = [[UIImageView alloc] initWithFrame:CGRectMake(150, 15, 104, 24)];
//    moneyimage.image = UIImageGetImageFromName(@"red_cloud.png");
    
    
    moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(300 - 8 - 20 - 12 - 120 - 6-13, 14, 120, 24)];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.textColor =  [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.font = [UIFont boldSystemFontOfSize:15];
    //  [moneyimage addSubview:moneyLabel];
    yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 32, 20, 24)];
    yuanlabel.backgroundColor = [UIColor clearColor];
    yuanlabel.textAlignment = NSTextAlignmentLeft;
    yuanlabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
    yuanlabel.text = @"元";
    yuanlabel.font = [UIFont systemFontOfSize:15];
    //[moneyimage addSubview:yuanlabel];
    
    
    //等级图片
    level1 = [[UIImageView alloc] initWithFrame:CGRectMake(55+15, 35, 11, 11)];
    level1.backgroundColor = [UIColor clearColor];
    level1.image = UIImageGetImageFromName(@"gc_jg.png");
    
    
    level2 = [[UIImageView alloc] initWithFrame:CGRectMake(73+15, 35, 11, 11)];
    level2.backgroundColor = [UIColor clearColor];
    level2.image = UIImageGetImageFromName(@"gc_zs.png");
    
    level3 = [[UIImageView alloc] initWithFrame:CGRectMake(91+15, 35, 11, 11)];
    level3.backgroundColor = [UIColor clearColor];
    level3.image = UIImageGetImageFromName(@"gc_jx.png");
    
    level4 = [[UIImageView alloc] initWithFrame:CGRectMake(109+15, 35, 11, 11)];
    level4.backgroundColor = [UIColor clearColor];
    level4.image = UIImageGetImageFromName(@"gc_lg.png");
    
    level5 = [[UIImageView alloc] initWithFrame:CGRectMake(127+15, 35, 11, 11)];
    level5.backgroundColor = [UIColor clearColor];
    level5.image = UIImageGetImageFromName(@"gc_ls.png");
    
    level6 = [[UIImageView alloc] initWithFrame:CGRectMake(145+15, 35, 11, 11)];
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
    levLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5+4, 3, 10, 10)];
    levLabel1.textAlignment = NSTextAlignmentRight;
    levLabel1.backgroundColor = [UIColor clearColor];
    levLabel1.font = [UIFont systemFontOfSize:10];
    levLabel1.textColor = [UIColor colorWithRed:248/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    
    levLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5+4, 3, 10, 10)];
    levLabel2.textAlignment = NSTextAlignmentRight;
    levLabel2.backgroundColor = [UIColor clearColor];
    levLabel2.font = [UIFont systemFontOfSize:10];
    levLabel2.textColor = [UIColor colorWithRed:248/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    
    levLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5+4, 3, 10, 10)];
    levLabel3.textAlignment = NSTextAlignmentRight;
    levLabel3.backgroundColor = [UIColor clearColor];
    levLabel3.font = [UIFont systemFontOfSize:10];
    levLabel3.textColor = [UIColor colorWithRed:248/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    
    levLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(5+4, 3, 10, 10)];
    levLabel4.textAlignment = NSTextAlignmentRight;
    levLabel4.backgroundColor = [UIColor clearColor];
    levLabel4.font = [UIFont boldSystemFontOfSize:10];
    levLabel4.textColor = [UIColor colorWithRed:248/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    
    levLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(5+4, 3, 10, 10)];
    levLabel5.textAlignment = NSTextAlignmentRight;
    levLabel5.backgroundColor = [UIColor clearColor];
    levLabel5.font = [UIFont boldSystemFontOfSize:10];
    levLabel5.textColor = [UIColor colorWithRed:248/255.0 green:64/255.0 blue:64/255.0 alpha:1];
  
    
    levLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(5+4, 3, 10, 10)];
    levLabel6.textAlignment = NSTextAlignmentRight;
    levLabel6.backgroundColor = [UIColor clearColor];
    levLabel6.font = [UIFont boldSystemFontOfSize:10];
    levLabel6.textColor = [UIColor colorWithRed:248/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    
    
    
    
    [level1 addSubview:levLabel1];
    [level2 addSubview:levLabel2];
    [level3 addSubview:levLabel3];
    [level4 addSubview:levLabel4];
    [level5 addSubview:levLabel5];
    [level6 addSubview:levLabel6];
    
    [view addSubview:headImage];
    [view addSubview:userName];
 
    [view addSubview:moneyLabel];
    [view addSubview:yuanlabel];
    [view addSubview:level1];
    [view addSubview:level2];
    [view addSubview:level3];
    [view addSubview:level4];
    [view addSubview:level5];
    [view addSubview:level6];
    
    
    
    UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(295, 21, 8, 13)];
    jiantou.backgroundColor = [UIColor clearColor];
    jiantou.image = UIImageGetImageFromName(@"jiantou_1.png");
    [view addSubview:jiantou];
    [jiantou release];
    
    return view;
    
    
   
}

- (void)dealloc{
    [yuanlabel release];
//    [moneyimage release];
//    [helabel release];
//    [headima release];
//    [imageUrl release];
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



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:[self returnTableViewCell]];
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