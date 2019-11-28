//
//  GouCaiShuZiInfoViewController.m
//  caibo
//
//  Created by yao on 12-5-16.
//  Copyright 2012 第一视频. All rights reserved.
//
#import "GouCaiShuZiInfoViewController.h"
#import "Info.h"
#import "GC_LotteryUtil.h"
#import "GC_BuyLottery.h"
#import "NSStringExtra.h"
#import "GC_UserInfo.h"
#import "caiboAppDelegate.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "ProvingViewCotroller.h"
#import "GCHeMaiSendViewController.h"
#import "GC_IssueInfo.h"
#import "ShuangSeQiuInfoViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "HighFreqViewController.h"
#import "DaLeTouViewController.h"
#import "FuCai3DViewController.h"
#import "PaiWuOrQiXingViewController.h"
#import "IssueObtain.h"
#import "Pai3ViewController.h"
#import "QIleCaiViewController.h"
#import "ChongZhiData.h"
#import "MaxIssueData.h"
#import "HappyTenViewController.h"
#import "KuaiSanViewController.h"
#import "GC_TopUpViewController.h"
#import "GC_UPMPViewController.h"
#import "PassWordView.h"
#import "TestViewController.h"
#import "PWInfoViewController.h"
#import "CP_TouZhuAlert.h"
#import "KuaiLePuKeViewController.h"
#import "KuaiSanTuiJianViewCotroller.h"
#import "LoginViewController.h"
#import "SharedMethod.h"
#import "GC_FangChenMiParse.h"
#import "LuckyChoseViewController.h"
#import "CQShiShiCaiViewController.h"
#import "ShiShiCaiViewController.h"
#import "SharedDefine.h"
#import "MobClick.h"
#import "Xieyi365ViewController.h"

@interface GouCaiShuZiInfoViewController (PrivateMethods)
- (void)getBuyLotteryRequest;
- (void)getBettingInfo;
@end

@implementation GouCaiShuZiInfoViewController
@synthesize maxrequst;
@synthesize dataArray;
@synthesize lotteryType;
@synthesize modeType;
@synthesize httpRequest;
@synthesize goucaishuziinfotype;
@synthesize betInfo;
@synthesize isHeMai;
@synthesize canBack;
@synthesize ahttpRequest;
@synthesize counthttpRequest;
@synthesize sysIssure;
@synthesize maxIssueCount, passWord;
@synthesize issuearr;
@synthesize danzhujiangjin;
@synthesize buyResult;
#pragma mark -
#pragma mark Initialization

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

- (void)clearBetArray {
    [self.dataArray removeAllObjects];
    [btn4 removeTarget:self action:@selector(calculateFunc) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
    //        [btn4 setImage:UIImageGetImageFromName(@"TZ960.png") forState:UIControlStateNormal];œ
//    btn4bg.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    btn4bg.image = [UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    
    zhuiTextStr = 0;
    zhuiLable.text = @"追号设置";
    [issuearr removeAllObjects];
    [betInfo.betlist removeAllObjects];
    dobackbool = NO;
    multipleTF.text = @"1";
    multiBtn.enabled = YES;
    addbutton.enabled = YES;
    jianbutton.enabled = YES;
    
}

- (void)returnPop:(NSMutableArray *)gcbet{
    
    [betInfo.betlist removeAllObjects];
    [betInfo.betlist addObjectsFromArray:gcbet];
    //    if ([gcbet count] > 1) {
    //        GC_BetInfo * bet = [gcbet objectAtIndex:0];
    ////        zhuiTextStr = [NSString stringWithFormat:@"%d", bet.beishu ];
    //    }
    
    
    
    
    // betInfo.betlist = gcbet;
    [self updateData];
    dobackbool = NO;
    NSLog(@"betinfo = %@", betInfo.betlist);
    //[betInfo.betlist removeAllObjects];
}

- (void)returnBetInfoData:(GC_BetInfo *)gcbetinfo{
    [gckeyView dissKeyFunc];
     multipleTF.textColor = [UIColor blackColor];
    [self keydis];
    betInfo = gcbetinfo;
    NSLog(@"betinfolist = %@", betInfo.betlist);
    
    
    
    NSMutableArray * numArray = [[[NSMutableArray alloc] init] autorelease];
    for (NSString * str in betInfo.betlist) {
        [numArray addObject:[[str componentsSeparatedByString:@":"] objectAtIndex:1]];
    }
    for (NSString * str in numArray) {
        if (![str isEqualToString:[numArray objectAtIndex:0]]) {
            same = NO;
            break;
        }
        same = YES;
    }
    
    
    if ([betInfo.betlist count] == 1) {
        [btn4 removeTarget:self action:@selector(calculateFunc) forControlEvents:UIControlEventTouchUpInside];
        [btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
        //        [btn4 setImage:UIImageGetImageFromName(@"TZ960.png") forState:UIControlStateNormal];
//------------------------------------------------bianpinghua by sichuanlin
//        btn4bg.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        btn4bg.image = [UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//        btn4bg.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:200.0/255.0 blue:50.0/255.0 alpha:1];
//        btn4bg.image = [UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        btn4bg.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:200.0/255.0 blue:50.0/255.0 alpha:1];
        zhuiTextStr = 0;
        zhuiLable.text = @"追号设置";
        
        
        //        label4.hidden = NO;
        //        textbgimage.hidden = NO;
        //        multipleTF.hidden = NO;
        //        addbutton.hidden = NO;
        //        jianbutton.hidden = NO;
        multiBtn.enabled = YES;
        addbutton.enabled = YES;
        jianbutton.enabled = YES;
        dobackbool = NO;
    }else if(same == YES){
        
        multiBtn.enabled = YES;
        addbutton.enabled = YES;
        jianbutton.enabled = YES;
    }else{
        dobackbool = YES;
        
        
        multiBtn.enabled = NO;
        addbutton.enabled = NO;
        jianbutton.enabled = NO;
        
    }
    if ([betInfo.betlist count] >= 1) {
        NSString * betstring = [betInfo.betlist objectAtIndex:0] ;
        NSArray * strarr = [betstring componentsSeparatedByString:@":"];
        if (strarr.count > 1) {
                multipleTF.text = [strarr objectAtIndex:1];
        }

    }
    
    if (betInfo.zhuihaoType == 0) {
        isTingZhui = YES;
    }else{
        isTingZhui = NO;
    }
    zhuiTextStr = [betInfo.betlist count]-1;
    //   zhuiLable.text = [NSString stringWithFormat:@"追号%d期", zhuiTextStr];
    //     btn4bg.image = [UIImageGetImageFromName(@"FQHMAN960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    if (zhuiTextStr > 0) {
//        btn4bg.image = [UIImageGetImageFromName(@"FQHMAN960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        btn4bg.image = [UIImageGetImageFromName(@"zhuceanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        zhuiLable.text = [NSString stringWithFormat:@"追号%d期", (int)zhuiTextStr];
        multiBtn.enabled = NO;
        addbutton.enabled = NO;
        jianbutton.enabled = NO;
    }
    [self updateData];
    
}

- (id)init {
	self = [super init];
	if (self) {
		self.dataArray = [NSMutableArray array];
		betInfo = [[GC_BetInfo alloc] init];
		maxMultiple = 10000;
		betInfo.lotteryType = TYPE_SHUANGSEQIU;
		betInfo.caizhong = @"001";
		betInfo.wanfa = @"00";
		betInfo.modeType = Shuangseqiufushi;
		betInfo.zhuihaoType = 0;
		betInfo.stopMoney = @"0";
		zhuihaoCount = 1;
		isTingZhui = YES;
		isHeMai = NO;
        canBack = YES;
        isGoBuy = NO;
//        danzhuJiangjin = @"";
        maxIssueCount = 120;
//        issuearr = [[NSMutableArray alloc] initWithCapacity:0];
        
	}
	return self;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	if ([textField.text intValue]>maxMultiple/10 && [string length]) {
        //		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //		[cai showMessage:[NSString stringWithFormat:@"最大支持%d倍",maxMultiple]];
		return NO;
	}
	[self performSelector:@selector(updateData) withObject:nil afterDelay:0.1];
	return YES;
}

#pragma mark -
#pragma mark Action

- (void)setModeType:(ModeTYPE)_modeType
{
    modeType = _modeType;
    betInfo.modeType = _modeType;
    NSString *wanfa = [GC_LotteryType changeLotteryTYPEToWanfa:lotteryType modeType:modeType];
    if ([wanfa length]) {
        betInfo.wanfa = wanfa;
    }
}

- (void)setLotteryType:(LotteryTYPE)_lotteryType {
	lotteryType = _lotteryType;
	betInfo.lotteryType = _lotteryType;
    NSString *caizhong = [GC_LotteryType lotteryIDWithLotteryType:lotteryType];
    if ([caizhong length]) {
        betInfo.caizhong = caizhong;
        betInfo.lotteryId = betInfo.caizhong;
    }
    
}


- (void)goback {
    if ([self.dataArray count] == 0) {
        if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 2] isKindOfClass:[KuaiSanTuiJianViewCotroller class]]) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 3] animated:YES];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"是否保存投注号码" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"保存",nil];
        alert.tag =  2315;
        [alert show];
        [alert release];
    }
    
}

- (void)goRoot {
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)addPutong {
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[ShuangSeQiuInfoViewController class]] || [[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[LuckyChoseViewController class]]) {
        if (betInfo.lotteryType == TYPE_SHUANGSEQIU) {
            GouCaiShuangSeQiuViewController *shuangViewController = [[GouCaiShuangSeQiuViewController alloc] init];
            shuangViewController.item = self.betInfo.issue;
            if (self.modeType == Shuangseqiudantuo) {
                shuangViewController.shuangsheqiuType = ShuangSheQiuTypeDantuo;
            }
            
            //shuangViewController.navigationController.title = @"双色球";
            [self.navigationController pushViewController:shuangViewController animated:YES];
            [shuangViewController.CP_navigation setHidesBackButton:YES];
            [shuangViewController release];
        }
        else if (lotteryType == TYPE_3D) {
            FuCai3DViewController *fu = [[FuCai3DViewController alloc] initWithModeType:modeType];
            [self.navigationController pushViewController:fu animated:YES];
            [fu.CP_navigation setHidesBackButton:YES];
            [fu release];
        }
        else if (lotteryType == TYPE_DALETOU) {
            DaLeTouViewController *da = [[DaLeTouViewController alloc] init];
            if (modeType == Daletoudantuo) {
                da.daleTouType = DaleTouTypeDantuo;
            }
            else {
                da.daleTouType = DaleTouTypePuTong;
            }
            [da.CP_navigation setHidesBackButton:YES];
            [self.navigationController pushViewController:da animated:YES];
            
            [da release];
        }
        else if(lotteryType == TYPE_PAILIE5){
            PaiWuOrQiXingViewController * PaiWu = [[PaiWuOrQiXingViewController alloc] init];
            PaiWu.qixingorpaiwu = shuZiCaiPaiWu;
            [PaiWu.CP_navigation setHidesBackButton:YES];
            [self.navigationController pushViewController:PaiWu animated:YES];
            
            [PaiWu release];
        }
        else if(lotteryType == TYPE_7LECAI){
            QIleCaiViewController * qile = [[QIleCaiViewController alloc] init];
            if (self.modeType == Qilecaidantuo) {
                qile.qilecaiType = QileCaiTypeDantuo;
            }
            else {
                qile.qilecaiType = QileCaiTypePuTong;
            }
            
            [qile.CP_navigation setHidesBackButton:YES];
            [self.navigationController pushViewController:qile animated:YES];
            
            [qile release];
        }
        else if(lotteryType == TYPE_QIXINGCAI){
            PaiWuOrQiXingViewController * PaiWu = [[PaiWuOrQiXingViewController alloc] init];
            PaiWu.qixingorpaiwu = shuZiCaiQiXing;
            [PaiWu.CP_navigation setHidesBackButton:YES];
            [self.navigationController pushViewController:PaiWu animated:YES];
            
            [PaiWu release];
        }
        else if(goucaishuziinfotype == GouCaiShuZiInfoTypeShiXuanWu) {
            HighFreqViewController * hig = [[[HighFreqViewController alloc] initWithElevenType:ShanDong11] autorelease];
            hig.lotterytype = self.lotteryType;
            [self.navigationController pushViewController:hig animated:YES];
            [hig.CP_navigation setHidesBackButton:YES];
        }
        else if(goucaishuziinfotype == GouCaiShuZiInfoTypeGDShiXuanWu) {
            HighFreqViewController * hig = [[[HighFreqViewController alloc] initWithElevenType:GuangDong11] autorelease];
            hig.lotterytype = self.lotteryType;
            [self.navigationController pushViewController:hig animated:YES];
            [hig.CP_navigation setHidesBackButton:YES];
        }
        else if(goucaishuziinfotype == GouCaiShuZiInfoTypeJXShiXuanWu) {
            HighFreqViewController * hig = [[[HighFreqViewController alloc] initWithElevenType:JiangXi11] autorelease];
            hig.lotterytype = self.lotteryType;
            [self.navigationController pushViewController:hig animated:YES];
            [hig.CP_navigation setHidesBackButton:YES];
        }
        else if(goucaishuziinfotype == GouCaiShuZiInfoTypeHBShiXuanWu) {
            HighFreqViewController * hig = [[[HighFreqViewController alloc] initWithElevenType:HeBei11] autorelease];
            hig.lotterytype = self.lotteryType;
            [self.navigationController pushViewController:hig animated:YES];
            [hig.CP_navigation setHidesBackButton:YES];
        }
        else if(goucaishuziinfotype == GouCaiShuZiInfoTypeShanXiShiXuanWu) {
            HighFreqViewController * hig = [[[HighFreqViewController alloc] initWithElevenType:ShanXi11] autorelease];
            hig.lotterytype = self.lotteryType;
            [self.navigationController pushViewController:hig animated:YES];
            [hig.CP_navigation setHidesBackButton:YES];
        }
        else if (goucaishuziinfotype == GouCaiShuZiInfoTypeShiShiCai) {
            ShiShiCaiViewController *happy = [[ShiShiCaiViewController alloc] init];
            happy.lotterytype = self.lotteryType;
            happy.modetype = self.modeType;
            [self.navigationController pushViewController:happy animated:YES];
            [happy release];
        }
        else if (goucaishuziinfotype == GouCaiShuZiInfoTypeCQShiShiCai) {
            CQShiShiCaiViewController *cq = [[CQShiShiCaiViewController alloc] init];
            cq.lotterytype = self.lotteryType;
            cq.modetype = self.modeType;
            [self.navigationController pushViewController:cq animated:YES];
            [cq release];
        }
        else if (goucaishuziinfotype ==GouCaiShuZiInfoTypePaiLie3) {
            Pai3ViewController *pai3 = [[Pai3ViewController alloc] initWithModetype:self.betInfo.modeType];
            pai3.lotteryType = self.lotteryType;
            [self.navigationController pushViewController:pai3 animated:YES];
            [pai3.CP_navigation setHidesBackButton:YES];
            [pai3 release];
        }
        else if (goucaishuziinfotype == GouCaiShuZiInfoTypeHappyTen) {
            HappyTenViewController *happye = [[HappyTenViewController alloc] init];
            happye.lotterytype = self.lotteryType;
            happye.modetype = self.betInfo.modeType;
            [self.navigationController pushViewController:happye animated:YES];
            [happye.CP_navigation setHidesBackButton:YES];
            [happye release];
        }
        else if (goucaishuziinfotype == GouCaiShuZiInfoTypeKuaiSan) {
            KuaiSanViewController *kuai3 = [[KuaiSanViewController alloc] initWithType:NeiMengKuaiSan];
            kuai3.lotterytype = self.lotteryType;
            kuai3.modetype = self.betInfo.modeType;
            [self.navigationController pushViewController:kuai3 animated:YES];
            [kuai3.CP_navigation setHidesBackButton:YES];
            [kuai3 release];
        }
        else if (goucaishuziinfotype == GouCaiShuZiInfoTypeKuaiLePuke) {
            KuaiLePuKeViewController *puke = [[KuaiLePuKeViewController alloc] init];
            puke.lotterytype = self.lotteryType;
            puke.modetype = self.betInfo.modeType;
            [self.navigationController pushViewController:puke animated:YES];
            [puke.CP_navigation setHidesBackButton:YES];
            [puke release];
        }
        
    }
    else if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[KuaiSanTuiJianViewCotroller class]]) {
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count] - 3] animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)getBetNumber
{
    NSString *separator = @"%";
    
    if (betInfo.lotteryType == TYPE_QIXINGCAI) {
        
        betInfo.caizhong = @"110";
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
        //betInfo.betNumber = [betInfo.betNumber stringByReplacingOccurrencesOfString:@"*" withString:@","];
        
    }else if(betInfo.lotteryType == TYPE_PAILIE5){
        betInfo.caizhong = @"109";
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
        //betInfo.betNumber = [betInfo.betNumber stringByReplacingOccurrencesOfString:@"*" withString:@","];
    }
    else if (betInfo.lotteryType == TYPE_SHUANGSEQIU) {
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
    }
    else if (betInfo.lotteryType >= TYPE_11XUAN5_1 && betInfo.lotteryType <= TYPE_11XUAN5_Q3DaTuo) {
        NSMutableArray *myarray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [dataArray count]; i++) {
            [myarray addObject:[[dataArray objectAtIndex:i] objectForKey:@"Num"]];
        }
        betInfo.betNumber = [myarray componentsJoinedByString:separator];
        [myarray release];
    }
    else if (betInfo.lotteryType >= TYPE_HB11XUAN5_1 && betInfo.lotteryType <= TYPE_HB11XUAN5_Q3DaTuo) {
        NSMutableArray *myarray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [dataArray count]; i++) {
            [myarray addObject:[[dataArray objectAtIndex:i] objectForKey:@"Num"]];
        }
        betInfo.betNumber = [myarray componentsJoinedByString:separator];
        [myarray release];
    }
    else if (betInfo.lotteryType >= TYPE_GD11XUAN5_1 && betInfo.lotteryType <= TYPE_GD11XUAN5_Q3DaTuo) {
        NSMutableArray *myarray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [dataArray count]; i++) {
            [myarray addObject:[[dataArray objectAtIndex:i] objectForKey:@"Num"]];
        }
        betInfo.betNumber = [myarray componentsJoinedByString:separator];
        [myarray release];
    }
    else if (betInfo.lotteryType >= TYPE_JX11XUAN5_1 && betInfo.lotteryType <= TYPE_JX11XUAN5_Q3DaTuo) {
        NSMutableArray *myarray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [dataArray count]; i++) {
            [myarray addObject:[[dataArray objectAtIndex:i] objectForKey:@"Num"]];
        }
        betInfo.betNumber = [myarray componentsJoinedByString:separator];
        [myarray release];
    }
    else if (betInfo.lotteryType >= TYPE_ShanXi11XUAN5_1 && betInfo.lotteryType <= TYPE_ShanXi11XUAN5_Q3DaTuo) {
        NSMutableArray *myarray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [dataArray count]; i++) {
            [myarray addObject:[[dataArray objectAtIndex:i] objectForKey:@"Num"]];
        }
        betInfo.betNumber = [myarray componentsJoinedByString:separator];
        [myarray release];
    }
    else if (betInfo.lotteryType == TYPE_DALETOU) {
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
    }
    else if (betInfo.lotteryType == TYPE_3D) {
        
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
        
        if (betInfo.modeType == ThreeDzhixuanhezhi || betInfo.modeType == ThreeDzusanHezhi || betInfo.modeType == ThreeDzuliuHezhi || betInfo.modeType == ThreeDzusanDantuo || betInfo.modeType == ThreeDzuliuDantuo) {
            betInfo.betNumber = [betInfo.betNumber stringByReplacingOccurrencesOfString:@"#0" withString:@"#"];
        }
    }
    else if (betInfo.lotteryType == TYPE_22XUAN5) {
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
    }
    else if (betInfo.lotteryType == TYPE_7LECAI){
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
    }
    else if (betInfo.lotteryType == TYPE_SHISHICAI){
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
    }
    else if (betInfo.lotteryType == TYPE_CQShiShi){
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
    }
    else if (betInfo.lotteryType == TYPE_PAILIE3) {
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
        if (betInfo.modeType == Array3zhixuanHezhi || betInfo.modeType == Array3zusanHezhi || betInfo.modeType == Array3zuliuHezhi || betInfo.modeType == Array3zusandantuo || betInfo.modeType == Array3zuliudantuo) {
            betInfo.betNumber = [betInfo.betNumber stringByReplacingOccurrencesOfString:@"#0" withString:@"#"];
        }
    }
    else if (betInfo.lotteryType == TYPE_HappyTen) {
        betInfo.betNumber = [dataArray componentsJoinedByString:separator];
        if (betInfo.modeType == HappyTenQuan) {
            betInfo.betNumber = [betInfo.betNumber stringByReplacingOccurrencesOfString:@"⑽⒎⒏" withString:@"00"];
        }else{
            if (betInfo.modeType == HappyTenDa || betInfo.modeType == HappyTenDan) {
                betInfo.betNumber = [betInfo.betNumber stringByReplacingOccurrencesOfString:@"⑽" withString:@"0"];
                
                betInfo.betNumber = [betInfo.betNumber stringByReplacingOccurrencesOfString:@";" withString:@"%01#"];
            }
        }
    }
    else if (betInfo.lotteryType == TYPE_KuaiSan || betInfo.lotteryType == TYPE_JSKuaiSan || betInfo.lotteryType == TYPE_HBKuaiSan || betInfo.lotteryType == TYPE_JLKuaiSan || betInfo.lotteryType == TYPE_AHKuaiSan) {
        if (betInfo.modeType == KuaiSanHezhi) {
            betInfo.betNumber = [[[dataArray componentsJoinedByString:separator] stringByReplacingOccurrencesOfString:@";" withString:@"%01#"] stringByReplacingOccurrencesOfString:@"03" withString:@"3"];
        }
        else {
            betInfo.betNumber = [[dataArray componentsJoinedByString:separator] stringByReplacingOccurrencesOfString:@";" withString:@"%01#"];
        }
        
        
    }
    else if (betInfo.lotteryType == TYPE_KuaiLePuKe) {
        betInfo.betNumber = [[dataArray componentsJoinedByString:separator] stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
}

- (void)getBettingInfo
{
    [self getBetNumber];
    
    if (betInfo.betlist) {
        [betInfo.betlist removeAllObjects];
    } else {
        betInfo.betlist = [NSMutableArray array];
    }
    if ([issuearr count] ==0) {
        if (betInfo.issue) {
            [issuearr addObject:betInfo.issue];
        }
        
    }
    if (dobackbool) {
        for (int i = 0; i < zhuihaoCount; i++) {
            
            if ([issuearr count] > i) {
                NSString * mul = [NSString stringWithFormat:@"%@:%d", [issuearr objectAtIndex:i], multiple];//
                [betInfo.betlist addObject:mul];
            }
            
            
            //        NSNumber *mul = [NSNumber numberWithUnsignedInteger:multiple];
            //        [betInfo.betlist addObject:mul];
        }
    }else{
        for (int i = 0; i < zhuihaoCount; i++) {
            
            //            if ([issuearr count] > i) {
            //                NSString * mul = [NSString stringWithFormat:@"%@:%d", [issuearr objectAtIndex:i], multiple];//
            //                [betInfo.betlist addObject:mul];
            //            }
            
            
            NSNumber *mul = [NSNumber numberWithUnsignedInteger:multiple];
            [betInfo.betlist addObject:mul];
        }
        
    }
    
}

- (void)updateData
{
    
    
    
    if (zhuiTextStr  > 0) {
        sw.enabled = YES;
    }else{
        sw.enabled = NO;
    }
    if ([multipleTF.text intValue] < 1) {
        multiple = 1;
    } else if ([multipleTF.text intValue] > maxMultiple) {
        multiple = maxMultiple;
    } else {
        multiple = [multipleTF.text intValue];
    }
    if (zhuiTextStr  < 0) {
        zhuihaoCount = 1;
    } else if (zhuiTextStr  > maxIssueCount) {
        zhuiTextStr =  maxIssueCount;
        
        
        NSString * msg = [NSString stringWithFormat:@"最多追%d期", (int)maxIssueCount];
        [[caiboAppDelegate getAppDelegate] showjianpanMessage:msg view:tempWindow];
        zhuihaoCount = 51;
    } else {
        zhuihaoCount = zhuiTextStr +1;
    }
    if (isTingZhui) {
        betInfo.zhuihaoType = 0;
    }
    else {
        betInfo.zhuihaoType = 1;
    }
    
    betInfo.bets = 0;
    betInfo.multiple = multiple;
    
    
    
    if (self.goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie5) {
        betInfo.lotteryType =  TYPE_PAILIE5;
        self.betInfo.modeType = fushi;
        
        for (NSString *number in dataArray) {
            number = [number substringWithRange:NSMakeRange(3, [number length] - 3)];
            int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:fushi];
            betInfo.bets += a;
            NSLog(@"number = %@, a = %d", number, a);
            
        }
        betInfo.price = betInfo.bets * 2;
        
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSLog(@"aaa = %d", betInfo.bets);
        
        NSInteger zongzhu = 0;
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeQiXingCai) {
        betInfo.lotteryType =  TYPE_QIXINGCAI;
        self.betInfo.modeType = fushi;
        for (NSString *number in dataArray) {
            number = [number substringWithRange:NSMakeRange(3, [number length] - 3)];
            int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:fushi];
            betInfo.bets += a;
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    
    
    
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeShuangSeqiu) {
        if (self.modeType == Shuangseqiudantuo) {
            for (NSString *number in dataArray) {
                int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
                betInfo.bets += a;
            }
        }
        else {
            for (NSString *number in dataArray) {
                int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
                betInfo.bets += a;
            }
        }
        
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeShiXuanWu || self.goucaishuziinfotype == GouCaiShuZiInfoTypeGDShiXuanWu || self.goucaishuziinfotype == GouCaiShuZiInfoTypeJXShiXuanWu || self.goucaishuziinfotype == GouCaiShuZiInfoTypeHBShiXuanWu || self.goucaishuziinfotype == GouCaiShuZiInfoTypeShanXiShiXuanWu) {
        for (NSDictionary *numberDic in dataArray) {
            int a = (int)[[numberDic objectForKey:@"ZhuShu"] intValue];
            betInfo.bets += a;
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        //            if (betInfo.payMoney == 0) {
        //                betInfo.payMoney = betInfo.bets*2*multiple;
        //            }
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeDaleTou) {
        for (NSString *number in dataArray) {
            int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
            betInfo.bets += a;
        }
        NSInteger danjia = 2;
        if (zhuijiaSwitch.selected) {
            betInfo.wanfa = @"01";
            danjia = 3;
        }
        else {
            betInfo.wanfa = @"00";
            danjia =2;
        }
        betInfo.price = betInfo.bets * (int)danjia;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*(int)danjia];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeFuCai3D) {
        for (NSString *number in dataArray) {
            if ([number hasPrefix:@"01#"]) {
                betInfo.bets += 1;
            }
            else {
                if ([number length] >3) {
                    number = [number substringFromIndex:3];
                }
                int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
                betInfo.bets += a;
            }
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie3) {
        for (NSString *number in dataArray) {
            if ([number hasPrefix:@"01#"]) {
                betInfo.bets += 1;
            }
            else {
                if ([number length] >3) {
                    number = [number substringFromIndex:3];
                }
                int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
                betInfo.bets += a;
            }
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoType22Xuan5) {
        for (NSString *number in dataArray) {
            if ([number hasPrefix:@"01#"]) {
                betInfo.bets += 1;
            }
            else {
                if ([number length] >3) {
                    number = [number substringFromIndex:3];
                }
                int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
                betInfo.bets += a;
            }
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        nameLabel.text = [NSString stringWithFormat:@"22选5方案: %d注,追%d期",betInfo.bets, (int)zhuihaoCount-1];
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeQiLeCai) {
        for (NSString *number in dataArray) {
            if ([number hasPrefix:@"01#"]) {
                betInfo.bets += 1;
            }
            else {
                if ([number length] >3) {
                    number = [number substringFromIndex:3];
                }
                int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
                betInfo.bets += a;
            }
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeShiShiCai || self.goucaishuziinfotype == GouCaiShuZiInfoTypeCQShiShiCai) {
        for (NSString *number in dataArray) {
            if ([number hasPrefix:@"01#"]) {
                betInfo.bets += 1;
            }
            else {
                if ([number length] >3) {
                    number = [[number substringFromIndex:3] stringByReplacingOccurrencesOfString:@"^" withString:@""];
                }
                int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
                betInfo.bets += a;
            }
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeHappyTen) {
        for (NSString *number in dataArray) {
            if ([number hasPrefix:@"01#"] && modeType != HappyTenDa && modeType != HappyTenDan) {
                betInfo.bets += 1;
            }
            else {
                if ([number length] >3) {
                    number = [number substringFromIndex:3];
                }
                int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
                betInfo.bets += a;
            }
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeKuaiSan) {
        for (NSString *number in dataArray) {
            if ([number length] >3) {
                number = [number substringFromIndex:3];
            }
            int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
            betInfo.bets += a;
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeKuaiLePuke) {
        for (NSString *number in dataArray) {
            if ([number length] >3) {
                number = [number substringFromIndex:3];
            }
            int a = (int)[GC_LotteryUtil getBets:number LotteryType:betInfo.lotteryType ModeType:betInfo.modeType];
            betInfo.bets += a;
        }
        betInfo.price = betInfo.bets * 2;
        betInfo.prices = betInfo.price * multiple;
        betInfo.payMoney = betInfo.prices * (int)zhuihaoCount;
        NSInteger zongzhu = 0;
        
        if (dobackbool) {
            for (int i = 0; i < [betInfo.betlist count]; i++) {
                NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
                NSLog(@"zhu = %@", zhushustr);
                NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
                if (zhuarr.count >1) {
                    NSInteger zhu = [[zhuarr objectAtIndex:1] intValue];
                    zongzhu = zongzhu + zhu;
                }
            }
            
            NSString * jinestr2 = [NSString stringWithFormat:@"%d", (int)zongzhu * betInfo.bets*2];
            betInfo.payMoney = [jinestr2 intValue];
        }
        
        moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",betInfo.payMoney];
        zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    }
    
//    if (!mySegment) {
//        [self.betInfo setBaomiType:BaoMiTypeGongKai];
//    }
//    else if (mySegment.selectIndex == 3){
//        [self.betInfo setBaomiType:BaoMiTypeYinShen];
//    }
//    else {
//        [self.betInfo setBaomiType:mySegment.selectIndex];
//    }
//    baomiButton.buttonName.text
    
    [self.betInfo setBaomiType:[SharedMethod changeBaoMiTypeByTitle:baomiButton.buttonName.text]];
    nameLabel.text = [NSString stringWithFormat:@"<%d>注",betInfo.bets];
    moneyLabel.frame = CGRectMake(240-[[NSString stringWithFormat:@"%d",betInfo.payMoney] length] *10+10,5-2, 200, 20);
    NSString *st = [NSString stringWithFormat:@"%.2f",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    
    zhanghuLabel.frame = CGRectMake(242 - [st length]*8+10, 25, 200, 20);
    
    
}

//合买开关

- (void)hemaiSetting:(CP_SWButton *)sender {
    if (zhuiTextStr != 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"已设置追期，合买不可用"];
        isHeMai = NO;
        sender.on = NO;
        return;
    }
	isHeMai = sender.on;
    
    if (isHeMai) {
        buttonLabel1.text = @"发起";
        
    }else{
        buttonLabel1.text = @"投注";
        
        
    }
    
}

- (void)send {

    
    [self updateData];
    [MobClick event:@"event_goucai_touzhu_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
    if (betInfo.payMoney == 2 && ![self.betInfo.lotteryId isEqualToString:@"122"]) {//不清楚原因，每隔几个月会出现单式传02#
        if ([dataArray count]) {
            if ([[dataArray objectAtIndex:0] isKindOfClass:[NSString class]]) {
                NSString *str = [dataArray objectAtIndex:0];
                if ([str hasPrefix:@"02#"]) {
                    [[caiboAppDelegate getAppDelegate]showMessage:@"投注内容有误，请删除后重新投注"];
                    return;
                }
            }
            
            if ([[dataArray objectAtIndex:0] isKindOfClass:[NSDictionary class]]) {
                NSString *str = [[dataArray objectAtIndex:0] objectForKey:@"Num"];
                if ([str hasPrefix:@"02#"]) {
                    [[caiboAppDelegate getAppDelegate]showMessage:@"投注内容有误，请删除后重新投注"];
                    return;
                }
            }
            
        }
        
    }
    if ([[[Info getInstance] userId] intValue] == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
        return;
    }
    if ([self.betInfo.issue length] == 0) {
        [self getIssure];
        [[caiboAppDelegate getAppDelegate] showMessage:@"期次获取中"];
        return;
    }
    if (betInfo.prices <= 1500000) {
        
        if (dobackbool) {
            [self getBetNumber];
        }else{
            [self getBettingInfo];
        }
        
        
        if (isHeMai) {
            GCHeMaiSendViewController *hemai = [[GCHeMaiSendViewController alloc] init];
            hemai.betInfo = self.betInfo;
            hemai.isPutong = self.canBack;
            hemai.title = self.title;
            [self.navigationController pushViewController:hemai animated:YES];
            [hemai release];
            return;
        }
        
        //		if (betInfo.prices <= 20000) {
        
        
        
#ifdef isYueYuBan
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"是否确定投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.shouldRemoveWhenOtherAppear = YES;
        alert.tag = 119;
        [alert show];
        [alert release];
        return;
#else
#endif
        
        
        [self getBuyLotteryRequest];
        
        //       } else {
        //			caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //			[cai showMessage:@"单票金额不能超过20000元！"];
        //        }
    } else {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"投注总金额不能超过150万"];
    }
    //    balance = [GC_UserInfo sharedInstance].accountBalance - betInfo.payMoney;
}

//保密类型更改
- (void)baomiTypeChange:(UIButton *)btn{
    baoMiImage.image = UIImageGetImageFromName(@"login_right_0.png");
    gongKaiImage.image = UIImageGetImageFromName(@"login_right_0.png");
    yinshenImage.image = UIImageGetImageFromName(@"login_right_0.png");
    jieZhiImage.image = UIImageGetImageFromName(@"login_right_0.png");
	baoMiBtn.selected = NO;
	jieZhiBtn.selected = NO;
	gongKaiBtn.selected = NO;
    yinshenBtn.selected = NO;
	btn.selected = YES;
    if (btn == baoMiBtn) {
        baoMiImage.image = UIImageGetImageFromName(@"login_right.png");
    }
    else if (btn == jieZhiBtn) {
        jieZhiImage.image = UIImageGetImageFromName(@"login_right.png");
    }
    else if (btn == gongKaiBtn) {
        gongKaiImage.image = UIImageGetImageFromName(@"login_right.png");
    }
    else if (btn == yinshenBtn) {
        yinshenImage.image = UIImageGetImageFromName(@"login_right.png");
    }
}

- (void)randBalls {
	if ([dataArray count]>=50) {
		caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate showMessage:@"已有50组号码，先去投注吧"];
		return;
	}
	if (goucaishuziinfotype ==GouCaiShuZiInfoTypeShuangSeqiu) {
		NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:6 start:1 maxnum:33];
		NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:16];
		NSString *new = @"01#";
        if (self.betInfo.modeType == Shuangseqiudantuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
		for (int i = 0; i<[redBalls count]; i++) {
			new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
			if (i !=[redBalls count] -1) {
				new = [new stringByAppendingString:@","];
			}
		}
		new = [new stringByAppendingString:@"+"];
		new = [new stringByAppendingString:[blueBalls objectAtIndex:0]];
		[self.dataArray addObject:new];
	}
	else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeShiXuanWu) {
        if (self.betInfo.lotteryType >= TYPE_11XUAN5_R2DaTuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
		if (self.betInfo.lotteryType >= TYPE_11XUAN5_1 && self.betInfo.lotteryType <= TYPE_11XUAN5_8) {
			NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - 30 start:1 maxnum:11];
			
			NSString *selet = [redBalls componentsJoinedByString:@","];
			
			NSUInteger bets = 0;
			if (lotteryType == TYPE_11XUAN5_1) {
				bets = ([selet length]+1)/3;
			}
			else {
				bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
			}
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
			NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
		}
		else if (lotteryType == TYPE_11XUAN5_Q2ZHI) {
			NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:11];
			
			NSString *selet = @"";
			int b = rand()%[redBalls count];
			for (int i = 0; i<[redBalls count]; i++) {
				selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
				if (i != [redBalls count] -1) {
					selet = [NSString stringWithFormat:@"%@|",selet];
				}
				
			}
            
			NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
			if (bets == 1) {
				selet = [NSString stringWithFormat:@"01#%@",selet];
			}
			else {
				selet = [NSString stringWithFormat:@"05#%@",selet];
			}
			
			NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
		}
		else if (lotteryType == TYPE_11XUAN5_Q3ZHI) {
			NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:11];
			
			NSString *selet = @"";
			int b = rand()%[redBalls count];
			for (int i = 0; i<[redBalls count]; i++) {
				selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
				if (i != [redBalls count] -1) {
					selet = [NSString stringWithFormat:@"%@|",selet];
				}
			}
			
			NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
			if (bets == 1) {
				selet = [NSString stringWithFormat:@"01#%@",selet];
			}
			else {
				selet = [NSString stringWithFormat:@"05#%@",selet];
			}
			
			NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
		}
        if (self.betInfo.lotteryType >= TYPE_11XUAN5_Q2ZU && self.betInfo.lotteryType <= TYPE_11XUAN5_Q3ZU) {
			NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - TYPE_11XUAN5_Q2ZU + 2 start:1 maxnum:11];
			
			NSString *selet = [redBalls componentsJoinedByString:@","];
			
			NSUInteger bets = 0;
            bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
			NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
		}
	}
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeHBShiXuanWu) {
        if (self.betInfo.lotteryType >= TYPE_HB11XUAN5_R2DaTuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
        if (self.betInfo.lotteryType >= TYPE_HB11XUAN5_1 && self.betInfo.lotteryType <= TYPE_HB11XUAN5_8) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - TYPE_HB11XUAN5_1 + 1 start:1 maxnum:11];
            
            NSString *selet = [redBalls componentsJoinedByString:@","];
            
            NSUInteger bets = 0;
            if (lotteryType == TYPE_HB11XUAN5_1) {
                bets = ([selet length]+1)/3;
            }
            else {
                bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
            }
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        else if (lotteryType == TYPE_HB11XUAN5_Q2ZHI) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:11];
            
            NSString *selet = @"";
            int b = rand()%[redBalls count];
            for (int i = 0; i<[redBalls count]; i++) {
                selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
                if (i != [redBalls count] -1) {
                    selet = [NSString stringWithFormat:@"%@|",selet];
                }
                
            }
            
            NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
            if (bets == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else {
                selet = [NSString stringWithFormat:@"05#%@",selet];
            }
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        else if (lotteryType == TYPE_HB11XUAN5_Q3ZHI) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:11];
            
            NSString *selet = @"";
            int b = rand()%[redBalls count];
            for (int i = 0; i<[redBalls count]; i++) {
                selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
                if (i != [redBalls count] -1) {
                    selet = [NSString stringWithFormat:@"%@|",selet];
                }
            }
            
            NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
            if (bets == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else {
                selet = [NSString stringWithFormat:@"05#%@",selet];
            }
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        if (self.betInfo.lotteryType >= TYPE_HB11XUAN5_Q2ZU && self.betInfo.lotteryType <= TYPE_HB11XUAN5_Q3ZU) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - TYPE_HB11XUAN5_Q2ZU + 2 start:1 maxnum:11];
            
            NSString *selet = [redBalls componentsJoinedByString:@","];
            
            NSUInteger bets = 0;
            bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeGDShiXuanWu) {
        if (self.betInfo.lotteryType >= TYPE_GD11XUAN5_R2DaTuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
		if (self.betInfo.lotteryType >= TYPE_GD11XUAN5_1 && self.betInfo.lotteryType <= TYPE_GD11XUAN5_8) {
			NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:self.betInfo.lotteryType - TYPE_GD11XUAN5_1 + 1 start:1 maxnum:11];
			
			NSString *selet = [redBalls componentsJoinedByString:@","];
			
			NSUInteger bets = 0;
			if (lotteryType == TYPE_GD11XUAN5_1) {
				bets = ([selet length]+1)/3;
			}
			else {
				bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
			}
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
			NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
		}
		else if (lotteryType == TYPE_GD11XUAN5_Q2ZHI) {
			NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:11];
			
			NSString *selet = @"";
			int b = rand()%[redBalls count];
			for (int i = 0; i<[redBalls count]; i++) {
				selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
				if (i != [redBalls count] -1) {
					selet = [NSString stringWithFormat:@"%@|",selet];
				}
				
			}
            
			NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
			if (bets == 1) {
				selet = [NSString stringWithFormat:@"01#%@",selet];
			}
			else {
				selet = [NSString stringWithFormat:@"05#%@",selet];
			}
			
			NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
		}
		else if (lotteryType == TYPE_GD11XUAN5_Q3ZHI) {
			NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:11];
			
			NSString *selet = @"";
			int b = rand()%[redBalls count];
			for (int i = 0; i<[redBalls count]; i++) {
				selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
				if (i != [redBalls count] -1) {
					selet = [NSString stringWithFormat:@"%@|",selet];
				}
			}
			
			NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
			if (bets == 1) {
				selet = [NSString stringWithFormat:@"01#%@",selet];
			}
			else {
				selet = [NSString stringWithFormat:@"05#%@",selet];
			}
			
			NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
		}
        if (self.betInfo.lotteryType >= TYPE_GD11XUAN5_Q2ZU && self.betInfo.lotteryType <= TYPE_GD11XUAN5_Q3ZU) {
			NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - TYPE_GD11XUAN5_Q2ZU + 2 start:1 maxnum:11];
			
			NSString *selet = [redBalls componentsJoinedByString:@","];
			
			NSUInteger bets = 0;
            bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
			NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
			[dataArray addObject:dic];
			[dic release];
		}
	}
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeJXShiXuanWu) {
        if (self.betInfo.lotteryType >= TYPE_JX11XUAN5_R2DaTuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
        if (self.betInfo.lotteryType >= TYPE_JX11XUAN5_1 && self.betInfo.lotteryType <= TYPE_JX11XUAN5_8) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - (TYPE_JX11XUAN5_1 - 1) start:1 maxnum:11];
            
            NSString *selet = [redBalls componentsJoinedByString:@","];
            
            NSUInteger bets = 0;
            if (lotteryType == TYPE_JX11XUAN5_1) {
                bets = ([selet length]+1)/3;
            }
            else {
                bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
            }
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        else if (lotteryType == TYPE_JX11XUAN5_Q2ZHI) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:11];
            
            NSString *selet = @"";
            int b = rand()%[redBalls count];
            for (int i = 0; i<[redBalls count]; i++) {
                selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
                if (i != [redBalls count] -1) {
                    selet = [NSString stringWithFormat:@"%@|",selet];
                }
                
            }
            
            NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
            if (bets == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else {
                selet = [NSString stringWithFormat:@"05#%@",selet];
            }
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        else if (lotteryType == TYPE_JX11XUAN5_Q3ZHI) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:11];
            
            NSString *selet = @"";
            int b = rand()%[redBalls count];
            for (int i = 0; i<[redBalls count]; i++) {
                selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
                if (i != [redBalls count] -1) {
                    selet = [NSString stringWithFormat:@"%@|",selet];
                }
            }
            
            NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
            if (bets == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else {
                selet = [NSString stringWithFormat:@"05#%@",selet];
            }
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        if (self.betInfo.lotteryType >= TYPE_JX11XUAN5_Q2ZU && self.betInfo.lotteryType <= TYPE_JX11XUAN5_Q3ZU) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - TYPE_JX11XUAN5_Q2ZU + 2 start:1 maxnum:11];
            
            NSString *selet = [redBalls componentsJoinedByString:@","];
            
            NSUInteger bets = 0;
            bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeShanXiShiXuanWu) {
        if (self.betInfo.lotteryType >= TYPE_ShanXi11XUAN5_R2DaTuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
        if (self.betInfo.lotteryType >= TYPE_ShanXi11XUAN5_1 && self.betInfo.lotteryType <= TYPE_ShanXi11XUAN5_8) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - TYPE_ShanXi11XUAN5_1 + 1 start:1 maxnum:11];
            
            NSString *selet = [redBalls componentsJoinedByString:@","];
            
            NSUInteger bets = 0;
            if (lotteryType == TYPE_ShanXi11XUAN5_1) {
                bets = ([selet length]+1)/3;
            }
            else {
                bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
            }
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        else if (lotteryType == TYPE_ShanXi11XUAN5_Q2ZHI) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:11];
            
            NSString *selet = @"";
            int b = rand()%[redBalls count];
            for (int i = 0; i<[redBalls count]; i++) {
                selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
                if (i != [redBalls count] -1) {
                    selet = [NSString stringWithFormat:@"%@|",selet];
                }
                
            }
            
            NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
            if (bets == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else {
                selet = [NSString stringWithFormat:@"05#%@",selet];
            }
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        else if (lotteryType == TYPE_ShanXi11XUAN5_Q3ZHI) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:11];
            
            NSString *selet = @"";
            int b = rand()%[redBalls count];
            for (int i = 0; i<[redBalls count]; i++) {
                selet = [NSString stringWithFormat:@"%@%@",selet,[redBalls objectAtIndex:(i+b)%[redBalls count]]];
                if (i != [redBalls count] -1) {
                    selet = [NSString stringWithFormat:@"%@|",selet];
                }
            }
            
            NSUInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5dingwei];
            if (bets == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else {
                selet = [NSString stringWithFormat:@"05#%@",selet];
            }
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
        if (self.betInfo.lotteryType >= TYPE_ShanXi11XUAN5_Q2ZU && self.betInfo.lotteryType <= TYPE_ShanXi11XUAN5_Q3ZU) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotteryType - TYPE_ShanXi11XUAN5_Q2ZU + 2 start:1 maxnum:11];
            
            NSString *selet = [redBalls componentsJoinedByString:@","];
            
            NSUInteger bets = 0;
            bets = [GC_LotteryUtil getBets:selet LotteryType:lotteryType ModeType:M11XUAN5fushi];
            selet = [NSString stringWithFormat:@"01#%@",selet];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",[NSString stringWithFormat:@"%d",(int)bets],@"ZhuShu",[NSString stringWithFormat:@"%d",lotteryType],@"lotterytype",nil];
            [dataArray addObject:dic];
            [dic release];
        }
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeDaleTou) {
        if (self.betInfo.modeType == Daletoudantuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
        
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:35];
		NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:12];
		NSString *new = @"01#";
		for (int i = 0; i<[redBalls count]; i++) {
			new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
			if (i !=[redBalls count] -1) {
				new = [new stringByAppendingString:@"_"];
			}
		}
		new = [new stringByAppendingString:@"_:_"];
        
        for (int i = 0; i<[blueBalls count]; i++) {
			new = [new stringByAppendingString:[blueBalls objectAtIndex:i]];
			if (i !=[blueBalls count] -1) {
				new = [new stringByAppendingString:@"_"];
			}
		}
        
		[self.dataArray addObject:new];
        
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeFuCai3D) {
        if (self.betInfo.modeType == ThreeDzhixuanfushi) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
            NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
            NSMutableArray *blueBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
            NSString *new = @"01#";
            for (int i = 0; i<[redBalls count]; i++) {
                new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
            }
            
            for (int i = 0; i<[blueBalls count]; i++) {
                new = [new stringByAppendingString:[blueBalls objectAtIndex:i]];
            }
            for (int i = 0; i<[blueBalls2 count]; i++) {
                new = [new stringByAppendingString:[blueBalls2 objectAtIndex:i]];
            }
            
            [self.dataArray addObject:new];
        }
        else if (self.betInfo.modeType == ThreeDzusanfushi) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:0 maxnum:9];
            NSString *new = @"02#";
            for (int i = 0; i<[redBalls count]; i++) {
                new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
            }
            [self.dataArray addObject:new];
        }
        else if (self.betInfo.modeType == ThreeDzuliufushi) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:0 maxnum:9];
            NSString *new = @"01#";
            for (int i = 0; i<[redBalls count]; i++) {
                new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
            }
            [self.dataArray addObject:new];
        }
        else if(self.betInfo.modeType == ThreeDzhixuandantuo || betInfo.modeType == ThreeDzusanDantuo || betInfo.modeType == ThreeDzuliuDantuo){
            [[caiboAppDelegate getAppDelegate]showMessage:@"胆拖玩法不支持机选"];
        }
        else if(self.betInfo.modeType == ThreeDzhixuanhezhi || betInfo.modeType == ThreeDzusanHezhi || betInfo.modeType == ThreeDzuliuHezhi){
            [[caiboAppDelegate getAppDelegate]showMessage:@"和值玩法不支持机选"];
        }
        else if (self.betInfo.modeType == ThreeDzusandanshi) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:0 maxnum:9];
            NSString *new = @"01#";
            new = [new stringByAppendingString:[redBalls objectAtIndex:0]];
            new = [new stringByAppendingString:[redBalls objectAtIndex:0]];
            new = [new stringByAppendingString:[redBalls objectAtIndex:1]];
            
            [self.dataArray addObject:new];
        }
        
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie3){
        
        if (self.betInfo.modeType == Array3zhixuanfushi) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
            NSMutableArray *redBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
            NSMutableArray *redBalls3 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
            NSString *new = [NSString stringWithFormat:@"01#%@*%@*%@",[redBalls objectAtIndex:0],[redBalls2 objectAtIndex:0],[redBalls3 objectAtIndex:0]];
            [self.dataArray addObject:new];
            
        }
        else if (self.betInfo.modeType == Array3zusanfushi) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:0 maxnum:9];
            NSString *new = @"02#";
            //拼串，直接将redBalls数组里的字符用*隔开
            NSString *num = [redBalls componentsJoinedByString:@"*"];
            new = [NSString stringWithFormat:@"%@%@",new,num];
            [self.dataArray addObject:new];
        }
        else if (self.betInfo.modeType == Array3zuliufushi) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:4 start:0 maxnum:9];
            NSString *new = @"02#";
            NSString *num = [redBalls componentsJoinedByString:@"*"];
            new = [NSString stringWithFormat:@"%@%@",new,num];
            //            for (int i = 0; i<[redBalls count]; i++) {
            //                new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
            //            }
            [self.dataArray addObject:new];
            
            
        }
        else if (self.betInfo.modeType == Array3zuxuandanshi) {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
            NSMutableArray *redBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
            NSMutableArray *redBalls3 = [GC_LotteryUtil getRandBalls:2 start:0 maxnum:9];
            if ([[redBalls objectAtIndex:0] isEqualToString:[redBalls2 objectAtIndex:0]]&&[[redBalls3 objectAtIndex:0] isEqualToString:[redBalls2 objectAtIndex:0]]) {
                NSString *new = [NSString stringWithFormat:@"01#%@*%@*%@",[redBalls objectAtIndex:0],[redBalls2 objectAtIndex:0],[redBalls3 objectAtIndex:1]];
                [self.dataArray addObject:new];
            }
            else {
                NSString *new = [NSString stringWithFormat:@"01#%@*%@*%@",[redBalls objectAtIndex:0],[redBalls2 objectAtIndex:0],[redBalls3 objectAtIndex:0]];
                [self.dataArray addObject:new];
            }
        }
        else if(self.betInfo.modeType == Array3zusandantuo || betInfo.modeType == Array3zuliudantuo){
            [[caiboAppDelegate getAppDelegate]showMessage:@"胆拖玩法不支持机选"];
        }
        else if(self.betInfo.modeType == Array3zhixuanHezhi || betInfo.modeType == Array3zusanHezhi || betInfo.modeType == Array3zuliuHezhi){
            [[caiboAppDelegate getAppDelegate]showMessage:@"和值玩法不支持机选"];
        }
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypePaiLie5) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls4 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls5 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSString *new = @"01#";
        for (int i = 0; i<[redBalls count]; i++) {
            new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls count]; i++) {
            new = [new stringByAppendingString:[blueBalls objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls2 count]; i++) {
            new = [new stringByAppendingString:[blueBalls2 objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls4 count]; i++) {
            new = [new stringByAppendingString:[blueBalls4 objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls5 count]; i++) {
            new = [new stringByAppendingString:[blueBalls5 objectAtIndex:i]];
        }
        //  new = [NSString stringWithFormat:@"%@,", new];
        
        [self.dataArray addObject:new];
        
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeQiXingCai) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls4 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls5 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls6 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *blueBalls7 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSString *new = @"01#";
        for (int i = 0; i<[redBalls count]; i++) {
            new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls count]; i++) {
            new = [new stringByAppendingString:[blueBalls objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls2 count]; i++) {
            new = [new stringByAppendingString:[blueBalls2 objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls4 count]; i++) {
            new = [new stringByAppendingString:[blueBalls4 objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls5 count]; i++) {
            new = [new stringByAppendingString:[blueBalls5 objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls6 count]; i++) {
            new = [new stringByAppendingString:[blueBalls6 objectAtIndex:i]];
        }
        new = [NSString stringWithFormat:@"%@*", new];
        for (int i = 0; i<[blueBalls7 count]; i++) {
            new = [new stringByAppendingString:[blueBalls7 objectAtIndex:i]];
        }
        
        [self.dataArray addObject:new];
        
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoType22Xuan5) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:22];
		NSString *new = @"01#";
		for (int i = 0; i<[redBalls count]; i++) {
			new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
			if (i !=[redBalls count] -1) {
				new = [new stringByAppendingString:@"*"];
			}
		}
		[self.dataArray addObject:new];
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeQiLeCai) {
        if (self.modeType == Qilecaidantuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
        else {
            NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:7 start:1 maxnum:30];
            NSString *new = @"01#";
            for (int i = 0; i<[redBalls count]; i++) {
                new = [new stringByAppendingString:[redBalls objectAtIndex:i]];
                if (i !=[redBalls count] -1) {
                    new = [new stringByAppendingString:@"_"];
                }
            }
            [self.dataArray addObject:new];
        }
    }
    else if (goucaishuziinfotype ==GouCaiShuZiInfoTypeShiShiCai || self.goucaishuziinfotype == GouCaiShuZiInfoTypeCQShiShiCai) {
        if (self.modeType == SSCerxingzuxuandantuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
        else {
            NSString *new = @"01#";
            if (self.modeType == SSCdaxiaodanshuang) {
                NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:3];
                NSMutableArray *redBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:3];
                new = [NSString stringWithFormat:@"%@%@,%@",new,[redBalls1 objectAtIndex:0],[redBalls2 objectAtIndex:0]];
                new = [new stringByReplacingOccurrencesOfString:@"3" withString:@"9"];
            }
            else if (self.modeType >= SSCyixingfushi &&self.modeType <= SSCwuxingfushi) {
                for (int a= SSCyixingfushi; a<=self.modeType; a++) {
                    NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                    new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
                    if (a != self.modeType) {
                        new = [NSString stringWithFormat:@"%@,",new];
                    }
                }
            }
            else if (self.modeType == SSCerxingzuxuan) {
                NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:2 start:0 maxnum:9];
                new = [NSString stringWithFormat:@"%@%@,%@",new,[redBalls1 objectAtIndex:0],[redBalls1 objectAtIndex:1]];
            }
            else if (self.modeType == SSCwuxingtongxuan) {
                for (int a= 0; a<=4; a++) {
                    NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                    new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
                    if (a != 4) {
                        new = [NSString stringWithFormat:@"%@,",new];
                    }
                }
            }
            else if (self.modeType >= SSCrenxuanyi &&self.modeType <= SSCrenxuansan) {
                NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:self.modeType - SSCrenxuanyi +1 start:0 maxnum:4];
                for (int a= 0; a<=4; a++) {
                    if ([redBalls1 indexOfObject:[NSString stringWithFormat:@"%d",a]]<[redBalls1 count]) {
                        NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
                        new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
                    }
                    else {
                        new = [NSString stringWithFormat:@"%@_",new];
                    }
                    if (a != 4) {
                        new = [NSString stringWithFormat:@"%@,",new];
                    }
                }
            }
            
            [self.dataArray addObject:new];
            
        }
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeHappyTen) {
        NSString *new = @"01#";
        if (self.modeType >= HappyTenRen2DanTuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
        if (self.modeType == HappyTen1Shu) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:18];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
        }
        else if (self.modeType == HappyTen1Hong) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:19 maxnum:20];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
        }
        else if (self.modeType == HappyTenRen2Zhi) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:20];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@"|"]];
        }
        else if (self.modeType == HappyTenRen2Zu || self.modeType == HappyTenRen2) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:20];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@","]];
        }
        else if (self.modeType == HappyTenRen3Zu || self.modeType == HappyTenRen3) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:20];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@","]];
        }
        else if (self.modeType == HappyTenRen3Zhi) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:20];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@"|"]];
        }
        else if (self.modeType == HappyTenRen4) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:4 start:1 maxnum:20];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@","]];
        }
        else if (self.modeType == HappyTenRen5) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:20];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@","]];
        }
        else if (self.modeType == HappyTenDa || self.modeType == HappyTenDan) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:8];
            new = [NSString stringWithFormat:@"%@⑽%@",new,[redBalls1 componentsJoinedByString:@","]];
        }
        else if (self.modeType == HappyTenQuan) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"猜全数不支持机选"];
            return;
        }
        
        [self.dataArray addObject:new];
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeKuaiSan) {
        if (self.betInfo.modeType >= KuaiSanSanBuTongDanTuo) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"胆拖模式不支持机选"];
            return;
        }
        NSString *new = @"01#";
        if (self.modeType == KuaiSanHezhi) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:3 maxnum:18];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
        }
        else if (self.modeType == KuaiSanSantongTong) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"三同号通选不支持机选"];
            return;
        }
        else if (self.modeType == KuaiSanSantongDan) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:6];
            new = [NSString stringWithFormat:@"%@%@,%@,%@",new,[redBalls1 objectAtIndex:0],[redBalls1 objectAtIndex:0],[redBalls1 objectAtIndex:0]];
        }
        else if (self.modeType == KuaiSanErtongDan) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:6];
            new = [NSString stringWithFormat:@"%@%@%@|%@",new,[redBalls1 objectAtIndex:0],[redBalls1 objectAtIndex:0],[redBalls1 objectAtIndex:1]];
        }
        else if (self.modeType == KuaiSanErTongFu) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:6];
            new = [NSString stringWithFormat:@"%@%@%@",new,[redBalls1 objectAtIndex:0],[redBalls1 objectAtIndex:0]];
        }
        else if (self.modeType == KuaiSanSanBuTong) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:6];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@","]];
        }
        else if (self.modeType == KuaiSanErButong) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:6];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@","]];
        }
        else if (self.modeType == KuaiSanSanLianTong) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"三连号通选不支持机选"];
            return;
        }
        
        [self.dataArray addObject:new];
    }
    else if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeKuaiLePuke) {
        NSString *new = @"01#";
        if (self.modeType >= KuaiLePuKeRen1 && self.modeType <= KuaiLePuKeRen6) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:(self.modeType - KuaiLePuKeRen1 + 1) start:1 maxnum:13];
            new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 componentsJoinedByString:@","]];
            [self.dataArray addObject:new];
        }
        else if (self.modeType >= KuaiLePuKeTongHua && self.modeType <= KuaiLePuKeTongHuaShun) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:5];
            if ([[redBalls1 objectAtIndex:0] intValue] >= 5) {
                new = @"02#00";
            }
            else {
                new = [NSString stringWithFormat:@"%@0%@",new,[redBalls1 objectAtIndex:0]];
            }
            
            [self.dataArray addObject:new];
        }
        else if (self.modeType == KuaiLePuKeShunZi) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:14];
            if ([[redBalls1 objectAtIndex:0] intValue] >= 13) {
                new = [NSString stringWithFormat:@"03#00"];
            }
            else {
                new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
            }
            
            [self.dataArray addObject:new];
            
        }
        else if (self.modeType >= KuaiLePuKeBaoZi) {
            NSMutableArray *redBalls1 = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:14];
            if ([[redBalls1 objectAtIndex:0] intValue] >= 14) {
                new = [NSString stringWithFormat:@"03#00"];
            }
            else {
                new = [NSString stringWithFormat:@"%@%@",new,[redBalls1 objectAtIndex:0]];
            }
            
            [self.dataArray addObject:new];
            
        }
    }
    
	[myTableView reloadData];
	if ([self.dataArray count] != 0) {
		sendBtn.enabled = YES;
        sendBtn.alpha=1;
        [sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	}
	[self updateData];
}

- (void)pressbaomibutton:(CP_PTButton *)sender {

    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"方案设置" message:baomiButton.buttonName.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.shouldRemoveWhenOtherAppear = YES;
    alert.alertTpye = segementType;
    alert.tag = 999;
    [alert show];
    [alert release];
}

//- (void)quxiaoBianji {
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    editeView.alpha = 0;
//    [UIView commitAnimations];
//}
//- (void)finishBianji {
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    editeView.alpha = 0;
//    [UIView commitAnimations];
//    NSArray *array = [NSArray arrayWithObjects:@"公开",@"保密",@"截止后公开",@"隐藏", nil];
//    baomiButton.buttonName.text = [array objectAtIndex:mySegment.selectIndex];
//}

- (void)pressaddbutton:(UIButton *)sender{
	if (sender.tag == 101) {
		if (zhuiTextStr  >= maxIssueCount) {
			zhuiTextStr =  maxIssueCount;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
			[cai showMessage:[NSString stringWithFormat:@"最多追%d期", (int)maxIssueCount]];
		}else{
            //			NSString * str = [NSString stringWithFormat:@"%d",zhuiTextStr + 1];
			zhuiTextStr = zhuiTextStr + 1;
		}
	}
	else {
		if ([multipleTF.text intValue] >= maxMultiple) {
			multipleTF.text = [NSString stringWithFormat:@"%d",maxMultiple];
		}else{
			NSString * str = [NSString stringWithFormat:@"%d",[multipleTF.text intValue] + 1];
			multipleTF.text = str;
		}
	}
    
	[self updateData];
}

- (void)pressjianbutton:(UIButton *)sender{
	if (sender.tag == 101) {
		if (zhuiTextStr  <= 0) {
			zhuiTextStr = 0;
		}else{
			
			zhuiTextStr = zhuiTextStr-1;
		}
	}
	else {
		if ([multipleTF.text intValue] <= 1) {
			multipleTF.text = @"1";
		}else{
			NSString * str = [NSString stringWithFormat:@"%d",[multipleTF.text intValue] - 1];
			multipleTF.text = str;
		}
	}
    
	[self updateData];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [multipleTF resignFirstResponder];
}

- (void)numberKeyBoarViewReturnText:(NSString *)text returnBool:(BOOL)rbool{
    
    zhuiTextStr = [text intValue];
    isTingZhui = rbool;
    [self hidenZhui];
    //    NSLog(@"zhuitext = %d", zhuiTextStr);
    
    
    
    
}

- (void)numberKeyBoarViewShow{
    
    
#ifdef isCaiPiaoForIPad
    CP_NumberKeyboardView * number = [[CP_NumberKeyboardView alloc] initWithFrame:self.view.bounds textValue:[NSString stringWithFormat:@"%d", zhuiTextStr] switchValue:isTingZhui cpNumberKeyboarTyle:CP_NumberKeyboarsSwitchtyle];
#else
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate] ;
    CP_NumberKeyboardView * number = [[CP_NumberKeyboardView alloc] initWithFrame:app.window.bounds textValue:[NSString stringWithFormat:@"%d", (int)zhuiTextStr] switchValue:isTingZhui cpNumberKeyboarTyle:CP_NumberKeyboarsSwitchtyle];
#endif
    
    //  [self.view addSubview:number];
    number.titleString = @"追号设置";
    number.fieldTitle = @"期数";
    number.minValue = 0;
    number.maxValue = maxIssueCount;
    
    number.switchTitle = @"中奖后停止";
    number.delegate = self;
#ifdef isCaiPiaoForIPad
    [self.view addSubview:number];
#else
    [app.window addSubview:number];
#endif
    
    [number release];
    btn4.enabled = YES;
    
}

- (void)quxiaoAnaxi {
    btn4bg.alpha = 1.0;
}

- (void)anxiaZhuihao{
    btn4bg.alpha = 0.65;
}

- (void)zhuiHaoAction{
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    btn4bg.alpha = 1.0;
    if (isHeMai) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"合买模式不支持追号"];
        return;
    }
    [MobClick event:@"event_goucai_zhuihaoshezhi_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
    if ([issuearr count] > 1) {
        [self calculateFunc];
    }else{
        [self hidenZhui];
    }
//    if (maxIssueCount == 0) {
//        [self maxIssueLottery];
//    }else{
//        [self numberKeyBoarViewShow];
//    }
    
}


- (void)calculateFunc{//详情计算页
    if (same == YES) {
        for (int i = 0; i < betInfo.betlist.count; i++) {
            if (![[betInfo.betlist objectAtIndex:i] isKindOfClass:[NSNumber class]]) {
                NSString * qishuStr =  [[[betInfo.betlist objectAtIndex:i] componentsSeparatedByString:@":"] objectAtIndex:0];
                NSString * finalStr = [NSString stringWithFormat:@"%@:%@",qishuStr,multipleTF.text];
                [betInfo.betlist replaceObjectAtIndex:i withObject:finalStr];
            }
            
        }
    }
    if (isHeMai) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"合买模式不支持追号"];
        return;
    }
    if ([dataArray count] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"请先选择投注号码再追号"];
        return;
    }
    
    dobackbool = YES;
    if ([betInfo.betlist count] > 1 ) {
        
    }else{
        
        [self getBettingInfo];
        
    }
    
    if (tankuangbool) {
        if ([betInfo.betlist count ]>0) {
            
            if ([[betInfo.betlist objectAtIndex:0] isKindOfClass:[NSNumber class]]) {
                [self getBettingInfo];
            }
            
            
        }else{
            [self getBettingInfo];
        }
        
        
        
    }
    
    if ([[betInfo.betlist objectAtIndex:0] isKindOfClass:[NSNumber class]]) {
        [self getBettingInfo];
    }
    
    
    
    tankuangbool = NO;
    CalculateViewController * calculate = [[CalculateViewController  alloc] init];
    calculate.betInfo = betInfo;
    
    calculate.delegate = self;
    if (zhuijiaSwitch.selected) {
        
        calculate.zhuijiabool = YES;
    }else{
        calculate.zhuijiabool = NO;
    }
    calculate.issuearr = issuearr;
    calculate.isTingZhui = isTingZhui;
    calculate.morenbeishu = [NSString stringWithFormat:@"%d", multiple];
    calculate.jisuanType = goucaishuziinfotype;
    [self.navigationController pushViewController:calculate animated:YES];
    [calculate release];
}

- (void)hidenZhui {
    
    
//    if ( zhuiTextStr != 0 &&([self.dataArray count]!=0) && zhuiTextStr  <= 10) {//来判断是否变红
        if ([issuearr count] == 0||[issuearr count] == 1) {
            NSLog(@"caizhong = %@", betInfo.caizhong);
            [ahttpRequest clearDelegatesAndCancel];
            
            NSInteger countIssue = 0;
            
            if (goucaishuziinfotype == GouCaiShuZiInfoTypeShuangSeqiu || goucaishuziinfotype == GouCaiShuZiInfoTypeDaleTou || goucaishuziinfotype == GouCaiShuZiInfoTypeQiLeCai || goucaishuziinfotype == GouCaiShuZiInfoTypeQiXingCai || goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie3 || goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie5) {
                countIssue = 99;
            }else{
                countIssue = 120;
            }

            
            
            
            NSMutableData *postData = [[GC_HttpService sharedInstance] huoQuQiHaoLotteryId:betInfo.caizhong shuliang:countIssue];
            
            
            self.ahttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [ahttpRequest setRequestMethod:@"POST"];
            [ahttpRequest addCommHeaders];
            [ahttpRequest setPostBody:postData];
            [ahttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [ahttpRequest setDelegate:self];
            [ahttpRequest setDidFinishSelector:@selector(reqStartTogetherBuyFinished:)];
            [ahttpRequest startAsynchronous];
        }
        
//        [btn4 removeTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
//        [btn4 addTarget:self action:@selector(calculateFunc) forControlEvents:UIControlEventTouchUpInside];
        //        [btn4 setImage:UIImageGetImageFromName(@"ZHAN960.png") forState:UIControlStateNormal];
//        btn4bg.image = [UIImageGetImageFromName(@"FQHMAN960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    btn4bg.backgroundColor=[UIColor clearColor];
        zhuiLable.text = [NSString stringWithFormat:@"追号%d期", (int)zhuiTextStr];
    btn4bg.image = [UIImageGetImageFromName(@"zhuceanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    multiBtn.enabled = NO;
    addbutton.enabled = NO;
    jianbutton.enabled = NO;
//    }
    
    
    if([self.dataArray count]==0 || zhuiTextStr ==0){
        zhuiTextStr = 0;
        dobackbool = NO;
        [btn4 removeTarget:self action:@selector(calculateFunc) forControlEvents:UIControlEventTouchUpInside];
        [btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
        //        [btn4 setImage:UIImageGetImageFromName(@"TZ960.png") forState:UIControlStateNormal];
//        btn4bg.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        btn4bg.image = [UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//        btn4.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:200.0/255.0 blue:50.0/255.0 alpha:1];
       zhuiLable.text = @"追号设置";
        multiBtn.enabled = YES;
        addbutton.enabled = YES;
        jianbutton.enabled = YES;
    }
//    if (zhuiTextStr  > 10) {
//        dobackbool = NO;
//        [btn4 removeTarget:self action:@selector(calculateFunc) forControlEvents:UIControlEventTouchUpInside];
//        [btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
//        //        [btn4 setImage:UIImageGetImageFromName(@"ZHAN960.png") forState:UIControlStateNormal];
//        btn4bg.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//        zhuiLable.text = [NSString stringWithFormat:@"追号%d期", zhuiTextStr];
//    }
    
    
    //	zhuiView.hidden = YES;
    //     [zhuiView removeFromSuperview];
    //	[zhuiText resignFirstResponder];
	[self updateData];
}

- (void)buyBack {
    
    if (isGoBuy) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"购买成功？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        alert.tag = 102;
        [alert release];
        dobackbool = NO;
    }
    isGoBuy = NO;

}

- (void)getIssure {
    NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:self.betInfo.lotteryId];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqLotteryInfoFinished:)];
    [httpRequest setDidFailSelector:@selector(reqLotteryInfoFaild:)];
    [httpRequest performSelectorInBackground:@selector(startAsynchronous) withObject:nil];
}

- (void)zhuijia:(UIButton *)swith {
    swith.selected = !swith.selected;
    //    UIView *v = [[swith.subviews objectAtIndex:0] viewWithTag:101];
    if (swith.selected) {
        UILabel *zhuiLab=(UILabel *)[zhuijiaSwitch viewWithTag:250];
        zhuiLab.frame=CGRectMake(5, 0, 40, 31);
        zhuiLab.textColor=[UIColor whiteColor];
        //        [UIView beginAnimations:nil context:nil];
        //        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        //        [UIView setAnimationDuration:0.15];
        //        v.frame = CGRectMake(-41, 0, 40, 27);
        //        [UIView commitAnimations];
        [MobClick event:@"event_goucai_zhuijia"];
        [[caiboAppDelegate getAppDelegate] showMessage:@"追加投注后,每注3元。"];
    }
    else {
        UILabel *zhuiLab=(UILabel *)[zhuijiaSwitch viewWithTag:250];
        zhuiLab.frame=CGRectMake(5+20, 0, 40, 31);
        zhuiLab.textColor=[UIColor grayColor];
        //        [UIView beginAnimations:nil context:nil];
        //        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        //        [UIView setAnimationDuration:0.15];
        //        v.frame = CGRectMake(-91, 0, 40, 27);
        //        [UIView commitAnimations];
    }
    [self updateData];
}


- (void)maxIssueLottery{
    NSLog(@"betinfo = %@", betInfo.lotteryId);
    NSMutableData *postData = [[GC_HttpService sharedInstance] maxIssueLotteryId:betInfo.lotteryId];
    
    [counthttpRequest clearDelegatesAndCancel];
    self.maxrequst = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [maxrequst setRequestMethod:@"POST"];
    [maxrequst addCommHeaders];
    [maxrequst setPostBody:postData];
    [maxrequst setDefaultResponseEncoding:NSUTF8StringEncoding];
    [maxrequst setDelegate:self];
    [maxrequst setDidFinishSelector:@selector(maxIssueFinishRequest:)];
    [maxrequst setDidFailSelector:@selector(maxIssueFail:)];
    [maxrequst startAsynchronous];
    
}
- (void)maxIssueFail:(ASIHTTPRequest *)mrequest{
    btn4.enabled = YES;
}
- (void)maxIssueFinishRequest:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
		MaxIssueData *aManage = [[MaxIssueData alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        
        if (aManage.maxcount > 120) {
            maxIssueCount = 120;
        }else{
            maxIssueCount = aManage.maxcount;
        }
        
        
        
        [aManage release];
        
    }
    
    [self numberKeyBoarViewShow];
    
}

- (void)getAccountInfoRequest
{
    if ([[[Info getInstance] userName] length] > 0 && [[GC_HttpService sharedInstance].sessionId length]) {
        //获取账户信息
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManagerNew:[[Info getInstance] userName]];
        
        [counthttpRequest clearDelegatesAndCancel];
        self.counthttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
		[counthttpRequest setRequestMethod:@"POST"];
        [counthttpRequest addCommHeaders];
        [counthttpRequest setPostBody:postData];
        [counthttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [counthttpRequest setDelegate:self];
        [counthttpRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [counthttpRequest startAsynchronous];
    }
}


- (void)doneButton:(id)sender {
    
    [multipleTF resignFirstResponder];
    //    [zhuiText resignFirstResponder];
}

//跳转其他浏览器
- (void)goLiuLanqi:(NSURL *)url {
    NSURL *newURl = [[GC_HttpService sharedInstance] changeURLToTheOther:url];
    if (newURl) {
        [[UIApplication sharedApplication] openURL:newURl];
    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"如果不能切换到浏览器进一步操作，请修改“设置->通用->访问限制->Safari”为“开启”" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

//成功跳转safari取消跳转其他浏览器
- (void)EnterBackground {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EnterBackground" object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark -
#pragma mark View lifecycle

- (void)LoadIpadView {
    CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:UIImageGetImageFromName(@"GC_btn10.png") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addPutong) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btn];
        [btn loadButonImage:@"GC_btn10.png" LabelName:@"增加普通投注"];
        btn.showNomore = YES;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
    btn.buttonName.textColor = [UIColor blackColor];
    btn.buttonName.shadowColor = [UIColor clearColor];
    btn.frame = CGRectMake(10 +35, 5, 144, 30);
	
	CP_PTButton *btn2 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
	[btn2 addTarget:self action:@selector(randBalls) forControlEvents:UIControlEventTouchUpInside];
	[self.mainView addSubview:btn2];
	btn2.frame = CGRectMake(165 + 35, 5, 144, 30);
	[btn2 loadButonImage:@"GC_btn10.png" LabelName:@"增加机选投注"];
    btn2.showNomore = YES;
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 3;
    btn2.buttonName.textColor = [UIColor blackColor];
	btn2.buttonName.shadowColor = [UIColor clearColor];
    
    UIImageView *back = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_touzhuback.png")];
    [self.mainView addSubview:back];
    back.frame = CGRectMake(10 + 35, 42, 300, 205 + 260);
    back.backgroundColor = [UIColor clearColor];
    [back release];
    
	myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10 + 35, 46, 300, 190 + 260)];
	myTableView.delegate = self;
	myTableView.dataSource = self;
	[self.mainView addSubview:myTableView];
	myTableView.backgroundColor = [UIColor clearColor];
	[myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    infoBackImage = [[CPZhanKaiView alloc] init];
    [self.mainView addSubview:infoBackImage];
    infoBackImage.canZhanKaiByTouch = NO;
    infoBackImage.backgroundColor = [UIColor clearColor];
    
//    UIImageView *imageView2 = [[UIImageView alloc] init];
//    imageView2.image = UIImageGetImageFromName(@"ZHBBG960.png");
//    imageView2.frame = CGRectMake(0, 85, 320, 113);
//    [infoBackImage addSubview:imageView2];
//    imageView2.userInteractionEnabled = YES;
//    [imageView2 release];
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    imageView1.frame = CGRectMake(0, 0, 300, 85);
    imageView1.userInteractionEnabled = YES;
    [infoBackImage addSubview:imageView1];
    [imageView1 release];
    infoBackImage.frame = CGRectMake(10 + 35, 250 + 288, 300, 85);
    infoBackImage.normalHeight = 85;
    infoBackImage.zhankaiHeight = 195;
    [infoBackImage release];
    
    
	nameLabel = [[ColorView alloc] initWithFrame:CGRectMake(10, 10, 290, 20)];
	nameLabel.backgroundColor = [UIColor clearColor];
	nameLabel.textColor = [UIColor grayColor];
	[infoBackImage addSubview:nameLabel];
	nameLabel.font = [UIFont systemFontOfSize:11];
	[nameLabel release];
	
	moneyLabel = [[ColorView alloc] initWithFrame:CGRectMake(100, 21, 290, 20)];
	moneyLabel.backgroundColor = [UIColor clearColor];
	moneyLabel.font = [UIFont systemFontOfSize:13];
    moneyLabel.colorfont = [UIFont systemFontOfSize:17];
	[infoBackImage addSubview:moneyLabel];
	[moneyLabel release];
	
	zhanghuLabel = [[ColorView alloc] initWithFrame:CGRectMake(200, 25, 100, 20)];
	zhanghuLabel.backgroundColor = [UIColor clearColor];
	[infoBackImage addSubview:zhanghuLabel];
	zhanghuLabel.font = [UIFont systemFontOfSize:13];
	[zhanghuLabel release];
    
    
//    for (int i = 0; i < 12; i ++) {
//        CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//        [imageView2 addSubview:btn];
//        int a = i/6;
//        int b = i%6;
//        btn.frame = CGRectMake(17 + b * 51, 12 + a *51, 39, 39);
//        [btn loadButonImage:@"ZHBANBG960.png" LabelName:[NSString stringWithFormat:@"%d",i]];
//        if (i == 10) {
//            btn.buttonName.text = nil;
//            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((39-22)/2, (39-12)/2, 22, 12)];
//            [btn addSubview:imageV];
//            imageV.image = UIImageGetImageFromName(@"ZHBANX960.png");
//            [imageV release];
//        }
//        
//        else if (i == 11) {
//            btn.buttonName.text = @"完成";
//        }
//        
//        btn.tag = i;
//        [btn addTarget:self action:@selector(jianPanClicke:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    
    
    
    
    
    
    multiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    multiBtn.frame = CGRectMake(10, 48, 94, 33);
    [infoBackImage addSubview:multiBtn];
    [multiBtn addTarget:self action:@selector(rengouSelcte) forControlEvents:UIControlEventTouchUpInside];
    [multiBtn setBackgroundImage:[UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateNormal];
    [multiBtn setBackgroundImage:[UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateHighlighted];
    
    
	label4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, 40, 17)];
	label4.backgroundColor = [UIColor clearColor];
	label4.textColor = [UIColor grayColor];
    label4.font = [UIFont systemFontOfSize:12];
	label4.text = @"倍投";
	[infoBackImage addSubview:label4];
	[label4 release];
    
    multipleTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 52, 60, 20)];
    multipleTF.delegate = self;
	multipleTF.textAlignment = NSTextAlignmentCenter;
    multipleTF.text = @"1";
    multipleTF.enabled = NO;
    multipleTF.backgroundColor = [UIColor clearColor];
    [multipleTF setReturnKeyType:UIReturnKeyDone];
    [multipleTF setKeyboardType:UIKeyboardTypeNumberPad];
    [infoBackImage addSubview:multipleTF];
	[multipleTF release];
    
    addbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    addbutton.frame = CGRectMake(110, 48, 49, 31);
    [addbutton loadButonImage:@"TYD960.png" LabelName:@"+"];
    addbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    addbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [addbutton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    jianbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    jianbutton.frame = CGRectMake(162, 48, 49, 31);
    [jianbutton loadButonImage:@"TYD960.png" LabelName:@"-"];
    jianbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    jianbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [jianbutton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
    [infoBackImage addSubview:addbutton];
    [infoBackImage addSubview:jianbutton];
    
    baomiButton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    baomiButton.frame = CGRectMake(215, 48, 75, 31);
    [baomiButton loadButonImage:@"FQHMAN960.png" LabelName:@"公开"];
    
    baomiButton.buttonName.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    baomiButton.buttonName.font = [UIFont systemFontOfSize:14];
    [baomiButton addTarget:self action:@selector(pressbaomibutton:) forControlEvents:UIControlEventTouchUpInside];
    [infoBackImage addSubview:baomiButton];
    
   
    
    label4.hidden = NO;
    textbgimage.hidden = NO;
    multipleTF.hidden = NO;
    addbutton.hidden = NO;
    jianbutton.hidden = NO;
    multiBtn.enabled = YES;
    addbutton.enabled = YES;
    jianbutton.enabled = YES;
    
	
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 320 + 70, 44)];
	[self.mainView addSubview:im];
    im.userInteractionEnabled = YES;
	im.image = UIImageGetImageFromName(@"XDH960.png");
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(anxiaZhuihao) forControlEvents:UIControlEventTouchDown];
    [btn4 addTarget:self action:@selector(quxiaoAnaxi) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragExit];
    btn4.frame = CGRectMake(10 + 35, 340 + 288, 300, 27);
    
    btn4bg = [[UIImageView alloc] initWithFrame:btn4.bounds];
    btn4bg.backgroundColor = [UIColor clearColor];
    btn4bg.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [btn4 addSubview:btn4bg];
    [btn4bg release];
    
    zhuiLable = [[UILabel alloc] initWithFrame:btn4.bounds];
    [btn4 addSubview:zhuiLable];
    zhuiLable.text = @"追号";
    zhuiLable.tag = 1112;
    zhuiLable.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
    zhuiLable.shadowOffset = CGSizeMake(0, 1.0);
    zhuiLable.backgroundColor = [UIColor clearColor];
    zhuiLable.textAlignment = NSTextAlignmentCenter;
    zhuiLable.font = [UIFont boldSystemFontOfSize:13];
    zhuiLable.textColor = [UIColor whiteColor];
    [zhuiLable release];
	[self.mainView addSubview:btn4];
	
    sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    buttonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    if (isHeMai) {
        buttonLabel1.text = @"发起";
    }else{
        buttonLabel1.text = @"投注";
    }
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:15];
    [sendBtn addSubview:buttonLabel1];
    
	sendBtn.frame = CGRectMake(120 + 35, 8, 80, 30);
	
	[im addSubview:sendBtn];
    
    
    
	if (![self.betInfo.caizhong isEqualToString:LOTTERY_ID_JIANGXI_11]&&![self.betInfo.caizhong isEqualToString:@"119"] && ![self.betInfo.caizhong isEqualToString:@"006"] && ![self.betInfo.caizhong isEqualToString:@"011"]&& ![self.betInfo.caizhong isEqualToString:@"012"]&& ![self.betInfo.caizhong isEqualToString:@"122"] && ![self.betInfo.caizhong isEqualToString:@"013"]&& ![self.betInfo.caizhong isEqualToString:@"121"] && ![self.betInfo.caizhong isEqualToString:@"014"] && ![self.betInfo.caizhong isEqualToString:@"019"] && ![self.betInfo.caizhong isEqualToString:LOTTERY_ID_JILIN] && ![self.betInfo.caizhong isEqualToString:@"123"] && ![self.betInfo.caizhong isEqualToString:LOTTERY_ID_SHANXI_11] && ![self.betInfo.caizhong isEqualToString:LOTTERY_ID_ANHUI]) {
		UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(195 + 35, 10, 35, 30)];
		lable.text = @"合买";
		lable.textAlignment = NSTextAlignmentCenter;
		lable.font = [UIFont systemFontOfSize:13];
		[im addSubview:lable];
		lable.backgroundColor = [UIColor clearColor];
		[lable release];
		sendBtn.frame = CGRectMake(100 + 35, 8, 80, 30);
		hemaiSwitch = [[CP_SWButton alloc] initWithFrame:CGRectMake(230 + 35, 8, 77, 27)];
        hemaiSwitch.onImageName = @"heji2-640_10.png";
        hemaiSwitch.offImageName = @"heji2-640_11.png";
		[im addSubview:hemaiSwitch];
		[hemaiSwitch addTarget:self action:@selector(hemaiSetting:) forControlEvents:UIControlEventValueChanged];
		hemaiSwitch.on = isHeMai;
		[hemaiSwitch release];
	}
	[im release];
//    if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeDaleTou) {
//        
//        btn4.frame = CGRectMake(10 + 35, 340 + 288, 215, 27);
//        btn4bg.frame = btn4.bounds;
//        zhuiLable.frame = btn4.bounds;
//        
//        
//        zhuijiaSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
//        zhuijiaSwitch.frame = CGRectMake(236 + 45, 340 + 288, 74, 27);
//        [self.mainView addSubview:zhuijiaSwitch];
//        [zhuijiaSwitch setImage:UIImageGetImageFromName(@"ONZhuijia960.png") forState:UIControlStateSelected];
//        [zhuijiaSwitch setImage:UIImageGetImageFromName(@"OFFZhuijia960.png") forState:UIControlStateNormal];
//        zhuijiaSwitch.selected = NO;
//        [zhuijiaSwitch addTarget:self action:@selector(zhuijia:) forControlEvents:UIControlEventTouchUpInside];
//        NSLog(@"%@",zhuijiaSwitch.subviews);
//    }
    gckeyView = [[GC_UIkeyView alloc] initWithFrame:self.mainView.bounds withType:upShowKey];
    gckeyView.hightFloat = infoBackImage.frame.size.height;
    gckeyView.delegate = self;
    [self.mainView addSubview:gckeyView];
    [gckeyView release];
}

- (void)LoadIphoneView {
    
    UIView *jiaView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 46)];
    jiaView.backgroundColor=[UIColor whiteColor];
    [self.mainView addSubview:jiaView];
    [jiaView release];
    
    UIImageView *lineIma=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 320, 1)];
    lineIma.image=[UIImage imageNamed:@"SZTG960.png"];
    [jiaView addSubview:lineIma];
    [lineIma release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 7.5, 137, 30);
    [btn addTarget:self action:@selector(addPutong) forControlEvents:UIControlEventTouchUpInside];
    [jiaView addSubview:btn];
    [btn setTitle:@"+  普通投注" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitleColor:[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:0.4] forState:UIControlStateHighlighted];
    
    
	UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn2 addTarget:self action:@selector(randBalls) forControlEvents:UIControlEventTouchUpInside];
	[jiaView addSubview:btn2];
    btn2.frame = CGRectMake(168, 7.5, 137, 30);
    [btn2 setTitle:@"+  机选投注" forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn2 setTitleColor:[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:0.4] forState:UIControlStateHighlighted];

    
//-----------------------------------------bianpinghua by sichuanlin
//    UIImageView *back = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"GC_touzhuback.png")];
    UIImageView *back = [[UIImageView alloc] init];
    
    [self.mainView addSubview:back];
    back.frame = CGRectMake(10, 42, 300, 205);
    back.backgroundColor = [UIColor clearColor];
//    back.backgroundColor = [UIColor whiteColor];
    
    [back release];
    
	myTableView = [[UITableView alloc] init];
//    myTableView.frame=CGRectMake(0, 46, 320, 190);
    myTableView.frame=CGRectMake(0, 46, 320, self.mainView.frame.size.height-46-44-50-85-30);
	myTableView.delegate = self;
	myTableView.dataSource = self;
	[self.mainView addSubview:myTableView];
    myTableView.backgroundColor=[UIColor clearColor];
//	myTableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
	[myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIView *xieyiView = [[UIView alloc]init];
    xieyiView.frame = CGRectMake(0, self.mainView.frame.size.height-44-50-85-30, 320, 30);
    xieyiView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:xieyiView];
    [xieyiView release];
    
    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 30)] ;
    agreeLabel.text = @"    《同城用户服务协议》";
    agreeLabel.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    agreeLabel.backgroundColor = [UIColor clearColor];
    //    agreeLabel.textAlignment = NSTextAlignmentRight;
    agreeLabel.font = [UIFont systemFontOfSize:18];
    agreeLabel.userInteractionEnabled = YES;
    [xieyiView addSubview:agreeLabel];
    [agreeLabel release];
    
    UIButton *agreeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn1.frame = CGRectMake(0, 0, 200, 30);
    [agreeBtn1 addTarget:self action:@selector(xieyi) forControlEvents:UIControlEventTouchUpInside];
    agreeBtn1.backgroundColor = [UIColor clearColor];
    [agreeLabel addSubview:agreeBtn1];
    
    UIImageView *agreeIma = [[UIImageView alloc]init];
    agreeIma.frame = CGRectMake(0, 7, 16, 16);
    agreeIma.backgroundColor = [UIColor clearColor];
    agreeIma.image = [UIImage imageNamed:@"zhuce-tongyixiyikuang_1.png"];
    [agreeLabel addSubview:agreeIma];
    [agreeIma release];
    
    UIImageView *rightIma = [[UIImageView alloc]init];
    rightIma.frame = agreeIma.bounds;
    rightIma.backgroundColor = [UIColor clearColor];
    rightIma.image = [UIImage imageNamed:@"zhuce-tongyixieyi_1.png"];
    [agreeIma addSubview:rightIma];
    [rightIma release];
    
    
    infoBackImage = [[CPZhanKaiView alloc] init];
    [self.mainView addSubview:infoBackImage];
    infoBackImage.canZhanKaiByTouch = NO;
    infoBackImage.backgroundColor = [UIColor whiteColor];
//    infoBackImage.backgroundColor = [UIColor clearColor];
    
    UIImageView *upupXian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upupXian.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [infoBackImage addSubview:upupXian];
    [upupXian release];
    
    
    //键盘
//    UIImageView *imageView2 = [[UIImageView alloc] init];
////-----------------------------------------bianpinghua by sichuanlin
////    imageView2.image = UIImageGetImageFromName(@"ZHBBG960.png");
//    imageView2.backgroundColor=[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    
//    imageView2.frame = CGRectMake(0, 85, 320, 113);
//    [infoBackImage addSubview:imageView2];
//    imageView2.userInteractionEnabled = YES;
//    [imageView2 release];
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
//    imageView1.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    imageView1.backgroundColor=[UIColor clearColor];
    
    imageView1.frame = CGRectMake(0, 0, 320, 85);
    imageView1.userInteractionEnabled = YES;
    [infoBackImage addSubview:imageView1];
    [imageView1 release];
//    infoBackImage.frame = CGRectMake(0, 250-14, 320, 85);
    infoBackImage.frame = CGRectMake(0, self.mainView.frame.size.height-44-50-85, 320, 85);
    
    infoBackImage.normalHeight = 85;
    infoBackImage.zhankaiHeight = 195;
    [infoBackImage release];
    
    UIImageView *asd=[[UIImageView alloc]init];
//    asd.frame=CGRectMake(0, 335-14, 320, 50);
    asd.frame=CGRectMake(0, self.mainView.frame.size.height-44-50, 320, 50);
    NSLog(@"%f",self.view.frame.size.height);
    NSLog(@"%f",self.mainView.frame.size.height);//504
    asd.backgroundColor=[UIColor whiteColor];
    asd.userInteractionEnabled=YES;
    [self.mainView addSubview:asd];
    [asd release];
    
    
	nameLabel = [[ColorView alloc] initWithFrame:CGRectMake(10+10, 3, 290, 20)];
	nameLabel.backgroundColor = [UIColor clearColor];
	nameLabel.textColor = [UIColor grayColor];
	[infoBackImage addSubview:nameLabel];
    nameLabel.colorfont=[UIFont systemFontOfSize:18];
	nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.changeColor=[UIColor blackColor];
	[nameLabel release];

    danzhuLab=[[ColorView alloc]initWithFrame:CGRectMake(20, 25, 100, 20)];
    danzhuLab.backgroundColor=[UIColor clearColor];
    danzhuLab.font=[UIFont systemFontOfSize:13];
    danzhuLab.changeColor=[UIColor redColor];
    danzhuLab.colorfont=[UIFont systemFontOfSize:15];
    [infoBackImage addSubview:danzhuLab];
    [danzhuLab release];
    danzhuLab.text=danzhujiangjin;
//    if(lotteryType >= TYPE_11XUAN5_1 && lotteryType <= TYPE_11XUAN5_Q3ZU)
//    {
//        NSArray *danzhuAry=[[NSArray alloc]initWithObjects:@"13",@"6",@"19",@"78",@"540",@"90",@"26",@"9",@"130",@"1170",@"65",@"195", nil];
//        danzhuLab.text=[NSString stringWithFormat:@"单注奖金<%@>元",[danzhuAry objectAtIndex:lotteryType-31]];
//        NSLog(@"山东11选5");
//    }
//    else if(lotteryType >= TYPE_GD11XUAN5_1 && lotteryType <= TYPE_GD11XUAN5_Q3ZU)
//    {
//        NSArray *danzhuAry=[[NSArray alloc]initWithObjects:@"13",@"6",@"19",@"78",@"540",@"90",@"26",@"9",@"130",@"1170",@"65",@"195", nil];
//        danzhuLab.text=[NSString stringWithFormat:@"单注奖金<%@>元",[danzhuAry objectAtIndex:lotteryType-31]];
//        NSLog(@"广东11选5");
//    }
//    else if(lotteryType == TYPE_SHISHICAI)
//    {
//        NSLog(@"黑龙江时时彩");
//    }
//    else if(lotteryType == TYPE_CQShiShi)
//    {
//        NSLog(@"重庆时时彩");
//    }
    
	
	moneyLabel = [[ColorView alloc] initWithFrame:CGRectMake(10, 21, 290, 20)];
	moneyLabel.backgroundColor = [UIColor clearColor];
	moneyLabel.font = [UIFont systemFontOfSize:13];
    moneyLabel.colorfont = [UIFont systemFontOfSize:18];
    moneyLabel.changeColor=[UIColor colorWithRed:15.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1];
	[infoBackImage addSubview:moneyLabel];
	[moneyLabel release];
	
	zhanghuLabel = [[ColorView alloc] initWithFrame:CGRectMake(200+10, 25, 100, 20)];
	zhanghuLabel.backgroundColor = [UIColor clearColor];
	[infoBackImage addSubview:zhanghuLabel];
	zhanghuLabel.font = [UIFont systemFontOfSize:13];
    zhanghuLabel.colorfont=[UIFont systemFontOfSize:15];
	[zhanghuLabel release];
    
    
//    for (int i = 0; i < 12; i ++) {
//        CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//        [imageView2 addSubview:btn];
////        int a = i/6;
////        int b = i%6;
//        int a = i/7;
//        int b = i%7;
////        btn.frame = CGRectMake(40 + b * 40, 15 + a *40, 35, 36);
//        btn.frame = CGRectMake(20 + b * 40+a*25, 15 + a *45, 35, 36);
////-----------------------------------------bianpinghua by sichuanlin
////        [btn loadButonImage:@"ZHBANBG960.png" LabelName:[NSString stringWithFormat:@"%d",i]];
//        [btn loadButonImage:@"anjian.png" LabelName:[NSString stringWithFormat:@"%d",i]];
//        
//        if (i == 10) {
//            btn.buttonName.text = nil;
//            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 24, 14)];
//            [btn addSubview:imageV];
//            imageV.image = UIImageGetImageFromName(@"ZHBANX960.png");
//            [imageV release];
//        }
//        
//        else if (i == 11) {
//            btn.buttonName.text = @"完成";
//            btn.frame = CGRectMake(20 + b * 40+a*25, 15 + a *45, 65, 36);
////-----------------------------------------bianpinghua by sichuanlin
//            [btn loadButonImage:@"tongyongxuanzhong.png" LabelName:[NSString stringWithFormat:@"完成"]];
//        }
//        
//        btn.tag = i;
//        [btn addTarget:self action:@selector(jianPanClicke:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
   
    
    
    multiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    multiBtn.frame = CGRectMake(10+10, 48, 94, 33);
    [infoBackImage addSubview:multiBtn];
    [multiBtn addTarget:self action:@selector(rengouSelcte) forControlEvents:UIControlEventTouchUpInside];
    
//    [multiBtn setBackgroundImage:[UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateNormal];
//    [multiBtn setBackgroundImage:[UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateHighlighted];
//    [multiBtn setBackgroundImage:[UIImageGetImageFromName(@"tongyonghui.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateNormal];
    [multiBtn setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateNormal];
    
    
	label4 = [[UILabel alloc] initWithFrame:CGRectMake(15+10, 56, 40, 17)];
	label4.backgroundColor = [UIColor clearColor];
	label4.textColor = [UIColor grayColor];//btn_gray_selected.png
    label4.font = [UIFont systemFontOfSize:12];
	label4.text = @"倍投";
	[infoBackImage addSubview:label4];
	[label4 release];
    
    multipleTF = [[UITextField alloc] initWithFrame:CGRectMake(40+10, 53, 60, 20)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        multipleTF.frame = CGRectMake(40+10, 55, 60, 20);
        
    }
    
    multipleTF.delegate = self;
	multipleTF.textAlignment = NSTextAlignmentCenter;
    multipleTF.text = @"1";
    multipleTF.enabled = NO;
    multipleTF.textColor = [ UIColor blackColor];
    multipleTF.backgroundColor = [UIColor clearColor];
    [multipleTF setReturnKeyType:UIReturnKeyDone];
    [multipleTF setKeyboardType:UIKeyboardTypeNumberPad];
    [infoBackImage addSubview:multipleTF];
	[multipleTF release];
    
    addbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    addbutton.frame = CGRectMake(110+10, 48, 50, 31);
//-----------------------------------------bianpinghua by sichuanlin
//    [addbutton loadButonImage:@"TYD960.png" LabelName:@"+"];
    [addbutton loadButonImage:@"zhuihaojia_normal.png" LabelName:nil];
    [addbutton setHightImage:UIImageGetImageFromName(@"zhuihaojia_selected.png")];
    
    addbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    addbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [addbutton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    jianbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    jianbutton.frame = CGRectMake(161+10, 48, 50, 31);
//    [jianbutton loadButonImage:@"TYD960.png" LabelName:@"-"];
    [jianbutton loadButonImage:@"zhuihaojian_normal.png" LabelName:nil];
    [jianbutton setHightImage:UIImageGetImageFromName(@"zhuihaojian_selected.png")];

    
    jianbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    jianbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [jianbutton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
    [infoBackImage addSubview:addbutton];
    [infoBackImage addSubview:jianbutton];
    
    baomiButton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    baomiButton.frame = CGRectMake(215+10, 48, 75, 31);
//-----------------------------------------bianpinghua by sichuanlin
//    [baomiButton loadButonImage:@"FQHMAN960.png" LabelName:@"公开"];
    [baomiButton loadButonImage:@"tongyonglan.png" LabelName:@"公开"];
//    baomiButton.buttonName.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    baomiButton.buttonName.shadowColor=[UIColor clearColor];
    baomiButton.buttonName.textColor=[UIColor colorWithRed:15.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1];
    
    baomiButton.buttonName.font = [UIFont systemFontOfSize:14];
    [baomiButton addTarget:self action:@selector(pressbaomibutton:) forControlEvents:UIControlEventTouchUpInside];
    [infoBackImage addSubview:baomiButton];
    
    
    
    label4.hidden = NO;
    textbgimage.hidden = NO;
    multipleTF.hidden = NO;
    addbutton.hidden = NO;
    jianbutton.hidden = NO;
    multiBtn.enabled = YES;
    addbutton.enabled = YES;
    jianbutton.enabled = YES;
    
	
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height -44, 320, 44)];
	[self.mainView addSubview:im];
    im.userInteractionEnabled = YES;
//-----------------------------------------bianpinghua by sichuanlin
//	im.image = UIImageGetImageFromName(@"XDH960.png");
    im.backgroundColor=[UIColor blackColor];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(anxiaZhuihao) forControlEvents:UIControlEventTouchDown];
    [btn4 addTarget:self action:@selector(quxiaoAnaxi) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchDragExit];
//    btn4.frame = CGRectMake(20, 340-14, 280, 35);
    btn4.frame = CGRectMake(20, 7, 280, 35);
    
    btn4bg = [[UIImageView alloc] initWithFrame:btn4.bounds];
    btn4bg.backgroundColor = [UIColor clearColor];
//-------------------------------------------bianpinghua by sichuanlin
//    btn4bg.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    btn4bg.image = [UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    btn4.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:200.0/255.0 blue:50.0/255.0 alpha:1];
    btn4.layer.masksToBounds=YES;
    btn4.layer.cornerRadius=5;
    
    [btn4 addSubview:btn4bg];
    [btn4bg release];
    
    zhuiLable = [[UILabel alloc] initWithFrame:btn4.bounds];
    [btn4 addSubview:zhuiLable];
    zhuiLable.text = @"追号设置";
    zhuiLable.tag = 1112;
//    zhuiLable.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
//    zhuiLable.shadowOffset = CGSizeMake(0, 1.0);
    zhuiLable.backgroundColor = [UIColor clearColor];
    zhuiLable.textAlignment = NSTextAlignmentCenter;
    zhuiLable.font = [UIFont boldSystemFontOfSize:16];
    zhuiLable.textColor = [UIColor whiteColor];
    [zhuiLable release];
//	[self.mainView addSubview:btn4];
    [asd addSubview:btn4];
	
    sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    buttonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    if (isHeMai) {
        buttonLabel1.text = @"发起";
    }else{
        buttonLabel1.text = @"投注";
    }
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
//    buttonLabel1.textColor = [UIColor blackColor];
//    buttonLabel1.textColor = [UIColor colorWithRed:202.0/255.0 green:194.0/255.0 blue:164.0/255.0 alpha:1];
    buttonLabel1.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    
    buttonLabel1.font = [UIFont boldSystemFontOfSize:18];
//-----------------------------------------bianpinghua by sichuanlin
//    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    [sendBtn addSubview:buttonLabel1];
    
	sendBtn.frame = CGRectMake(120, 8, 80, 30);
	
	[im addSubview:sendBtn];
    
    
    
	if (![self.betInfo.caizhong isEqualToString:LOTTERY_ID_JIANGXI_11]&&![self.betInfo.caizhong isEqualToString:@"119"] && ![self.betInfo.caizhong isEqualToString:@"006"] && ![self.betInfo.caizhong isEqualToString:@"011"]&& ![self.betInfo.caizhong isEqualToString:@"012"]&& ![self.betInfo.caizhong isEqualToString:@"122"] && ![self.betInfo.caizhong isEqualToString:@"121"] &&![self.betInfo.caizhong isEqualToString:@"013"] && ![self.betInfo.caizhong isEqualToString:@"014"] && ![self.betInfo.caizhong isEqualToString:@"019"] && ![self.betInfo.caizhong isEqualToString:LOTTERY_ID_JILIN] && ![self.betInfo.caizhong isEqualToString:@"123"] && ![self.betInfo.caizhong isEqualToString:LOTTERY_ID_SHANXI_11] && ![self.betInfo.caizhong isEqualToString:LOTTERY_ID_ANHUI]) {
		UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(195, 10, 35, 30)];
		lable.text = @"合买";
		lable.textAlignment = NSTextAlignmentCenter;
		lable.font = [UIFont systemFontOfSize:13];
		[im addSubview:lable];
		lable.backgroundColor = [UIColor clearColor];
		[lable release];
		sendBtn.frame = CGRectMake(120, 8, 80, 30);
//----------------------------------------------bianpinghua by sichuanlin
//		hemaiSwitch = [[CP_SWButton alloc] initWithFrame:CGRectMake(230, 8, 77, 27)];
        hemaiSwitch = [[CP_SWButton alloc] initWithFrame:CGRectMake(240, 8, 70, 31)];
//        hemaiSwitch.onImageName = @"heji2-640_10.png";
//        hemaiSwitch.offImageName = @"heji2-640_11.png";
        hemaiSwitch.onImageName = @"switch_hemai_on.png";
        hemaiSwitch.offImageName = @"switch_hemai_off.png";
		[im addSubview:hemaiSwitch];
		[hemaiSwitch addTarget:self action:@selector(hemaiSetting:) forControlEvents:UIControlEventValueChanged];
		hemaiSwitch.on = isHeMai;
		[hemaiSwitch release];
	}
	[im release];
//    if (self.goucaishuziinfotype == GouCaiShuZiInfoTypeDaleTou) {
//
////        btn4.frame = CGRectMake(20, 340-14, 200+1, 35);
//        btn4.frame = CGRectMake(20, 7, 200, 35);
//        btn4bg.frame = btn4.bounds;
//        zhuiLable.frame = btn4.bounds;
//        
//        
//        zhuijiaSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
////        zhuijiaSwitch.frame = CGRectMake(236, 340, 74, 27);
////        zhuijiaSwitch.frame = CGRectMake(236+4-10, 340-14, 70, 31);
//        zhuijiaSwitch.frame = CGRectMake(236+4-10, self.mainView.frame.size.height-44-35-8, 70, 31);
//        [self.mainView addSubview:zhuijiaSwitch];
////        [zhuijiaSwitch setImage:UIImageGetImageFromName(@"ONZhuijia960.png") forState:UIControlStateSelected];
////        [zhuijiaSwitch setImage:UIImageGetImageFromName(@"OFFZhuijia960.png") forState:UIControlStateNormal];
//        [zhuijiaSwitch setImage:UIImageGetImageFromName(@"zhuijia1.png") forState:UIControlStateSelected];
//        [zhuijiaSwitch setImage:UIImageGetImageFromName(@"zhuijia2.png") forState:UIControlStateNormal];
//        zhuijiaSwitch.selected = NO;
//        [zhuijiaSwitch addTarget:self action:@selector(zhuijia:) forControlEvents:UIControlEventTouchUpInside];
//        NSLog(@"%@",zhuijiaSwitch.subviews);
//        
//        UILabel *zhuiLab=[[UILabel alloc]init];
//        zhuiLab.frame=CGRectMake(5+20, 0, 40, 31);
//        zhuiLab.text=@"追加";
//        zhuiLab.textAlignment=NSTextAlignmentCenter;
//        zhuiLab.textColor=[UIColor grayColor];
//        zhuiLab.font=[UIFont systemFontOfSize:15];
//        zhuiLab.tag=250;
//        zhuiLab.backgroundColor = [UIColor clearColor];
//        [zhuijiaSwitch addSubview:zhuiLab];
//        [zhuiLab release];
//        
//    }
//     zhuiTextStr = [betInfo.betlist count]-1;
//    if (zhuiTextStr ) {
//        <#statements#>
//    }
    if (zhuiTextStr > 0) {
//        btn4bg.image = [UIImageGetImageFromName(@"FQHMAN960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        btn4bg.image = [UIImageGetImageFromName(@"zhuceanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        zhuiLable.text = [NSString stringWithFormat:@"追号%d期", (int)zhuiTextStr];
        multiBtn.enabled = NO;
        addbutton.enabled = NO;
        jianbutton.enabled = NO;
    }
    
    gckeyView = [[GC_UIkeyView alloc] initWithFrame:self.mainView.bounds withType:upShowKey];
    gckeyView.hightFloat = infoBackImage.frame.size.height;
    gckeyView.delegate = self;
    [self.mainView addSubview:gckeyView];
    [gckeyView release];

    
}
-(void)xieyi
{
    Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = Xieyi;
    xie.title = @"同城用户服务协议";
    [self.navigationController pushViewController:xie animated:YES];
    [xie release];
}
- (void)passWordOpenUrl{
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
   [self getBuyLotteryRequest];
}
- (void)resetPassWord{
    
    BOOL pwInfoBool = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
        
        
        for (int i = 0; i < [allUserArr count]; i++) {
            //        NSArray * userArr = [];
            NSString * userString = [allUserArr objectAtIndex:i];
            NSArray * userArr = [userString componentsSeparatedByString:@" "];
            if ([userArr count] == 3) {
                
                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                    
                    pwInfoBool = YES;
                    
                    break;
                }
                
            }
            
        }
        
    }
    
    if (pwInfoBool) {
        TestViewController * test = [[TestViewController alloc] init];
        
        //                UIViewController * con = [viewController.navigationController.viewControllers objectAtIndex:[viewController.navigationController.viewControllers cou]];
        //
        [self.navigationController pushViewController:test animated:YES];
        [test release];
    }else{
        PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
        [self.navigationController pushViewController:pwinfo animated:YES];
        [pwinfo release];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ///////////////////////////////////
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAccountInfoRequest) name:@"BecomeActive" object:nil];
    
    //(测试)默认设置用户已 防沉迷
    
    //测试
//    maxIssueCount = 0;
    issuearr = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    if (canBack) {
        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goback)];
        self.CP_navigation.leftBarButtonItem = left;
    }
    else {
        [self.CP_navigation setHidesBackButton:YES];
        self.CP_navigation.rightBarButtonItem = [Info homeItemTarget:self action:@selector(goRoot)];
    }
    
//	UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
    UIImageView *backImageV = [[UIImageView alloc] init];
    backImageV.backgroundColor=[UIColor clearColor];
	backImageV.frame = self.mainView.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];
    self.mainView.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
	
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif
    
}

- (void)resetTitle {
    NSString *caizhong = [GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId];
//    if ([self.betInfo.lotteryId isEqualToString:@"107"]) {
//        caizhong = [GC_LotteryType lotteryNameWithLotteryID:@"119"];
//    }
    self.CP_navigation.titleLabel.font = [UIFont systemFontOfSize:18];
    self.CP_navigation.title = [NSString stringWithFormat:@"%@ %@期",caizhong,self.betInfo.issue];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passWordOpenUrl) name:@"passWordOpenUrl" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetPassWord) name:@"resetPassWord" object:nil];
	[myTableView reloadData];
	if ([self.dataArray count]!= 0) {
		sendBtn.enabled = YES;
        sendBtn.alpha=1;
        [sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	}
	else {
//		sendBtn.enabled = NO;
        sendBtn.alpha=0.5;
        [sendBtn removeTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	}
	[multipleTF resignFirstResponder];
    //	[zhuiText resignFirstResponder];
    
    [self updateData];
    
	//[self updateData];
    if ([self.betInfo.issue length] == 0) {
        [self getIssure];
    }
    else {
        [self resetTitle];
    }
    if (![GC_UserInfo sharedInstance].accountManage) {
        if (![GC_HttpService sharedInstance].sessionId) {
            [self performSelector:@selector(getAccountInfoRequest) withObject:nil afterDelay:3];
        }
        else {
            [self getAccountInfoRequest];
        }
    }
    if ([[[Info getInstance] userName] length] > 0) {
        zhanghuLabel.hidden = NO;
    }
    else {
         zhanghuLabel.hidden = YES;
    }
    
    [self keydis];
    if (betInfo && betInfo.baomiType != 3) {
        if (self.betInfo.baomiType == 1) {
            baomiButton.buttonName.text = @"保密";
        }
        else if (self.betInfo.baomiType == 2) {
            baomiButton.buttonName.text = @"截止后公开";
        }
        else if (self.betInfo.baomiType == 4) {
            baomiButton.buttonName.text = @"隐藏";
        }
        else {
            baomiButton.buttonName.text = @"公开";
        }
        
        betInfo.baomiType = [SharedMethod changeBaoMiTypeByTitle:baomiButton.buttonName.text];
    }
}
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resetPassWord" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"passWordOpenUrl" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    //   [[NSNotificationCenter defaultCenter] removeObjectForKey:UIKeyboardDidShowNotification];
    [gckeyView dissKeyFunc];
     multipleTF.textColor = [UIColor blackColor];
}

/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (goucaishuziinfotype == GouCaiShuZiInfoTypeShuangSeqiu) {
		NSString *info = [dataArray objectAtIndex:indexPath.row];
		NSInteger lines = ([info length]/3 -1)/7 +1;
		if (lines != 1) {
//			return 35 +23*(lines -1);
            return 35 +23*(lines -1)+10;
		}
        if (self.betInfo.modeType == Shuangseqiudantuo) {
            NSInteger lines = (([info length]/3 - 1))/7 +1;
            if (lines != 1) {
//                return 35 +23*(lines -1);
                return 35 +23*(lines -1)+10;
            }
        }
        
	}
	else if (goucaishuziinfotype == GouCaiShuZiInfoTypeShiXuanWu || goucaishuziinfotype == GouCaiShuZiInfoTypeGDShiXuanWu || goucaishuziinfotype == GouCaiShuZiInfoTypeJXShiXuanWu || goucaishuziinfotype == GouCaiShuZiInfoTypeHBShiXuanWu || goucaishuziinfotype == GouCaiShuZiInfoTypeShanXiShiXuanWu) {
		NSString *info = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"Num"];
		CGSize maxSize = CGSizeMake(140, 1000);
		CGSize expectedSize = [info sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
        NSLog(@"%f",expectedSize.height);
        if (expectedSize.height <33) {
            expectedSize.height = 33+6;
        }
//		return expectedSize.height + 6;
        return expectedSize.height + 6;
		
	}
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeDaleTou) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
        if (self.betInfo.modeType == Daletoudantuo) {
            NSInteger lines = (([info length]/3 - 1))/7 +1;
            if (lines != 1) {
//                return 35 +23*(lines -1);
                return 35 +23*(lines -1)+10;
            }
        }
        info = [info stringByReplacingOccurrencesOfString:@"_:_" withString:@"_"];
        info = [info stringByReplacingOccurrencesOfString:@"_,_" withString:@"_"];
		NSInteger lines = (([info length]/3 -1))/7 +1;
		if (lines != 1) {
//			return 31 +23*(lines -1);
            return 35 +23*(lines -1)+10;
		}
    }
//    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeFuCai3D || goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie5 ||  goucaishuziinfotype == GouCaiShuZiInfoTypeQiXingCai) {
//        NSString *info = [dataArray objectAtIndex:indexPath.row];
//        NSLog(@"%d",info.length);
////        if (info.length > 54) {
////            return 82;
////        }
////        if (info.length > 37) {
////            return 65;
////        }
////        if (info.length > 20) {
////            return 48;
////        }
////        return 33;
//        if(info.length > 161)
//        {
//            return 87;
//        }
//        if(info.length > 107)
//        {
//            return 70;
//        }
//        if (info.length > 54) {
//            return 55;
//        }
//        if (info.length > 37) {
//            return 45;
//        }
//        if (info.length > 20) {
//            return 55;
//        }
//        return 45;
//        
//    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeFuCai3D) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
//        if(info.length > 161)
//        {
//            return 87;
//        }
//        if(info.length > 107)
//        {
//            return 70;
//        }
//        if (info.length > 54) {
//            return 55;
//        }
//        if (info.length > 37) {
//            return 45;
//        }
//        return 45;
        if (modeType == ThreeDzhixuanhezhi || modeType == ThreeDzusanHezhi || modeType == ThreeDzuliuHezhi)
        {
            if(info.length > 143)
            {
                return 78;
            }
            if(info.length > 95)
            {
                return 62;
            }
            if (info.length > 47) {
                return 45;
            }
            else
            {
                return 45;
            }
        }
        else
        {
            if (info.length > 31) {
                return 62;
            }
            return 45;
        }
        
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie5 ||  goucaishuziinfotype == GouCaiShuZiInfoTypeQiXingCai) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
        //        if (info.length > 54) {
        //            return 82;
        //        }
        //        if (info.length > 37) {
        //            return 65;
        //        }
        //        if (info.length > 20) {
        //            return 48;
        //        }
        //        return 33;
        if(info.length > 161)
        {
            return 87;
        }
        if(info.length > 107)
        {
            return 70;
        }
        if (info.length > 54) {
            return 55;
        }
        if (info.length > 37) {
            return 70;
        }
        if (info.length > 20) {
            return 54;
        }
        return 45;
        
    }
//    else if (goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie3) {
//        NSString *info = [dataArray objectAtIndex:indexPath.row];
//        if (info.length > 54) {
//            return 82;
//        }
//        if (info.length > 37) {
//            return 65;
//        }
//        if (info.length > 20) {
//            return 48;
//        }
//        return 33;
//    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypePaiLie3) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
        if (modeType == Array3zuliuHezhi || modeType == Array3zusanHezhi || modeType == Array3zhixuanHezhi)
        {
            if(info.length > 143)
            {
                return 78;
            }
            if(info.length > 95)
            {
                return 62;
            }
            if (info.length > 47) {
                return 45;
            }
            else
            {
                return 45;
            }
        }
        else
        {
            if (info.length > 31) {
                return 62;
            }
            return 45;
        }
//        NSRange asd=[info rangeOfString:@"#"];
//        if(asd.length)
//        {
//            info=[info substringFromIndex:asd.location+1];
//        }
//        info = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
//        NSLog(@"%@",info);
//        CGSize size=[info sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(150, 2000) lineBreakMode:NSLineBreakByCharWrapping];
//        NSLog(@"%f",size.height);
//        if (size.height >30) {
//            return size.height + 8+4;
//        }
//        else {
//            return 45;
//        }
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoType22Xuan5) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
		NSInteger lines = ([info length]/3 -1)/7 +1;
		if (lines != 1) {
//			return 35 +23*(lines -1);
            return 35 +23*(lines -1)+10;
		}
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeQiLeCai) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
        if (self.betInfo.modeType == Qilecaidantuo) {
            NSInteger lines = (([info length]/3 - 1))/7 +1;
            if (lines != 1) {
//                return 35 +23*(lines -1);
                return 35 +23*(lines -1)+10;
            }
        }
        
        info = [info stringByReplacingOccurrencesOfString:@"_,_" withString:@"_"];
		NSInteger lines = (([info length]/3 -1))/7 +1;
		if (lines != 1) {
//			return 31 +23*(lines -1);
            return 31 +23*(lines -1)+14;
		}
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeShiShiCai || self.goucaishuziinfotype == GouCaiShuZiInfoTypeCQShiShiCai) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
        info = [[info stringByReplacingOccurrencesOfString:@"^" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@"|"];
        if (modeType == SSCerxingzuxuandantuo) {
            info = [NSString stringWithFormat:@"[%@",[info stringByReplacingOccurrencesOfString:@"|" withString:@"]"]];
        }
        CGSize  size = [info sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(130, 2000)];
        if (size.height >35) {
            return size.height + 12;
        }
//        return 33;
        return 33+12;
    }
//    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeHappyTen) {
//        NSString *info = [dataArray objectAtIndex:indexPath.row];
//        if (info.length >= 62) {
//            return 82;
//        }
//        if (info.length > 42) {
//            return 65;
//        }
//        if (info.length >= 23) {
//            return 48;
//        }
//        return 33;
//    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeHappyTen) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
        NSLog(@"%@",info);
        NSRange asd=[info rangeOfString:@"#"];
        if(asd.length)
        {
            info=[info substringFromIndex:asd.location+1];
        }
        info = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
        NSLog(@"%@",info);
//        NSLog(@"%d",info.length);
//        if(info.length > 161)
//        {
//            return 100;
//        }
//        if(info.length > 107)
//        {
//            return 86;
//        }
//        if (info.length > 54) {
//            return 70;
//        }
//        if (info.length > 31) {
//            return 54;
//        }
//        return 45;
        CGSize size=[info sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(150, 2000) lineBreakMode:NSLineBreakByCharWrapping];
        NSLog(@"%f",size.height);
        if (size.height >30) {
            return size.height + 8+4;
        }
        else {
            return 45;
        }
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeKuaiSan) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
        if (info.length > 40) {
//            return 65;
            return 70;
        }
        if (info.length > 22) {
//            return 48;
            return 54;
        }
    }
    else if (goucaishuziinfotype == GouCaiShuZiInfoTypeKuaiLePuke) {
        NSString *info = [dataArray objectAtIndex:indexPath.row];
        if (info.length > 3) {
            info = [info substringFromIndex:3];
        }
        [self changePuke:info];
//        CGSize  size = [info sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(135, 2000)];
        CGSize  size = [info sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(135, 2000)];
        
        if (size.height >30) {
            return size.height + 12+8;
        }
        else {
//            return 35;
            return 45;
        }
    }
    
	return 35+10;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    if (goucaishuziinfotype == GouCaiShuZiInfoTypeShiXuanWu || goucaishuziinfotype == GouCaiShuZiInfoTypeGDShiXuanWu || goucaishuziinfotype == GouCaiShuZiInfoTypeJXShiXuanWu || goucaishuziinfotype == GouCaiShuZiInfoTypeHBShiXuanWu || goucaishuziinfotype == GouCaiShuZiInfoTypeShanXiShiXuanWu) {
		ShiYiXuanWuCell *cell = (ShiYiXuanWuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[ShiYiXuanWuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			cell.shiyixuanwuCellDelegate = self;
		}
		[cell LoadData:[dataArray objectAtIndex:indexPath.row]];
		return cell;
	}
    ShuangSeQiuCell *cell = (ShuangSeQiuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ShuangSeQiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		cell.shuangseqiuCellDelegate = self;
    }
    NSLog(@"lott = %d, mode = %d", self.betInfo.lotteryType, self.betInfo.modeType);
    cell.lotteryType = self.betInfo.lotteryType;
    cell.modeType = self.betInfo.modeType;
	[cell LoadData:[dataArray objectAtIndex:indexPath.row]];
    
    // Configure the cell...
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    
//    [editeView removeFromSuperview];
    [buyResult release];

    [issuearr release];
    [buttonLabel1 release];
	self.dataArray = nil;
	self.betInfo = nil;
	[myTableView release];
	[betInfo release];
	[httpRequest clearDelegatesAndCancel];
	[httpRequest release];
    [ahttpRequest clearDelegatesAndCancel];
	[ahttpRequest release];
    [counthttpRequest clearDelegatesAndCancel];
    self.counthttpRequest = nil;
//	[zhuiView release];
    self.sysIssure = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    
    [super dealloc];
}

//充值请求
- (void)returnSysTime:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime] afterDelay:1];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime]];
        [chongzhi release];
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message {
    
    if (alertView.tag == 101) {
		if (buttonIndex == 1) {
            self.passWord = message;
			[self.httpRequest clearDelegatesAndCancel];
			NSString *name = [[Info getInstance] login_name];
			NSString *password = self.passWord;
			self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
			[httpRequest setTimeOutSeconds:20.0];
			[httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
			[httpRequest setDidFailSelector:@selector(recivedFail:)];
			[httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
			[httpRequest setDelegate:self];
			[httpRequest startAsynchronous];
			
		}
	}
    
    if (alertView.tag == 998) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"oneAlertView"];
        if (buttonIndex == 1) {
            
            BOOL pwInfoBool = NO;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
                NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
                
                
                for (int i = 0; i < [allUserArr count]; i++) {
                    //        NSArray * userArr = [];
                    NSString * userString = [allUserArr objectAtIndex:i];
                    NSArray * userArr = [userString componentsSeparatedByString:@" "];
                    if ([userArr count] == 3) {
                        
                        if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                            
                            pwInfoBool = YES;
                            
                            break;
                        }
                        
                    }
                    
                }
                
            }
            
            if (pwInfoBool) {
                TestViewController * test = [[TestViewController alloc] init];
                [self.navigationController pushViewController:test animated:YES];
                [test release];
            }else{
                PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
                [self.navigationController pushViewController:pwinfo animated:YES];
                [pwinfo release];
                
            }
        }else{
            
            [self getBuyLotteryRequest];
        }
        
    }
    
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 119) {
        if (buttonIndex == 1) {
            [self getBuyLotteryRequest];
        }
    }
    if (alertView.tag == 109) {
        if (buttonIndex == 1) {
//#ifdef isYueYuBan
            //            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
            //                GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
            //                upmpView.chongZhiType = ChongZhiTypeZhiFuBao;
            //                [self.navigationController pushViewController:upmpView animated:YES];
            //                [upmpView release];
            //            }else{
            GC_TopUpViewController * toUp = [[GC_TopUpViewController alloc] init];
            [self.navigationController pushViewController:toUp animated:YES];
            [toUp release];
            //            }
            
//#else
//            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
//            
//            [httpRequest clearDelegatesAndCancel];
//            self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
//            [httpRequest setRequestMethod:@"POST"];
//            [httpRequest addCommHeaders];
//            [httpRequest setPostBody:postData];
//            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//            [httpRequest setDelegate:self];
//            [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
//            [httpRequest startAsynchronous];
//#endif
            
        }
    }
    if (alertView.tag == 999) {
        if (buttonIndex == 1) {
        baomiButton.buttonName.text = alertView.alertSegement.selectBtn.buttonName.text;
        }
    }
    
	if (alertView.tag == 101) {
		if (buttonIndex == 1) {
			[self.httpRequest clearDelegatesAndCancel];
			NSString *name = [[Info getInstance] login_name];
			NSString *password = self.passWord;
			self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
			[httpRequest setTimeOutSeconds:20.0];
			[httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
			[httpRequest setDidFailSelector:@selector(recivedFail:)];
			[httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
			[httpRequest setDelegate:self];
			[httpRequest startAsynchronous];
			
		}
	}
    if (alertView.tag == 103) {
        self.betInfo.issue = self.sysIssure;
        NSLog(@"slef = %@", self.sysIssure );
        // sendBtn.enabled = NO;
        [self resetTitle];
        [btn4 removeTarget:self action:@selector(calculateFunc) forControlEvents:UIControlEventTouchUpInside];
        [btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
        //        [btn4 setImage:UIImageGetImageFromName(@"TZ960.png") forState:UIControlStateNormal];
//        btn4bg.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        btn4bg.image = [UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        zhuiTextStr = 0;
        zhuiLable.text = @"追号设置";
        [issuearr removeAllObjects];
        [betInfo.betlist removeAllObjects];
        dobackbool = NO;
        //        label4.hidden = NO;
        //        textbgimage.hidden = NO;
        //        multipleTF.hidden = NO;
        //        addbutton.hidden = NO;
        //        jianbutton.hidden = NO;
        multiBtn.enabled = YES;
        addbutton.enabled = YES;
        jianbutton.enabled = YES;
        [self updateData];
    }
    if (alertView.tag == 104) {
        if (buttonIndex == 1) {
            self.betInfo.issue = self.sysIssure;
            [self resetTitle];
            [self getBuyLotteryRequest];
        }
    }
    if (alertView.tag == 105) {
        if (buttonIndex == 1) {
            [[Info getInstance] setCaipaocount:[[Info getInstance] caipaocount]+ 1];
            [self getBuyLotteryRequest];
        }
    }
    if (alertView.tag == 2315) {
        if (buttonIndex == 0) {
            [self.dataArray removeAllObjects];
            if ([self.dataArray count] == 0) {
                //		sendBtn.enabled = NO;
                sendBtn.alpha=0.5;
                [sendBtn removeTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
                
                [btn4 removeTarget:self action:@selector(calculateFunc) forControlEvents:UIControlEventTouchUpInside];
                [btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
                btn4bg.image = [UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
                zhuiTextStr = 0;
                zhuiLable.text = @"追号设置";
                [issuearr removeAllObjects];
                [betInfo.betlist removeAllObjects];
                dobackbool = NO;
                multiBtn.enabled = YES;
                addbutton.enabled = YES;
                jianbutton.enabled = YES;
            }
        }
        if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 2] isKindOfClass:[KuaiSanTuiJianViewCotroller class]]) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 3] animated:YES];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            [MobClick event:@"event_goumai_chenggong" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.nikeName = [[Info getInstance] nickName] ;
            info.canBack = self.canBack;
            // info.title = @"投注详情";
            NSString *caizhong = [GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId];
//            if ([self.betInfo.lotteryId isEqualToString:@"107"]) {
//                caizhong = [GC_LotteryType lotteryNameWithLotteryID:@"119"];
//            }
            if ([caizhong length]) {
                info.lottoryName = caizhong;
            }
            else {
                info.lottoryName = caizhong;
            }
            
            if (zhuiTextStr > 0) {
                info.waibubool = YES;
                info.chuanzhuihao = [NSString stringWithFormat:@"1|%d", (int)zhuiTextStr+1];
            }
            
            info.issure = self.betInfo.issue;
            [self.navigationController pushViewController:info animated:YES];
            [info release];
        }
        
        [self requestFangChenMi];
    }
    
    if(alertView.tag == 1234)
    {

    }
}

//投注成功回调
- (void)CP_TouZhuAlert:(CP_TouZhuAlert *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
        info.nikeName = [[Info getInstance] nickName] ;
        info.canBack = self.canBack;
        info.orderId = chooseView.buyResult.number;
        info.issure = self.betInfo.issue;
        if (zhuiTextStr > 0) {
            info.waibubool = YES;
            info.chuanzhuihao = [NSString stringWithFormat:@"1|%d", (int)zhuiTextStr+1];
        }
        [self.navigationController pushViewController:info animated:YES];
        [info release];
    }
    
    [self requestFangChenMi];
}

//防沉迷弹窗
-(void)showFangChenMiText:(NSString *)_text andImageNum:(int)_imgNum
{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"投注站提示您" message:_text delegate:self cancelButtonTitle:@"休息一下" otherButtonTitles:nil,nil];
    alert.alertTpye = textAndImage;
    alert.tag = 1234;
    if(_imgNum%9 == 1 || _imgNum%9 == 2 || _imgNum%9 == 3){
        alert.imageName = @"anti-addiction_1.png";

    }
    if(_imgNum%9 == 4 || _imgNum%9 == 5 || _imgNum%9 == 6){
        alert.imageName = @"anti-addiction_2.png";
        
    }

    if(_imgNum%9 == 7 || _imgNum%9 == 8 || _imgNum%9 == 0){
        alert.imageName = @"anti-addiction_3.png";
        
    }

    [alert show];
    [alert release];
}


#pragma mark -
#pragma mark ASIHTTPRequestDelegate

//获取余额
- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
		GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData]WithRequest:request];
        if (aManage != nil && aManage.returnId != 3000){
            [GC_UserInfo sharedInstance].accountManage = aManage;
        }
		[aManage release];
        [self updateData];
    }
}

- (void)reqStartTogetherBuyFinished:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        
        IssueObtain *obtain = [[IssueObtain alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        
        if ([obtain.issuestring length] != 0 && obtain.issuestring) {
            NSArray * arr = [obtain.issuestring componentsSeparatedByString:@","];
            [issuearr removeAllObjects];
            if (![self.betInfo.issue isEqualToString:[arr objectAtIndex:0]]) {
                [issuearr addObject:self.betInfo.issue];
            }
            
            [issuearr addObjectsFromArray:arr];
        }
        
        
        
        [obtain release];
        [self calculateFunc];
    }
    
}
- (BOOL)typeFunc{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
        
        
        for (int i = 0; i < [allUserArr count]; i++) {
            //        NSArray * userArr = [];
            NSString * userString = [allUserArr objectAtIndex:i];
            NSArray * userArr = [userString componentsSeparatedByString:@" "];
            if ([userArr count] == 3) {
                
                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                    NSString * typestr = [userArr objectAtIndex:2];
                    if ([typestr isEqualToString:@"1"]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }
                
            }
            
        }
        
    }
    return NO;
}
- (void)sleepPassWordViewShow{
    caiboAppDelegate * cai = [caiboAppDelegate getAppDelegate];
    PassWordView * pwv = [[PassWordView alloc] init];
    pwv.alpha = 0;
//    pwv.viewController = self;
    [cai.window addSubview:pwv];
    [pwv release];
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    pwv.alpha = 1;
    [UIView commitAnimations];
}

- (void)getBuyLotteryRequest
{
	if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"] intValue]&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
        
        if ([self typeFunc]) {
            
            [self sleepPassWordViewShow];
            
        }else{
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alert.tag = 101;
            [alert show];
            [alert release];
            
        }
        
       
		return;
	}
    if (isTingZhui) {
        betInfo.zhuihaoType = 0;
    }else{
        betInfo.zhuihaoType = 1;
    }
    
#ifdef isYueYuBan
    if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney || [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] == 0) {
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.shouldRemoveWhenOtherAppear = YES;
        alert.tag = 109;
        [alert show];
        [alert release];
        
        return;
    }
#else
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney || [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] == 0) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            return;
        }
        
    }else{
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < betInfo.payMoney) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            return;
        }
        
    }
    
#endif
    
    
    
    if (dobackbool) {// if ([betInfo.betlist count] > 1) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] zhuihaoreqBuyLotteryData:betInfo];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
        [httpRequest startAsynchronous];
    }else{
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqBuyLotteryData:betInfo reSend:[[Info getInstance] caipaocount]];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
        [httpRequest startAsynchronous];
        
    }
    
    
}

- (void)reqLotteryInfoFaild:(ASIHTTPRequest*)request{
    if (request.responseStatusCode >= 400){
        CP_UIAlertView * failAlertView = [[CP_UIAlertView alloc] initWithTitle:nil message:@"服务器忙于兑奖" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        failAlertView.tag = 112345678;
        [failAlertView show];
        [failAlertView release];
    }
    
}

- (void)reqLotteryInfoFinished:(ASIHTTPRequest*)request {
    IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
    if (issrecord.returnId == 3000) {
        [issrecord release];
        return;
    }
    self.betInfo.issue = issrecord.curIssue;
    [self resetTitle];
    
    [issrecord release];
    
}

-(void)requestFangChenMi
{
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"FangChenMiSwitch"] integerValue] == 1){
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] getUSerFangChenMiMessage];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(requestFangChenMiFinished:)];
        [httpRequest startAsynchronous];
        
    }

}
- (void)requestFangChenMiFinished:(ASIHTTPRequest*)request{
    
    if([request responseData]){
        
        GC_FangChenMiParse *fangchenmi = [[GC_FangChenMiParse alloc] initWithResponseData:request.responseData WithRequest:request];
        
        if(fangchenmi.returnID != 3000){
            
            if([fangchenmi.code integerValue] == 1){
                
                [self showFangChenMiText:fangchenmi.alertText andImageNum:(int)fangchenmi.alertNum];
                
            }
            
        }
        [fangchenmi release];
        
    }
}

- (void)reqBuyLotteryFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
		
        /*******
         投注结果：
         0	操作成功！
         1	用户未登录！
         2	余额不足，请充值！
         3	期次不存在	！
         4	不是当前期
         5	期次已截期
         6	方案已满
         7	发生异常
         8	扣款失败(可能是余额不足或者账号被锁定等)
         *******/
        
        //        NSString *title = @"投注结果";
        //        NSString *message = nil;
        //        if (buyResult.betResult == 0) {
        //            message = @"订单提交成功！\n可在投注记录中查看信息！\n祝您中大奖！";
        //            [[GC_HttpService sharedInstance] getPersonalInfoRequest];
        //        } else if (buyResult.betResult == 1) {
        //            message = @"用户未登录！";
        //        } else if (buyResult.betResult == 2) {
        //            message = @"余额不足，请充值！";
        //        } else if (buyResult.betResult == 3) {
        //            message = @"期次不存在	！";
        //        } else if (buyResult.betResult == 4) {
        //            message = @"不是当前期	！";
        //        } else if (buyResult.betResult == 5) {
        //            message = @"期次已截止！";
        //        } else if (buyResult.betResult == 6) {
        //            message = @"方案已满！";
        //        } else if (buyResult.betResult == 7) {
        //            message = @"发生异常！";
        //        } else if (buyResult.betResult == 8) {
        //            message = @"扣款失败！";
        //        }
        //        if (message != nil) {
        //            [AlertViewCenter alertViewWithTitle:title message:message cancelButtonTitle:@"确定"];
        //        }
        NSInteger resalut = 1;
#ifdef isYueYuBan
        self.buyResult = [[GC_BuyLottery alloc]initWithResponseData:[request responseData] isYueyu:YES WithRequest:request];
        resalut = 0;
#else
        self.buyResult = [[GC_BuyLottery alloc]initWithResponseData:[request responseData]WithRequest:request];
        resalut = 1;
#endif
        buyResult.lotteryId = self.betInfo.lotteryId;
        if (buyResult.returnId == 3000) {
            return;
        }
		if (buyResult.returnValue == resalut) {
			[multipleTF resignFirstResponder];
            if (resalut == 1) {
                if ([[UIApplication sharedApplication] canOpenURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]]) {
                    isGoBuy = YES;
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
                    [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] payUrlWith:buyResult] afterDelay:1];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyBack) name:@"BecomeActive" object:nil];
                    [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]];
                }
                
            }
            else {
                [MobClick event:@"event_goumai_chenggong" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
                
                CP_TouZhuAlert *alert = [[CP_TouZhuAlert alloc] init];
                alert.buyResult = buyResult;
                alert.delegate = self;
                [alert show];
                [alert release];

            }
            
            
        } else if (buyResult.returnValue == 4) {
            self.sysIssure = buyResult.curIssure;
            if ([betInfo.betlist count] > 1) {
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"当期期号过期提示" message:@"请重新设置追号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 103;
                [alert show];
                [alert release];
            }
            else {
                if ([self.sysIssure length] == 0) {
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"此彩种已经截期" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 0;
                    [alert show];
                    [alert release];
                }
                else {
                    
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@期已截止，当前只能投注%@期，是否继续投注？",self.betInfo.issue,self.sysIssure] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 104;
                    [alert show];
                    [alert release];
                }
                
            }
            
			
		}
#ifdef isYueYuBan
        else  if(buyResult.returnValue == 2){
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            
        }
        else if (buyResult.returnValue == 10) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您之前已经投过此注，是否继续投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 105;
            [alert show];
            [alert release];
        }else if (buyResult.returnValue == 9){
            
            NSString * h5url = @"http://h5123.cmwb.com/lottery/nearStation/toMap.jsp";
            
            MyWebViewController *webview = [[MyWebViewController alloc] init];
            [webview LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
            webview.delegate= self;
            webview.hiddenNav = NO;
            [self.navigationController pushViewController:webview animated:YES];
            [webview release];
            
        }
#else
#endif
        else{
            [[caiboAppDelegate getAppDelegate] showMessage:@"投注失败"];
        }
        
    }
    
}

- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
	NSString *responseStr = [request responseString];
	
	if ([responseStr isEqualToString:@"fail"])
	{
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"密码不正确"];
	}
	else {
		UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
		if (!userInfo) {
			caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
			[cai showMessage:@"密码不正确"];
			return;
		}
        [userInfo release];
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"oneAlertView"] intValue] == 0) {
            CP_UIAlertView * alear = [[CP_UIAlertView alloc] initWithTitle:@"设置手势密码" message:@"" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"马上设置",nil];
            alear.delegate = self;
            alear.tag = 998;
            alear.alertTpye = twoTextType;
            [alear show];
        }else{
            [self getBuyLotteryRequest];
        }

		
	}
}

#pragma mark CPZhankaiViewDelegte

- (void)ZhankaiViewClicke:(CPZhanKaiView *)_zhankaiView {
    if (_zhankaiView.isOpen) {
    }
    else {
    }
}

- (void)buttonRemovButton:(GC_UIkeyView *)keyView{
    [gckeyView dissKeyFunc];
     multipleTF.textColor = [UIColor blackColor];
    [self keydis];
}

- (void)keyViewDelegateView:(GC_UIkeyView *)keyView jianPanClicke:(NSInteger)sender{

    if (sender == 11) {
        [gckeyView dissKeyFunc];
         multipleTF.textColor = [UIColor blackColor];
        [self keydis];
    }
    else if (sender == 10) {
        multipleTF.text = [NSString stringWithFormat:@"%d",[multipleTF.text intValue]/10];
    }
    else {
        if (multipleTF.textColor == [ UIColor lightGrayColor]) {
            multipleTF.text = [NSString stringWithFormat:@"%d", (int)sender];
        }
        else {
            multipleTF.text = [NSString stringWithFormat:@"%d",(int)[multipleTF.text intValue] * 10 + (int)sender];
        }
        
    }
    if ([multipleTF.text intValue] > maxMultiple) {
        multipleTF.text = [NSString stringWithFormat:@"%d",maxMultiple];
    }
    if ([multipleTF.text intValue] <= 0) {
        multipleTF.textColor = [ UIColor lightGrayColor];
    }
    else {
        multipleTF.textColor = [ UIColor blackColor];
    }
    [self updateData];
    
}

- (void)keyshow{
    infoBackImage.isOpen = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
#ifdef isCaiPiaoForIPad
    infoBackImage.frame = CGRectMake(infoBackImage.frame.origin.x, 140 + 288-14, infoBackImage.frame.size.width, 195+3);
#else
//    infoBackImage.frame = CGRectMake(infoBackImage.frame.origin.x, 140-14, infoBackImage.frame.size.width, 195+3);
    infoBackImage.frame = CGRectMake(infoBackImage.frame.origin.x, self.mainView.frame.size.height-infoBackImage.frame.size.height - 54*4-2.5, infoBackImage.frame.size.width, 195+3);
//    myTableView.frame=CGRectMake(0, 46, 320, self.mainView.frame.size.height-46-44-50-195);
#endif
    
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}

- (void)keydis{
    infoBackImage.isOpen = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
#ifdef isCaiPiaoForIPad
    infoBackImage.frame = CGRectMake(10 + 35, 250 + 288, 300, 85);
#else
//    infoBackImage.frame = CGRectMake(0, 250-14, 320, 85);
    infoBackImage.frame = CGRectMake(0, self.mainView.frame.size.height-44-50-85, 320, 85);
//    myTableView.frame=CGRectMake(0, 46, 320, self.mainView.frame.size.height-46-44-50-85);
#endif
    
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
    if ([multipleTF.text intValue] <= 0) {
        multipleTF.text = @"1";
    }
}

- (NSString *) changePuke:(NSString *)puke {
    NSArray *array = [puke componentsSeparatedByString:@","];
    NSMutableArray *ballArray = [NSMutableArray array];
    for (NSString *strBall in array) {
        NSInteger num = [strBall intValue];
        if (self.betInfo.modeType == KuaiLePuKeTongHua || self.betInfo.modeType == KuaiLePuKeTongHuaShun) {
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"♠黑桃"];
            }
            else if ([strBall isEqualToString:@"02"]) {
                [ballArray addObject:@"♥红桃"];
            }
            else if ([strBall isEqualToString:@"03"]) {
                [ballArray addObject:@"♣梅花"];
            }
            else if ([strBall isEqualToString:@"04"]) {
                [ballArray addObject:@"♦方块"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if (self.betInfo.modeType >= KuaiLePuKeRen1 && self.betInfo.modeType <= KuaiLePuKeRen6) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d",(int)num]];
            }
            else if (num == 1) {
                [ballArray addObject:@"A"];
            }
            else if (num == 11) {
                [ballArray addObject:@"J"];
            }
            else if (num == 12) {
                [ballArray addObject:@"Q"];
            }
            else if (num == 13) {
                [ballArray addObject:@"K"];
            }
        }
        else if (self.betInfo.modeType == KuaiLePuKeDuiZi) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d",(int)num,(int)num]];
            }
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"AA"];
            }
            else if ([strBall isEqualToString:@"11"]) {
                [ballArray addObject:@"JJ"];
            }
            else if ([strBall isEqualToString:@"12"]) {
                [ballArray addObject:@"QQ"];
            }
            else if ([strBall isEqualToString:@"13"]) {
                [ballArray addObject:@"KK"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if (self.betInfo.modeType == KuaiLePuKeBaoZi) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d%d",(int)num,(int)num,(int)num]];
            }
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"AAA"];
            }
            else if ([strBall isEqualToString:@"11"]) {
                [ballArray addObject:@"JJJ"];
            }
            else if ([strBall isEqualToString:@"12"]) {
                [ballArray addObject:@"QQQ"];
            }
            else if ([strBall isEqualToString:@"13"]) {
                [ballArray addObject:@"KKK"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if (self.betInfo.modeType == KuaiLePuKeShunZi) {
            if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
            else if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"A23"];
            }
            else if (num >= 1 && num <= 8) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d%d",(int)num,(int)num + 1,(int)num + 2]];
            }
            else if (num == 9) {
                [ballArray addObject:@"910J"];
            }
            else if (num == 10) {
                [ballArray addObject:@"10JQ"];
            }
            else if (num == 11) {
                [ballArray addObject:@"JQK"];
            }
            else if (num == 12) {
                [ballArray addObject:@"QKA"];
            }
        }
    }
    if (self.betInfo.modeType >= KuaiLePuKeRen1 && self.betInfo.modeType <= KuaiLePuKeRen6) {
        return [ballArray componentsJoinedByString:@""];
    }
    return [ballArray componentsJoinedByString:@" "];
}

- (void)rengouSelcte {
    if (infoBackImage.isOpen) {
        if ([multipleTF.text isEqualToString:@""]) {
            multipleTF.text = [NSString stringWithFormat:@"%d", (int)textcount];
        }
        [gckeyView dissKeyFunc];
        multipleTF.textColor = [UIColor blackColor];
        [self keydis];
    }else{
        
        textcount =  [multipleTF.text intValue];
        multipleTF.textColor = [UIColor lightGrayColor];
        [gckeyView showKeyFunc];
        [self keyshow];
        
    }
    
}

#pragma mark -
#pragma mark ShuangSeQiuCellDelegate

- (void)deleteCell:(UITableViewCell *)shuangseCell {
	NSIndexPath *indexPath = [myTableView indexPathForCell:shuangseCell];
	[self.dataArray removeObjectAtIndex:indexPath.row];
	if ([self.dataArray count] == 0) {
//		sendBtn.enabled = NO;
        sendBtn.alpha=0.5;
        [sendBtn removeTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        
        [btn4 removeTarget:self action:@selector(calculateFunc) forControlEvents:UIControlEventTouchUpInside];
        [btn4 addTarget:self action:@selector(zhuiHaoAction) forControlEvents:UIControlEventTouchUpInside];
        //        [btn4 setImage:UIImageGetImageFromName(@"TZ960.png") forState:UIControlStateNormal];
//        btn4bg.image = [UIImageGetImageFromName(@"TYD960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        btn4bg.image = [UIImageGetImageFromName(@"tongyongxuanzhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        zhuiTextStr = 0;
        zhuiLable.text = @"追号设置";
        [issuearr removeAllObjects];
        [betInfo.betlist removeAllObjects];
        dobackbool = NO;
        multiBtn.enabled = YES;
        addbutton.enabled = YES;
        jianbutton.enabled = YES;
        //        label4.hidden = NO;
        //        textbgimage.hidden = NO;
        //        multipleTF.hidden = NO;
        //        addbutton.hidden = NO;
        //        jianbutton.hidden = NO;
	}
	[myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[self updateData];
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    