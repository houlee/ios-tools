//
//  RankingListTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-3-13.
//
//

#import "RankingListTableViewCell.h"
#import "caiboAppDelegate.h"
#import "NSStringExtra.h"
#import "QuartzCore/QuartzCore.h"

@implementation RankingListTableViewCell
@synthesize receiver;
@synthesize imageUrl;
@synthesize helabel;
@synthesize baimage;
@synthesize imagebool;
@synthesize headbool;
@synthesize ishemai;
@synthesize isdiyi, indexPathCell;

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
    levLabel1.text = _annou.level1;
    levLabel2.text = _annou.level2;
    levLabel3.text = _annou.level3;
    levLabel4.text = _annou.level4;
    levLabel5.text = _annou.level5;
    levLabel6.text = _annou.level6;
    
//    levLabel1.text = @"1";
//    levLabel2.text = @"2";
//    levLabel3.text = @"3";
//    levLabel4.text = @"4";
//    levLabel5.text = @"5";
//    levLabel6.text = @"6";

    
    helabel.text = _annou.headna;
    imageUrl = _annou.imagestr;
    [headImage setImageWithURL:imageUrl];
    NSLog(@"num = %@", imageUrl);
    wanfaLabel.text = _annou.lotteryname;
    gradeLabel.text = [NSString stringWithFormat:@"%d", (int)indexPathCell.row+1];
    if (indexPathCell.row < 3) {
        gradeLabel.frame = CGRectMake(0, 0, 24, 18);
        NSString * imageStr = [NSString stringWithFormat:@"gradeImage%d.png", (int)indexPathCell.row+1];
        gradeImage.image = UIImageGetImageFromName(imageStr);
        gradeImage.frame = CGRectMake((48.5 - 24) / 2, (60 - 24)/2, 24, 24);
    }else{
        gradeLabel.frame = CGRectMake(0, 0, 18.5, 18.5);
        gradeImage.image = UIImageGetImageFromName(@"gradeImage4.png");
        gradeImage.frame = CGRectMake((48.5 - 18.5) / 2, (60 - 18.5)/2, 18.5, 18.5);
    }
    
    
    //6个等级图标显示
    NSArray * levalarr = [NSArray arrayWithObjects:levLabel1, levLabel2, levLabel3, levLabel4, levLabel5, levLabel6, nil];
    NSArray * levaimage  = [NSArray arrayWithObjects:level1, level2, level3, level4, level5, level6, nil];
    
    NSInteger levCount = 0;
    for (int i = 0; i < [levalarr count]; i++) {
         UILabel * le = [levalarr objectAtIndex:i];
        if ([le.text isAllNumber]) {
            if (![le.text isEqualToString:@"0"]) {
                levCount += 1;
            }
        }
    }
    
    NSInteger count = 0;
    for (int i = 0; i < 6; i++) {
        UILabel * le = [levalarr objectAtIndex:i];
        UIImageView * ima = [levaimage objectAtIndex:i];
        if ([le.text isAllNumber]) {
            if ([le.text isEqualToString:@"0"]) {
                ima.hidden = YES;
            }else{
                if (levCount > 3) {
                    if (count < 3) {
                        ima.frame = CGRectMake(101.5 + (count*23), 28, 11, 11);
                    }else{
                        ima.frame = CGRectMake(101.5 + ((count - 3)*23), 39, 11, 11);
                    }
                }else{
                    ima.frame = CGRectMake(101.5 + (count*23), 39, 11, 11);
                }
                
                
                
                ima.hidden = NO;
                count++;
            }
            
        }else{
            ima.hidden = YES;
        }
        
    }
    
}

- (UIView *)returnTableViewCell{
    
    view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60.5)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    
    
    
    // view.backgroundColor = [UIColor purpleColor];
    baimage = [[UIImageView alloc] initWithFrame:view.bounds];
    baimage.backgroundColor = [UIColor whiteColor];
    [view addSubview:baimage];
    //[baimage release];
    
    gradeImage = [[UIImageView alloc] initWithFrame:CGRectMake((48.5 - 18.5) / 2, (60 - 18.5)/2, 18.5, 18.5)];
    gradeImage.backgroundColor = [UIColor clearColor];
//    gradeImage.image = UIImageGetImageFromName(@"gradeImage4.png");
    [view addSubview:gradeImage];
    [gradeImage release];
    
    gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18.5, 18.5)];
    gradeLabel.backgroundColor = [UIColor clearColor];
    gradeLabel.font = [UIFont systemFontOfSize:10];
    gradeLabel.textColor = [UIColor whiteColor];
    gradeLabel.textAlignment = NSTextAlignmentCenter;
//    gradeLabel.text = @"5";
    [gradeImage addSubview:gradeLabel];
    [gradeLabel release];
    
    
    
    //头像
    headImage = [[DownLoadImageView alloc] initWithFrame:CGRectMake(48.5, (60 - 42)/2, 42, 42)];
    headImage.layer.cornerRadius = 3;
    [headImage.layer setMasksToBounds:YES];
    headImage.backgroundColor = [UIColor grayColor];

    
    //用户名
    userName = [[UILabel alloc] initWithFrame:CGRectMake(90.5+11, 3, 110, 25)];
    userName.backgroundColor = [UIColor clearColor];
    userName.textAlignment = NSTextAlignmentLeft;
    userName.font = [UIFont boldSystemFontOfSize:12];
    
    
    wanfaLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.5+11 + 110, 3, 80, 25)];
    wanfaLabel.backgroundColor = [UIColor clearColor];
    wanfaLabel.textAlignment = NSTextAlignmentRight;
    wanfaLabel.font = [UIFont systemFontOfSize:12];
    
    //钱数
    
    moneyimage = [[UIImageView alloc] initWithFrame:CGRectMake(150, 15, 104, 24)];
    moneyimage.image = UIImageGetImageFromName(@"red_cloud.png");
    
    
    moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(320 - 8 - 14  - 120 - 20 - 6, 28, 120, 24)];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.textColor =  [UIColor colorWithRed:248/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.font = [UIFont boldSystemFontOfSize:15];
    //  [moneyimage addSubview:moneyLabel];
    yuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(320 - 8 - 20 -14, 29, 20, 24)];
    yuanlabel.backgroundColor = [UIColor clearColor];
    yuanlabel.textAlignment = NSTextAlignmentLeft;
    yuanlabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    yuanlabel.text = @"元";
    yuanlabel.font = [UIFont systemFontOfSize:11];
    //[moneyimage addSubview:yuanlabel];
    
    
    //等级图片
    level1 = [[UIImageView alloc] initWithFrame:CGRectMake(90.5+11, 37, 11, 11)];
    level1.backgroundColor = [UIColor clearColor];
    level1.image = UIImageGetImageFromName(@"gc_jg.png");
    
    
    level2 = [[UIImageView alloc] initWithFrame:CGRectMake(108.5+11, 37, 11, 11)];
    level2.backgroundColor = [UIColor clearColor];
    level2.image = UIImageGetImageFromName(@"gc_zs.png");
    
    level3 = [[UIImageView alloc] initWithFrame:CGRectMake(127.5+11, 37, 11, 11)];
    level3.backgroundColor = [UIColor clearColor];
    level3.image = UIImageGetImageFromName(@"gc_jx.png");
    
    level4 = [[UIImageView alloc] initWithFrame:CGRectMake(145.5+11, 37, 11, 11)];
    level4.backgroundColor = [UIColor clearColor];
    level4.image = UIImageGetImageFromName(@"gc_lg.png");
    
    level5 = [[UIImageView alloc] initWithFrame:CGRectMake(163.5+11, 37, 11, 11)];
    level5.backgroundColor = [UIColor clearColor];
    level5.image = UIImageGetImageFromName(@"gc_ls.png");
    
    level6 = [[UIImageView alloc] initWithFrame:CGRectMake(181.5+11, 37, 11, 11)];
    level6.backgroundColor = [UIColor clearColor];
    level6.image = UIImageGetImageFromName(@"gc_lx.png");
    
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
    [view addSubview:wanfaLabel];
    [wanfaLabel release];
    [view addSubview:moneyLabel];
    [view addSubview:yuanlabel];
    [view addSubview:level1];
    [view addSubview:level2];
    [view addSubview:level3];
    [view addSubview:level4];
    [view addSubview:level5];
    [view addSubview:level6];
    
    
    
    UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(320 - 8-14, 20, 8, 13)];
    jiantou.backgroundColor = [UIColor clearColor];
    jiantou.image = UIImageGetImageFromName(@"JTD960.png");
    [view addSubview:jiantou];
    [jiantou release];
    
    
//    userName.text = @"asdfsadfwef";
//    moneyLabel.text = @"234234234";
//    levLabel1.text = @"1";
//    levLabel2.text = @"2";
//    levLabel3.text = @"3";
//    levLabel4.text = @"4";
//    levLabel5.text = @"5";
//    levLabel6.text = @"6";
//    helabel.text = @"7";
//    wanfaLabel.text = @"竞彩胜平负";
    
    UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 0.5)];
    lineImage.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [view addSubview:lineImage];
    [lineImage release];
    
    
    return view;
    
    
    
}

- (void)dealloc{
    [indexPathCell release];
    [yuanlabel release];
    [moneyimage release];
    //    [helabel release];
    [baimage release];
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
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
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