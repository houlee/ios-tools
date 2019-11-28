//
//  KuaiSanTuiJianViewCotroller.m
//  CPgaopin
//
//  Created by yaofuyu on 13-11-20.
//
//

#import "KuaiSanTuiJianViewCotroller.h"
#import "Info.h"
#import "GC_BetInfo.h"
#import "GouCaiShuZiInfoViewController.h"
#import "GC_LotteryUtil.h"
#import "IssueObtain.h"
#import "caiboAppDelegate.h"
#import "NetURL.h"
#import "JSON.h"
#import "MobClick.h"

#define KEYBOARD_HEIGHT 113
#define YUCHULABEL_FRAME CGRectMake(yuchuLabel.frame.origin.x, yuchuLabel.frame.origin.y, 82, yuchuLabel.frame.size.height)

#define YUCHULABEL_FRAME_SHORT CGRectMake(yuchuLabel.frame.origin.x, yuchuLabel.frame.origin.y, 60, yuchuLabel.frame.size.height)


@interface KuaiSanTuiJianViewCotroller ()

@end

@implementation KuaiSanTuiJianViewCotroller
@synthesize viewType;
@synthesize infoViewController;
@synthesize dataDic;
@synthesize myBentInfo;
@synthesize ahttpRequest;
@synthesize yilouRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithLotteryID:(NSString *)lotteryID
{
    self = [super init];
    if (self) {
        issuearr = [[NSMutableArray alloc] init];
        myLotteryID = lotteryID;
    }
    return self;
}

- (void)doBack {
    self.myBentInfo.betlist = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setHeadView {
    UIView *tableHeaderView = [[[UIView alloc] init] autorelease];
    tableHeaderView.frame = CGRectMake(0, 0, 320, 15);
    tableHeaderView.backgroundColor = mytableView.backgroundColor;
    mytableView.tableHeaderView = tableHeaderView;
}

- (void)setFootView {
    UIView *footView = [[UIView alloc] init];
    if (viewType == KuaiSanTuiJianTypeHeZhi) {
        footView.frame = CGRectMake(0, 0, 320, 115);
    }
    else {
        footView.frame = CGRectMake(0, 0, 320, 65);
    }
//    UIImageView *foot1 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 0, 302, 7)];
//    foot1.image =[UIImageGetImageFromName(@"dikuang12.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0];
//    [footView addSubview:foot1];
//    [foot1 release];
    
    numView = [[UIImageView alloc] init];
    numView.frame = CGRectMake(0, 10, 320, footView.frame.size.height - 10);
//    numView.image = [UIImageGetImageFromName(@"dikuang1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    numView.backgroundColor = [UIColor clearColor];
    numView.userInteractionEnabled = YES;
    [footView addSubview:numView];
    mytableView.tableFooterView = footView;
    
    UIView * lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, numView.frame.size.width, 0.5)] autorelease];
    lineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [numView addSubview:lineView];
    
    if (viewType == KuaiSanTuiJianTypeHeZhi) {
        NSArray *arrnumber =[self.dataDic objectForKey:@"k3ArrAndValuesArrNumber"];
        for (int i = 0; i < 16; i ++) {
            int a = i/8,b = i%8;
            NSString *num = nil;
//            if (i < 14) {
                num = [NSString stringWithFormat:@"%d",i + 3];
//            }
//            else {
//                num = @"-";
//            }
            GCBallView *ball = [[GCBallView alloc] initWithFrame:CGRectMake(15 + b * 37, 13 + a * 59.5, 30, 30) Num:num ColorType:GCBallViewColorTuiJian];
            ball.gcballDelegate = self;
//            if (i >=14) {
//                ball.enabled = NO;
//            }
//            else {
                if (i < [arrnumber count]) {
                    ball.ylLable.text = [NSString stringWithFormat:@"%@",[arrnumber objectAtIndex:i]];
                }
//            }
            ball.isBlack = YES;
            [numView addSubview:ball];
            [ball release];
            
        }
    }
    else {
            NSArray *arrnumber =[self.dataDic objectForKey:@"arrNumber"];
            for (int i = 0; i < 8; i ++) {
                int a = i/8,b = i%8;
                NSString *num = nil;
                if (i < 6) {
                    num = [NSString stringWithFormat:@"%d",i + 1];
                }
                else {
                    num = @"-";
                }
                GCBallView *ball = [[GCBallView alloc] initWithFrame:CGRectMake(15 + b * 32, 13 + a * 59.5, 30, 30) Num:num ColorType:GCBallViewColorTuiJian];
                ball.isBlack = YES;
                if (i >=6) {
                    ball.enabled = NO;
                    ball.numLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
                }
                else {
                    if (i < [arrnumber count]) {
                        ball.ylLable.text = [NSString stringWithFormat:@"%@",[arrnumber objectAtIndex:i]];
                    }
                }
                ball.gcballDelegate = self;
                [numView addSubview:ball];
                [ball release];
                
            }
    }
    
    [numView release];
    [footView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.CP_navigation.title = self.title;
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    
//    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bgimageview.image = UIImageGetImageFromName(@"login_bgn.png");
//    bgimageview.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
//    bgimageview.backgroundColor = [UIColor grayColor];
//    [self.mainView addSubview:bgimageview];
//    [bgimageview release];
    
    UIScrollView * bgScrollView = [[[UIScrollView alloc] initWithFrame:self.mainView.bounds] autorelease];
    bgScrollView.bounces = NO;
    [self.mainView addSubview:bgScrollView];
    
    mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [bgScrollView addSubview:mytableView];
    mytableView.backgroundColor =[UIColor colorWithRed:245/255.0 green:244/255.0 blue:239/255.0 alpha:1];
    mytableView.scrollEnabled = NO;
    [mytableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [mytableView release];

    footBackImage = [[UIImageView alloc] init];
    [bgScrollView addSubview:footBackImage];
    footBackImage.userInteractionEnabled = YES;
    footBackImage.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
//    footBackImage.image = [UIImageGetImageFromName(@"dikuang9.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    infoBackImage = [[CPZhanKaiView alloc] init];
    [footBackImage addSubview:infoBackImage];
    infoBackImage.canZhanKaiByTouch = NO;
    infoBackImage.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
//    imageView2.image = UIImageGetImageFromName(@"ZHBBG960.png");
    imageView2.backgroundColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    imageView2.frame = CGRectMake(0, 55, 320, KEYBOARD_HEIGHT);
    [infoBackImage addSubview:imageView2];
    imageView2.userInteractionEnabled = YES;
    [imageView2 release];
    
//    UIImageView *imageView1 = [[UIImageView alloc] init];
//    imageView1.image = [UIImageGetImageFromName(@"dikuang3.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    imageView1.backgroundColor = [UIColor yellowColor];
//    imageView1.frame = CGRectMake(10, 10, 280, 55);
//    imageView1.tag = 101;
//    imageView1.userInteractionEnabled = YES;
//    [infoBackImage addSubview:imageView1];
//    [imageView1 release];
    
    zhuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuiBtn.frame = CGRectMake(15, 16, 174, 30);
    zhuiBtn.backgroundColor = [UIColor clearColor];
    [infoBackImage addSubview:zhuiBtn];
    [zhuiBtn addTarget:self action:@selector(rengouSelcte) forControlEvents:UIControlEventTouchUpInside];
    [zhuiBtn setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [zhuiBtn setBackgroundImage:[UIImageGetImageFromName(@"YuSheButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
    [zhuiBtn setTitle:@"追号期数                   期" forState:UIControlStateNormal];
    zhuiBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [zhuiBtn setTitleColor:[UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1] forState:UIControlStateNormal];
    
//	UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 170, 17)];
//	label4.backgroundColor = [UIColor purpleColor];
//	label4.textColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
//    label4.font = [UIFont systemFontOfSize:11];
//	label4.text = @"追号期数                   期";
//	[imageView1 addSubview:label4];
//	[label4 release];
    
    zhuiTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 5, 70, 17)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        zhuiTextField.frame = CGRectMake(75, 7, 70, 17);
    }
	zhuiTextField.textAlignment = NSTextAlignmentRight;
    zhuiTextField.text = @"20";
    zhuiTextField.enabled = NO;
    zhuiTextField.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    zhuiTextField.font = [UIFont systemFontOfSize:15];
    zhuiTextField.backgroundColor = [UIColor clearColor];
    [zhuiTextField setReturnKeyType:UIReturnKeyDone];
    [zhuiTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [zhuiBtn addSubview:zhuiTextField];
	[zhuiTextField release];
    
    
    addbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    addbutton.frame = CGRectMake(ORIGIN_X(zhuiBtn) + 21.5, zhuiBtn.frame.origin.y, 44, zhuiBtn.frame.size.height);
    [addbutton loadButonImage:@"zhuihaojia_normal.png" LabelName:nil];
    [addbutton setHightImage:UIImageGetImageFromName(@"zhuihaojia_selected.png")];    addbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    addbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [addbutton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
    [infoBackImage addSubview:addbutton];
    
    jianbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    jianbutton.frame = CGRectMake(ORIGIN_X(addbutton) + 0.5, addbutton.frame.origin.y, addbutton.frame.size.width, addbutton.frame.size.height);
    [jianbutton loadButonImage:@"zhuihaojian_normal.png" LabelName:nil];
    [jianbutton setHightImage:UIImageGetImageFromName(@"zhuihaojian_selected.png")];    jianbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    jianbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [jianbutton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
    [infoBackImage addSubview:jianbutton];
    
    infoBackImage.frame = CGRectMake(0, 0, 320, 55);
    infoBackImage.normalHeight = 55;
    infoBackImage.zhankaiHeight = 165;
    [infoBackImage release];

    UIView * lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, numView.frame.size.width, 0.5)] autorelease];
    lineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [infoBackImage addSubview:lineView];
    
    for (int i = 0; i < 12; i ++) {
        CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        [imageView2 addSubview:btn];
        int a = i/7;
        int b = i%7;
        btn.frame = CGRectMake(20 + b * 40+a*25, 15 + a *45, 35, 36);
        [btn loadButonImage:@"anjian.png" LabelName:[NSString stringWithFormat:@"%d",i]];
        if (i == 10) {
            btn.buttonName.text = nil;
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 24, 14)];
            [btn addSubview:imageV];
            imageV.image = UIImageGetImageFromName(@"ZHBANX960.png");
            [imageV release];
        }
        
        else if (i == 11) {
//            btn.buttonName.text = @"完成";
            btn.frame = CGRectMake(20 + b * 40+a*25, 15 + a *45, 65, 36);
            [btn loadButonImage:@"tongyongxuanzhong.png" LabelName:[NSString stringWithFormat:@"完成"]];
        }
        
        btn.tag = i;
        [btn addTarget:self action:@selector(jianPanClicke:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    infoBackImaeg2 = [[UIImageView alloc] init];
    [footBackImage addSubview:infoBackImaeg2];
//    infoBackImaeg2.image = [UIImageGetImageFromName(@"dikuang8.png") stretchableImageWithLeftCapWidth:6 topCapHeight:1];
    infoBackImaeg2.backgroundColor = [UIColor clearColor];
    infoBackImaeg2.userInteractionEnabled = YES;
    
    UILabel * touRu = [[[UILabel alloc] init] autorelease];
    touRu.text = @"投入";
    touRu.textColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1];
    touRu.backgroundColor = [UIColor clearColor];
    [infoBackImaeg2 addSubview:touRu];
    touRu.font = [UIFont systemFontOfSize:15];
    CGSize touRuSize = [touRu.text sizeWithFont:touRu.font constrainedToSize:CGSizeMake(INT_MAX,INT_MAX)];
    touRu.frame = CGRectMake(12.5, 8.5, touRuSize.width, touRuSize.height);
    
    touruLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(touRu) + 5, touRu.frame.origin.y, 90, touRu.frame.size.height)];
    touruLabel.font = touRu.font;
    touruLabel.textColor = [UIColor redColor];
    touruLabel.backgroundColor = [UIColor clearColor];
    [infoBackImaeg2 addSubview:touruLabel];
    touruLabel.textAlignment = 2;
    
    UILabel * yuanLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(touruLabel) + 6, touruLabel.frame.origin.y, 15, touruLabel.frame.size.height)] autorelease];
    yuanLabel.backgroundColor = [UIColor clearColor];
    yuanLabel.textColor = touRu.textColor;
    yuanLabel.font = touRu.font;
    [infoBackImaeg2 addSubview:yuanLabel];
    yuanLabel.text = @"元";

    UILabel * danZhu = [[[UILabel alloc] init] autorelease];
    danZhu.text = @"单注奖金";
    danZhu.textColor = touRu.textColor;
    danZhu.backgroundColor = [UIColor clearColor];
    [infoBackImaeg2 addSubview:danZhu];
    danZhu.font = touRu.font;
    CGSize danZhuSize = [danZhu.text sizeWithFont:danZhu.font constrainedToSize:CGSizeMake(INT_MAX,INT_MAX)];
    danZhu.frame = CGRectMake(touRu.frame.origin.x, ORIGIN_Y(touRu) + 4, danZhuSize.width, danZhuSize.height);

    danZhuLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(danZhu) + 5, danZhu.frame.origin.y, 60, danZhu.frame.size.height)];
    danZhuLabel.font = touRu.font;
    danZhuLabel.textColor = [UIColor redColor];
    danZhuLabel.backgroundColor = [UIColor clearColor];
    [infoBackImaeg2 addSubview:danZhuLabel];
    danZhuLabel.textAlignment = 2;
    
    UILabel * yuanLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(danZhuLabel) + 6, danZhuLabel.frame.origin.y, 15, danZhuLabel.frame.size.height)] autorelease];
    yuanLabel1.backgroundColor = [UIColor clearColor];
    yuanLabel1.textColor = touRu.textColor;
    yuanLabel1.font = touRu.font;
    [infoBackImaeg2 addSubview:yuanLabel1];
    yuanLabel1.text = @"元";
    
    UILabel * yuChu = [[[UILabel alloc] init] autorelease];
    yuChu.text = @"欲出几率";
    yuChu.textColor = touRu.textColor;
    yuChu.backgroundColor = [UIColor clearColor];
    [infoBackImaeg2 addSubview:yuChu];
    yuChu.font = touRu.font;
    CGSize yuChuSize = [yuChu.text sizeWithFont:yuChu.font constrainedToSize:CGSizeMake(INT_MAX,INT_MAX)];
    yuChu.frame = CGRectMake(touRu.frame.origin.x, ORIGIN_Y(danZhu) + 4, yuChuSize.width, yuChuSize.height);

    yuchuLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(yuChu) + 5, yuChu.frame.origin.y, 82, yuChu.frame.size.height)];
    yuchuLabel.font = touRu.font;
    yuchuLabel.textColor = [UIColor blueColor];
    yuchuLabel.backgroundColor = [UIColor clearColor];
    [infoBackImaeg2 addSubview:yuchuLabel];
    yuchuLabel.textAlignment = 2;

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(touRu.frame.origin.x, ORIGIN_Y(yuChu) + 7, 270, 17)];
	label1.backgroundColor = [UIColor clearColor];
	label1.textColor = [UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1.0];
    label1.font = [UIFont systemFontOfSize:11];
	label1.text = @"欲出几率: 当前遗漏/平均遗漏（有可能>100%）";
	[infoBackImaeg2 addSubview:label1];
	[label1 release];
    
    zhuiInfoBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    zhuiInfoBtn.frame = CGRectMake(ORIGIN_X(yuanLabel1) + 38, yuanLabel1.frame.origin.y + 3, 103.5, 30);
    [infoBackImaeg2 addSubview:zhuiInfoBtn];
    [zhuiInfoBtn loadButonImage:nil LabelName:@"追号详情"];
    zhuiInfoBtn.buttonName.frame = CGRectMake(0, 0, zhuiInfoBtn.frame.size.width, 30);
    [zhuiInfoBtn addTarget:self action:@selector(goZhuiHao) forControlEvents:UIControlEventTouchUpInside];
    [zhuiInfoBtn setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    
    infoBackImaeg2.frame = CGRectMake(0, ORIGIN_Y(infoBackImage), 320, ORIGIN_Y(label1) + 10);
    footBackImage.frame = CGRectMake(0, ORIGIN_Y(mytableView), 320, ORIGIN_Y(infoBackImaeg2));
    
    UIImageView * im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height - 44, 320, 44)];
	[self.mainView addSubview:im];
    im.userInteractionEnabled = YES;
    im.backgroundColor = [UIColor colorWithRed:20/255.0 green:19/255.0 blue:19/255.0 alpha:1];
//	im.image = UIImageGetImageFromName(@"XDH960.png");
    
    if (!(IS_IPHONE_5)) {
        bgScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(footBackImage) + im.frame.size.height);
    }
    
    sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.frame = CGRectMake(120, 8, 80, 30);
	sendBtn.backgroundColor = [UIColor clearColor];
    [sendBtn setTitleColor:[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor colorWithRed:63/255.0 green:59/255.0 blue:47/255.0 alpha:1] forState:UIControlStateDisabled];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [sendBtn setTitle:@"投注" forState:UIControlStateNormal];
	[im addSubview:sendBtn];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    [self.yilouRequest clearDelegatesAndCancel];
    if ([myLotteryID isEqualToString:@"012"]) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL klsfLouTuLottery:@"k3" item:@"1" category:@""]];
    }
    else if ([myLotteryID isEqualToString:@"013"]) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL klsfLouTuLottery:@"jsk3" item:@"1" category:@""]];
    }
    else if ([myLotteryID isEqualToString:@"019"]) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetYL:@"hbk3" Item:@"1"]];
    }
    [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yilouRequest setDelegate:self];
    [yilouRequest setDidFinishSelector:@selector(reqYilouFinished:)];
    [yilouRequest startAsynchronous];
}

- (void)reqYilouFinished:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
	NSLog(@"~%@~",responseStr);
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        NSArray * array = [responseStr JSONValue];
        if ([array count] >= 1) {
            self.dataDic = [array objectAtIndex:0];
            
            [self setHeadView];
            [self setFootView];
            [self ballSelectChange:nil];
            [self qingqiuZhuiHaoQici];
            [mytableView reloadData];
        }
    }
}

- (void)getBettingInfo {
    NSString *tou = @"01#";
    NSInteger bets = [GC_LotteryUtil getBets:[self selectNum] LotteryType:myBentInfo.lotteryType ModeType:myBentInfo.modeType];
    if (bets > 1) {
        tou =@"02#";
    }
    myBentInfo.bets = (int)bets;
    myBentInfo.betNumber = [NSString stringWithFormat:@"%@%@",tou,[self selectNum]];
    myBentInfo.price = (int)bets *2;
    if ([myBentInfo.betlist count] > 1 ) {
        
    }
    else {
        myBentInfo.betlist = [NSMutableArray array];
        if ([issuearr count] ==0) {
            if (myBentInfo.issue) {
                [issuearr addObject:myBentInfo.issue];
            }
            
        }
        for (int i = 0; i < [zhuiTextField.text integerValue]+ 1; i++) {
            
            if ([issuearr count] > i) {
                NSString * mul = [NSString stringWithFormat:@"%@:%d", [issuearr objectAtIndex:i], 1];
                [myBentInfo.betlist addObject:mul];
            }
            
            
        }

    }

}

- (NSString *)selectNum {
    NSMutableString *mStr = [[[NSMutableString alloc] init] autorelease];
    NSString *st = @",";
    if (viewType == KuaiSanTuiJianTypeHeZhi) {
        NSMutableString *num = [NSMutableString string];
        for (GCBallView *ball in numView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if (ball.selected && ![ball.numLabel.text isEqualToString:@"-"]) {
                    if ([ball.numLabel.text intValue] < 10) {
                        [num appendString:[NSString stringWithFormat:@"0%@",ball.numLabel.text]];
                    }
                    else {
                        [num appendString:ball.numLabel.text];
                    }
                    
                    [num appendString:st];
                }
            }
        }
        if ([num length] > 0) {
            [num deleteCharactersInRange:NSMakeRange([num length]-1, 1)];
            [mStr appendString:num];
        }
        else {
            [mStr appendString:@"e"];
        }
        
    }
    else if (viewType == KuaiSanTuiJianTypeErBuTong || viewType == KuaiSanTuiJianTypeSanBuTong) {
        NSMutableString *num = [NSMutableString string];
        for (GCBallView *ball in numView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if (ball.selected && ![ball.numLabel.text isEqualToString:@"-"]) {
                    [num appendString:ball.numLabel.text];
                    [num appendString:st];
                }
            }
        }
        if ([num length] > 0) {
            [num deleteCharactersInRange:NSMakeRange([num length]-1, 1)];
            [mStr appendString:num];
        }
        else {
            [mStr appendString:@"e"];
        }
    }

    return mStr;
}

- (void)send {
    [self getBettingInfo];
    [MobClick event:@"event_goucai_yushetouzhu_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
    [infoViewController.dataArray removeAllObjects];
    
    [infoViewController.dataArray addObject:myBentInfo.betNumber];
    [infoViewController returnBetInfoData:self.myBentInfo];
    [self.navigationController pushViewController:infoViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [infoViewController release];
    [issuearr release];
    [self.ahttpRequest clearDelegatesAndCancel];
    self.ahttpRequest = nil;
    self.dataDic = nil;
    self.myBentInfo = nil;
    
    [touruLabel release];
    [danZhuLabel release];
    [yuchuLabel release];
    [infoBackImaeg2 release];
    [footBackImage release];
    [myLotteryID release];

    [self.yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark GCBallViewDelegate

- (void)ballSelectChange:(UIButton *)imageView {
    NSString *selctNum = [self selectNum];
        NSInteger bets = [GC_LotteryUtil getBets:selctNum LotteryType:myBentInfo.lotteryType ModeType:myBentInfo.modeType];
    if (bets == 1) {
        zhuiInfoBtn.enabled = YES;
        sendBtn.enabled = YES;
        footBackImage.userInteractionEnabled = YES;
    }
    else if (bets == 0){
        touruLabel.text = @"-";
        danZhuLabel.text = @"-";
//        yuchuLabel.text = @"-     ";
        yuchuLabel.text = @"-";
        yuchuLabel.frame = YUCHULABEL_FRAME_SHORT;
        zhuiInfoBtn.enabled = NO;
        sendBtn.enabled = NO;

        footBackImage.userInteractionEnabled = NO;
    }
    else {
        footBackImage.userInteractionEnabled = YES;
        yuchuLabel.text = @"-";
        yuchuLabel.frame = YUCHULABEL_FRAME_SHORT;

        zhuiInfoBtn.enabled = YES;
        sendBtn.enabled = YES;
    }
    [self upUI];
}

#pragma mark -
#pragma mark CPTuiJianCellDelegate

- (void)BtnClick:(GCBallView *)btn WithCell:(UITableViewCell *)cell {
    NSIndexPath *indext = [mytableView indexPathForCell:cell];
    if (viewType == KuaiSanTuiJianTypeHeZhi) {
        if (indext.row == 0) {
            for (GCBallView *ball in numView.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]){
                    if ([ball.numLabel.text isEqualToString:btn.numLabel.text]) {
                        ball.selected = YES;
                    }
                    else {
                        ball.selected = NO;
                    }
                    
                }
            }
        }
        else if (indext.row == 1) {
            for (GCBallView *ball in numView.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]) {
                    if ([ball.numLabel.text intValue]%10 == [btn.numLabel.text intValue]) {
                        ball.selected = YES;
                    }
                    else {
                        ball.selected = NO;
                    }
                    
                }
            }
        }
        else if (indext.row == 2) {
            NSInteger a = 0,b = 0;
            if ([[btn.numLabel.text componentsSeparatedByString:@"-"] count] >= 2) {
                a = [[[btn.numLabel.text componentsSeparatedByString:@"-"] objectAtIndex:0] intValue];
                b = [[[btn.numLabel.text componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
                
            }
            for (GCBallView *ball in numView.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]) {
                    if ([ball.numLabel.text intValue] >= a && [ball.numLabel.text intValue] <= b) {
                        ball.selected = YES;
                    }
                    else {
                        ball.selected = NO;
                    }
                }
            }
        }
    }
    else if (viewType == KuaiSanTuiJianTypeSanBuTong) {
        for (GCBallView *ball in numView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]){
                if ([btn.numLabel.text rangeOfString:ball.numLabel.text].location != NSNotFound) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
                
            }
        }
    }
    else if (viewType == KuaiSanTuiJianTypeErBuTong) {
        for (GCBallView *ball in numView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]){
                if ([btn.numLabel.text rangeOfString:ball.numLabel.text].location != NSNotFound) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
                
            }
        }
        
    }
    [self ballSelectChange:nil];
}

#pragma mark Action



- (NSString *)getHeZhiJiangjinBy:(NSString *)Num {
    if ([Num length] == 0 ||[Num rangeOfString:@"e"].location != NSNotFound) {
        return @"-";
    }
    NSString *qujian = @"-";
    NSArray *jianjinArray =[NSArray arrayWithObjects:@"240",@"80",@"40",@"25",@"16",@"12",@"10",@"9",@"9",@"10",@"12",@"16",@"25",@"40",@"80",@"240", nil];
    NSArray *numArray = [Num componentsSeparatedByString:@","];
    int a = 0,b = 0;
    
    for (int i = 0; i <[numArray count]; i ++) {
        if ([[numArray objectAtIndex:i] intValue]  < [jianjinArray count] + 3) {
            int c = [[jianjinArray objectAtIndex:[[numArray objectAtIndex:i] intValue] - 3] intValue];
            if (a > c || a == 0) {
                a = c;
            }
            if (b < c || b == 0) {
                b = c;
            }
        }
        
    }
    if (a && b) {
        if (a == b) {
            qujian = [NSString stringWithFormat:@"%d",a];
        }
        else {
            qujian = [NSString stringWithFormat:@"%d-%d",a,b];
        }
        
    }
    
    return qujian;
}


- (void)upUI {
    NSString *selectNum =[self selectNum];
    myBentInfo.bets = (int)[GC_LotteryUtil getBets:selectNum LotteryType:myBentInfo.lotteryType ModeType:myBentInfo.modeType];
    NSInteger zongzhu = 0;
    yuchuLabel.text = @"-";
    yuchuLabel.frame = YUCHULABEL_FRAME_SHORT;

    if (myBentInfo.bets == 0) {
        touruLabel.text = @"-";
        danZhuLabel.text = @"-";
    }
    else if (myBentInfo.bets >= 1) {
        if ([myBentInfo.betlist count]) {
            for (int i = 0; i < [myBentInfo.betlist count]; i++) {
                NSString * zhushustr = [myBentInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if ([zhuarr count] > 1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu * myBentInfo.bets;
                }
               
            }
        }
        else {
            zongzhu = myBentInfo.bets * ([zhuiTextField.text intValue] + 1);
        }
        
        
        NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * 2];
        myBentInfo.payMoney = [jinestr2 intValue];
        if (viewType == KuaiSanTuiJianTypeHeZhi) {
            touruLabel.text = [NSString stringWithFormat:@"%d",myBentInfo.payMoney];
            danZhuLabel.text = [self getHeZhiJiangjinBy:selectNum];
        }
        else if (viewType == KuaiSanTuiJianTypeErBuTong) {
            touruLabel.text = [NSString stringWithFormat:@"%d",myBentInfo.payMoney];
            danZhuLabel.text = @"8";
        }
        else if (viewType == KuaiSanTuiJianTypeSanBuTong) {
            touruLabel.text = [NSString stringWithFormat:@"%d",myBentInfo.payMoney];
            danZhuLabel.text = @"40";
        }
        if (myBentInfo.bets > 1) {
        }
        else {
            if (viewType == KuaiSanTuiJianTypeHeZhi) {
                NSString *num = selectNum;
                NSArray *arrnumber =[self.dataDic objectForKey:@"k3ArrAndValuesArrNumber"];
                NSString *yilou = @"0";
                float pingjunyilou = 1;
                NSArray *array = [NSArray arrayWithObjects:@"216",@"72",@"36",@"21.6",@"14.4",@"10.2",@"8.64",@"8.0",@"8.0",@"8.64",@"10.2",@"14.4",@"21.6",@"36",@"72",@"216",nil];

                if (3 <=[num intValue] && [num intValue] <= 18) {
                    pingjunyilou = [[array objectAtIndex:[num intValue] -3] floatValue];
                    if ([num intValue]-3 < [arrnumber count]) {
                        yilou = [NSString stringWithFormat:@"%@",[arrnumber objectAtIndex:[num intValue] - 3]];
                    }
                    
                }
                if (pingjunyilou != 1) {
                    yuchuLabel.text = [NSString stringWithFormat:@"%.1f%%",[yilou intValue]/pingjunyilou *100];
                    yuchuLabel.frame = YUCHULABEL_FRAME;
                }
                
            }
            else if (viewType == KuaiSanTuiJianTypeErBuTong) {
                float pingjunyilou = 7.2;
                NSString *num = [selectNum stringByReplacingOccurrencesOfString:@"," withString:@""];
                CPTuiJianCell *cell = (CPTuiJianCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                if (cell) {
                    if ([cell.btn1.numLabel.text isEqualToString:num]) {
                        yuchuLabel.text = [NSString stringWithFormat:@"%.1f%%",[[cell.btn1.ylLable.text stringByReplacingOccurrencesOfString:@"遗漏" withString:@""] intValue]/pingjunyilou *100];
                        yuchuLabel.frame = YUCHULABEL_FRAME;
                    }
                    else if ([cell.btn2.numLabel.text isEqualToString:num]) {
                        yuchuLabel.text = [NSString stringWithFormat:@"%.1f%%",[[cell.btn2.ylLable.text stringByReplacingOccurrencesOfString:@"遗漏" withString:@""] intValue]/pingjunyilou *100];
                        yuchuLabel.frame = YUCHULABEL_FRAME;
                    }
                    else if ([cell.btn3.numLabel.text isEqualToString:num]) {
                        yuchuLabel.text = [NSString stringWithFormat:@"%.1f%%",[[cell.btn3.ylLable.text stringByReplacingOccurrencesOfString:@"遗漏" withString:@""] intValue]/pingjunyilou *100];
                        yuchuLabel.frame = YUCHULABEL_FRAME;
                    }
                }
            }
            else if (viewType == KuaiSanTuiJianTypeSanBuTong) {
                float pingjunyilou = 36;
                NSString *num = [selectNum stringByReplacingOccurrencesOfString:@"," withString:@""];
                CPTuiJianCell *cell = (CPTuiJianCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                if (cell) {
                    if ([cell.btn1.numLabel.text isEqualToString:num]) {
                        yuchuLabel.text = [NSString stringWithFormat:@"%.1f%%",[[cell.btn1.ylLable.text stringByReplacingOccurrencesOfString:@"遗漏" withString:@""] intValue]/pingjunyilou *100];
                        yuchuLabel.frame = YUCHULABEL_FRAME;

                    }
                    else if ([cell.btn2.numLabel.text isEqualToString:num]) {
                        yuchuLabel.text = [NSString stringWithFormat:@"%.1f%%",[[cell.btn2.ylLable.text stringByReplacingOccurrencesOfString:@"遗漏" withString:@""] intValue]/pingjunyilou *100];
                        yuchuLabel.frame = YUCHULABEL_FRAME;

                    }
                    else if ([cell.btn3.numLabel.text isEqualToString:num]) {
                        yuchuLabel.text = [NSString stringWithFormat:@"%.1f%%",[[cell.btn3.ylLable.text stringByReplacingOccurrencesOfString:@"遗漏" withString:@""] intValue]/pingjunyilou *100];
                        yuchuLabel.frame = YUCHULABEL_FRAME;

                    }                }
            }
        }
    }


}

- (void)puShiZhuiHao {
    [self keydis];
    [self getBettingInfo];
    CalculateViewController * calculate = [[CalculateViewController  alloc] init];
    calculate.betInfo = myBentInfo;
    calculate.delegate = self;
    calculate.zhuijiabool = NO;
    calculate.issuearr = issuearr;
    calculate.isTingZhui = YES;
    calculate.morenbeishu = @"1";
    calculate.jisuanType = GouCaiShuZiInfoTypeKuaiSanJiSuan;
    [self.navigationController pushViewController:calculate animated:YES];
    [calculate release];
}

- (void)returnBetInfoData:(GC_BetInfo *)gcbetinfo{
    
    zhuiTextField.text = [NSString stringWithFormat:@"%d", (int)[self.myBentInfo.betlist count]-1];
    self.myBentInfo = gcbetinfo;
    infoViewController.issuearr = issuearr;
    [self upUI];
    [infoViewController returnBetInfoData:self.myBentInfo];
}

- (void)qingqiuZhuiHaoQici {
    [ahttpRequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] huoQuQiHaoLotteryId:myBentInfo.caizhong shuliang:120];
    
    
    self.ahttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [ahttpRequest setRequestMethod:@"POST"];
    [ahttpRequest addCommHeaders];
    [ahttpRequest setPostBody:postData];
    [ahttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [ahttpRequest setDelegate:self];
    [ahttpRequest setDidFinishSelector:@selector(reqStartTogetherBuyFinished:)];
    [ahttpRequest startAsynchronous];
}

- (void)goZhuiHao {
    if ([issuearr count] > 1) {
        [self puShiZhuiHao];
    }else{
        [[caiboAppDelegate getAppDelegate] showMessage:@"获取可请求期次中"];
        [self qingqiuZhuiHaoQici];
    }

}

- (void)pressaddbutton:(UIButton *)sender {
    zhuiTextField.text = [NSString stringWithFormat:@"%d",[zhuiTextField.text intValue] + 1];
    if ([zhuiTextField.text intValue] > [issuearr count] - 1) {
        zhuiTextField.text = [NSString stringWithFormat:@"%d",(int)[issuearr count] - 1];
    }
    else {
        if ([myBentInfo.betlist count] > 1) {
            NSString * mul = [NSString stringWithFormat:@"%@:%d", [issuearr objectAtIndex:[zhuiTextField.text intValue]], 1];
            [myBentInfo.betlist addObject:mul];
        }
        else {
            [self getBettingInfo];
        }
        
    }
    
    if ([zhuiTextField.text intValue] <= 0) {
        zhuiTextField.text = @"0";
    }
    [self upUI];
    
}

- (void)pressjianbutton:(UIButton *)sender{
    zhuiTextField.text = [NSString stringWithFormat:@"%d",[zhuiTextField.text intValue] - 1];
    if ([zhuiTextField.text intValue] < 0) {
        zhuiTextField.text = @"0";
    }
    else {
        if ([myBentInfo.betlist count] > 1) {
            [myBentInfo.betlist removeLastObject];
        }
        
    }
    [self upUI];
}

- (void)rengouSelcte {
    if (infoBackImage.isOpen) {
        [self keydis];
    }else{
        [self keyshow];
    }
}



#pragma mark CPZhankaiViewDelegte

- (void)ZhankaiViewClicke:(CPZhanKaiView *)_zhankaiView {
    if (!_zhankaiView.isOpen) {
        [self keydis];
    }
    else {
        [self keyshow];
    }
}

- (void)jianPanClicke:(UIButton *)sender {
    if (sender.tag == 11) {
        
        
        
        [self keydis];
        [self upUI];
    }
    else if (sender.tag == 10) {
        zhuiTextField.text = [NSString stringWithFormat:@"%d",[zhuiTextField.text intValue]/10];
    }
    else {
            zhuiTextField.text = [NSString stringWithFormat:@"%d",(int)[zhuiTextField.text intValue] * 10 + (int)sender.tag];
        
    }
    if ([zhuiTextField.text intValue] > [issuearr count] - 1) {
        zhuiTextField.text = [NSString stringWithFormat:@"%d",(int)[issuearr count] - 1];
    }
    if ([zhuiTextField.text intValue] <= 0) {
        zhuiTextField.text = @"0";
    }
    while ([myBentInfo.betlist count] > [zhuiTextField.text integerValue]+ 1 && [myBentInfo.betlist count] > 1) {
        [myBentInfo.betlist removeLastObject];
    }
    for (int i = (int)[myBentInfo.betlist count]; i < (int)[zhuiTextField.text integerValue]+ 1; i++) {
        
        if ([issuearr count] > i &&i >= 1) {
            NSString * mul = [NSString stringWithFormat:@"%@:%d", [issuearr objectAtIndex:i - 1], 1];
            [myBentInfo.betlist addObject:mul];
        }
        
        
    }
    [self upUI];
    
}

- (void)keyshow{
    infoBackImage.isOpen = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
//    if (IS_IPHONE_5) {
        //113
//        footBackImage.frame = CGRectMake(0, 233, 320, 222);
        footBackImage.frame = CGRectMake(footBackImage.frame.origin.x, footBackImage.frame.origin.y - KEYBOARD_HEIGHT, footBackImage.frame.size.width, footBackImage.frame.size.height + KEYBOARD_HEIGHT);

//    }
//    else {
//        footBackImage.frame = CGRectMake(footBackImage.frame.origin.x, 145, footBackImage.frame.size.width, 222);
//    }
//    infoBackImage.frame = CGRectMake(0, 0, 320, 55);

    infoBackImage.frame = CGRectMake(0, 0, 320, 170);
    infoBackImaeg2.frame = CGRectMake(infoBackImaeg2.frame.origin.x, infoBackImaeg2.frame.origin.y + KEYBOARD_HEIGHT, infoBackImaeg2.frame.size.width, infoBackImaeg2.frame.size.height);
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
    
}

- (void)keydis{

    if (infoBackImage.isOpen == YES) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
//        if (IS_IPHONE_5) {
            //        footBackImage.frame = CGRectMake(0, 338, 320, 117);
            footBackImage.frame = CGRectMake(footBackImage.frame.origin.x, footBackImage.frame.origin.y + KEYBOARD_HEIGHT, footBackImage.frame.size.width, footBackImage.frame.size.height);
//        }
//        else {
//            footBackImage.frame = CGRectMake(0, 250, 320, 117);
//        }
        infoBackImage.frame = CGRectMake(0, 0, 320, 55);
        infoBackImaeg2.frame = CGRectMake(infoBackImaeg2.frame.origin.x, infoBackImaeg2.frame.origin.y - KEYBOARD_HEIGHT, infoBackImaeg2.frame.size.width, infoBackImaeg2.frame.size.height);
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView commitAnimations];

    }
    infoBackImage.isOpen = NO;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (viewType == KuaiSanTuiJianTypeHeZhi) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
		CPTuiJianCell *cell = (CPTuiJianCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[CPTuiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.tuijianCellDelegate = self;
		}

		
    if (viewType == KuaiSanTuiJianTypeHeZhi) {
        if (indexPath.row == 0) {
            [cell LoadName:@"号码和值"];
            [cell LoadData:[self.dataDic objectForKey:@"k3MobileAndValuesValue"]];
        }
        else if (indexPath.row == 1) {
            [cell LoadName:@"号码和尾"];
            [cell LoadData:[self.dataDic objectForKey:@"k3MobileHeWeiValue"]];
        }
        else if (indexPath.row == 2) {
            [cell LoadName:@"号码和值段"];
            [cell LoadData:[self.dataDic objectForKey:@"k3MobileZhiDuanValue"]];
        }
        
    }
    else if (viewType == KuaiSanTuiJianTypeSanBuTong) {
        [cell LoadName:@"三不同号"];
        [cell LoadData:[self.dataDic objectForKey:@"k3MobileThreeDefrentValue"]];
    }
    else if (viewType == KuaiSanTuiJianTypeErBuTong) {
        [cell LoadName:@"二不同号"];
        [cell LoadData:[self.dataDic objectForKey:@"k3MobileTwoDefrentValue"]];
    }
    return cell;
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate


- (void)reqStartTogetherBuyFinished:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        
        IssueObtain *buyResult = [[IssueObtain alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        
        if ([buyResult.issuestring length] != 0 && buyResult.issuestring) {
            NSArray * arr = [buyResult.issuestring componentsSeparatedByString:@","];
            [issuearr removeAllObjects];
            if ([arr count] > 0) {
                if (![self.myBentInfo.issue isEqualToString:[arr objectAtIndex:0]]) {
                    [issuearr addObject:self.myBentInfo.issue];
                }
            }
           
            
            [issuearr addObjectsFromArray:arr];
        }
        
        
        
        [buyResult release];
    }
    
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    