//
//  CalculateViewController.m
//  caibo
//
//  Created by houchenguang on 12-11-2.
//
//

#import "CalculateViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "GC_HttpService.h"
#import "IssueObtain.h"
#import "QuartzCore/QuartzCore.h"
#import "CP_PTButton.h"
#import "SharedDefine.h"

//#import <MobileCoreServices/MobileCoreServices.h>

@interface CalculateViewController ()

@end

@implementation CalculateViewController
@synthesize jisuanType;
@synthesize betInfo;
@synthesize httpRequest;
@synthesize issuearr;
@synthesize morenbeishu;
@synthesize delegate;
@synthesize isTingZhui;
@synthesize zhuijiabool;
//@synthesize isConfirm;

- (void)touchesbgview{
    if (shouyibut.tag == 1) {
        //shouyibut.tag = 0;
        [self performSelector:@selector(pressshouyishu:) withObject:shouyibut afterDelay:0];
        
    }
    [countTextField resignFirstResponder];
    [baifenTextField resignFirstResponder];
    //    [self updateData];
    yorn = YES;
    countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
    
    
    [self jineHightWidth];
    [myTableView reloadData];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [[self nextResponder] touchesBegan:touches withEvent:event];
    if (keyboardShowBool) {
        [self doneButton:nil];
        [self touchesbgview];
    }
    
    
    
    [super touchesBegan:touches withEvent:event];
}
- (void)returnPop:(NSMutableArray *)gcbet;{
    
    if ([delegate respondsToSelector:@selector(returnPop:)]) {
        //        [delegate returnPop:betinfocopy];
    }
}

- (void)returnBetInfoData:(GC_BetInfo *)gcbetinfo{
    if ([delegate respondsToSelector:@selector(returnBetInfoData:)]) {
        [delegate returnBetInfoData:betInfo];
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)goback {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
	[self returnBetInfoData:betinfocopy];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [gckeyView dissKeyFunc];
     countTextField.textColor = [UIColor redColor];
    [self returnBetInfoData:betinfocopy];
    [super viewWillDisappear:animated];
}


- (void)pressshouyishu:(UIButton *)sender{
    if (sender.tag == 0) {
        sender.tag = 1;
        jiantouima.image = UIImageGetImageFromName(@"JT960.png");
        
        //        tourula.frame = CGRectMake(10, 15, 200, 20);
        //        tourula.hidden = NO;
        //        shoula.frame = CGRectMake(10, 42, 60, 20);
        //        textimage1.frame = CGRectMake(70, 36, 39, 31);
        //        baifenTextField.frame= CGRectMake(1, 8, 39, 20);
        //        baifenla.frame = CGRectMake(114, 42, 20, 20);
        //        jisuanbut.frame= CGRectMake(210, 18, 94, 43);
        
        
        //        jilabel.frame = jisuanbut.bounds;
        
        
        [UIView beginAnimations:@"nddd" context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        
        
        
        zhanbgimage.frame = CGRectMake(0, 95, 320, 80);
        [zhanbgimage.layer setMasksToBounds:YES];
       
        
        
        
        [UIView commitAnimations];
        
        
    }else{
        sender.tag = 0;
        jiantouima.image = UIImageGetImageFromName(@"JT960_2.png");
        
        [UIView beginAnimations:@"ndd" context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        
        
        
        zhanbgimage.frame = CGRectMake(0, 95, 320, 0);
        [zhanbgimage.layer setMasksToBounds:YES];
        
        
        
        
        [UIView commitAnimations];
        
        
    }
    
}

- (NSInteger)wanfaqufen{
    NSLog(@"betinfo.wanfa = %@ ，caizhong = %@ ", betInfo.wanfa,betInfo.caizhong);
    if ([betInfo.caizhong isEqualToString:@"006"]) {
        if ([betInfo.wanfa isEqualToString:@"23"]) {
            return  4;//大小单双
        }else if ([betInfo.wanfa isEqualToString:@"01"]) {
            return 10;//一星复式
        }else if ([betInfo.wanfa isEqualToString:@"02"]) {
            return 100;//二星复式
        }else if ([betInfo.wanfa isEqualToString:@"06"]) {
            return 50;//二星组选
        }else if ([betInfo.wanfa isEqualToString:@"03"]) {
            return 1000;//三星复式
        }else if ([betInfo.wanfa isEqualToString:@"04"]) {
            return 10000;//四星复式
        }else if ([betInfo.wanfa isEqualToString:@"05"]) {
            return 100000;//五星复式
        }
        //        else if ([betInfo.wanfa isEqualToString:@"14"]) {
        //            return 20000;//五星通选
        //        }
        else if ([betInfo.wanfa isEqualToString:@"20"]) {
            //任选一
            return 11;
        }else if ([betInfo.wanfa isEqualToString:@"21"]) {
            //任选2
            return 116;
        }else if ([betInfo.wanfa isEqualToString:@"22"]) {
            //任选三
            return 1000;
        }else if ([betInfo.wanfa isEqualToString:@""]) {
            
        }
    }else if ([betInfo.caizhong isEqualToString:LOTTERY_ID_JIANGXI_11]){
        
        if ([betInfo.wanfa isEqualToString:@"02"]) {
            // 任选二
            return 6;
        }else if ([betInfo.wanfa isEqualToString:@"03"]) {
            //任选三
            return 19;
        }else if ([betInfo.wanfa isEqualToString:@"04"]) {
            //任选四
            return 78;
        }else if ([betInfo.wanfa isEqualToString:@"05"]) {
            //任选五
            return 540;
        }else if ([betInfo.wanfa isEqualToString:@"06"]) {
            //任选六
            return 90;
        }else if ([betInfo.wanfa isEqualToString:@"07"]) {
            //任选七
            return 26;
        }else if ([betInfo.wanfa isEqualToString:@"08"]) {
            //任选八
            return 9;
        }else if ([betInfo.wanfa isEqualToString:@"09"]) {
            //前一
            return 13;
        }else if ([betInfo.wanfa isEqualToString:@"10"]) {
            //前二
            return 130;
        }else if ([betInfo.wanfa isEqualToString:@"11"]) {
            //前三
            return 1170;
        }else if ([betInfo.wanfa isEqualToString:@"12"]) {
            //前三
            return 65;
        }else if ([betInfo.wanfa isEqualToString:@"13"]) {
            //前三
            return 195;
        }
        
    }else if ([betInfo.caizhong isEqualToString:@"121"]||[betInfo.caizhong isEqualToString:@"119"] ||[betInfo.caizhong isEqualToString:LOTTERY_ID_SHANXI_11] ||[betInfo.caizhong isEqualToString:LOTTERY_ID_HEBEI_11] ){//广东11选5
        
        if ([betInfo.wanfa isEqualToString:@"02"]) {
            // 任选二
            return 6;
        }else if ([betInfo.wanfa isEqualToString:@"03"]) {
            //任选三
            return 19;
        }else if ([betInfo.wanfa isEqualToString:@"04"]) {
            //任选四
            return 78;
        }else if ([betInfo.wanfa isEqualToString:@"05"]) {
            //任选五
            return 540;
        }else if ([betInfo.wanfa isEqualToString:@"06"]) {
            //任选六
            return 90;
        }else if ([betInfo.wanfa isEqualToString:@"07"]) {
            //任选七
            return 26;
        }else if ([betInfo.wanfa isEqualToString:@"08"]) {
            //任选八
            return 9;
        }else if ([betInfo.wanfa isEqualToString:@"01"]) {
            //前一
            return 13;
        }else if ([betInfo.wanfa isEqualToString:@"09"]) {
            //前二
            return 130;
        }else if ([betInfo.wanfa isEqualToString:@"10"]) {
            //前三
            return 1170;
        }else if ([betInfo.wanfa isEqualToString:@"11"]) {
            //前三
            return 65;
        }else if ([betInfo.wanfa isEqualToString:@"12"]) {
            //前三
            return 195;
        }
        
    }else if ([betInfo.caizhong isEqualToString:@"002"]){//福彩3D
        
        if ([betInfo.wanfa isEqualToString:@"01"]||[betInfo.wanfa isEqualToString:@"04"]) {
            //直选、胆拖
            return 1040;
        }else if ([betInfo.wanfa isEqualToString:@"02"]) {
            //组三
            return 346;
        }else if ([betInfo.wanfa isEqualToString:@"03"]) {
            //组六
            return 173;
        }
        
        
    }else  if ([betInfo.caizhong isEqualToString:@"108"]){//排列三
        
        if ([betInfo.wanfa isEqualToString:@"01"]) {
            //直选
            return 1040;
        }else if ([betInfo.wanfa isEqualToString:@"03"]) {
            //组三
            return 346;
        }else if ([betInfo.wanfa isEqualToString:@"04"]) {
            //组六
            return 173;
        }
    }else if ([betInfo.caizhong isEqualToString:@"012"] || [betInfo.caizhong isEqualToString:@"013"] || [betInfo.caizhong isEqualToString:@"019"] || [betInfo.caizhong isEqualToString:LOTTERY_ID_JILIN] || [betInfo.caizhong isEqualToString:LOTTERY_ID_ANHUI]){//快三 江苏快三
        
        if ([betInfo.wanfa isEqualToString:@"01"]) {
            //和值
            
            NSArray * betArr = [betInfo.betNumber componentsSeparatedByString:@"#"];
            
            if (betArr.count > 1) {
                NSString * allNumber = [betArr objectAtIndex:1];
                NSArray * numArr = [allNumber componentsSeparatedByString:@","];
                if (betInfo.bets == 1) {
                    
                    if ([[numArr objectAtIndex:0] intValue] == 4) {
                        return 80;
                    }if ([[numArr objectAtIndex:0] intValue] == 5) {
                        return 40;
                    }if ([[numArr objectAtIndex:0] intValue] == 6) {
                        return 25;
                    }if ([[numArr objectAtIndex:0] intValue] == 7) {
                        return 16;
                    }if ([[numArr objectAtIndex:0] intValue] == 8) {
                        return 12;
                    }if ([[numArr objectAtIndex:0] intValue] == 9) {
                        return 10;
                    }if ([[numArr objectAtIndex:0] intValue] == 10) {
                        return 9;
                    }if ([[numArr objectAtIndex:0] intValue] == 11) {
                        return 9;
                    }if ([[numArr objectAtIndex:0] intValue] == 12) {
                        return 10;
                    }if ([[numArr objectAtIndex:0] intValue] == 13) {
                        return 12;
                    }if ([[numArr objectAtIndex:0] intValue] == 14) {
                        return 16;
                    }if ([[numArr objectAtIndex:0] intValue] == 15) {
                        return 25;
                    }if ([[numArr objectAtIndex:0] intValue] == 16) {
                        return 40;
                    }if ([[numArr objectAtIndex:0] intValue] == 17) {
                        return 80;
                    }
                }
                
            }
            
            
            
            
            return 1000;
        }else if ([betInfo.wanfa isEqualToString:@"02"]) {
            //三同号单选
            return 240;
        }else if ([betInfo.wanfa isEqualToString:@"03"]) {
            //三连号通选
            return 10;
        }else if ([betInfo.wanfa isEqualToString:@"04"]) {
            //三同号通选
            return 40;
        }else if ([betInfo.wanfa isEqualToString:@"05"]) {
            //三不同号
            return 40;
        }else if ([betInfo.wanfa isEqualToString:@"06"]) {
            //二同号单选
            return 80;
        }else if ([betInfo.wanfa isEqualToString:@"07"]) {
            //二同号复选
            return 15;
        }else if ([betInfo.wanfa isEqualToString:@"08"]) {
            //二不同号
            return 8;
        }
    }else if ([betInfo.caizhong isEqualToString:@"011"]){//快乐十分
        
        if ([betInfo.wanfa isEqualToString:@"01"]) {
            //选一数投
            return 24;
        }else if ([betInfo.wanfa isEqualToString:@"02"]) {
            //选一红投
            return 8;
        }else if ([betInfo.wanfa isEqualToString:@"03"]) {
            //选二连组
            return 31;
        }else if ([betInfo.wanfa isEqualToString:@"04"]) {
            //选二连直
            return 62;
        }else if ([betInfo.wanfa isEqualToString:@"05"]) {
            //选三前组
            return 1300;
        }else if ([betInfo.wanfa isEqualToString:@"06"]) {
            //选三前直
            return 8000;
        }else if ([betInfo.wanfa isEqualToString:@"07"]) {
            //任选二
            return 8;
        }else if ([betInfo.wanfa isEqualToString:@"08"]) {
            //任选三
            return 24;
        }else if ([betInfo.wanfa isEqualToString:@"09"]) {
            //任选四
            return 80;
        }else if ([betInfo.wanfa isEqualToString:@"10"]) {
            //任选五
            return 320;
        }
        
//        else if ([betInfo.wanfa isEqualToString:@"11"]) {
//            //猜大数
//            return 320;
//        }else if ([betInfo.wanfa isEqualToString:@"12"]) {
//            //猜单数
//            return 320;
//        }
        else if ([betInfo.wanfa isEqualToString:@"13"]) {
            //猜全数
            return 3;
        }
        
//        else if ([wanfa isEqualToString:@"11"]) {
//            return @"猜大数";
//        }
//        else if ([wanfa isEqualToString:@"12"]) {
//            return @"猜单数";
//        }
//        else if ([wanfa isEqualToString:@"13"]) {
//            return @"猜全数";
//        }
        
        
    }else if ([betInfo.caizhong isEqualToString:@"014"]){//重庆时时彩
        
        if ([betInfo.wanfa isEqualToString:@"01"]) {//一星直选
            return 10;
        }else if ([betInfo.wanfa isEqualToString:@"02"]) {
            //二星直选
            return 100;
        }else if ([betInfo.wanfa isEqualToString:@"03"]) {
            //三星直选
            return 1000;
        }else if ([betInfo.wanfa isEqualToString:@"05"]) {
            //五星直选
            return 100000;
        }else if ([betInfo.wanfa isEqualToString:@"06"]) {
            //二星组选
            return 50;
        }else if ([betInfo.wanfa isEqualToString:@"07"]) {
            //三星组三
            return 320;
        }else if ([betInfo.wanfa isEqualToString:@"08"]) {
            //三星组六
            return 160;
        }else if ([betInfo.wanfa isEqualToString:@"23"]) {
            //大小单双
            return 4;
        }
    
    }
    
    return 0;
}


- (void)jisuanhanshuxx{
    [self updateData];
    NSMutableArray * betlistarr = [NSMutableArray arrayWithCapacity:0];
    [betlistarr addObjectsFromArray:betInfo.betlist];
    NSString * ddd = [betInfo.betlist objectAtIndex:0];
    NSArray * betarr = [ddd componentsSeparatedByString:@":"];
    if (betarr.count > 1) {
        tourubeishu = [[betarr objectAtIndex:1] intValue];
    }
    else {
        tourubeishu = 1;
    }
    
    benqitouru = betInfo.price * tourubeishu;
    //leijitouru1 = leijitouru;
    leijitouru = leijitouru+benqitouru;
    benqishoyi = jiangjinshu * tourubeishu;
    leijishouyi = benqishoyi - leijitouru;
    
    for (int i = 1; i < [betInfo.betlist count]; i++) {
        NSString * ddd1 = [betInfo.betlist objectAtIndex:i];
        NSArray * betarr1 = [ddd1 componentsSeparatedByString:@":"];
        
        float  e = (([baifenTextField.text intValue]*leijitouru)+(100*leijitouru))/((100*jiangjinshu)-(2*[baifenTextField.text intValue]*betInfo.bets)- (200*betInfo.bets));
        NSLog(@"e = %f", e);
        int inte = e/1;
        if (e == inte) {
            tourubeishu = e;
        }else if((e > inte)&& (e < inte+1)){
            tourubeishu = inte+1;
        }
        
        
        //  leijitouru = leijitouru-benqitouru;
        if (tourubeishu <=  [[betarr1 objectAtIndex:1] intValue]) {
            tourubeishu = [[betarr1 objectAtIndex:1] intValue];
        }
        // if (zhongjie == 1) {
        benqitouru = betInfo.price * tourubeishu;
        //leijitouru1 = leijitouru;
        leijitouru = leijitouru+benqitouru;
        benqishoyi = jiangjinshu * tourubeishu;
        leijishouyi = benqishoyi - leijitouru;
        //}
        
        
        if (tourubeishu > 10000) {
             caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请修改收益率值。"];
            betInfo.betlist = betlistarr;
            return;
        }
        
        
        float shouyifloat = (leijishouyi / leijitouru)*100;
        if (shouyifloat >= [baifenTextField.text intValue]) {
            
            
            NSString * betstring = [betInfo.betlist objectAtIndex:i];
            NSArray * arrbet = [betstring componentsSeparatedByString:@":"];
            NSString * zuistr = [NSString stringWithFormat:@"%@:%ld", [arrbet objectAtIndex:0], (long)tourubeishu];
            [betInfo.betlist replaceObjectAtIndex:i withObject:zuistr];
            
        }
        
        
        
        
        
        
    }
    countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
    
    [self jineHightWidth];
    
    [myTableView reloadData];
    
    
}


- (void)pressjisuanbutton:(UIButton *)sender{//计算按钮
    
    
    if ([baifenTextField.text isEqualToString:@""]) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"请输入收益率"];
        return;
    }
    
    isTingZhui = YES;
    sw.on = YES;
    betInfo.zhuihaoType = 0;
    
    tourubeishu = 0;
    benqitouru = 0;
    leijitouru = 0;
    jiangjinshu = [self wanfaqufen];
    benqishoyi = 0;
    
    
    [self jisuanhanshuxx];
    
    
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)clearfunc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    //    [betInfo.betlist removeObjectAtIndex:[betInfo.betlist count]-1];
    NSArray * betarr = [NSArray arrayWithObject:[betInfo.betlist objectAtIndex:0]];//[betInfo.betlist objectAtIndex:0];
    [betInfo.betlist removeAllObjects];
    [betInfo.betlist addObjectsFromArray:betarr];
    [self returnBetInfoData:betInfo];
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)pressTextFliedButton{
//    if (!imageViewkey) {
//        imageViewkey = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 0)];
//        imageViewkey.backgroundColor = [UIColor clearColor];
//        imageViewkey.userInteractionEnabled = YES;
//        //imageViewkey.image = UIImageGetImageFromName(@"ZHBBG960.png");
//        imageViewkey.backgroundColor = [UIColor darkGrayColor];
//        [imageViewkey.layer setMasksToBounds:YES];
//        //CGRectMake(22, 98, 256, 110)
//        
//        float width = 35;
//        float height = 40;
//
//        NSInteger tagcount = 0;
//        for (int i = 0; i < 2; i++) {
//            for (int a = 0; a < 7; a++) {
//                
//                UIButton * dataButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                dataButton.frame = CGRectMake(a*width+8.5*a+15, i*height+16+15*i, width, height);
//                [dataButton setImage:[UIImage imageNamed:@"jianpan-zhengchang.png"] forState:UIControlStateNormal];
//                [dataButton setImage:[UIImage imageNamed:@"jianpan-anxia.png"] forState:UIControlStateSelected];
//                dataButton.tag = tagcount;
//                [dataButton addTarget:self action:@selector(jianPanClicke:) forControlEvents:UIControlEventTouchUpInside];
//                if (tagcount <= 9 || tagcount == 11) {
//                    
//                    UILabel * buttonTitle = [[UILabel alloc] initWithFrame:dataButton.bounds];
//                    buttonTitle.backgroundColor = [UIColor clearColor];
//                    buttonTitle.textAlignment = NSTextAlignmentCenter;
//                    buttonTitle.textColor = [UIColor  whiteColor];
//                    buttonTitle.font = [UIFont boldSystemFontOfSize:13];
//                   
//                    if (tagcount <= 9) {
//                        buttonTitle.text = [NSString stringWithFormat:@"%d", tagcount];
//                    }else if(tagcount == 11){
//                        dataButton.frame = CGRectMake(a*width+8.5*a+42.5, i*height+8+22.5*i, width*2, height);
//                        buttonTitle.frame = dataButton.bounds;
//                        [dataButton setImage:[UIImage imageNamed:@"jianpan-queding-zhengchang_1.png"] forState:UIControlStateNormal];
//                        [dataButton setImage:[UIImage imageNamed:@"jianpan-queding-anxia_1.png"] forState:UIControlStateSelected ];
//                        buttonTitle.text = @"确定";
//                        
//                    }
//                    if (tagcount>6&&tagcount<11) {
//                        dataButton.frame = CGRectMake(a*width+8.5*a+38, i*height+8+22.5*i, width, height);
//                    }
//                    [dataButton addSubview:buttonTitle];
//                    [buttonTitle release];
//                    
//                }else if(tagcount == 10){
//                    
//                    dataButton.frame = CGRectMake(a*width+8.5*a+38, i*height+8+22.5*i, width, height);
//                    [dataButton setImage:[UIImage imageNamed:@"jianpan-shanchu-zhengchang.png"] forState:UIControlStateNormal];
//                    [dataButton setImage:[UIImage imageNamed:@"jianpan-shanchu-anxia.png"] forState:UIControlStateSelected ];
//                    
//                }else if (tagcount > 11)
//                {
//                    dataButton.hidden = YES;
//                }
//                tagcount += 1;
//                [imageViewkey addSubview:dataButton];
//                
//            }
//        }
//        
//        
//        
//        [upbgImage addSubview:imageViewkey];
//    }
//    
//    
//}

- (void)showkey{
    
    [UIView beginAnimations:@"aaa" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    imageViewkey.frame = CGRectMake(0, 70  , 320, 54*4);
    
    
    
    if (([self wanfaqufen]) && sylBool == NO) {
        
        upimage.frame = CGRectMake(0, 10, 320, 168+113);
        upbgImage.frame = CGRectMake(0, 10, 320,130+113);
        leijila.frame = CGRectMake(6-5, 141+54*4, 80, 25);
        //        jinela.frame = CGRectMake(98, 141+113, 80, 25);
        //        yuanla.frame = CGRectMake(98, 141+113, 80, 25);
        jinela.frame = CGRectMake(98+10, 141+54*4, jinela.frame.size.width, jinela.frame.size.height);
        yuanla.frame = CGRectMake(98+jinela.frame.size.width+15, 141+54*4,yuanla.frame.size.width, yuanla.frame.size.height);
        quanchengView.frame = CGRectMake(0, 70+54*4, 300-14, 57);
        belowImage.frame = CGRectMake(0, 186+54*4, 320, self.mainView.frame.size.height - 196 - 113-44);
        helpButton.frame = CGRectMake(200+20, 141+54*4, 65+40, 35);
    }else{
        upimage.frame = CGRectMake(0, 10, 320, 109+113);
        upbgImage.frame = CGRectMake(0, 10, 320,72+113);
        leijila.frame = CGRectMake(6-5, 82+54*4, 80, 25);
        //        jinela.frame = CGRectMake(98, 82+113, 80, 25);
        //        yuanla.frame = CGRectMake(98, 82+113, 80, 25);
        jinela.frame = CGRectMake(98+10, 82+54*4, jinela.frame.size.width, jinela.frame.size.height);
        yuanla.frame = CGRectMake(98+jinela.frame.size.width+15, 82+54*4,yuanla.frame.size.width, yuanla.frame.size.height);
        belowImage.frame = CGRectMake(0, 127+54*4, 320, self.mainView.frame.size.height - 137-113-44);
        helpButton.frame = CGRectMake(200+20, 82+54*4, 65+40, 35);
        
    }
    
    myTableView.frame = CGRectMake(0, 5, 320, belowImage.frame.size.height+ 10);
    
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}


- (void)hidenJianPan {
    
    [UIView beginAnimations:@"ddd" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    imageViewkey.frame = CGRectMake(0, 70, 320, 0);
    
    if (([self wanfaqufen]) && sylBool == NO) {
        
        upimage.frame = CGRectMake(0, 10, 320, 168);
        upbgImage.frame = CGRectMake(0, 10, 320,130);
        leijila.frame = CGRectMake(6-5, 141, 80, 25);
        //        jinela.frame = CGRectMake(98, 141, 80, 25);
        //        yuanla.frame = CGRectMake(98, 141, 80, 25);
        jinela.frame = CGRectMake(98+10, 141, jinela.frame.size.width, jinela.frame.size.height);
        yuanla.frame = CGRectMake(98+jinela.frame.size.width+15, 141,yuanla.frame.size.width, yuanla.frame.size.height);
        quanchengView.frame = CGRectMake(0, 70, 300-14, 57);
        belowImage.frame = CGRectMake(0, 186, 320, self.mainView.frame.size.height - 196-44);
        helpButton.frame = CGRectMake(200+20, 141, 65+40, 35);
    }else{
        
        upimage.frame = CGRectMake(0, 10, 320, 109);
        upbgImage.frame = CGRectMake(0, 10, 320,72);
        leijila.frame = CGRectMake(6-5, 82, 80, 25);
        //        jinela.frame = CGRectMake(98, 82, 80, 25);
        //        yuanla.frame = CGRectMake(98, 82, 80, 25);
        jinela.frame = CGRectMake(98+10, 82, jinela.frame.size.width, jinela.frame.size.height);
        yuanla.frame = CGRectMake(98+jinela.frame.size.width+15, 82,yuanla.frame.size.width, yuanla.frame.size.height);
        belowImage.frame = CGRectMake(0, 127, 320, self.mainView.frame.size.height - 137-44);
        helpButton.frame = CGRectMake(200+20, 82, 65+40, 35);
        
    }
    
    myTableView.frame = CGRectMake(0, 5, 320, belowImage.frame.size.height+ 10);
    
    
    
    
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
    
}
- (void)pressaddbutton:(UIButton *)sender{
    if ([countTextField.text isEqualToString:@"-1"] ) {
        return;
    }
    if (zhuiQiButton.tag == 1) {
        zhuiQiButton.tag = 0;
        [gckeyView dissKeyFunc];
         countTextField.textColor = [UIColor redColor];
        [self jineHightWidth];
        countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
        return;
    }
    if ([countTextField.text intValue] >= [issuearr count]-1) {
        
        countTextField.text = [NSString stringWithFormat:@"%d", (int)[issuearr count]-1];
        //        if (sender) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:[NSString stringWithFormat:@"最多可追%d期", (int)[issuearr count] -1 ]];
        //        }
        
        
    }else{
        
        //        NSString * strc = [betInfo.betlist objectAtIndex:[betInfo.betlist count]-1];
        //        NSArray * arrs = [strc componentsSeparatedByString:@":"];
        //        NSString * ssst = [arrs objectAtIndex:0];
        //        NSInteger diji = 0;
        //        for ( int i = 0; i < [issuearr count]; i++) {
        //            if ([ssst isEqualToString:[issuearr objectAtIndex:i]]) {
        //                diji = i;
        //                break;
        //            }
        //        }
        //        if (diji != [issuearr count]-1) {
        //            NSString * stri = [NSString stringWithFormat:@"%@:%@", [issuearr objectAtIndex:diji+1], morenbeishu];
        //            [betInfo.betlist addObject:stri];
        //        }else{
        //
        //            countTextField.text = [NSString stringWithFormat:@"%d", [betInfo.betlist count]-2];
        //            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        //            [cai showMessage:@"您已选择了可投注的最后一期。"];
        //
        //        }
        
        if ([countTextField.text intValue] >= [issuearr count]-1) {
            countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
            
        }else{
            NSString * stri = [NSString stringWithFormat:@"%@:%@", [issuearr objectAtIndex:[betInfo.betlist count]], morenbeishu];
            [betInfo.betlist addObject:stri];
            
        }
        
        NSString * str = [NSString stringWithFormat:@"%d",[countTextField.text intValue] + 1];
        countTextField.text = str;
    }
    
    [markArray addObject:@0];
    [buttonBoolArray addObject:@0];
    [self jineHightWidth];
    [myTableView reloadData];
}

- (void)buttonRemovButton:(GC_UIkeyView *)keyView{
    if (keyView.tag == 165) {
        [keyView dissKeyFunc];
    }else{
        [self sendButtonFunc];
    }
    
}

- (void)sendButtonFunc{
    [gckeyView dissKeyFunc];
     countTextField.textColor = [UIColor redColor];
    gckeyShowKey = NO;
    [self hidenJianPan];
    if([countTextField.text isEqualToString:@"0"]||[countTextField.text isEqualToString:@""]){
        countTextField.text = @"0";
    }
    NSLog(@"counttextfield = %d", [countTextField.text intValue]);
    if ([countTextField.text intValue] >= [betInfo.betlist count]-1) {
        
        if ([betInfo.betlist count] >= [issuearr count]) {
            countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您已选择了可投注的最后一期。"];
            return;
            
        }else{
            for ( int i = (int)[betInfo.betlist count] - 1; i < [countTextField.text intValue]; i++) {
                if ([issuearr count] > i+1) {
                    NSString * stri = [NSString stringWithFormat:@"%@:%@", [issuearr objectAtIndex:i+1], morenbeishu];
                    [betInfo.betlist addObject:stri];
                    [markArray addObject:@0];
                    [buttonBoolArray addObject:@0];
                }else{
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:[NSString stringWithFormat:@"当前只可追%d期", (int)[issuearr count]-1]];
                }
                
            }
            
            
        }
        
        NSString * str = [NSString stringWithFormat:@"%d",[countTextField.text intValue]];
        countTextField.text = str;
        [myTableView reloadData];
        
    }else{
        
        //            if ([countTextField.text intValue] == 0) {
        //                countTextField.text = @"0";
        //            }
        NSInteger beginCount = [betInfo.betlist count];
        for (int i = 0; i < beginCount - [countTextField.text intValue]-1; i++) {
            [betInfo.betlist removeObjectAtIndex:[betInfo.betlist count]-1];
            [markArray removeLastObject];
            [buttonBoolArray removeLastObject];
        }
        
        [myTableView reloadData];
        
    }
    
    
    [self jineHightWidth];

}

- (void)keyViewDelegateView:(GC_UIkeyView *)keyView jianPanClicke:(NSInteger)sender{

    
    if (keyView.tag == 165) {
        if (sender == 11) {
            
            [keyView dissKeyFunc];
            
        }else if (sender == 10) {
            
            baifenTextField.text = [NSString stringWithFormat:@"%d",[baifenTextField.text intValue]/10];
            if ([baifenTextField.text isEqualToString:@"0"]||[baifenTextField.text isEqualToString:@""]) {
                baifenTextField.text = @"";
                
            }
            
        }else {
            
            
            if (baifenTextField.textColor == [ UIColor lightGrayColor]) {
                baifenTextField.text = [NSString stringWithFormat:@"%ld", (long)sender];
            }
            else {
                baifenTextField.text = [NSString stringWithFormat:@"%d",(int)[baifenTextField.text intValue] * 10 + (int)sender];
            }
            
            //        countTextField.text = [NSString stringWithFormat:@"%d",[countTextField.text intValue] * 10 + sender];
//            if ([countTextField.text integerValue] > [issuearr count]-1) {
//                countTextField.text = [NSString stringWithFormat:@"%d", [issuearr count] - 1];
//            }
            
            
        }
        [self updateData];
    }else{
        if (sender == 11) {
            
            [self sendButtonFunc];
            
        }else if (sender == 10) {
            
            countTextField.text = [NSString stringWithFormat:@"%d",[countTextField.text intValue]/10];
            if ([countTextField.text isEqualToString:@"0"]||[countTextField.text isEqualToString:@""]) {
                countTextField.text = @"";
                
            }
            
        }else {
            
            
            if (countTextField.textColor == [ UIColor lightGrayColor]) {
                countTextField.text = [NSString stringWithFormat:@"%ld", (long)sender];
            }
            else {
                countTextField.text = [NSString stringWithFormat:@"%d",(int)[countTextField.text intValue] * 10 + (int)sender];
            }
            
            //        countTextField.text = [NSString stringWithFormat:@"%d",[countTextField.text intValue] * 10 + sender];
            if ([countTextField.text integerValue] > [issuearr count]-1) {
                countTextField.text = [NSString stringWithFormat:@"%d", (int)[issuearr count] - 1];
            }
            
            
        }
        countTextField.textColor = [UIColor redColor];
    
    }
    
    
    //    [self pressaddbutton:nil];
    
    
}


- (void)loadingIphone{
    
    betinfocopy = [[GC_BetInfo alloc] init];//[[NSMutableArray alloc] initWithCapacity:0];
    [betinfocopy.betlist addObjectsFromArray:betInfo.betlist];
    
    betinfocopy.lotteryType = betInfo.lotteryType;
	betinfocopy.baomiType = betInfo.baomiType;
    betinfocopy.lotteryId = betInfo.lotteryId;
    betinfocopy.issue = betInfo.issue;
    betinfocopy.modeType = betInfo.modeType;
    betinfocopy.betNumber = betInfo.betNumber;
    betinfocopy.bets = betInfo.bets;
    betinfocopy.price = betInfo.price;
    betinfocopy.multiple = betInfo.multiple;
    betinfocopy.totalParts = betInfo.totalParts;
    betinfocopy.rengouParts = betInfo.rengouParts;
    betinfocopy.baodiParts = betInfo.baodiParts;
    betinfocopy.tichengPercentage = betInfo.tichengPercentage;
    betinfocopy.secrecyType = betInfo.secrecyType;
    betinfocopy.endTime = betInfo.endTime;
    betinfocopy.schemeTitle = betInfo.schemeTitle;
    betinfocopy.schemeDescription = betInfo.schemeDescription;
    
    betinfocopy.prices = betInfo.prices;
    betinfocopy.zhuihaoType = betInfo.zhuihaoType;
    betinfocopy.payMoney = betInfo.payMoney;
    betinfocopy.betlist = betInfo.betlist;
    betinfocopy.caizhong = betInfo.caizhong;
    betinfocopy.wanfa = betInfo.wanfa;
    betinfocopy.stopMoney = betInfo.stopMoney;
    betinfocopy.beishu = betInfo.beishu;
    
    
    
    
	// Do any additional setup after loading the view.
    NSLog(@"%@, %@, %@",betInfo.wanfa, betInfo.caizhong, betInfo.lotteryId);
    NSLog(@"%@", betInfo.betlist);
    yorn = NO;
    panduanling = NO;
    baocunarr = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.CP_navigation.title = @"追号详情";
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goback)];
    self.CP_navigation.leftBarButtonItem = left;
    
    
    
    
    // 清除按钮
    UIButton * exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitLoginButton setBounds:CGRectMake(0, 0, 70, 40)];
    [exitLoginButton addTarget:self action:@selector(clearfunc) forControlEvents:UIControlEventTouchUpInside];
   
    UILabel *beginLabel = [[UILabel alloc] initWithFrame:exitLoginButton.bounds];
    beginLabel.backgroundColor = [UIColor clearColor];
    beginLabel.textColor = [UIColor whiteColor];
    beginLabel.text = @"清  除";
    beginLabel.font = [UIFont systemFontOfSize:15];
    beginLabel.textAlignment = NSTextAlignmentCenter;
    [exitLoginButton addSubview:beginLabel];
    [beginLabel release];
    UIBarButtonItem *barBtnItem = [[[UIBarButtonItem alloc] initWithCustomView:exitLoginButton] autorelease];
    self.CP_navigation.rightBarButtonItem = barBtnItem;

    
    // 大背景图
    // UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
    UIImageView *backImageV = [[UIImageView alloc] init];
    backImageV.backgroundColor = [UIColor whiteColor];
	backImageV.frame = self.view.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];
    
    
    // 上面最底层背景图
    upimage = [[UIImageView alloc] init];
    upimage.backgroundColor = [UIColor clearColor];
    upimage.userInteractionEnabled = YES;
    [self.mainView addSubview:upimage];
    [upimage release];
    
    // 圆框图
    upbgImage = [[UIImageView alloc] init] ;
    upbgImage.backgroundColor = [UIColor clearColor];
    // upbgImage.image = [UIImageGetImageFromName(@"zhuihaocellimage.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    upbgImage.userInteractionEnabled = YES;
    [upimage addSubview:upbgImage];
    [upbgImage release];
    
    
    
    // 追期按钮 tongyonglan.png
    zhuiQiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuiQiButton.frame = CGRectMake(15, 0, 69, 30);
    [zhuiQiButton addTarget:self action:@selector(pressZhuiQiButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *kuangImage = [[[UIImageView alloc] initWithFrame:zhuiQiButton.bounds] autorelease];
    kuangImage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7.5];
    [zhuiQiButton addSubview:kuangImage];
    [upbgImage addSubview:zhuiQiButton];
    
    
//    // 追期输入框图片
//    UIImageView * textimage = [[[UIImageView alloc] initWithFrame:zhuiQiButton.bounds] autorelease];
//    textimage.backgroundColor = [UIColor clearColor];
//    textimage.userInteractionEnabled = YES;
//    // textimage.image = [UIImageGetImageFromName(@"tongyonghui.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    [textimage setImage:[UIImageGetImageFromName(@"tongyonghui.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7]];
//    [zhuiQiButton addSubview:textimage];
    
    
    
    UILabel * zhuila = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 35, 31)];
    zhuila.backgroundColor = [UIColor clearColor];
    zhuila.text = @"追期";
    zhuila.textAlignment = NSTextAlignmentRight;
    zhuila.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    zhuila.font = [UIFont systemFontOfSize:14];
    [zhuiQiButton addSubview:zhuila];
    [zhuila release];
//
    
    
    
   
    
    
    
    
    // 追号输入
    countTextField = [[UILabel alloc] initWithFrame:CGRectMake(38, 6, 31, 20)];
    countTextField.backgroundColor = [UIColor clearColor];
    //countTextField.text = @"0";
    countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
    NSLog(@"co = %@", countTextField.text);
    countTextField.textAlignment = NSTextAlignmentCenter;
    countTextField.font = [UIFont systemFontOfSize:14];
   // countTextField.text = [NSString stringWithFormat:@"%d", [betInfo.betlist count]-1];
    countTextField.textColor = [UIColor redColor];
    [zhuiQiButton addSubview:countTextField];
    
   
    
    // 加减图片
    UIImageView *jiaJianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 12-12, 60, 30)];
    jiaJianImageView.image = [UIImage imageNamed:@"zhuiqi.png"];
//    jiaJianImageView.userInteractionEnabled = YES;
    [upbgImage addSubview:jiaJianImageView];
    [jiaJianImageView release];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(70, 0, 60, 30);
    addButton.backgroundColor = [UIColor clearColor];
    [addButton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
    [upbgImage addSubview:addButton];
   
    UIImageView *jiaImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(27, 19-12, 16, 16)] autorelease];
    jiaImageView.image = [UIImageGetImageFromName(@"jiahao-zhengchang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
//    jiaImageView.userInteractionEnabled = YES;
    [addButton addSubview:jiaImageView];
    
    UIButton *jianButton = [UIButton buttonWithType:UIButtonTypeCustom];
    jianButton.frame = CGRectMake(120, 0, 70, 30);
    //  [addButton setImage:[UIImage imageNamed:@"jiahao-anxia.png"] forState:UIControlStateSelected];
    jianButton.backgroundColor = [UIColor clearColor];
    [jianButton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
    [jiaJianImageView addSubview:jianButton];
    UIImageView *jianImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(7, 19-12, 16, 16)] autorelease];
    jianImageView.image = [UIImageGetImageFromName(@"jianhao-zhengchang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15] ;
//    jiaImageView.userInteractionEnabled = YES;
    [jianButton addSubview:jianImageView];
    [upbgImage addSubview:jianButton];
    
    
    
    
    
    // 中奖后停止
    UILabel * zhongjiangla = [[UILabel alloc] initWithFrame:CGRectMake(170, 12-12, 63, 30)];
    zhongjiangla.backgroundColor = [UIColor clearColor];
    zhongjiangla.text = @"中奖后停止";
    zhongjiangla.textAlignment = NSTextAlignmentCenter;
    zhongjiangla.textColor =  [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    zhongjiangla.font = [UIFont systemFontOfSize:12];
    [upbgImage addSubview:zhongjiangla];
    [zhongjiangla release];
    
    
    sw = [[CP_SWButton alloc] initWithFrame:CGRectMake(235, 13-12, 70, 32)];
    sw.onImageName = @"heji2-640_10.png";
    sw.offImageName = @"heji2-640_11.png";
    [upbgImage addSubview:sw];
    [sw addTarget:self action:@selector(zhuihaochange:) forControlEvents:UIControlEventValueChanged];
    sw.on = isTingZhui;
    [sw release];
    
    
    
    UILabel * maxIssueLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 44-12, 100, 28)];
    maxIssueLabel.backgroundColor = [UIColor clearColor];
    if (jisuanType == GouCaiShuZiInfoTypeShuangSeqiuJiSuan || jisuanType == GouCaiShuZiInfoTypeDaleTouJiSuan || jisuanType == GouCaiShuZiInfoTypeQiLeCaiJiSuan || jisuanType == GouCaiShuZiInfoTypeQiXingCaiJiSuan || jisuanType == GouCaiShuZiInfoTypePaiLie3JiSuan || jisuanType == GouCaiShuZiInfoTypePaiLie5JiSuan) {
        maxIssueLabel.text = @"最多可追99期";
    }else{
        maxIssueLabel.text = @"最多可追120期";
    }
    
    maxIssueLabel.textAlignment = NSTextAlignmentLeft;
    maxIssueLabel.textColor =  [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    maxIssueLabel.font = [UIFont systemFontOfSize:10];
    [upbgImage addSubview:maxIssueLabel];
    [maxIssueLabel release];
    
    
    
    leijila = [[UILabel alloc] initWithFrame:CGRectMake(6-5, 72, 80, 25)];
    leijila.text = @"累计金额";
    leijila.textAlignment = NSTextAlignmentCenter;
    leijila.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    leijila.font = [UIFont systemFontOfSize:14];
    leijila.backgroundColor = [UIColor clearColor];
    [upimage addSubview:leijila];
    
    
    
    jinela = [[UILabel alloc] initWithFrame:CGRectMake(125, 72, 0, 25)];
    jinela.backgroundColor = [UIColor clearColor];
    jinela.textColor = [UIColor redColor];
    jinela.font = [UIFont systemFontOfSize:14];
    [upimage addSubview:jinela];
    
    
    
    yuanla = [[UILabel alloc] initWithFrame:CGRectMake(160+20, 0, 0, 25)];
    yuanla.backgroundColor = [UIColor clearColor];
    yuanla.text = @"元";
    yuanla.font = [UIFont systemFontOfSize:14];
    yuanla.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    [upimage addSubview:yuanla];
    [yuanla release];
    
    belowImage = [[UIImageView alloc] init];
    belowImage.backgroundColor = [UIColor clearColor];
    belowImage.userInteractionEnabled = YES;
    [self.mainView addSubview:belowImage];
    [belowImage release];
    
    helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.backgroundColor = [UIColor clearColor];
    [helpButton addTarget:self action:@selector(pressHelpButton:) forControlEvents:UIControlEventTouchUpInside];
    [upimage addSubview:helpButton];
    
    
    
    if (([self wanfaqufen]) && sylBool == NO) {
        
        upimage.frame = CGRectMake(0, 10, 320, 168);
        upbgImage.frame = CGRectMake(0, 10, 320,130);
        leijila.frame = CGRectMake(6-5, 141, 80, 25);
        jinela.frame = CGRectMake(98+10, 141, 80, 25);
        yuanla.frame = CGRectMake(118, 141, 80, 25);
        belowImage.frame = CGRectMake(0, 186, 320, self.mainView.frame.size.height - 196-44);
        helpButton.frame = CGRectMake(200+20, 141, 65+40, 35);
        
        UIImageView * xianImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 0.5)];
        xianImage.backgroundColor = [UIColor clearColor];
        xianImage.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
        [upbgImage addSubview:xianImage];
        [xianImage release];
        
        
        quanchengView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320-14, 57)];
        quanchengView.backgroundColor = [UIColor clearColor];
        quanchengView.userInteractionEnabled = YES;
        [upbgImage addSubview:quanchengView];
        [quanchengView release];
        
        
        
        tourula = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, 250, 20)];
        tourula.backgroundColor = [UIColor clearColor];
        tourula.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        tourula.font = [UIFont systemFontOfSize:14];
        tourula.textAlignment = NSTextAlignmentLeft;
        [quanchengView addSubview:tourula];
        [tourula release];
        NSString * jinestr = [NSString stringWithFormat:@"投入注数             %d", betInfo.bets];
        tourula.text = jinestr;
        
      
        
        shoula = [[UILabel alloc] initWithFrame:CGRectMake(15-2, 101-65, 80, 20)];
        shoula.backgroundColor = [UIColor clearColor];
        shoula.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        shoula.text = @"全程收益率";
        shoula.textAlignment = NSTextAlignmentLeft;
        shoula.font = [UIFont systemFontOfSize:14];
        [quanchengView addSubview:shoula];
        [shoula release];
        
        
        shouyiImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 101-70, 35, 24)];//追号输入框图片
        shouyiImage.backgroundColor = [UIColor clearColor];
        shouyiImage.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7.5];
        shouyiImage.userInteractionEnabled = YES;
        [quanchengView addSubview:shouyiImage];
        [shouyiImage release];
        
        UIButton * shouyiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shouyiButton.frame = shouyiImage.bounds;
        shouyiButton.tag = 123;
        [shouyiButton addTarget:self action:@selector(pressShouyiButton:) forControlEvents:UIControlEventTouchUpInside];
        [shouyiImage addSubview:shouyiButton];
        
        
        baifenTextField = [[UITextField alloc] initWithFrame:CGRectMake(2, 5-2, 31, 20)];
        baifenTextField.delegate = self;
        baifenTextField.tag = 0;
        baifenTextField.keyboardType = UIKeyboardTypeNumberPad;
        baifenTextField.backgroundColor = [UIColor clearColor];
        baifenTextField.userInteractionEnabled = NO;
        baifenTextField.placeholder = @"50";
//        baifenTextField.text = @"50";
        baifenTextField.textAlignment = NSTextAlignmentCenter;
        baifenTextField.font = [UIFont systemFontOfSize:14];
        [shouyiButton addSubview:baifenTextField];
        [baifenTextField release];
        
        baifenla = [[UILabel alloc] initWithFrame:CGRectMake(140, 35, 20, 20)];
        baifenla.backgroundColor = [UIColor clearColor];
        baifenla.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
        baifenla.text = @"%";
        baifenla.textAlignment = NSTextAlignmentLeft;
        baifenla.font = [UIFont systemFontOfSize:14];
        [quanchengView addSubview:baifenla];
        [baifenla release];
        
        quanchengView.userInteractionEnabled = YES;
        jisuanbut = [UIButton buttonWithType:UIButtonTypeCustom];
        jisuanbut.frame= CGRectMake(228, 85-70, 75, 30);
        jisuanbut.backgroundColor = [UIColor redColor];
        [jisuanbut setTitle:@"计  算" forState:UIControlStateNormal];
        jisuanbut.titleLabel.font = [UIFont systemFontOfSize:15];
        [jisuanbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jisuanbut addTarget:self action:@selector(pressjisuanbutton:) forControlEvents:UIControlEventTouchUpInside];

        jisuanbut.layer.masksToBounds = YES;
//        // 设置边框的宽度
//        jisuanbut.layer.borderWidth = 1.0;
//        // 设置边框颜色
//        jisuanbut.layer.borderColor = [[UIColor redColor] CGColor];
        // 设置圆角半径
        jisuanbut.layer.cornerRadius = 5.0;
       
        [quanchengView addSubview:jisuanbut];
       
//        jilabel = [[UILabel alloc] initWithFrame:jisuanbut.bounds];
//        jilabel.backgroundColor = [UIColor clearColor];
//        jilabel.textAlignment = NSTextAlignmentCenter;
//        jilabel.textColor = [UIColor whiteColor];
//        jilabel.font = [UIFont systemFontOfSize:15];
//        jilabel.text = @"计  算";
//        jilabel.userInteractionEnabled = YES;
//        [jisuanbut addSubview:jilabel];
//        [jilabel release];
        
        
        
    }else{
        
        upimage.frame = CGRectMake(0, 10, 320, 109);
        upbgImage.frame = CGRectMake(0, 10, 320,72);
        leijila.frame = CGRectMake(6-5, 82, 80, 25);
        jinela.frame = CGRectMake(98+10, 82, 80, 25);
        yuanla.frame = CGRectMake(120+20, 82, 80, 25);
        belowImage.frame = CGRectMake(0, 127, 320, self.mainView.frame.size.height - 137-44);
        helpButton.frame = CGRectMake(200+20, 82, 65+40, 35);
    }
    
    
    UILabel * calculateInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    calculateInfo.backgroundColor = [UIColor clearColor];
    calculateInfo.text = @"如何计算";
    calculateInfo.textAlignment = NSTextAlignmentLeft;
    calculateInfo.textColor =  [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    calculateInfo.font = [UIFont systemFontOfSize:13];
    [helpButton addSubview:calculateInfo];
    [calculateInfo release];
    
    UIImageView * helpImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 0, 23, 23)];
    helpImage.image = UIImageGetImageFromName(@"zhuihaowenhao.png");
    helpImage.backgroundColor = [UIColor clearColor];
    [helpButton addSubview:helpImage];
    [helpImage release];
    
    if (!(([self wanfaqufen]) && sylBool == NO)) {
        
        helpButton.hidden = YES;
    }else{
        helpButton.hidden = NO;
    }
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, belowImage.frame.size.height+ 10) style:UITableViewStylePlain];
    myTableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [belowImage addSubview: myTableView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillhide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    
   
    NSInteger countIssue = 0;
    if (jisuanType == GouCaiShuZiInfoTypeShuangSeqiuJiSuan || jisuanType == GouCaiShuZiInfoTypeDaleTouJiSuan || jisuanType == GouCaiShuZiInfoTypeQiLeCaiJiSuan || jisuanType == GouCaiShuZiInfoTypeQiXingCaiJiSuan || jisuanType == GouCaiShuZiInfoTypePaiLie3JiSuan || jisuanType == GouCaiShuZiInfoTypePaiLie5JiSuan) {
        countIssue = 99;
    }else{
       countIssue = 120;
    }
    
    
    if ([issuearr count] < countIssue) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:[NSString stringWithFormat:@"当前只可追%d期", (int)[issuearr count]-1]];
    }
    
    
    
    
    
    // 底部横条
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 372, 320, 44)];
	[self.mainView addSubview:im];
    if (IS_IPHONE_5) {
        im.frame = CGRectMake(0, 460, 320, 44);
    }
    im.userInteractionEnabled = YES;
    im.backgroundColor = [UIColor blackColor];
    
    UIButton * sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    buttonLabel1.text = @"选好了";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:22];
    [sendBtn addSubview:buttonLabel1];
	sendBtn.frame = CGRectMake(120, 10, 80, 30);
	[im addSubview:sendBtn];
    [im release];
    [buttonLabel1 release];
    
    
    gckeyView = [[GC_UIkeyView alloc] initWithFrame:self.mainView.bounds withType:downShowKey];
    gckeyView.hightFloat = 64;//44+self.isIOS7Pianyi;
    gckeyView.delegate = self;
    [self.mainView addSubview:gckeyView];
    [gckeyView release];

    
    
}

- (void)pressShouyiButton:(UIButton *)sender{

    GC_UIkeyView * shouyiKeyView = [[GC_UIkeyView alloc] initWithFrame:self.mainView.bounds withType:blankShowKey];
    shouyiKeyView.tag = 165;
    shouyiKeyView.hightFloat = 0;//44+self.isIOS7Pianyi;
    shouyiKeyView.delegate = self;
    [self.mainView addSubview:shouyiKeyView];
    [shouyiKeyView release];
    [shouyiKeyView showKeyFunc];

}

- (void)pressHelpButton:(UIButton *)sender{
    
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"收益率计算说明" message:@"1.收益率计算适用于有固定奖金数字彩玩法。目前有11选5、快3、快乐十分、时时彩、福彩3D可以进行计算，其他玩法不可进行此计算。\n\n2. 可以设置全程收益率百分数，点击计算，随后我们会根据您当前的信息内容，为您计算，并且快速显示出计算内容。显示后，您也可以根据自己的喜好，进行更改显示的投注内容。" delegate:self
                                                cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    alert.delegate = self;
    alert.alertTpye = explainType;
    [alert show];
    [alert release];
    
}

- (void)jineHightWidth{
    zongzhu = 0;
    
    for (int i = 0; i < [betInfo.betlist count]; i++) {
        NSString * zhushustr = [betInfo.betlist objectAtIndex:i];
        NSLog(@"zhu = %@", zhushustr);
        NSArray * zhuarr = [zhushustr componentsSeparatedByString:@":"];
        int zhu = 1;
        if (zhuarr.count > 1) {
            zhu = [[zhuarr objectAtIndex:1] intValue];
        }
        
        zongzhu = zongzhu + zhu;
    }
    
    
    
      NSString * jinestr2 = @"";
//    if (isConfirm) {
        if (zhuijiabool) {
            jinestr2 = [NSString stringWithFormat:@"%d.00", zongzhu * betInfo.bets*3];
        }else{
            jinestr2 = [NSString stringWithFormat:@"%d.00", zongzhu * betInfo.bets*2];
        }
//    }
    
    UIFont * font2 = [UIFont systemFontOfSize:14];
    CGSize  size2 = CGSizeMake(137, 20);
    CGSize labelSize2 = [jinestr2 sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:NSLineBreakByWordWrapping];
    
    jinela.text = jinestr2;
    [jinestr2 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(192,2000) lineBreakMode:UILineBreakModeCharacterWrap];
    jinela.frame = CGRectMake(98+10, jinela.frame.origin.y, labelSize2.width, 25);
    yuanla.frame = CGRectMake(98+jinela.frame.size.width+15, yuanla.frame.origin.y, 20, 25);
}

- (void)pressZhuiQiButton:(UIButton *)sender{
    
        
    
//    [self pressTextFliedButton];
    if (gckeyShowKey == NO) {
        [baifenTextField resignFirstResponder];
        gckeyShowKey = YES;
        
        for (int i = 0; i < [markArray count]; i++) {
            [markArray replaceObjectAtIndex:i withObject:@0];
            [buttonBoolArray replaceObjectAtIndex:i withObject:@0];
        }
        
        [myTableView reloadData];
//        [baifenTextField resignFirstResponder];
        [gckeyView showKeyFunc];
         countTextField.textColor = [UIColor lightGrayColor];
        [self showkey];
    }else{
        gckeyShowKey = NO;
        
    
        [gckeyView dissKeyFunc];
         countTextField.textColor = [UIColor redColor];
        countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
        [self hidenJianPan];
    }
    
    [self jineHightWidth];
    

    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    buttonBoolArray = [[NSMutableArray alloc] init];
    markArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < betInfo.betlist.count; i++) {
        [markArray addObject:@0];
        [buttonBoolArray addObject:@0];
    }
//    isConfirm = NO;
    
    if ([self wanfaqufen]) {
        
        float datafloat = (float)[self wanfaqufen];
        float maxfloat = 0;
        if (zhuijiabool) {
            maxfloat = (datafloat - (betInfo.bets*3))/(betInfo.bets*3)*100;
        }else{
            maxfloat = (datafloat - (betInfo.bets*2))/(betInfo.bets*2)*100;
        }
        if (maxfloat <= 0) {
            sylBool = YES;
        }
        
        
        if ([betInfo.caizhong isEqualToString:@"012"] || [betInfo.caizhong isEqualToString:@"013"] || [betInfo.caizhong isEqualToString:@"019"] || [betInfo.caizhong isEqualToString:LOTTERY_ID_JILIN] || [betInfo.caizhong isEqualToString:LOTTERY_ID_ANHUI]){//快三,江苏快三
            
            if ([betInfo.wanfa isEqualToString:@"01"]) {
                //和值
                
                
                if (betInfo.bets == 1) {
                    if (sylBool != YES) {
                        sylBool = NO;
                    }
                    
                    
                }else{
                    sylBool = YES;
                }
                
                
                
                
                
            }
        }
        
        if ([betInfo.caizhong isEqualToString:@"014"] && [betInfo.wanfa isEqualToString:@"14"]) {
            sylBool = YES;
        }
        
    }
    
    
    
    [self loadingIphone];
    [self jineHightWidth];
    
}



- (void)send{
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    if (zhuijiabool) {
        betInfo.payMoney = zongzhu * betInfo.bets*3;//[jinela.text intValue];
    }else{
        betInfo.payMoney = zongzhu * betInfo.bets*2;//[jinela.text intValue];
    }
    
    
	[self returnBetInfoData:betInfo];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 增加数字键盘 done按钮


- (void)viewMoveAnimationShow{
    
    //    [UIView beginAnimations:@"aaa" context:nil];
    //    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDuration:0.2];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    upimage.frame = CGRectMake(upimage.frame.origin.x, upimage.frame.origin.y - keyhiegh+10, upimage.frame.size.width, upimage.frame.size.height);
    belowImage.frame = CGRectMake(belowImage.frame.origin.x, belowImage.frame.origin.y - keyhiegh+10, belowImage.frame.size.width, belowImage.frame.size.height - 44);
    
    if (([self wanfaqufen]) && sylBool == NO) {
        
        belowImage.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height - keyhiegh-44);
        
    }else{
        
        belowImage.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height - keyhiegh-44);
    }
    myTableView.frame = CGRectMake(0, 0, 320, belowImage.frame.size.height+ 10);
    
    
    //    [UIView setAnimationRepeatAutoreverses:NO];
    //    [UIView commitAnimations];
    
}
- (void)viewMoveAnimationHide{
    
    [UIView beginAnimations:@"aaa" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    upimage.frame = CGRectMake(upimage.frame.origin.x, upimage.frame.origin.y , upimage.frame.size.width, upimage.frame.size.height);
    belowImage.frame = CGRectMake(belowImage.frame.origin.x, belowImage.frame.origin.y , belowImage.frame.size.width, belowImage.frame.size.height-44);
    if (([self wanfaqufen]) && sylBool == NO) {
        
        belowImage.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height-44);
        
    }else{
        
        belowImage.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height-44);
    }
    myTableView.frame = CGRectMake(0, 2, 320, belowImage.frame.size.height+10);
    
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
    
    
}

- (void)keyboardWillhide:(NSNotification *)note{
    
    NSLog(@"asdfasdfasdfsadf");
    keyboardShowBool = NO;
  
//    [gckeyView dissKeyFunc];
    
}


- (void)keyboardWillShow:(NSNotification *)note
{
    keyboardShowBool = YES;
    // create custom button

    
    
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
    
    
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        keyhiegh = keyboard.frame.size.height;
        //if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)// OS 3.0
        NSLog(@"xkey = %@", [keyboard description]);
        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) ||(([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES))){
            if ([baifenTextField isFirstResponder]) {
                
                [keyboard addSubview:doneButton];
                
                
            }
        }
        
        
        
        
        if ([baifenTextField isFirstResponder]) {
            
            [gckeyView dissKeyFunc];
             countTextField.textColor = [UIColor redColor];
            for (int i = 0; i < [markArray count]; i++) {
                [markArray replaceObjectAtIndex:i withObject:@0];
                [buttonBoolArray replaceObjectAtIndex:i withObject:@0];
            }
            
            [myTableView reloadData];
            
        }else{
            [self viewMoveAnimationShow];
           
        }
        
        return;
    }
    
    if (![baifenTextField isFirstResponder]) {
        [self viewMoveAnimationShow];
        
    }else{
        [gckeyView dissKeyFunc];
         countTextField.textColor = [UIColor redColor];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (markArray.count != 0 && [[markArray objectAtIndex:indexPath.row]  isEqual: @1]) {
        return 50 + 54*4;
    }
    return 50;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return [countTextField.text intValue];
    
    
    
    
    return [betInfo.betlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellid = @"cellid";
    calculateCell * cell = (calculateCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[calculateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
    }
    cell.delegate = self;
    if (yorn) {
        [cell.textqihao resignFirstResponder];
    }
    if ([[markArray objectAtIndex:indexPath.row] isEqual:@1]) {
        cell.imageViewkey.frame = CGRectMake(0, 42, 320, 54*4);
    }else{
        cell.imageViewkey.frame = CGRectMake(0, 42, 320, 0);
    }
    
   
    
    cell.zhuijiaBOOL = zhuijiabool;
    cell.issuearr = issuearr;//所有期号
    cell.qianshu = betInfo.bets;
    cell.row = indexPath.row;
     cell.buttonBool = [[buttonBoolArray objectAtIndex:indexPath.row] intValue];
    if (indexPath.row < 9) {//号码
        cell.haolabel.text = [NSString stringWithFormat:@"0%d", (int)indexPath.row+1];
    }else{
        cell.haolabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
    }
    
    
    NSString * zuistr = [betInfo.betlist objectAtIndex:indexPath.row];
    NSArray * beishuarr = [zuistr componentsSeparatedByString:@":"];
    
    
    
    // [beishuarr objectAtIndex:0]
    NSString *str;
    if([[beishuarr objectAtIndex:0] length] >= 7)
    {
        str = [[beishuarr objectAtIndex:0] substringFromIndex:[[beishuarr objectAtIndex:0] length]-7];
    }
    else
    {
        str = [[beishuarr objectAtIndex:0] substringFromIndex:[[beishuarr objectAtIndex:0] length]-5];
    }
//    NSString  *str = [[beishuarr objectAtIndex:0] substringFromIndex:[[beishuarr objectAtIndex:0] length]-7];
    
    cell.labelqihao.text = [NSString stringWithFormat:@"%@期", str];
    if (beishuarr.count > 1) {
        cell.textqihao.text = [beishuarr objectAtIndex:1];//倍数
    }
    else {
        cell.textqihao.text = @"1";
    }
    
    
    //  cell.yuanlabel.text = [NSString stringWithFormat:@"%d", [cell.textqihao.text intValue]*2];//钱数
    if (zhuijiabool) {
        cell.yuanlabel.text = [NSString stringWithFormat:@"%d", [cell.textqihao.text intValue]*3*betInfo.bets];
    }else{
        cell.yuanlabel.text = [NSString stringWithFormat:@"%d", [cell.textqihao.text intValue]*2*betInfo.bets];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)showkey1:(calculateCell *)cell{
    int mark1 = (int)cell.row;
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:mark  inSection:0];
    [markArray replaceObjectAtIndex:mark withObject:@0];
    [buttonBoolArray  replaceObjectAtIndex:mark withObject:@0];
    [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath1] withRowAnimation:UITableViewRowAnimationNone];
    
    //    [UIView animateWithDuration:11 animations:^{
    //        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:mark  inSection:0];
    //
    //        calculateCell * cell2 = (calculateCell *)[myTableView cellForRowAtIndexPath:indexPath];
    //        cell2.imageViewkey.frame = CGRectMake(6.5, 42, 285, 0);
    //    }];
    
    mark = mark1;
}
- (void)sleepScrollToAnimate:(NSIndexPath *)indexPath1{
 [myTableView scrollToRowAtIndexPath:indexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)showKeyboardWithCell:(calculateCell *)cell{
    
    calculateCell * calculateCell = [cell retain];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:cell.row  inSection:0];
    [markArray replaceObjectAtIndex:cell.row withObject:@1];
    [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath1] withRowAnimation:UITableViewRowAnimationNone];
    
    [self performSelector:@selector(sleepScrollToAnimate:) withObject:indexPath1 afterDelay:0.5];
    
    
    if (mark != calculateCell.row && mark < markArray.count) {
        [self performSelector:@selector(showkey1:) withObject:calculateCell afterDelay:0.2];
    }
}

-(void)hidenCellKeyboard:(calculateCell *)cell
{
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:cell.row  inSection:0];
    [markArray replaceObjectAtIndex:cell.row withObject:@0];
    [buttonBoolArray replaceObjectAtIndex:cell.row withObject:@0];
    [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath1] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)openCellKeyboard:(calculateCell *)cell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cell.row  inSection:0];
    if ([[markArray objectAtIndex:indexPath.row] isEqual:@0]) {
        [gckeyView dissKeyFunc];
         countTextField.textColor = [UIColor redColor];
        [self showKeyboardWithCell:cell];
    }else{
        [self hidenCellKeyboard:cell];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // if (baifenTextField.tag == 1) {
    //   [self touchesbgview];
    //}
    
}

#pragma mark 点击done事件
- (void)doneButton:(id)sender {
    
    //    [countTextField resignFirstResponder];
    [baifenTextField resignFirstResponder];
    [self updateData];
    if (shouyibut.tag == 0) {
       
    }else{
        
        
    }
    
    
    baifenTextField.tag = 0;
    [self jianpanshuaxin];
    countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
    //    [self jineHightWidth];
    [myTableView reloadData];
}

- (void)pressjianbutton:(UIButton *)sender{
    
    if (zhuiQiButton.tag == 1) {
        zhuiQiButton.tag = 0;
       [gckeyView dissKeyFunc];
         countTextField.textColor = [UIColor redColor];
        [self jineHightWidth];
        countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
        return;
    }
    if (panduanling) {
        [betInfo.betlist removeObjectAtIndex:[betInfo.betlist count]-1];
    }else{
        if ([countTextField.text intValue] <= 0) {
            countTextField.text = @"0";
        }else{
            NSString * str = [NSString stringWithFormat:@"%d",[countTextField.text intValue] - 1];
            countTextField.text = str;
            [betInfo.betlist removeObjectAtIndex:[betInfo.betlist count]-1];
        }
    }
    
    
    
    //    countTextField.text = [NSString stringWithFormat:@"%d", [betInfo.betlist count]-1];
    //
    //
    //    [self jineHightWidth];
    if (markArray.count > 1) {
        [markArray removeLastObject];
        [buttonBoolArray removeLastObject];
    }
    [self jineHightWidth];
    [myTableView reloadData];
}

- (void)jianpanshuaxin{
    //if ([countTextField.text intValue] <= 10 && [countTextField.text intValue] >= 0) {
    panduanling = NO;
    if ([countTextField.text intValue]==0) {
        // if ([betInfo.betlist count] >= 2) {
        NSInteger c= [betInfo.betlist count]-1;
        for (int i = 0; i < c; i++) {
            if ([betInfo.betlist count] > 1) {
                panduanling = YES;
                [self pressjianbutton:nil];
            }else{
                panduanling = NO;
            }
            
        }
        
        //        }
        panduanling = NO;
        
        
    }
    //    else if([countTextField.text intValue]==120){
    
    //        NSInteger c= 122-[betInfo.betlist count];
    //        for (int i = 0; i < c; i++) {
    //            [self pressaddbutton:nil];
    //        }
    //
    //    }
    else{
        if ([countTextField.text intValue] < [betInfo.betlist count] -1) {
            NSInteger c= ([betInfo.betlist count]-1) - [countTextField.text intValue];
            for (int i = 0; i < c; i++) {
                [self pressjianbutton:nil];
            }
            
        }else if ([countTextField.text intValue] > [betInfo.betlist count] -1) {
            NSInteger c = 0;
            if ([issuearr count] >= [countTextField.text intValue]) {
                c=  [countTextField.text intValue] - ([betInfo.betlist count]-1);
                
            }else{
                c = [issuearr count] - [betInfo.betlist count];
            }
            for (int i = 0; i < c; i++) {
                [self pressaddbutton:nil];
            }
        }
        
    }
    
    
    
    //  }
    
    
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    
//    if ([text isEqualToString:@"\n"]) {
//        
//        [textView resignFirstResponder];
//        
//        return NO;
//        
//    }
//    
//    return YES;    
//    
//}

- (void)bfWidthFunc{
    
    UIFont * font2 = [UIFont systemFontOfSize:14];
    CGSize  size2 = CGSizeMake(100, 20);
    CGSize labelSize2 = [baifenTextField.text sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:NSLineBreakByWordWrapping];
    
    if (labelSize2.width < 31) {
        labelSize2.width = 31;
    }
    baifenTextField.frame =  CGRectMake(baifenTextField.frame.origin.x, baifenTextField.frame.origin.y, labelSize2.width, baifenTextField.frame.size.height);//31
    shouyiImage.frame = CGRectMake(shouyiImage.frame.origin.x, shouyiImage.frame.origin.y , labelSize2.width+4, shouyiImage.frame.size.height);//追号输入框图片
    UIButton * shouyiButton = (UIButton *)[shouyiImage viewWithTag:123];
    shouyiButton.frame = shouyiImage.bounds;
    
    if ((shouyiImage.frame.origin.x+shouyiImage.frame.size.width+1 )< 140) {
        baifenla.frame = CGRectMake(140, baifenla.frame.origin.y, 20, 20);
    }else{
        baifenla.frame = CGRectMake(shouyiImage.frame.origin.x+shouyiImage.frame.size.width+1, baifenla.frame.origin.y, 20, 20);
    }
    
}

- (void)updateData{
    if ([countTextField.text intValue] < 0) {
        countTextField.text = @"0";
    }
    if([countTextField.text intValue] > [issuearr count]-1){
       countTextField.text = [NSString stringWithFormat:@"%d", (int)[issuearr count]-1];
    }
    //    if ([baifenTextField.text intValue] > 100) {
    //        baifenTextField.text = @"100";
    //    }
    float datafloat = (float)[self wanfaqufen];
    float maxfloat = 0;
    if (zhuijiabool) {
        maxfloat = (datafloat - (betInfo.bets*3))/(betInfo.bets*3)*100;
    }else{
        maxfloat = (datafloat - (betInfo.bets*2))/(betInfo.bets*2)*100;
    }
    
    NSLog(@"float = %f", maxfloat);
    
    if ([baifenTextField.text floatValue] <= 0) {
//        baifenTextField.text = @"0";
        baifenTextField.placeholder = @"50";
    
    }
    //    else{
    //        baifenTextField.text = [NSString stringWithFormat:@"%.2f", [baifenTextField.text floatValue]];
    //    }
    if ([baifenTextField.text floatValue] > maxfloat) {
        baifenTextField.text = [NSString stringWithFormat:@"%.2f", maxfloat];
    }
    [self bfWidthFunc];
}
- (void)updataBaiFen{
    float datafloat = (float)[self wanfaqufen];
    float maxfloat = 0;
    if (zhuijiabool) {
        maxfloat = (datafloat - (betInfo.bets*3))/(betInfo.bets*3)*100;
    }else{
        maxfloat = (datafloat - (betInfo.bets*2))/(betInfo.bets*2)*100;
    }
    
    NSLog(@"float = %f", maxfloat);
    if ([baifenTextField.text floatValue] > maxfloat) {
        baifenTextField.text = [NSString stringWithFormat:@"%.2f", maxfloat];
    }
    [self bfWidthFunc];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [self performSelector:@selector(updataBaiFen) withObject:nil afterDelay:0.1];
    
    //	[self performSelector:@selector(updateData) withObject:nil afterDelay:0.1];
    
    
    
    
	return YES;
}

- (void)zhuihaochange:(CP_SWButton *)sww {
	isTingZhui = sww.on;
    
    if (isTingZhui) {
        betInfo.zhuihaoType = 0;
    }
    else {
        betInfo.zhuihaoType = 1;
    }
    
    
    
}

- (void)returnTextField:(NSString *)fieldText row:(NSInteger)rowte{
    
    NSString * testring = [betInfo.betlist objectAtIndex:rowte];
    NSArray * tearr = [testring componentsSeparatedByString:@":"];
    NSString * pinstr = [NSString stringWithFormat:@"%@:%@", [tearr objectAtIndex:0], fieldText];
    [betInfo.betlist replaceObjectAtIndex:rowte withObject:pinstr];
    
    [self jineHightWidth];
    
    //[myTableView reloadData];
}

- (void)returnRow:(NSInteger)rerow beishu:(NSString *)beishus qihao:(NSString *)issue{
    
    if (issue) {
        
        BOOL xiangtong = NO;
        NSInteger xiangtongwei = 0;
        
        
        for (int i = 0; i < [betInfo.betlist count]; i++) {
            NSString * zuistr = [betInfo.betlist objectAtIndex:i];
            NSArray * beishuarr = [zuistr componentsSeparatedByString:@":"];
            NSString * issstr = [beishuarr objectAtIndex:0];
            if ([issstr isEqualToString:issue]) {
                xiangtong = YES;
                xiangtongwei = i;
            }
        }
        
        if (xiangtong) {
            
            if (xiangtongwei < rerow) {
                [myTableView reloadData];
                
                
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"对不起，所选的期次必须在上一期之后"];
                
                return;
            }
            
        }
        
        
        
        NSString * zuistr1 = [betInfo.betlist objectAtIndex:rerow];
        NSArray * beishuarr1 = [zuistr1 componentsSeparatedByString:@":"];
        NSString * issstr1 = [beishuarr1 objectAtIndex:0];
        
        NSString* qianstr = [betInfo.betlist objectAtIndex:rerow - 1];
        NSArray * qianstrarr = [qianstr componentsSeparatedByString:@":"];
        NSString * issstr2 = [qianstrarr objectAtIndex:0];
        
        NSInteger yuandijige = 0;
        NSInteger countxian = 0;
        NSInteger xianzai = 0;
        NSInteger qianyige = 0;
        for (int i = 0; i < [issuearr count]; i++) {
            if ([issue isEqualToString:[issuearr objectAtIndex:i]]) {
                xianzai = i;
                countxian = i;
            }
            if ([issstr1 isEqualToString:[issuearr objectAtIndex:i]]) {
                yuandijige = i;
            }
            //if (i > 0) {
            if ([issstr2 isEqualToString:[issuearr objectAtIndex:i]]) {
                qianyige = i;
            }
            // }else{
            //  qianyige = 0;
            //}
            
        }
        
        if((qianyige > xianzai)){//(yuandijige > xianzai) &&
            [myTableView reloadData];
            
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"对不起，所选的期次必须在上一期之后"];
            
            return;
        }
        
        if ((yuandijige < xianzai) || (yuandijige > xianzai)) {//||(yuandijige > xianzai
            
            
            
            
            
            
            NSString * isstring = [NSString stringWithFormat:@"%@:%@", [issuearr objectAtIndex:xianzai],morenbeishu  ];
            [betInfo.betlist replaceObjectAtIndex:rerow withObject:isstring];
            for (int i = (int)rerow+1; i < [betInfo.betlist count]; i++) {
                NSInteger xiayigebet = 0;
                NSInteger xiayigeiss = 0;
                xianzai+=1;
                NSString * zuistr2 = [betInfo.betlist objectAtIndex:i];
                NSArray * beishuarr2 = [zuistr2 componentsSeparatedByString:@":"];
                NSString * issstr2 = [beishuarr2 objectAtIndex:0];
                
                if (xianzai < [issuearr count]) {
                    NSString * issstring = [issuearr objectAtIndex:xianzai];
                    for (int a = 0; a < [issuearr count]; a++) {
                        
                        if ([issstr2 isEqualToString:[issuearr objectAtIndex:a]]) {
                            xiayigebet = a;
                            
                        }
                        if ([issstring isEqualToString:[issuearr objectAtIndex:a]]) {
                            xiayigeiss = a;
                            
                        }
                    }
                    
                    if ((xiayigebet > xiayigeiss)||(xiayigebet == xiayigeiss)) {
                        
                        
                        
                    }else{
                        BOOL youwu = NO;
                        NSInteger youint = 0;
                        for (int s = 0; s < [betInfo.betlist count]; s++) {
                            
                            NSString * sst = [betInfo.betlist objectAtIndex:s];
                            NSArray * tssar = [sst componentsSeparatedByString:@":"];
                            if ([[issuearr objectAtIndex:xianzai] isEqualToString:[tssar objectAtIndex:0]]) {
                                youwu = YES;
                                youint = s;
                            }
                        }
                        if (youwu) {
                            
                            NSString * zuistr = [betInfo.betlist objectAtIndex:youint];
                            NSArray * beishuarr = [zuistr componentsSeparatedByString:@":"];
                            if (beishuarr.count > 1) {
                                NSString * isstring = [NSString stringWithFormat:@"%@:%@", [issuearr objectAtIndex:xianzai],[beishuarr objectAtIndex:1]];
                                [betInfo.betlist replaceObjectAtIndex:i withObject:isstring];
                            }
                            
                        }else{
                            NSString * isstring = [NSString stringWithFormat:@"%@:%@", [issuearr objectAtIndex:xianzai],morenbeishu  ];
                            [betInfo.betlist replaceObjectAtIndex:i withObject:isstring];
                        }
                        
                        
                        if (xianzai == [issuearr count]) {
                            for (int c = i; c < [betInfo.betlist count]; c++) {
                                [betInfo.betlist removeObjectAtIndex:[betInfo.betlist count]-1];
                            }
                        }
                        
                        
                    }
                    
                }
                
            }
            
        }
        if (countxian == [issuearr count]-1) {
            for (int i = (int)rerow+1; i < [betInfo.betlist count]; i++) {
                [betInfo.betlist removeObjectAtIndex:[betInfo.betlist count]-1];
            }
        }
        
        
        
        
    }else{
        
        NSString * zuistr = [betInfo.betlist objectAtIndex:rerow];
        NSArray * beishuarr = [zuistr componentsSeparatedByString:@":"];
        NSString * issstr = [beishuarr objectAtIndex:0];
        NSString * isstring = [NSString stringWithFormat:@"%@:%@", issstr,beishus];
        [betInfo.betlist replaceObjectAtIndex:rerow withObject:isstring];
        
        
    }
    
    
    
    
    
    
    NSMutableArray  * arrmuta = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [betInfo.betlist count]; i++) {
        NSString * sss = [betInfo.betlist objectAtIndex:i];
        NSArray * ssarr = [sss componentsSeparatedByString:@":"];
        
        
        
        NSString * ddd = [issuearr objectAtIndex:[issuearr count]-1];
        NSLog(@"sss = %@, ddd=%@", sss, ddd);
        if (![[ssarr objectAtIndex:0] isEqualToString:ddd]) {
            [arrmuta addObject:[betInfo.betlist objectAtIndex:i ]];
        }else{
            [arrmuta addObject:[betInfo.betlist objectAtIndex:i ]];
            break;
        }
    }
    [betInfo.betlist removeAllObjects];
    [betInfo.betlist addObjectsFromArray:arrmuta];
    [arrmuta release];
    
    
    countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
    
    
    [self jineHightWidth];
    
    [myTableView reloadData];
}


- (void)returnjianpanjiaodian:(BOOL)yesorno{
    if (yesorno) {
        
        shouyibut.tag = 1;
        
        [self pressshouyishu:shouyibut];
        
      
        
        if (![baifenTextField isFirstResponder]) {
            upimage.frame = CGRectMake(upimage.frame.origin.x, upimage.frame.origin.y - keyhiegh+10, upimage.frame.size.width, upimage.frame.size.height);
            belowImage.frame = CGRectMake(belowImage.frame.origin.x, belowImage.frame.origin.y - keyhiegh+10, belowImage.frame.size.width, belowImage.frame.size.height-44);
            
            if (([self wanfaqufen]) && sylBool == NO) {
                
                belowImage.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height - keyhiegh-44);
                
            }else{
                
                belowImage.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height - keyhiegh-44);
            }
            myTableView.frame = CGRectMake(0, 0, 320, belowImage.frame.size.height+ 10);
            
        }else{
            [gckeyView dissKeyFunc];
             countTextField.textColor = [UIColor redColor];
        }
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [buttonBoolArray release];
    //    [betinfocopy release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [betinfocopy release];
    [baocunarr release];
    [issuearr release];
    [morenbeishu release];
    [myTableView release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [betInfo release];
    [markArray release];
    [countTextField release];
    [leijila release];
    [jinela release];

    [super dealloc];
}

- (void)returnjianpan:(BOOL)yesorno{
    if (yesorno) {
        yorn = yesorno;
        
        [self jianpanshuaxin];
        [countTextField resignFirstResponder];
        [baifenTextField resignFirstResponder];
        baifenTextField.tag = 0;
        //    zhanbgimage.hidden = NO;
        
        
        
        countTextField.text = [NSString stringWithFormat:@"%d", (int)[betInfo.betlist count]-1];
        
        
        [self jineHightWidth];
        
        [myTableView reloadData];
    }else{
        yorn = NO;
    }
}

- (void)returnButtonSelectBool:(BOOL)yesORno row:(NSInteger)row{
    if (yesORno == NO) {
        [buttonBoolArray replaceObjectAtIndex:row withObject:@0];
    }else{
        [buttonBoolArray replaceObjectAtIndex:row withObject:@1];
    }
     NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:row  inSection:0];
    [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath1] withRowAnimation:UITableViewRowAnimationNone];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    