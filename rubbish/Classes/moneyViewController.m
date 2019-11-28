//
//  moneyViewController.m
//  caibo
//
//  Created by cp365dev on 14-3-3.
//
//

#import "moneyViewController.h"
#import "Info.h"
#import "CP_KindsOfChoose.h"
#import "NetURL.h"
#import "LotteryList.h"
#import "CP_NumOfChoose.h"
#import "JSON.h"
#import "JiangJinJiSuanView.h"
#import "GC_LotteryUtil.h"
#import "Info.h"

@interface moneyViewController ()

@end


@implementation moneyViewController

@synthesize lottoryID;
@synthesize myHttpRequest,infoHttpRequest,infoHttpRequest2;
@synthesize dataDic;
@synthesize shuangseqiuQici,daletouQici;
@synthesize isDaleTouKaiChu,isShuangSeQiuKaichu;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.isDaleTouKaiChu = YES;
        self.isShuangSeQiuKaichu = YES;
        self.daletouQici = 0;
        self.shuangseqiuQici = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.CP_navigation.title = @"奖金计算";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    UIImageView *titleview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"biaotouBG.png"]];
    titleview.frame=CGRectMake(0, 0, 320, 50);
    titleview.userInteractionEnabled=YES;
    titleview.backgroundColor=[UIColor clearColor];
    [self.mainView addSubview:titleview];
    
    
    lanxian=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"biaotouhunxian.png"]];
    lanxian.frame=CGRectMake(0, 49, 159, 2);
    [self.mainView addSubview:lanxian];
    [lanxian release];
    
    
    UIButton *buttonShuang=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 159, 50)];
    buttonShuang.tag=1;
    labelshuang=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 50, 50)];
    labelshuang.text=@"双色球";
    labelshuang.backgroundColor=[UIColor clearColor];
    buttonShuang.backgroundColor=[UIColor clearColor];
    labelshuang.font=[UIFont systemFontOfSize:16];
    labelshuang.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
    
    
    [buttonShuang addSubview:labelshuang];
    [labelshuang release];
    [buttonShuang addTarget:self action:@selector(Shuangseqiu) forControlEvents:UIControlEventTouchUpInside];
    [buttonShuang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleview addSubview:buttonShuang];
    
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(160, 7, 1, 35)];
    line.image=[UIImage imageNamed:@"biaotouxian.png"];
    line.backgroundColor=[UIColor clearColor];
    [titleview addSubview:line];
    [line release];
    
    UIButton *buttonDaletou=[[UIButton alloc]initWithFrame:CGRectMake(161, 0, 159, 50)];
    buttonDaletou.tag=2;
    [buttonDaletou addTarget:self action:@selector(daletou) forControlEvents:UIControlEventTouchUpInside];

    buttonDaletou.backgroundColor=[UIColor clearColor];
    labeDa=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 50, 50)];
    labeDa.text=@"大乐透";
    labeDa.tag=2;
    labeDa.backgroundColor=[UIColor clearColor];
    labeDa.font=[UIFont systemFontOfSize:16];
    labeDa.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
    [buttonDaletou addSubview:labeDa];
    [labeDa release];
    
    
    
    [buttonDaletou setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [titleview addSubview:buttonDaletou];
    
    self.mainView.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    if ([lottoryID isEqualToString:@"001"]) {
        [self Shuangseqiu];
    }
    else {
        [self daletou];
    }
    [titleview release];
    [buttonDaletou release];
    [buttonShuang release];
	// Do any additional setup after loading the view.
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Shuangseqiu
{
    self.lottoryID = @"001";
    [self.myHttpRequest clearDelegatesAndCancel];
   // [viewDaletou removeFromSuperview];
    monytype = monyTypeShuangSeQiu;
    lanxian.frame=CGRectMake(0, 49, 161, 2);
    labeDa.textColor=[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1];
    labelshuang.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
    
    if (!viewshuang) {
        viewshuang=[[UIView alloc]initWithFrame:CGRectMake(0, 58, self.mainView.frame.size.width, self.mainView.frame.size.height-40)];
        viewshuang.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [self.mainView addSubview:viewshuang];
        
        UIButton *jisuan=[UIButton buttonWithType:UIButtonTypeCustom];
        jisuan.frame=CGRectMake(15, 312, 290, 40);
        
        UILabel *labelTitle=[[UILabel alloc]initWithFrame:jisuan.bounds];
        labelTitle.text=@"计算我的奖金";
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        labelTitle.backgroundColor=[UIColor clearColor];
        labelTitle.font=[UIFont systemFontOfSize:16];
        labelTitle.tag = 101;
        [jisuan addSubview:labelTitle];
        [jisuan setImage:UIImageGetImageFromName(@"jiangjin.png") forState:UIControlStateNormal];
        [jisuan setImage:UIImageGetImageFromName(@"jiangjinzhong.png") forState:UIControlStateHighlighted];
        [jisuan addTarget:self action:@selector(jisuanMoney) forControlEvents:UIControlEventTouchUpInside];
        [viewshuang addSubview:jisuan];
        jisuan.tag = 115;
        
        
        
        UIImageView *kaijiang=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodetouzhuBj.png"]];
        kaijiang.userInteractionEnabled=YES;
        
        kaijiang.frame=CGRectMake(0, 2, 320, 70);
        [viewshuang addSubview:kaijiang];
        
        UILabel *qiciLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 16)];
        qiciLabel.backgroundColor = [UIColor clearColor];
        qiciLabel.tag = 2222;
        qiciLabel.font = [UIFont systemFontOfSize:15];
        qiciLabel.textColor= [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
        [viewshuang addSubview:qiciLabel];
        [qiciLabel release];
        
        UIButton *buttonQici=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 320, 40)];
        UIImageView *sanjiao=[[UIImageView alloc]initWithFrame:CGRectMake(283, 25, 15, 10)];
        sanjiao.image=UIImageGetImageFromName(@"upSanjiao.png");
        sanjiao.backgroundColor=[UIColor clearColor];
        buttonQici.backgroundColor=[UIColor clearColor];
        [buttonQici addSubview:sanjiao];
        
        [sanjiao release];
        
        [buttonQici addTarget:self action:@selector(qici) forControlEvents:UIControlEventTouchUpInside];
        [kaijiang addSubview:buttonQici];
        
        
        
        UIImageView *touzhu=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodetouzhuBj.png"]];
        touzhu.userInteractionEnabled=YES;
        touzhu.frame=CGRectMake(0, 82, 320, 100);
        touzhu.tag = 400;
        [viewshuang addSubview:touzhu];
        
        UILabel *touzhuLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
        touzhuLabel.text=@"我的投注";
        touzhuLabel.textColor=[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1];
        touzhuLabel.font=[UIFont systemFontOfSize:15];
        touzhuLabel.backgroundColor=[UIColor clearColor];
        [touzhu addSubview:touzhuLabel];
        [touzhuLabel release];
        
        
        
        //投注注数与金额
        
        UILabel *labelZhu=[[UILabel alloc]initWithFrame:CGRectMake(195, 5, 30, 20)];
        labelZhu.text=@"投注";
        labelZhu.tag = 501;
        labelZhu.textColor=[UIColor colorWithRed:92/255.0 green:92/255.0 blue:92/255.0 alpha:1];
        labelZhu.font=[UIFont systemFontOfSize:15];
        [touzhu addSubview:labelZhu];
        [labelZhu release];
        
        UILabel *labelJinE=[[UILabel alloc]initWithFrame:CGRectMake(195, 5, 30, 20)];
        labelJinE.tag = 502;
        labelJinE.text = @"1注, 2元";
        labelJinE.textColor=[UIColor redColor];
        labelJinE.font=[UIFont systemFontOfSize:15];
        [touzhu addSubview:labelJinE];
        [labelJinE release];
        
        labelJinE.frame = CGRectMake(300 - [labelJinE.text sizeWithFont:labelJinE.font].width, 5, [labelJinE.text sizeWithFont:labelJinE.font].width, 20);
        labelZhu.frame = CGRectMake(labelJinE.frame.origin.x - 40, 5, 100, 20);
        
        
        //投注红框
        UIImageView *imageHong=[[UIImageView alloc]initWithImage:[UIImageGetImageFromName(@"hongkuang.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        imageHong.backgroundColor=[UIColor clearColor];
        imageHong.userInteractionEnabled=YES;
        imageHong.tag = 300;
        imageHong.frame=CGRectMake(18, 32, 140, 55);
        [touzhu addSubview:imageHong];
        
        UILabel *hongqiuLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 35, 15)];
        hongqiuLa.text=@"红球";
        hongqiuLa.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        hongqiuLa.backgroundColor=[UIColor clearColor];
        hongqiuLa.font=[UIFont systemFontOfSize:17];
        [imageHong addSubview:hongqiuLa];
        [hongqiuLa release];
        
        UILabel *geshu=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 33, 15)];
        geshu.text=@"6";
        geshu.textAlignment=NSTextAlignmentCenter;
        geshu.textColor=[UIColor redColor];
        geshu.tag = 112;
        geshu.backgroundColor=[UIColor clearColor];
        geshu.font=[UIFont systemFontOfSize:18];
        [imageHong addSubview:geshu];
        [geshu release];
        
        UILabel *geLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 20, 15)];
        geLabel.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        geLabel.text=@"个";
        geLabel.backgroundColor=[UIColor clearColor];
        geLabel.font=[UIFont systemFontOfSize:17];
        [imageHong addSubview:geLabel];
        [geLabel release];
        
        
        UIButton *geButton=[[UIButton alloc]initWithFrame:imageHong.bounds];
        UIImageView *sanjiaoGeshu=[[UIImageView alloc]initWithFrame:CGRectMake(115, 24, 15, 10)];
        [geButton addTarget:self action:@selector(touhonggeshu:) forControlEvents:UIControlEventTouchUpInside];
        geButton.tag = 200;
        sanjiaoGeshu.image=UIImageGetImageFromName(@"upSanjiao.png");
        [geButton addSubview:sanjiaoGeshu];
        geButton.backgroundColor=[UIColor clearColor];
        [imageHong addSubview:geButton];
        [geButton release];
        [sanjiaoGeshu release];
        
        
        [imageHong release];
        
        //my投注蓝框
        UIImageView *imageLan=[[UIImageView alloc]initWithImage:[UIImageGetImageFromName(@"lankuang.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        imageLan.backgroundColor=[UIColor clearColor];
        imageLan.userInteractionEnabled=YES;
        imageLan.frame=CGRectMake(168, 32, 140, 55);
        [touzhu addSubview:imageLan];
        imageLan.tag = 301;
        
        UILabel *lanqiuLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 35, 15)];
        lanqiuLa.text=@"蓝球";
        lanqiuLa.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        lanqiuLa.backgroundColor=[UIColor clearColor];
        lanqiuLa.font=[UIFont systemFontOfSize:17];
        [imageLan addSubview:lanqiuLa];
        [lanqiuLa release];
        
        UILabel *geshuLan=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 33, 15)];
        geshuLan.text=@"1";
        geshuLan.textAlignment=NSTextAlignmentCenter;
        geshuLan.backgroundColor=[UIColor clearColor];
        geshuLan.tag = 112;
        geshuLan.font=[UIFont systemFontOfSize:18];
        geshuLan.textColor=[UIColor colorWithRed:0/255.0 green:91/255.0 blue:212/255.0 alpha:1];
        [imageLan addSubview:geshuLan];
        [geshuLan release];
        
        UILabel *geLabelLan=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 20, 15)];
        geLabelLan.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        geLabelLan.text=@"个";
        geLabelLan.backgroundColor=[UIColor clearColor];
        geLabelLan.font=[UIFont systemFontOfSize:17];
        [imageLan addSubview:geLabelLan];
        [geLabelLan release];
        
        
        UIButton *geButtonLan=[[UIButton alloc]initWithFrame:imageLan.bounds];
        UIImageView *sanjiaoGeshuLan=[[UIImageView alloc]initWithFrame:CGRectMake(115, 24, 15, 10)];
        [geButtonLan addTarget:self action:@selector(touhonggeshu:) forControlEvents:UIControlEventTouchUpInside];
        geButtonLan.tag = 201;
        sanjiaoGeshuLan.image=UIImageGetImageFromName(@"upSanjiao.png");
        [geButtonLan addSubview:sanjiaoGeshuLan];
        geButtonLan.backgroundColor=[UIColor clearColor];
        [imageLan addSubview:geButtonLan];
        [geButtonLan release];
        [sanjiaoGeshuLan release];
        
        [imageLan release];
        
        
        
        UIImageView *mingzhong=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodetouzhuBj.png"]];
        mingzhong.userInteractionEnabled=YES;
        mingzhong.frame=CGRectMake(0, 192, 320, 100);
        [viewshuang addSubview:mingzhong];
        mingzhong.tag = 401;
        
        UILabel *mingLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
        mingLabel.text=@"我的命中";
        mingLabel.textColor=[UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
        mingLabel.font=[UIFont systemFontOfSize:15];
        mingLabel.backgroundColor=[UIColor clearColor];
        [mingzhong addSubview:mingLabel];
        [mingLabel release];
        
        
        
        UIImageView *imageHong1=[[UIImageView alloc]initWithImage:[UIImageGetImageFromName(@"hongkuang.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        imageHong1.backgroundColor=[UIColor clearColor];
        imageHong1.userInteractionEnabled=YES;
        imageHong1.frame=CGRectMake(18, 32, 140, 55);
        [mingzhong addSubview:imageHong1];
        imageHong1.tag = 300;
        
        UILabel *hongqiuMing=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 35, 20)];
        hongqiuMing.text=@"红球";
        hongqiuMing.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        hongqiuMing.backgroundColor=[UIColor clearColor];
        hongqiuMing.font=[UIFont systemFontOfSize:17];
        [imageHong1 addSubview:hongqiuMing];
        [hongqiuMing release];
        
        UILabel *geshuMing=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 33, 20)];
        geshuMing.text=@"0";
        geshuMing.textAlignment=NSTextAlignmentCenter;
        geshuMing.textColor=[UIColor redColor];
        geshuMing.tag = 112;
        geshuMing.backgroundColor=[UIColor clearColor];
        geshuMing.font=[UIFont systemFontOfSize:18];
        [imageHong1 addSubview:geshuMing];
        [geshuMing release];
        
        UILabel *geLabelMing=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 20, 20)];
        geLabelMing.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        geLabelMing.text=@"个";
        geLabelMing.backgroundColor=[UIColor clearColor];
        geLabelMing.font=[UIFont systemFontOfSize:17];
        [imageHong1 addSubview:geLabelMing];
        [geLabelMing release];
        
        
        UIButton *geButtonMing=[[UIButton alloc]initWithFrame:imageHong1.bounds];
        UIImageView *sanjiaoMing=[[UIImageView alloc]initWithFrame:CGRectMake(115, 24, 15, 10)];
        geButtonMing.tag = 202;
        [geButtonMing addTarget:self action:@selector(touhonggeshu:) forControlEvents:UIControlEventTouchUpInside];
        sanjiaoMing.image=UIImageGetImageFromName(@"upSanjiao.png");
        [geButtonMing addSubview:sanjiaoMing];
        geButtonMing.backgroundColor=[UIColor clearColor];
        [imageHong1 addSubview:geButtonMing];
        [geButtonMing release];
        [sanjiaoMing release];
        
        
        [imageHong1 release];
        
        
        UIImageView *imageLan1=[[UIImageView alloc]initWithImage:[UIImageGetImageFromName(@"lankuang.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        imageLan1.backgroundColor=[UIColor clearColor];
        imageLan1.userInteractionEnabled=YES;
        imageLan1.frame=CGRectMake(168, 32, 140, 55);
        [mingzhong addSubview:imageLan1];
        imageLan1.tag = 301;
        
        UILabel *lanqiuMing=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 35, 20)];
        lanqiuMing.text=@"蓝球";
        lanqiuMing.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        lanqiuMing.backgroundColor=[UIColor clearColor];
        lanqiuMing.font=[UIFont systemFontOfSize:17];
        [imageLan1 addSubview:lanqiuMing];
        [lanqiuMing release];
        
        UILabel *geshuLanMing=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 33, 20)];
        geshuLanMing.text=@"0";
        geshuLanMing.tag = 112;
        geshuLanMing.textAlignment=NSTextAlignmentCenter;
        geshuLanMing.backgroundColor=[UIColor clearColor];
        geshuLanMing.font=[UIFont systemFontOfSize:18];
        geshuLanMing.textColor=[UIColor colorWithRed:0/255.0 green:91/255.0 blue:212/255.0 alpha:1];
        [imageLan1 addSubview:geshuLanMing];
        [geshuLanMing release];
        
        UILabel *geLabelLanMing=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 20, 20)];
        geLabelLanMing.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        geLabelLanMing.text=@"个";
        geLabelLanMing.backgroundColor=[UIColor clearColor];
        geLabelLanMing.font=[UIFont systemFontOfSize:17];
        [imageLan1 addSubview:geLabelLanMing];
        [geLabelLanMing release];
        
        
        UIButton *geButtonLanMing=[[UIButton alloc]initWithFrame:imageLan1.bounds];
        UIImageView *sanjiaoGeshuLanMing=[[UIImageView alloc]initWithFrame:CGRectMake(115, 24, 15, 10)];
        sanjiaoGeshuLanMing.image=UIImageGetImageFromName(@"upSanjiao.png");
        [geButtonLanMing addTarget:self action:@selector(touhonggeshu:) forControlEvents:UIControlEventTouchUpInside];
        geButtonLanMing.tag = 203;
        [geButtonLanMing addSubview:sanjiaoGeshuLanMing];
        geButtonLanMing.backgroundColor=[UIColor clearColor];
        [imageLan1 addSubview:geButtonLanMing];
        [geButtonLanMing release];
        [sanjiaoGeshuLanMing release];
        
        
        [imageLan1 release];
        
        
        
        
        
        [labelTitle release];
        [buttonQici release];
        [kaijiang release];
        [touzhu release];
        [mingzhong release];
        [viewshuang release];
    }
    viewshuang.hidden = NO;
    viewDaletou.hidden = YES;
    UIButton *btn = (UIButton *)[viewshuang viewWithTag:115];
    if (!isShuangSeQiuKaichu &&shuangseqiuQici == 0) {
        btn.selected = YES;
    }
    else {
        btn.selected = NO;
    }
    if (![dataDic objectForKey:@"001"]) {
        [self.myHttpRequest clearDelegatesAndCancel];
        self.myHttpRequest = [ASIHTTPRequest requestWithURL:
									   [NetURL CBsynLotteryList:@"001"
														 pageNo:@"1"
													   pageSize:@"10"
														 userId:[[Info getInstance] userId]]];
		
		[myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[myHttpRequest setDelegate:self];
		
		[myHttpRequest setDidFinishSelector:@selector(LoadingShuangSeQiu:)];
		[myHttpRequest setDidFailSelector:@selector(failselector:)];
		[myHttpRequest setNumberOfTimesToRetryOnTimeout:2];
		
		[myHttpRequest startAsynchronous];
    }
    
}
-(void)touhonggeshu:(UIButton *)sender
{
    NSInteger min = 0,max = 0;
    BOOL isLan = NO;
    NSString *title = @"";
    if (sender.tag == 200) {
        title = @"我的投注-红球";
        if (monytype == monyTypeShuangSeQiu) {
            min = 6;
            max = 20;
        }
        else if (monytype == monyTypeDaletou) {
            min = 5;
            max = 35;
        }
    }
    else if (sender.tag == 201) {
        title = @"我的投注-蓝球";
        if (monytype == monyTypeShuangSeQiu) {
            min = 1;
            max = 16;
            isLan = YES;
        }
        else if (monytype == monyTypeDaletou) {
            min = 2;
            max = 12;
            isLan = YES;
        }
    }
    else if (sender.tag == 202) {
        title = @"我的命中-红球";
        if (monytype == monyTypeShuangSeQiu) {
            min = 0;
            max = 6;
        }
        else if (monytype == monyTypeDaletou) {
            min = 0;
            max = 5;
        }
    }
    else if (sender.tag == 203) {
        title = @"我的命中-蓝球";
        if (monytype == monyTypeShuangSeQiu) {
            min = 0;
            max = 1;
            isLan = YES;
        }
        else if (monytype == monyTypeDaletou) {
            min = 0;
            max = 2;
            isLan = YES;
        }
    }
    
    UILabel *lable = (UILabel *)[sender.superview viewWithTag:112];
    CP_NumOfChoose *choose = [[CP_NumOfChoose alloc] initWithTitle:title MaxNum:max MinNum:min cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
    choose.inputLable = lable;
    choose.delegate = self;
    
//    choose.norImage = UIImageGetImageFromName(@"jiangjinNor.png");
    choose.norImage = [UIImageGetImageFromName(@"tongyonghui.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
    if (!isLan) {
//    choose.selectImage = UIImageGetImageFromName(@"jiangjinHong.png");
        choose.selectImage = [UIImageGetImageFromName(@"btn_red_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
    }
    else {
//        choose.selectImage = UIImageGetImageFromName(@"jiangjinLan.png");
        choose.selectImage = [UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7];
    }
    
    [choose show];
    if ([lable isKindOfClass:[UILabel class]]) {
        for (CP_PTButton *btn in choose.backScrollView.subviews) {
            if ([btn isKindOfClass:[CP_PTButton class]]) {
                if ([btn.buttonName.text isEqualToString:lable.text]) {
                    btn.selected = YES;
                    btn.buttonName.textColor = [UIColor whiteColor];
                }
            }
        }
    }
    [choose release];
}


-(void)daletou
{
   // [viewshuang removeFromSuperview];
    self.lottoryID = @"113";
    [self.myHttpRequest clearDelegatesAndCancel];
    monytype = monyTypeDaletou;
    lanxian.frame=CGRectMake(161, 49, 159, 2);
    labelshuang.textColor=[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1];
    labeDa.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
    
    if (!viewDaletou) {
        viewDaletou=[[UIView alloc]initWithFrame:CGRectMake(0, 58, self.mainView.frame.size.width, self.mainView.frame.size.height-40)];
        viewDaletou.backgroundColor=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [self.mainView addSubview:viewDaletou];
        UIImageView *kaijiang=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodetouzhuBj.png"]];
        kaijiang.userInteractionEnabled=YES;
        
        kaijiang.frame=CGRectMake(0, 2, 320, 70);
        [viewDaletou addSubview:kaijiang];
        
        UILabel *qiciLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 16)];
        qiciLabel.backgroundColor = [UIColor clearColor];
        qiciLabel.tag = 2222;
        qiciLabel.font = [UIFont systemFontOfSize:15];
        qiciLabel.textColor= [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
        [viewDaletou addSubview:qiciLabel];
        [qiciLabel release];
        
        UIButton *buttonQici=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 320, 40)];
        UIImageView *sanjiao=[[UIImageView alloc]initWithFrame:CGRectMake(283, 25, 15, 10)];
        sanjiao.image=UIImageGetImageFromName(@"upSanjiao.png");
        sanjiao.backgroundColor=[UIColor clearColor];
        buttonQici.backgroundColor=[UIColor clearColor];
        [buttonQici addSubview:sanjiao];
        
        [sanjiao release];
        
        [buttonQici addTarget:self action:@selector(qici) forControlEvents:UIControlEventTouchUpInside];
        [kaijiang addSubview:buttonQici];
        
        
        
        UIImageView *touzhu=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodetouzhuBj.png"]];
        touzhu.userInteractionEnabled=YES;
        touzhu.frame=CGRectMake(0, 82, 320, 120);
        [viewDaletou addSubview:touzhu];
        touzhu.tag = 400;
        
        UILabel *touzhuLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
        touzhuLabel.text=@"我的投注";
        touzhuLabel.textColor=[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1];
        touzhuLabel.font=[UIFont systemFontOfSize:15];
        touzhuLabel.backgroundColor=[UIColor clearColor];
        [touzhu addSubview:touzhuLabel];
        
        //投注注数与金额
        
        UILabel *labelZhu=[[UILabel alloc]initWithFrame:CGRectMake(195, 5, 30, 20)];
        labelZhu.text=@"投注";
        labelZhu.tag = 501;
        labelZhu.textColor=[UIColor colorWithRed:92/255.0 green:92/255.0 blue:92/255.0 alpha:1];
        labelZhu.font=[UIFont systemFontOfSize:15];
        [touzhu addSubview:labelZhu];
        [labelZhu release];
        
        UILabel *labelJinE=[[UILabel alloc]initWithFrame:CGRectMake(195, 5, 30, 20)];
        labelJinE.tag = 502;
        labelJinE.textColor=[UIColor redColor];
        labelJinE.text = @"1注, 2元";
        labelJinE.font=[UIFont systemFontOfSize:15];
        [touzhu addSubview:labelJinE];
        [labelJinE release];
        
        labelJinE.frame = CGRectMake(290 - [labelJinE.text sizeWithFont:labelJinE.font].width, 5, [labelJinE.text sizeWithFont:labelJinE.font].width, 20);
        labelZhu.frame = CGRectMake(labelJinE.frame.origin.x - 40, 5, 100, 20);
        
        
        
        //圆圈按钮 普通投注 追加投注
        
        putongButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 85, 140, 40)];
        putongImg=[[UIImageView alloc]initWithFrame:CGRectMake(29, 13, 15, 15)];
        putongImg.image=UIImageGetImageFromName(@"xuanzhong.png");
        [putongButton addTarget:self action:@selector(putong:) forControlEvents:UIControlEventTouchUpInside];
        [putongButton addSubview:putongImg];
        UILabel *labelPutong=[[UILabel alloc]initWithFrame:CGRectMake(55, 10, 100, 20)];
        labelPutong.text=@"普通投注";
        putongButton.selected = YES;
        labelPutong.textColor=[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1];
        labelPutong.font=[UIFont systemFontOfSize:15];
        labelPutong.backgroundColor=[UIColor clearColor];
        [putongButton addSubview:labelPutong];
        [labelPutong release];
        [touzhu addSubview:putongButton];
        [putongButton release];
        
        zhujiaButton=[[UIButton alloc]initWithFrame:CGRectMake(175, 85, 120, 40)];
        zhujiaImag=[[UIImageView alloc]initWithFrame:CGRectMake(4, 13, 15, 15)];
        zhujiaImag.image=UIImageGetImageFromName(@"weixuan.png");
        [zhujiaButton addTarget:self action:@selector(putong:) forControlEvents:UIControlEventTouchUpInside];
        [zhujiaButton addSubview:zhujiaImag];
        UILabel *labelZhuijia=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 100, 20)];
        labelZhuijia.text=@"追加投注";
        labelZhuijia.textColor=[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1];
        labelZhuijia.font=[UIFont systemFontOfSize:15];
        labelZhuijia.backgroundColor=[UIColor clearColor];
        [zhujiaButton addSubview:labelZhuijia];
        [labelZhuijia release];
        [touzhu addSubview:zhujiaButton];
        [zhujiaButton release];
        
        //投注红框
        UIImageView *imageHong=[[UIImageView alloc]initWithImage:[UIImageGetImageFromName(@"hongkuang.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        imageHong.backgroundColor=[UIColor clearColor];
        imageHong.userInteractionEnabled=YES;
        imageHong.frame=CGRectMake(18, 30, 140, 55);
        [touzhu addSubview:imageHong];
        imageHong.tag = 300;
        
        UILabel *hongqiuLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 35, 15)];
        hongqiuLa.text=@"红球";
        hongqiuLa.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        hongqiuLa.backgroundColor=[UIColor clearColor];
        hongqiuLa.font=[UIFont systemFontOfSize:17];
        [imageHong addSubview:hongqiuLa];
        [hongqiuLa release];
        
        UILabel *geshu=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 33, 15)];
        geshu.text=@"5";
        geshu.tag = 112;
        geshu.textAlignment=NSTextAlignmentCenter;
        geshu.textColor=[UIColor redColor];
        geshu.backgroundColor=[UIColor clearColor];
        geshu.font=[UIFont systemFontOfSize:18];
        [imageHong addSubview:geshu];
        [geshu release];
        
        
        UILabel *geLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 20, 15)];
        geLabel.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        geLabel.text=@"个";
        geLabel.backgroundColor=[UIColor clearColor];
        geLabel.font=[UIFont systemFontOfSize:17];
        [imageHong addSubview:geLabel];
        [geLabel release];
        
        
        UIButton *geButton=[[UIButton alloc]initWithFrame:imageHong.bounds];
        UIImageView *sanjiaoGeshu=[[UIImageView alloc]initWithFrame:CGRectMake(115, 24, 15, 10)];
        [geButton addTarget:self action:@selector(touhonggeshu:) forControlEvents:UIControlEventTouchUpInside];
        geButton.tag = 200;
        sanjiaoGeshu.image=UIImageGetImageFromName(@"upSanjiao.png");
        [geButton addSubview:sanjiaoGeshu];
        geButton.backgroundColor=[UIColor clearColor];
        [imageHong addSubview:geButton];
        [geButton release];
        [sanjiaoGeshu release];
        
        
        [imageHong release];
        
        
        //投注蓝框
        UIImageView *imageLan=[[UIImageView alloc]initWithImage:[UIImageGetImageFromName(@"lankuang.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        imageLan.backgroundColor=[UIColor clearColor];
        imageLan.userInteractionEnabled=YES;
        imageLan.frame=CGRectMake(168, 30, 140, 55);
        [touzhu addSubview:imageLan];
        imageLan.tag = 301;
        
        UILabel *lanqiuLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 35, 15)];
        lanqiuLa.text=@"蓝球";
        lanqiuLa.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        lanqiuLa.backgroundColor=[UIColor clearColor];
        lanqiuLa.font=[UIFont systemFontOfSize:17];
        [imageLan addSubview:lanqiuLa];
        [lanqiuLa release];
        
        UILabel *geshuLan=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 33, 15)];
        geshuLan.text=@"2";
        geshuLan.tag = 112;
        geshuLan.textAlignment=NSTextAlignmentCenter;
        geshuLan.backgroundColor=[UIColor clearColor];
        geshuLan.font=[UIFont systemFontOfSize:18];
        geshuLan.textColor=[UIColor colorWithRed:0/255.0 green:91/255.0 blue:212/255.0 alpha:1];
        [imageLan addSubview:geshuLan];
        [geshuLan release];
        
        UILabel *geLabelLan=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 20, 15)];
        geLabelLan.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        geLabelLan.text=@"个";
        geLabelLan.backgroundColor=[UIColor clearColor];
        geLabelLan.font=[UIFont systemFontOfSize:17];
        [imageLan addSubview:geLabelLan];
        [geLabelLan release];
        
        
        UIButton *geButtonLan=[[UIButton alloc]initWithFrame:imageLan.bounds];
        UIImageView *sanjiaoGeshuLan=[[UIImageView alloc]initWithFrame:CGRectMake(115, 24, 15, 10)];
        [geButtonLan addTarget:self action:@selector(touhonggeshu:) forControlEvents:UIControlEventTouchUpInside];
        geButtonLan.tag = 201;
        sanjiaoGeshuLan.image=UIImageGetImageFromName(@"upSanjiao.png");
        [geButtonLan addSubview:sanjiaoGeshuLan];
        geButtonLan.backgroundColor=[UIColor clearColor];
        [imageLan addSubview:geButtonLan];
        [geButtonLan release];
        [sanjiaoGeshuLan release];
        
        [imageLan release];
        
        [touzhuLabel release];
        
        
        UIImageView *mingzhong=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wodetouzhuBj.png"]];
        mingzhong.userInteractionEnabled=YES;
        mingzhong.frame=CGRectMake(0, 212, 320, 90);
        [viewDaletou addSubview:mingzhong];
        mingzhong.tag = 401;
        
        UILabel *mingLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
        mingLabel.text=@"我的命中";
        mingLabel.textColor=[UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
        mingLabel.font=[UIFont systemFontOfSize:15];
        mingLabel.backgroundColor=[UIColor clearColor];
        [mingzhong addSubview:mingLabel];
        
        
        //命中红框
        UIImageView *imageHongMing=[[UIImageView alloc]initWithImage:[UIImageGetImageFromName(@"hongkuang.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        imageHongMing.backgroundColor=[UIColor clearColor];
        imageHongMing.userInteractionEnabled=YES;
        imageHongMing.frame=CGRectMake(18, 30, 140, 55);
        [mingzhong addSubview:imageHongMing];
        imageHongMing.tag = 300;
        
        
        UILabel *hongqiuLaMing=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 35, 15)];
        hongqiuLaMing.text=@"红球";
        hongqiuLaMing.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        hongqiuLaMing.backgroundColor=[UIColor clearColor];
        hongqiuLaMing.font=[UIFont systemFontOfSize:17];
        [imageHongMing addSubview:hongqiuLaMing];
        [hongqiuLaMing release];
        
        UILabel *geshuMing=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 33, 15)];
        geshuMing.text=@"0";
        geshuMing.tag = 112;
        geshuMing.textAlignment=NSTextAlignmentCenter;
        geshuMing.textColor=[UIColor redColor];
        geshuMing.backgroundColor=[UIColor clearColor];
        geshuMing.font=[UIFont systemFontOfSize:18];
        [imageHongMing addSubview:geshuMing];
        [geshuMing release];
        
        UILabel *geLabelMing=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 20, 15)];
        geLabelMing.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        geLabelMing.text=@"个";
        geLabelMing.backgroundColor=[UIColor clearColor];
        geLabelMing.font=[UIFont systemFontOfSize:17];
        [imageHongMing addSubview:geLabelMing];
        [geLabelMing release];
        
        
        UIButton *geButtonMing=[[UIButton alloc]initWithFrame:imageHongMing.bounds];
        UIImageView *sanjiaoMing=[[UIImageView alloc]initWithFrame:CGRectMake(115, 24, 15, 10)];
        geButtonMing.tag = 202;
        [geButtonMing addTarget:self action:@selector(touhonggeshu:) forControlEvents:UIControlEventTouchUpInside];
        sanjiaoMing.image=UIImageGetImageFromName(@"upSanjiao.png");
        [geButtonMing addSubview:sanjiaoMing];
        geButtonMing.backgroundColor=[UIColor clearColor];
        [imageHongMing addSubview:geButtonMing];
        [geButtonMing release];
        [sanjiaoMing release];
        
        
        [imageHongMing release];
        
        
        //命中蓝框
        UIImageView *imageLanMing=[[UIImageView alloc]initWithImage:[UIImageGetImageFromName(@"lankuang.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        imageLanMing.backgroundColor=[UIColor clearColor];
        imageLanMing.userInteractionEnabled=YES;
        imageLanMing.frame=CGRectMake(168, 30, 140, 55);
        [mingzhong addSubview:imageLanMing];
        imageLanMing.tag = 301;
        
        UILabel *lanqiuLaMing=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 35, 15)];
        lanqiuLaMing.text=@"蓝球";
        lanqiuLaMing.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        lanqiuLaMing.backgroundColor=[UIColor clearColor];
        lanqiuLaMing.font=[UIFont systemFontOfSize:17];
        [imageLanMing addSubview:lanqiuLaMing];
        [lanqiuLaMing release];
        
        UILabel *geshuLanMing=[[UILabel alloc]initWithFrame:CGRectMake(45, 20, 33, 15)];
        geshuLanMing.text=@"0";
        geshuLanMing.tag = 112;
        geshuLanMing.textAlignment=NSTextAlignmentCenter;
        geshuLanMing.backgroundColor=[UIColor clearColor];
        geshuLanMing.font=[UIFont systemFontOfSize:18];
        geshuLanMing.textColor=[UIColor colorWithRed:0/255.0 green:91/255.0 blue:212/255.0 alpha:1];
        [imageLanMing addSubview:geshuLanMing];
        [geshuLanMing release];
        
        UILabel *geLabelLanMing=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 20, 15)];
        geLabelLanMing.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
        geLabelLanMing.text=@"个";
        geLabelLanMing.backgroundColor=[UIColor clearColor];
        geLabelLanMing.font=[UIFont systemFontOfSize:17];
        [imageLanMing addSubview:geLabelLanMing];
        [geLabelLanMing release];
        
        
        UIButton *geButtonLanMing=[[UIButton alloc]initWithFrame:imageLanMing.bounds];
        UIImageView *sanjiaoGeshuLanMing=[[UIImageView alloc]initWithFrame:CGRectMake(115, 24, 15, 10)];
        sanjiaoGeshuLanMing.image=UIImageGetImageFromName(@"upSanjiao.png");
        [geButtonLanMing addTarget:self action:@selector(touhonggeshu:) forControlEvents:UIControlEventTouchUpInside];
        geButtonLanMing.tag = 203;
        [geButtonLanMing addSubview:sanjiaoGeshuLanMing];
        geButtonLanMing.backgroundColor=[UIColor clearColor];
        [imageLanMing addSubview:geButtonLanMing];
        [geButtonLanMing release];
        [sanjiaoGeshuLanMing release];
        
        [imageLanMing release];
        
        
        [mingLabel release];
        
        
        UIButton *jisuan=[UIButton buttonWithType:UIButtonTypeCustom];
        jisuan.frame=CGRectMake(15, 312, 290, 40);
        
        UILabel *labelTitle=[[UILabel alloc]initWithFrame:jisuan.bounds];
        labelTitle.text=@"计算我的奖金";
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        labelTitle.backgroundColor=[UIColor clearColor];
        labelTitle.font=[UIFont systemFontOfSize:16];
        labelTitle.tag = 101;
        [jisuan addSubview:labelTitle];
        [jisuan setImage:UIImageGetImageFromName(@"jiangjin.png") forState:UIControlStateNormal];
        [jisuan setImage:UIImageGetImageFromName(@"jiangjinzhong.png") forState:UIControlStateHighlighted];
        [jisuan addTarget:self action:@selector(jisuanMoney) forControlEvents:UIControlEventTouchUpInside];
        jisuan.tag = 115;
        [viewDaletou addSubview:jisuan];
        
        
        [labelTitle release];
        [mingzhong release];
        [kaijiang release];
        [touzhu release];
        [viewDaletou release];
    }
    viewDaletou.hidden = NO;
    viewshuang.hidden = YES;
    if (![dataDic objectForKey:@"113"]) {
        [self.myHttpRequest clearDelegatesAndCancel];
        self.myHttpRequest = [ASIHTTPRequest requestWithURL:
                              [NetURL CBsynLotteryList:@"113"
                                                pageNo:@"1"
                                              pageSize:@"10"
                                                userId:[[Info getInstance] userId]]];
		
		[myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[myHttpRequest setDelegate:self];
		
		[myHttpRequest setDidFinishSelector:@selector(LoadingDaletou:)];
		[myHttpRequest setDidFailSelector:@selector(failselector:)];
		[myHttpRequest setNumberOfTimesToRetryOnTimeout:2];
		
		[myHttpRequest startAsynchronous];
    }
}

- (void)putong:(UIButton *)sender {
    sender.selected = YES;
    if (sender == putongButton) {
        zhujiaButton.selected = NO;
    }
    else {
        putongButton.selected = NO;

    }
    UILabel *thLabel = (UILabel *)[[[viewDaletou viewWithTag:400] viewWithTag:300] viewWithTag:112];
    UILabel *tlLabel = (UILabel *)[[[viewDaletou viewWithTag:400] viewWithTag:301] viewWithTag:112];
    
    NSInteger Zhushu = 0;
    if (monytype == monyTypeShuangSeQiu) {
        Zhushu = [GC_LotteryUtil combination:[thLabel.text intValue] :6] * [tlLabel.text intValue];
    }
    else if (monytype == monyTypeDaletou) {
        Zhushu = [GC_LotteryUtil combination:[thLabel.text intValue] :5] *[GC_LotteryUtil combination:[tlLabel.text intValue] :2];
        
    }
    UILabel *zhuLabel = (UILabel *)[[viewDaletou viewWithTag:400] viewWithTag:501];
    UILabel *Jinlabel = (UILabel *)[[viewDaletou viewWithTag:400] viewWithTag:502];
    Jinlabel.text = [NSString stringWithFormat:@"%ld注, %ld元",(long)Zhushu, (long)Zhushu *2];
    if (monyTypeDaletou == monytype && zhujiaButton.selected) {
        Jinlabel.text = [NSString stringWithFormat:@"%ld注, %ld元",(long)Zhushu, (long)Zhushu *3];
    }
    Jinlabel.frame = CGRectMake(290 - [Jinlabel.text sizeWithFont:Jinlabel.font].width, 5, [Jinlabel.text sizeWithFont:Jinlabel.font].width, 20);
    zhuLabel.frame = CGRectMake(Jinlabel.frame.origin.x - 40, 5, 100, 20);
    if (putongButton.selected) {
        putongImg.image = UIImageGetImageFromName(@"xuanzhong.png");
        zhujiaImag.image=UIImageGetImageFromName(@"weixuan.png");
    }
    else {
        zhujiaImag.image = UIImageGetImageFromName(@"xuanzhong.png");
        putongImg.image=UIImageGetImageFromName(@"weixuan.png");

    }
}

-(void)qici
{
    NSMutableArray *array = nil;
    if (monytype == monyTypeShuangSeQiu) {
        array = [self.dataDic valueForKey:@"001"];
    }
    else if (monytype == monyTypeDaletou) {
        array = [self.dataDic valueForKey:@"113"];
    }
    NSMutableArray *array2 = [NSMutableArray array];
    for (int i = 0; i < [array count] && i < 10; i ++) {
        LotteryList *liset = [array objectAtIndex:i];
        [array2 addObject:liset.issue];
    }
    if ([array2 count]) {
        CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"期次选择" withChuanNameArray:array2 andChuanArray:nil];
        alert2.duoXuanBool = NO;
        alert2.delegate = self;
        alert2.tag = 100;
        [alert2 show];
        UIView *backView = nil;
        if (monytype == monyTypeShuangSeQiu) {
            backView = viewshuang;
        }
        else if (monytype == monyTypeDaletou) {
            backView = viewDaletou;
        }
        UILabel *label = (UILabel *)[backView viewWithTag:2222];
        for (CP_XZButton *btn in alert2.backScrollView.subviews) {
            if ([btn isKindOfClass:[CP_XZButton class]]) {
                if ([label.text rangeOfString:btn.buttonName.text].location != NSNotFound) {
                    btn.selected = YES;
                }
            }
        }
        [alert2 release];
    }
}

#pragma mark -
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
    if (chooseView.tag == 100) {
        if (buttonIndex == 1) {
            NSArray *array = nil;
            if (monytype == monyTypeShuangSeQiu) {
                array = [self.dataDic objectForKey:@"001"];

            }
            else if (monytype == monyTypeDaletou) {
                array = [self.dataDic objectForKey:@"113"];
            }
            for (LotteryList *list in array) {
                if ([list.issue isEqualToString:[returnarry firstObject]]) {
                    [self resetNumWithIndex:[array indexOfObject:list]];
                    break;
                }
            }
        }
    }
}

-(void)jisuanMoney
{
    NSString *lotterid = @"001";
    UIView *backView = nil;
    NSString *playtype = @"1";
    if (zhujiaButton.selected) {
        playtype = @"2";
    }
    if (monytype == monyTypeShuangSeQiu) {
        lotterid = @"001";
        backView = viewshuang;
        if (shuangseqiuQici == 0 && !isShuangSeQiuKaichu) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"在官方公布各奖级之前不能计算当期奖金可计算往期奖金"];
            return;
        }
        
    }
    else if (monytype == monyTypeDaletou) {
        lotterid = @"113";
        backView = viewDaletou;
        if (daletouQici == 0 && !isDaleTouKaiChu) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"在官方公布各奖级之前不能计算当期奖金可计算往期奖金"];
            return;
        }
    }
    UILabel *thLabel = (UILabel *)[[[backView viewWithTag:400] viewWithTag:300] viewWithTag:112];
    UILabel *tlLabel = (UILabel *)[[[backView viewWithTag:400] viewWithTag:301] viewWithTag:112];
    UILabel *zhLabel = (UILabel *)[[[backView viewWithTag:401] viewWithTag:300] viewWithTag:112];
    UILabel *zlLabel = (UILabel *)[[[backView viewWithTag:401] viewWithTag:301] viewWithTag:112];
    UILabel *label = (UILabel *)[backView viewWithTag:2222];
    if (![label.text length]) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"获取期次失败"];
        return;
    }
    [self.myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = [ASIHTTPRequest requestWithURL:
                          [NetURL JiangJinJiSuanWithlotteryid:lotterid t_h:thLabel.text t_l:tlLabel.text z_h:zhLabel.text z_l:zlLabel.text playtype:playtype issue:[label.text stringByReplacingOccurrencesOfString:@" 期" withString:@""]]];
    
    [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [myHttpRequest setDelegate:self];
    
    [myHttpRequest setDidFinishSelector:@selector(JiangjInBack:)];
    [myHttpRequest setDidFailSelector:@selector(failselector:)];
    [myHttpRequest setNumberOfTimesToRetryOnTimeout:2];
    
    [myHttpRequest startAsynchronous];
}


//- (void)touchxibutton:(UIButton *)sender{
//    
//    if (sender.tag == 1) {
//        labelshuang.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
//    }
//    else
//    {
//         labeDa.textColor=[UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:1];
//    }
//    
//}
//
//- (void)TouchCancel:(UIButton *)sender{
//    if (sender.tag == 1) {
//        labelshuang.textColor=[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1];
//    }
//    if (sender.tag == 2) {
//        labeDa.textColor=[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1];
//    }
//    
//}
//
//- (void)TouchDragExit:(UIButton *)sender{
//    if (sender.tag == 1) {
//        labelshuang.textColor=[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1];
//    }
//    if (sender.tag == 2) {
//        labeDa.textColor=[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1];
//    }
//    
//}
//
-(void)dealloc
{
    [self.infoHttpRequest clearDelegatesAndCancel];
    self.infoHttpRequest = nil;
    [self.infoHttpRequest2 clearDelegatesAndCancel];
    self.infoHttpRequest2 = nil;
    [self.myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = nil;
    self.lottoryID = nil;
    self.dataDic = nil;
    self.isShuangSeQiuKaichu = nil;
    self.isDaleTouKaiChu = nil;
    self.shuangseqiuQici = nil;
    self.daletouQici = nil;
    [putongImg release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetNumWithIndex:(NSInteger) index {
    NSArray *array = nil;
    UIView *backView = nil;
    if (monytype == monyTypeShuangSeQiu) {
        array = [self.dataDic objectForKey:@"001"];
        backView = viewshuang;
        shuangseqiuQici = index;
    }
    else if (monytype == monyTypeDaletou) {
        array = [self.dataDic objectForKey:@"113"];
        backView = viewDaletou;
        daletouQici = index;
    }
    
    UIButton *btn = (UIButton *)[backView viewWithTag:115];
    UILabel *btnLable = (UILabel *)[btn viewWithTag:101];
    if (index == 0) {
        if (monytype == monyTypeDaletou && !isDaleTouKaiChu) {
            [btn setImage:UIImageGetImageFromName(@"jiangjindis.png") forState:UIControlStateNormal];
            [btn setImage:nil forState:UIControlStateHighlighted];
            btnLable.text=@"官方奖金未公布不能计算";
            btnLable.textColor=[UIColor darkGrayColor];
        }
        else if (monytype == monyTypeShuangSeQiu && !isShuangSeQiuKaichu) {
            [btn setImage:UIImageGetImageFromName(@"jiangjindis.png") forState:UIControlStateNormal];
            [btn setImage:nil forState:UIControlStateHighlighted];
            btnLable.text=@"官方奖金未公布不能计算";
            btnLable.textColor=[UIColor darkGrayColor];
        }
        else {
            [btn setImage:UIImageGetImageFromName(@"jiangjin.png") forState:UIControlStateNormal];
            [btn setImage:UIImageGetImageFromName(@"jiangjinzhong.png") forState:UIControlStateHighlighted];
            btnLable.text=@"计算我的奖金";
            btnLable.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        }
    }
    else {
        [btn setImage:UIImageGetImageFromName(@"jiangjin.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"jiangjinzhong.png") forState:UIControlStateHighlighted];
        btnLable.text=@"计算我的奖金";
        btnLable.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    }
    LotteryList *ls = [array objectAtIndex:index];
    NSString *qiustring = ls.lotteryNumber;
    UILabel *label = (UILabel *)[backView viewWithTag:2222];
    label.text = [NSString stringWithFormat:@"%@ 期",ls.issue];
    UIView * qiubgimage = [backView viewWithTag:1111];
    if (!qiubgimage) {
        qiubgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 33, 300, 49)];
        qiubgimage.tag = 1111;
        qiubgimage.backgroundColor = [UIColor clearColor];
        [backView addSubview:qiubgimage];
        [qiubgimage release];
    }
    for (UIView *subview in qiubgimage.subviews) {
        [subview removeFromSuperview];
    }
    
    NSArray * testqian1 = [qiustring componentsSeparatedByString:@"+"];
    if ([testqian1 count] < 2) {
        testqian1 = [NSArray arrayWithObjects:@"",@"", nil];
    }
    NSArray *testqian2 = [[testqian1 objectAtIndex:0] componentsSeparatedByString:@","];
    NSArray *testqian3 = [[testqian1 objectAtIndex:1] componentsSeparatedByString:@","];
    for (int  i = 0;  i < [testqian2 count]+[testqian3 count]; i++) {
        
        UIImageView *qiuview = [[UIImageView alloc] init];
        qiuview.frame = CGRectMake(0, 0, 24, 24);
        UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 22, 22)];
        
        nLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        nLabel.textAlignment = NSTextAlignmentCenter;
        nLabel.highlightedTextColor = [UIColor whiteColor];
        nLabel.highlighted = YES;
        nLabel.backgroundColor = [UIColor clearColor];
        [qiuview addSubview:nLabel];
        [nLabel release];
        
        if (i < [testqian2 count]) {
            qiuview.image = UIImageGetImageFromName(@"hongqiu.png");
            nLabel.text = [testqian2 objectAtIndex:i];
            qiuview.center = CGPointMake(18+i*25, 12);
        }else{
            qiuview.image = UIImageGetImageFromName(@"lanqiu.png");
            nLabel.text = [testqian3 objectAtIndex:i - [testqian2 count]];
            qiuview.frame =CGRectMake(210 -  ([testqian2 count]+[testqian3 count] - i)*26, 0, 24, 24);
        }
        
        [qiubgimage addSubview:qiuview];
        [qiuview release];
        
    }
}

#pragma mark HTTPDelegate

- (void)LoadingShuangSeQiuHuaTi:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
	
	NSLog(@"responseString = %@\n", responseString);
    NSDictionary *dic = [responseString JSONValue];
    if ([[dic objectForKey:@"reList"] count] != 0) {
        isShuangSeQiuKaichu = YES;
    }
    else {
        isShuangSeQiuKaichu = NO;
    }
    UIView *backView = nil;
    if (monytype == monyTypeShuangSeQiu) {
        backView = viewshuang;
    }
    else if (monytype == monyTypeDaletou) {
        backView = viewDaletou;
    }
    
    UIButton *btn = (UIButton *)[backView viewWithTag:115];
    UILabel *btnLable = (UILabel *)[btn viewWithTag:101];
    if (shuangseqiuQici == 0) {
        if (monytype == monyTypeShuangSeQiu && !isShuangSeQiuKaichu) {
            [btn setImage:UIImageGetImageFromName(@"jiangjindis.png") forState:UIControlStateNormal];
            [btn setImage:nil forState:UIControlStateHighlighted];
            btnLable.text=@"官方奖金未公布不能计算";
            btnLable.textColor=[UIColor darkGrayColor];
        }
    }
}

- (void)LoadingShuangSeQiu:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
	
	NSLog(@"responseString = %@\n", responseString);
   	
	if (responseString != nil) {
		
		LotteryList *lList = [[LotteryList alloc] initWithParse: responseString];
		
		//self.lotteryList = lList;
		
		if (!self.dataDic) {
            self.dataDic = [NSMutableDictionary dictionary];
        }
        [self.dataDic setValue:lList.reListArray forKey:@"001"];
        [self.infoHttpRequest clearDelegatesAndCancel];
        self.infoHttpRequest = nil;
        self.infoHttpRequest = [ASIHTTPRequest requestWithURL:
                                [NetURL cpthreeKaiJiangHuaTiLotteryId:@"001" userid:[[Info getInstance] userId] pageSize:@"5" PageNum:@"1" issue:[lList.reListArray firstObject] themeName:@""]];
		
		[infoHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[infoHttpRequest setDelegate:self];
		
		[infoHttpRequest setDidFinishSelector:@selector(LoadingShuangSeQiuHuaTi:)];
		[infoHttpRequest setDidFailSelector:@selector(failselector:)];
		[infoHttpRequest setNumberOfTimesToRetryOnTimeout:2];
		
		[infoHttpRequest startAsynchronous];
        
        if ([lList.reListArray count]) {
            [self resetNumWithIndex:0];
        }
        		[lList release];
        
	}
    
}

- (void)JiangjInBack:(ASIHTTPRequest *)request {
    NSDictionary *dic = [[request responseString] JSONValue];
    NSString *qici = [dic objectForKey:@"issue"];
//    NSArray *array = nil;
    UIView *backView =nil;
    if (monytype == monyTypeShuangSeQiu) {
//        array = [self.dataDic objectForKey:@"001"];
        backView = viewshuang;
    }
    else if (monytype == monyTypeDaletou) {
//        array = [self.dataDic objectForKey:@"113"];
        backView = viewDaletou;
    }
    UILabel *label = (UILabel *)[backView viewWithTag:2222];
    if (label.text && ![label.text isEqualToString:[NSString stringWithFormat:@"%@ 期",qici]]) {
        if (monytype == monyTypeShuangSeQiu) {
            isShuangSeQiuKaichu = NO;
        }
        else if (monytype == monyTypeDaletou) {
            isDaleTouKaiChu = NO;
        }
        [self resetNumWithIndex:0];
        [[caiboAppDelegate getAppDelegate] showMessage:@"在官方公布各奖级之前不能计算当期奖金可计算往期奖金"];
        return;
    }
    
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic removeObjectForKey:@"7_award"];
    [mutableDic removeObjectForKey:@"8_award"];
    [mutableDic removeObjectForKey:@"7_num"];
    [mutableDic removeObjectForKey:@"8_num"];
    
    JiangJinJiSuanView *alert = [[JiangJinJiSuanView alloc] init];
    alert.lottoryID = self.lottoryID;
    alert.dataDic = mutableDic;
    [alert show];
    [alert release];
}

- (void)LoadingDaleTouHuaTi:(ASIHTTPRequest *)request {
    NSDictionary *dic = [[request responseString] JSONValue];
    if ([[dic objectForKey:@"reList"] count] != 0) {
        isDaleTouKaiChu = YES;
    }
    else {
        isDaleTouKaiChu = NO;
    }
    UIView *backView = nil;
    if (monytype == monyTypeShuangSeQiu) {
        backView = viewshuang;
    }
    else if (monytype == monyTypeDaletou) {
        backView = viewDaletou;
    }
    
    UIButton *btn = (UIButton *)[backView viewWithTag:115];
    UILabel *btnLable = (UILabel *)[btn viewWithTag:101];
    if (daletouQici == 0) {
        if (monytype == monyTypeDaletou && !isDaleTouKaiChu) {
            [btn setImage:UIImageGetImageFromName(@"jiangjindis.png") forState:UIControlStateNormal];
            [btn setImage:nil forState:UIControlStateHighlighted];
            btnLable.text=@"官方奖金未公布不能计算";
            btnLable.textColor=[UIColor darkGrayColor];
        }
    }
}

- (void)LoadingDaletou:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
	
	NSLog(@"responseString = %@\n", responseString);
   	
	if (responseString != nil) {
		
		LotteryList *lList = [[LotteryList alloc] initWithParse: responseString];
		
		//self.lotteryList = lList;
		
		if (!self.dataDic) {
            self.dataDic = [NSMutableDictionary dictionary];
        }
        [self.dataDic setValue:lList.reListArray forKey:@"113"];
        LotteryList *lList2 = [lList.reListArray firstObject];
        
        [self.infoHttpRequest2 clearDelegatesAndCancel];
        self.infoHttpRequest2 = nil;
        self.infoHttpRequest2 = [ASIHTTPRequest requestWithURL:
                                [NetURL cpthreeKaiJiangHuaTiLotteryId:@"113" userid:[[Info getInstance] userId] pageSize:@"5" PageNum:@"1" issue:lList2.issue themeName:@""]];
		
		[infoHttpRequest2 setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[infoHttpRequest2 setDelegate:self];
		
		[infoHttpRequest2 setDidFinishSelector:@selector(LoadingDaleTouHuaTi:)];
		[infoHttpRequest2 setDidFailSelector:@selector(failselector:)];
		[infoHttpRequest2 setNumberOfTimesToRetryOnTimeout:2];
		
		[infoHttpRequest2 startAsynchronous];
        
        if ([lList.reListArray count]) {
            [self resetNumWithIndex:0];
        }
        [lList release];
        //		[myTableView reloadData];
        
	}
}

#pragma mark CP_NumDelegate
- (void)CP_NumOfChooseView:(CP_NumOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (chooseView.inputLable && [chooseView.inputLable isKindOfClass:[UILabel class]]) {
            for (CP_PTButton *btn in chooseView.backScrollView.subviews) {
                if ([btn isKindOfClass:[CP_PTButton class]] && btn.selected) {
                    [(UILabel *)chooseView.inputLable setText:btn.buttonName.text];
                    btn.buttonName.textColor = [UIColor whiteColor];
                    break;
                }
            }
            UIView *backView = nil;
//            NSString *playtype = @"1";
//            if (zhujiaButton.selected) {
//                playtype = @"2";
//            }
            if (monytype == monyTypeShuangSeQiu) {
                backView = viewshuang;
            }
            else if (monytype == monyTypeDaletou) {
                backView = viewDaletou;
            }
            UILabel *thLabel = (UILabel *)[[[backView viewWithTag:400] viewWithTag:300] viewWithTag:112];
            UILabel *tlLabel = (UILabel *)[[[backView viewWithTag:400] viewWithTag:301] viewWithTag:112];
            if (chooseView.inputLable == thLabel || chooseView.inputLable == tlLabel) {
                
                NSInteger Zhushu = 0;
                if (monytype == monyTypeShuangSeQiu) {
                    Zhushu = [GC_LotteryUtil combination:[thLabel.text intValue] :6] * [tlLabel.text intValue];
                }
                else if (monytype == monyTypeDaletou) {
                    Zhushu = [GC_LotteryUtil combination:[thLabel.text intValue] :5] *[GC_LotteryUtil combination:[tlLabel.text intValue] :2];
                    
                }
                UILabel *zhuLabel = (UILabel *)[[backView viewWithTag:400] viewWithTag:501];
                UILabel *Jinlabel = (UILabel *)[[backView viewWithTag:400] viewWithTag:502];
                Jinlabel.text = [NSString stringWithFormat:@"%ld注, %ld元",(long)Zhushu, (long)Zhushu *2];
                if (monyTypeDaletou == monytype && zhujiaButton.selected) {
                    Jinlabel.text = [NSString stringWithFormat:@"%ld注, %ld元",(long)Zhushu, (long)Zhushu *3];
                }
                Jinlabel.frame = CGRectMake(290 - [Jinlabel.text sizeWithFont:Jinlabel.font].width, 5, [Jinlabel.text sizeWithFont:Jinlabel.font].width, 20);
                zhuLabel.frame = CGRectMake(Jinlabel.frame.origin.x - 40, 5, 100, 20);
            }
            
        }
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    