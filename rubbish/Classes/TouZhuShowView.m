//
//  TouZhuShowView.m
//  caibo
//
//  Created by yao on 12-5-7.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "TouZhuShowView.h"
#import "caiboAppDelegate.h"
#import "NSStringExtra.h"
#import "JingCaiZuQiuCell.h"
#import "ShenFuCaiCell.h"
#import "RangQiuShengPingFuCell.h"
#import "ZuCaiJinQiuCell.h"
#import "NetURL.h"
#import "JSON.h"
#import "ShuangSeQiuInfoViewController.h"
#import "PreJiaoDianTabBarController.h"
#import "GC_BetData.h"
#import "GC_BetInfo.h"
#import "GC_ShengfuInfoViewController.h"
#import "GC_HttpService.h"
#import "YuJiJinE.h"
#import "DangQianQiData.h"
#import "QuartzCore/QuartzCore.h"

@implementation TouZhuShowView
@synthesize BetDetailInfo;
@synthesize myrequest;
@synthesize httprequest;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        self.backgroundColor = [UIColor clearColor];
        cellarray = [[NSMutableArray alloc] initWithCapacity:0];
        zhushuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)hidenSelf {
	self.alpha = 1;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	self.alpha = 0;
	[UIView commitAnimations];
	[self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.5];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self hidenSelf];
}

- (void)showTouzhuWithData:(NSDictionary *)dic {
	caiboAppDelegate *delegate1 = [caiboAppDelegate getAppDelegate];
	[delegate1.window addSubview:self];
	if ([dic objectForKey:@"lotteryId"]) {
		touZhuShowType = TouZhuShowTypeZC;
	}
	dataDic = [[NSDictionary alloc] initWithDictionary:dic];
	self.frame = delegate1.window.bounds;
	self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
	self.alpha = 0;
    tableViewBackView = [[UIView alloc] initWithFrame:CGRectMake(5, 80, 310, 390)];
//#ifdef isCaiPiaoForIPad
//    tableViewBackView.frame = CGRectMake(100, 200, 310, 390);
//#endif
    tableViewBackView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    [self addSubview:tableViewBackView];
    [tableViewBackView release];
    tableViewBackView.backgroundColor = [UIColor clearColor];
	myTableView = [[UITableView alloc] initWithFrame:tableViewBackView.bounds style:UITableViewStylePlain];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	tableViewBackView.layer.masksToBounds = YES;
	tableViewBackView.layer.cornerRadius = 2.0;
	[tableViewBackView addSubview:myTableView];
	myTableView.delegate = self;
	myTableView.dataSource = self;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	self.alpha = 1;
	[UIView commitAnimations];
}

- (void)showTouzhuWithTopicId:(NSString *)topicId {
	caiboAppDelegate *delegate1 = [caiboAppDelegate getAppDelegate];
	[delegate1.window addSubview:self];

	self.frame = delegate1.window.bounds;
	self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
	self.alpha = 0;
	tableViewBackView = [[UIView alloc] initWithFrame:CGRectMake(5, 80, 310, 390)];
//#ifdef isCaiPiaoForIPad
//    tableViewBackView.frame = CGRectMake(100, 200, 310, 390);
//#endif
    tableViewBackView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    [self addSubview:tableViewBackView];
    [tableViewBackView release];
    tableViewBackView.backgroundColor = [UIColor clearColor];
	myTableView = [[UITableView alloc] initWithFrame:tableViewBackView.bounds style:UITableViewStylePlain];
        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.backgroundColor = [UIColor clearColor];
	tableViewBackView.layer.masksToBounds = YES;
	tableViewBackView.layer.cornerRadius = 2.0;
	[tableViewBackView addSubview:myTableView];
	myTableView.delegate = self;
	myTableView.dataSource = self;
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	self.alpha = 1;
	[UIView commitAnimations];
    [myrequest clearDelegatesAndCancel];
	self.myrequest = [ASIHTTPRequest requestWithURL:[NetURL CBtopicBetInfo:topicId]];
	[myrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[myrequest setDelegate:self];
	[myrequest setTimeOutSeconds:20.0];
	[myrequest startAsynchronous];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[self hidenSelf];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *responseString = [request responseString];
	[dataDic release];
	dataDic = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
    NSLog(@"datadic = %@, changci = %@", dataDic, [[[dataDic objectForKey:@"matchVS"] objectAtIndex:0] objectForKey:@"touZhu"]);
//	[[[dataDic objectForKey:@"matchVS"] objectAtIndex:1] setValue:@"胜平负，胜平负，胜平负，胜平负，胜平负，胜平负" forKey:@"touZhu"];
//    if ([[dataDic objectForKey:@"lotteryId"] isEqualToString:@"23"]) {
//        UIAlertView *alet = [[UIAlertView alloc] initWithTitle:nil message:@"此彩种暂不支持显示" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//		[alet show];
//		[alet release];
//		myTableView.hidden = YES;
//        return;
//    }
	if ([[dataDic objectForKey:@"code"] intValue] ==1 && [[dataDic objectForKey:@"orderId"] length] == 0) {
		UIAlertView *alet = [[UIAlertView alloc] initWithTitle:nil message:[dataDic objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alet show];
		[alet release];
		myTableView.hidden = YES;
	}
	else {
		myTableView.hidden = NO;
		if ([dataDic objectForKey:@"lotteryId"]) {
			touZhuShowType = TouZhuShowTypeZC;
		}
		if ([[dataDic objectForKey:@"lotteryId"] intValue] == 13||[[dataDic objectForKey:@"lotteryId"] intValue]==14) {
			touZhuShowType = TouZhuShowTypeSPF;
		}
		else if([[dataDic objectForKey:@"lotteryId"] intValue] == 16) {
			touZhuShowType = TouZhuShowType4JQ;
		}
		else if([[dataDic objectForKey:@"lotteryId"] intValue] == 15) {
			touZhuShowType = TouZhuShowType6JQ;
		}
		else if ([[dataDic objectForKey:@"lotteryId"] intValue] == 200 ||[[dataDic objectForKey:@"lotteryId"] intValue] == 22||[[dataDic objectForKey:@"lotteryId"] intValue] == 49) {
			touZhuShowType = TouZhuShowTypeRQSPF;
		}
        else if([[dataDic objectForKey:@"lotteryId"] intValue] == 26) {
			touZhuShowType = TouZhuShowTypeLanqiuShengfu;
		}
        else if([[dataDic objectForKey:@"lotteryId"] intValue] == 27) {
			touZhuShowType = TouZhuShowTypeLanqiuRangFenShengFu;
		}
        else if([[dataDic objectForKey:@"lotteryId"] intValue] == 28) {
			touZhuShowType = TouZhuShowTypeLanqiuShengfencha;
		}
        else if([[dataDic objectForKey:@"lotteryId"] intValue] == 29) {
			touZhuShowType = TouZhuShowTypeLanqiuDaXiaoFen;
		}
        if ([dataDic objectForKey:@"issue"]||[[dataDic objectForKey:@"orderId"] length]) {
            UIView *footV  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 36)];
            footV.backgroundColor = [UIColor clearColor];
            UIImageView *imV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 310, 36)];
            [footV addSubview:imV];
            imV.image = UIImageGetImageFromName(@"FAZSX960.png");
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 63, 20)];
            label2.backgroundColor = [UIColor clearColor];
            [imV addSubview:label2];
            label2.textAlignment = NSTextAlignmentRight;
            label2.text = @"投注站";
            label2.font = [UIFont boldSystemFontOfSize:16];
            [label2 release];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(75, 9, 90, 18)];
            label.backgroundColor = [UIColor clearColor];
            [imV addSubview:label];
            label.text = @"caipiao365.com";
            label.font = [UIFont systemFontOfSize:12];
            [label release];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:UIImageGetImageFromName(@"FAZSAN960.png") forState:UIControlStateNormal];
            [btn setImage:UIImageGetImageFromName(@"FAZSAAN960.png") forState:UIControlStateHighlighted];
            btn.frame = CGRectMake(200, 5, 76.5, 22);
            [btn addTarget:self action:@selector(goBuy) forControlEvents:UIControlEventTouchUpInside];
            [footV addSubview:btn];
            
            [imV release];
            
            myTableView.tableFooterView = footV;
            [footV release];
        }
		
		[myTableView reloadData];
#ifdef isCaiPiaoForIPad
        if (myTableView.contentSize.height < myTableView.frame.size.height) {
			myTableView.frame = CGRectMake(myTableView.frame.origin.x, myTableView.frame.origin.y, 310, myTableView.contentSize.height);
			myTableView.scrollEnabled = NO;
			myTableView.center = self.center;
            tableViewBackView.frame = myTableView.frame;
            tableViewBackView.center = self.center;
		}
		else {
			myTableView.scrollEnabled = YES;
			myTableView.center = self.center;
		}
		myTableView.center = CGPointMake(tableViewBackView.bounds.size.width/2.0, tableViewBackView.bounds.size.height/2.0);
        
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
        rotationAnimation.duration = 0.0f;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [tableViewBackView.layer addAnimation:rotationAnimation forKey:@"run"];
        tableViewBackView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);

        
#else
        if (myTableView.contentSize.height < myTableView.frame.size.height) {
			myTableView.frame = CGRectMake(myTableView.frame.origin.x, myTableView.frame.origin.y, 310, myTableView.contentSize.height);
			myTableView.scrollEnabled = NO;
			myTableView.center = self.center;
            tableViewBackView.frame = myTableView.frame;
            tableViewBackView.center = self.center;
		}
		else {
			myTableView.scrollEnabled = YES;
			myTableView.center = self.center;
		}
		myTableView.center = CGPointMake(tableViewBackView.bounds.size.width/2.0, tableViewBackView.bounds.size.height/2.0);
#endif
        
		
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"%@",[request error]);
	[self hidenSelf];
}
- (NSString *)yujitouzhuxuanxiang{
    NSString * returnstr = @"";
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"400"]||[self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * bet = [cellarray objectAtIndex:i];
            if (bet.selection1 || bet.selection2 || bet.selection3) {
                returnstr = [NSString stringWithFormat:@"%@%@:", returnstr, bet.changhao];
                if (bet.selection1) {
                    returnstr = [NSString stringWithFormat:@"%@0,", returnstr];
                    
                }
                if (bet.selection2) {
                    returnstr = [NSString stringWithFormat:@"%@1,", returnstr];
                    
                }
                if (bet.selection3) {
                    returnstr = [NSString stringWithFormat:@"%@2,", returnstr];
                    
                }
                returnstr = [returnstr substringToIndex:[returnstr length]-1];
                returnstr = [NSString stringWithFormat:@"%@;", returnstr];
            }
        }
        returnstr = [returnstr substringToIndex:[returnstr length]-1];
   }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"] || [self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]) {
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * bet = [cellarray objectAtIndex:i];
            BOOL zhongjie = NO;
            for (int j = 0; j < [bet.bufshuarr count]; j++) {
                NSString * bufstr = [bet.bufshuarr objectAtIndex:j];
                if ([bufstr isEqualToString:@"1"]) {
                    zhongjie = YES;
                    break;
                }
            }
            if (zhongjie) {
                returnstr = [NSString stringWithFormat:@"%@%@:", returnstr, bet.changhao];
            }
            
            for (int m = 0; m < [bet.bufshuarr count]; m++) {
                NSString * stringbuf = [bet.bufshuarr objectAtIndex:m];
                if ([stringbuf isEqualToString:@"1"]) {
                    
                    returnstr = [NSString stringWithFormat:@"%@%d,", returnstr, m];
                    
                }
            }
            if (zhongjie) {
                returnstr = [returnstr substringToIndex:[returnstr length]-1];
                returnstr = [NSString stringWithFormat:@"%@;", returnstr];
            }
            
            
            
        }
        
    }
    
    
    
    
    return returnstr;
}
- (void)jingcaichaodand{
    GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
//    NSLog(@"sys = %@", [dataDic objectForKey:@"issue"]   );
//    NSArray * arr = [self.BetDetailInfo.systemTime componentsSeparatedByString:@" "];
    
    sheng.systimestr = [dataDic objectForKey:@"issue"];
    sheng.chaodanbool = YES;
    // sheng.title = @"竞彩足球胜平负(过关)";
    // NSLog(@"%d", two);
    
    //            if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
    //                yuji.maxmoney = @"";
    //            }
    //            if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
    //                yuji.minmoney = @"";
    //            }
    BOOL danbool = NO;
    
    for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
        NSString * sheng = [self.BetDetailInfo.betContentArray objectAtIndex:i];
        NSArray * arrcont = [sheng componentsSeparatedByString:@";"];
        if ([[arrcont objectAtIndex:8] length] > 1) {
            NSString *shengpingfustr = [arrcont objectAtIndex:8];
            NSRange douhao = [shengpingfustr rangeOfString:@","];
            if (douhao.location != NSNotFound) {
                danbool = YES;
            }
            
            
        }
    }
    
    if (!danbool) {
        sheng.danfushi = 0;
    } else{
        sheng.danfushi = 1;
    }
    if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"]) {
        sheng.fenzhong = jingcaibifen;
    }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]) {
        sheng.fenzhong = jingcaipiao;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
        sheng.fenzhong = zongjinqiushu;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
        sheng.fenzhong = banquanchangshengpingfu;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"06"]){
        sheng.fenzhong = jingcailanqiushengfu;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"07"]){
        sheng.fenzhong = jingcailanqiurangfenshengfu;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
        sheng.fenzhong = jingcailanqiushengfencha;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"09"]){
        sheng.fenzhong = jingcailanqiudaxiaofen;
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"10"]){
        sheng.fenzhong = jingcairangfenshengfu;
    }

    
    if ([self.BetDetailInfo.multiplenNum isEqualToString:@"1"]) {
        sheng.moneynum = self.BetDetailInfo.programAmount;
    }else{
        sheng.moneynum = [NSString stringWithFormat:@"%d",[self.BetDetailInfo.programAmount intValue]/[self.BetDetailInfo.multiplenNum intValue] ];
    }
    
    
    sheng.zhushu = self.BetDetailInfo.betsNum;//[NSString stringWithFormat:@"%d", [twoLabel.text intValue]/2];
    
    sheng.jingcai = YES;
    sheng.BetDetailInfo = self.BetDetailInfo;
    sheng.bianjibool = YES;
    sheng.bettingArray = cellarray;
    sheng.zhushudict = zhushuDic;
    
    if ((sheng.fenzhong == jingcailanqiushengfencha && [self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) || (sheng.fenzhong == jingcaibifen && [self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"])) {
        sheng.maxmoneystr = [NSString stringWithFormat:@"%f", [maxmoney floatValue]*2];//yuji.maxmoney;
        sheng.minmoneystr = [NSString stringWithFormat:@"%f", [minmoney floatValue]*2];//yuji.minmoney;
    }else{
        sheng.maxmoneystr = maxmoney;
        sheng.minmoneystr = minmoney;
    }
    
    sheng.maxmoneystr = maxmoney;
    sheng.minmoneystr = minmoney;
    NSLog(@"zhushumax = %@, min = %@", maxmoney, minmoney);
    //            sheng.isHeMai = self.isHeMai;
    //  NSLog(@"zhushu = %@", zhushuDic);
    
    //            if (isHeMai) {
    //                sheng.hemaibool = YES;
    //            }else{
    sheng.hemaibool = NO;
    //    }
    
    if ([sheng.bettingArray count] != 0) {
        UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        [NV setNavigationBarHidden:NO];
        [sheng.navigationController setNavigationBarHidden:YES];
        if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
            PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
            NSLog(@"%@",VC);
            [VC.selectedViewController.navigationController pushViewController:sheng animated:YES];
        }
        else {
            [NV pushViewController:sheng animated:YES];
        }
        
        //                [self.navigationController pushViewController:sheng animated:YES];
    

    }
    [sheng release];
    
    
}

- (NSString *)issueInfoReturn{
    if (cellarray&&cellarray.count) {
        NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
        
        
       if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
            for (int i = 0; i < [cellarray count]; i++) {
                GC_BetData * da = [cellarray objectAtIndex:i];
                NSLog(@"da.sele = %d  %d  %d", da.selection1, da.selection2, da.selection3);
                
                if (da.selection1 || da.selection2 || da.selection3) {
                    [str appendString:da.changhao];
                    //[str appendString:@":"];
                    //[str appendString:da.numzhou];
                    [str appendString:@":"];
                    //[str appendString:@"["];
                    
                    [str appendFormat:@"1"];
                    
                    [str appendString:@";"]; 
                    
                }
            }
            
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"05"]||[self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
            for (int i = 0; i < [cellarray count]; i++) {
                GC_BetData * da = [cellarray objectAtIndex:i];
                BOOL zhonjieb = NO;
                for (int j = 0; j < [da.bufshuarr count]; j++) {
                    if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                        zhonjieb = YES;
                        break;
                    }
                }
                if (zhonjieb) {
                    [str appendString:da.changhao];
                    //[str appendString:@":"];
                    //[str appendString:da.numzhou];
                    [str appendString:@":"];
                    //[str appendString:@"["];
                    
                    [str appendFormat:@"1"];
                    
                    [str appendString:@";"]; 
                }
                
                
            }
            
        }
        NSLog(@"str = %@", str);
        [str setString:[str substringToIndex:[str length] - 1]];
        NSLog(@"str = %@", str);
        return str;
    }
    
    
    return nil;
}  

- (void)didFailSelector:(ASIHTTPRequest *)mrequest{
    NSLog(@"%@",[mrequest error]);
}

- (void)yuceyuJiJiangJin:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        maxmoney = @"0";
        minmoney = @"0";
        YuJiJinE * yuji = [[YuJiJinE alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        if (yuji.sysid == 3000) {
            [yuji release];
            return;
        }
        if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
            yuji.maxmoney = @"0";
        }
        if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
            yuji.minmoney = @"0";
        }
        maxmoney = yuji.maxmoney;
        minmoney = yuji.minmoney;
        NSLog(@"max = %@, min = %@", maxmoney, minmoney);
        
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"201"]||[self.BetDetailInfo.lotteryId isEqualToString:@"200"]) {
            [self jingcaichaodand];
        }else if([self.BetDetailInfo.lotteryId isEqualToString:@"400"]){
            //[self beidanchaodan];
        }
        [yuji release];
        
        
        
    }
    [self removeFromSuperview];    
    
    
}

//预计奖金
- (void)chaoDanYuJiJiangJin{
    
    NSMutableString *strshedan = [[[NSMutableString alloc] init] autorelease];
    NSInteger zongchangci = 0;
    
    if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.lotteryId isEqualToString:@"400"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"])  {
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            if (da.selection1 || da.selection2 || da.selection3) {
                zongchangci++;
            }
            if (da.dandan) {
                [strshedan appendFormat:@"%@,",da.changhao];
            }
        }
        NSLog(@"%@", strshedan);
        if ([strshedan length] != 0) {
            [strshedan setString:[strshedan substringToIndex:[strshedan length] - 1]];
        }else{
            [strshedan appendString:@"0"];
        }
        
    }else if([self.BetDetailInfo.wanfaId isEqualToString:@"05"] || [self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
        for (int i = 0; i < [cellarray count]; i++) {
            GC_BetData * da = [cellarray objectAtIndex:i];
            BOOL zhongjiebool = NO;
            for (int j = 0; j < [da.bufshuarr count]; j++) {
                if ([[da.bufshuarr objectAtIndex:j] isEqualToString:@"1"]) {
                    zhongjiebool = YES;    
                    break;
                }
            }
            if (zhongjiebool) {
                zongchangci++;
            }
            if (da.dandan) {
                [strshedan appendFormat:@"%@,",da.changhao];
            }
        }
        
        if ([strshedan length] != 0) {
            [strshedan setString:[strshedan substringToIndex:[strshedan length] - 1]];
        }else{
            [strshedan appendString:@"0"];
        }
        
        
        
    }
    NSString *passTypeSet = @"";
    if ([self.BetDetailInfo.lotteryId isEqualToString:@"400"]) {
        NSArray * arr = [zhushuDic allKeys];
        NSLog(@"arr = %@", arr);
        NSLog(@"self.guguan = %@", self.BetDetailInfo.guguanWanfa);
        
        
        for (int i = 0; i < [arr count]; i++) {
            //   NSLog(@"chuan = %@", [arr objectAtIndex:i]);
            if ([[arr objectAtIndex:i] isEqualToString:@"单关"]) {
                passTypeSet = [NSString stringWithFormat:@"%@单关;" ,passTypeSet];
            }else{
                if (i!=arr.count-1){
                    NSString * com = [arr objectAtIndex:i];
                    NSArray * nsar = [com componentsSeparatedByString:@"串"];
                    if ([nsar count] >= 2) {
                        com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                        passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                    }
                    
                    
                }else{
                    NSString * com = [arr objectAtIndex:i];
                    NSArray * nsar = [com componentsSeparatedByString:@"串"];
                    if ([nsar count] >= 2) {
                        com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
                        passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
                    }
                    
                    
                }
                
                
            }
        }
        // if (![passTypeSet isEqualToString:@"单关"]) {
        passTypeSet = [passTypeSet substringToIndex:[passTypeSet length]-1];
    }else if ([self.BetDetailInfo.lotteryId isEqualToString:@"201"]||[self.BetDetailInfo.lotteryId isEqualToString:@"200"]){
        //        NSLog(@"strshedan = %@", strshedan);
        //        
        //        NSArray * arr = [zhushuDic allKeys];
        //        NSLog(@"arr = %@", arr);
        //        NSLog(@"self.guguan = %@", self.BetDetailInfo.guguanWanfa);
        //       
        //        
        //        for (int i = 0; i < [arr count]; i++) {
        //            NSLog(@"chuan = %@", [arr objectAtIndex:i]);
        //            if (i!=arr.count-1){
        //                NSString * com = [arr objectAtIndex:i];
        //                NSArray * nsar = [com componentsSeparatedByString:@"串"];
        //                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
        //                passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
        //                
        //            }else{
        //                NSString * com = [arr objectAtIndex:i];
        //                NSArray * nsar = [com componentsSeparatedByString:@"串"];
        //                com = [NSString  stringWithFormat:@"%@x%@", [nsar objectAtIndex:0], [nsar objectAtIndex:1]];
        //                passTypeSet = [NSString stringWithFormat:@"%@%@;",passTypeSet, com];
        //                
        //            }
        //        }
        //        
        //        passTypeSet = [passTypeSet substringToIndex:[passTypeSet length]-1];
        
        
        NSRange douhao = [self.BetDetailInfo.guguanWanfa rangeOfString:@","];
        if (douhao.location != NSNotFound) {
            NSArray * arrdou = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@","];
            
           
            
            
            for (int i = 0; i < [arrdou count]; i++) {
               //  NSArray * fenstr = [[arrdou objectAtIndex:i] componentsSeparatedByString:@"x"];
                
                passTypeSet = [NSString stringWithFormat:@"%@%@;", passTypeSet, [arrdou objectAtIndex:i]];
            }
            passTypeSet = [passTypeSet substringToIndex:[passTypeSet length]-1];
        }else{
            passTypeSet = self.BetDetailInfo.guguanWanfa;
        }
        
    }
    
    
    NSLog(@"fangshi = %@", passTypeSet);
    
    NSInteger caizhong = 1;
    NSInteger wanfa = 1;
    NSString * issuestr=@"";
    
    
    if([self.BetDetailInfo.lotteryId isEqualToString:@"200"]){
        caizhong = 1;
        issuestr =  [dataDic objectForKey:@"issue"] ;
        
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]) {
            wanfa = 11;
        }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"07"]){
            wanfa = 12;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
            wanfa = 13;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"09"]){
            wanfa = 14;
        }
        
    }else if([self.BetDetailInfo.lotteryId isEqualToString:@"201"]){
        caizhong = 1;
        issuestr =  [dataDic objectForKey:@"issue"] ;
        if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]) {
            wanfa = 1;
        }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"]){
            wanfa = 2;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
            wanfa = 3;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
            wanfa = 4;
        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"10"]){
            wanfa = 15;
        }

        
        
    } else if([self.BetDetailInfo.lotteryId isEqualToString:@"400"]){
        caizhong = 2;
        wanfa = 5;
        issuestr = [dataDic objectForKey:@"issue"] ;
    }   
    
    
    NSLog(@"issue = %@， iss = %@", issuestr, [dataDic objectForKey:@"issue"] );
    [httprequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] chaoDanYuJiChangCi:[self issueInfoReturn] guoGuanCiShu:zongchangci fangShi:passTypeSet sheDanChangCi:strshedan beishu:1 touzhuxuanxiang:[self yujitouzhuxuanxiang] caizhong:caizhong wanfa:wanfa issue:issuestr];
	
	[httprequest clearDelegatesAndCancel];
	self.httprequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
	[httprequest setDidFinishSelector:@selector(yuceyuJiJiangJin:)];
    [httprequest setDidFailSelector:@selector(didFailSelector:)];
	[httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[httprequest setRequestMethod:@"POST"];
	[httprequest setPostBody:postData];
	[httprequest setDelegate:self];
	[httprequest addCommHeaders];
	[httprequest startAsynchronous];
}


//抄单
- (void)chaodan {
    NSLog(@"self.lott = %@", self.BetDetailInfo.lotteryId);
                //体彩
        if ([self.BetDetailInfo.lotteryId isEqualToString:@"300"]||[self.BetDetailInfo.lotteryId isEqualToString:@"301"]){//胜负彩
            GC_BetInfo * betInfo = [[GC_BetInfo alloc] init];
            int two = [self.BetDetailInfo.betsNum intValue];
            betInfo.modeType = (two > 1) ? fushi:danshi;
            //  DD_LOG(@"玩法：%i", betInfo.modeType);
            betInfo.bets = two;
            betInfo.price = two * 2;
            NSMutableArray * bettingArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
                NSString * teamstr = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                NSArray * arrte = [teamstr componentsSeparatedByString:@";"];
                GC_BetData * pkb = [[GC_BetData alloc] init];
                if ([arrte count] >= 7) {
                     pkb.event = [arrte objectAtIndex:7];
                }else{
                     pkb.event = @"";
                }
                NSString * strdui = @"";
                if ([arrte count] >= 1) {
                    strdui = [arrte objectAtIndex:1];
                }
                NSArray * duiarr = [strdui componentsSeparatedByString:@"VS"];
                if ([duiarr count] >=2) {
                    pkb.team = [NSString stringWithFormat:@"%@,%@,%@", [duiarr objectAtIndex:0], [duiarr objectAtIndex:1], @"0"];
                }else{
                    pkb.team = [NSString stringWithFormat:@"%@,%@,%@", @"", @"", @"0"];
                }
                
                
                
                NSString * spfstr = @"";
                if ([duiarr count] >=2) {
                    spfstr = [arrte objectAtIndex:2];
                }
                NSLog(@"spfstr = %@", spfstr);
                if ([spfstr length] == 1) {
                    NSLog(@"qian = %@", spfstr);
                    if ([spfstr isEqualToString:@"3"]) {
                        pkb.selection1 = YES;
                        
                    }else if([spfstr isEqualToString:@"1"]){
                        pkb.selection2 = YES;
                    }else if([spfstr isEqualToString:@"0"]){
                        pkb.selection3 = YES;
                    }
                    
                }else if([spfstr length] == 2){
                    NSString * qianstr = [spfstr substringToIndex:1];
                    NSString * houstr = [spfstr substringWithRange:NSMakeRange(1, 1)];
                    NSLog(@"qian = %@, hou = %@", qianstr, houstr);
                    if ([qianstr isEqualToString:@"3"]) {
                        pkb.selection1 = YES;
                    }else if([qianstr isEqualToString:@"1"]){
                        pkb.selection2 = YES;
                    }else if([qianstr isEqualToString:@"0"]){
                        pkb.selection3 = YES;
                    }
                    if ([houstr isEqualToString:@"3"]) {
                        pkb.selection1 = YES;
                    }else if([houstr isEqualToString:@"1"]){
                        pkb.selection2 = YES;
                    }else if([houstr isEqualToString:@"0"]){
                        pkb.selection3 = YES;
                    }
                    
                    
                    
                }else if([spfstr length] == 3){
                    
                    NSString * qianstr = [spfstr substringToIndex:1];
                    NSString * zhongstr = [spfstr substringWithRange:NSMakeRange(1, 1)];
                    NSString * houstr = [spfstr substringWithRange:NSMakeRange(2, 1)];
                    NSLog(@"qian = %@, zhong = %@, hou = %@", qianstr, zhongstr, houstr);
                    if ([qianstr isEqualToString:@"3"]) {
                        pkb.selection1 = YES;
                    }else if([qianstr isEqualToString:@"1"]){
                        pkb.selection2 = YES;
                    }else if([qianstr isEqualToString:@"0"]){
                        pkb.selection3 = YES;
                    }
                    
                    if ([zhongstr isEqualToString:@"3"]) {
                        pkb.selection1 = YES;
                    }else if([zhongstr isEqualToString:@"1"]){
                        pkb.selection2 = YES;
                    }else if([zhongstr isEqualToString:@"0"]){
                        pkb.selection3 = YES;
                    }
                    
                    if ([houstr isEqualToString:@"3"]) {
                        pkb.selection1 = YES;
                    }else if([houstr isEqualToString:@"1"]){
                        pkb.selection2 = YES;
                    }else if([houstr isEqualToString:@"0"]){
                        pkb.selection3 = YES;
                    }
                    
                }
                
                
                [bettingArray addObject:pkb];
                [pkb release];
                
            }
            
            
            
            NSString * string = @"";
            for (GC_BetData * data in bettingArray) {
                if (data.selection1) {
                    string = [string stringByAppendingFormat:@"3"];
                }
                if (data.selection2) {
                    string = [string stringByAppendingFormat:@"1"];
                }
                if (data.selection3) {
                    string = [string stringByAppendingFormat:@"0"];
                }
                if (!data.selection1&&!data.selection2&&!data.selection3) {
                    string = [string stringByAppendingFormat:@"4"];
                }
                string = [string stringByAppendingFormat:@"*"];
            }
            string = [string substringToIndex:[string length] - 1];
            NSLog(@"string = %@", string);
            
            
            if (betInfo.modeType == fushi) {
                string = [NSString stringWithFormat:@"02#%@", string];
            }else if(betInfo.modeType == danshi){
                string = [NSString stringWithFormat:@"01#%@", string];
            }
            betInfo.zhuihaoType = 0;
            betInfo.betNumber = string;
            
            NSLog(@"%i", two);
            //            NSString * issstr = [issString substringWithRange:NSMakeRange(2, 5)];//ccc
            //            betInfo.issue = issstr;//ccc
            betInfo.issue = [dataDic objectForKey:@"issue"];//ccc
            
            if ([self.BetDetailInfo.lotteryId isEqualToString:@"300"]) {
                betInfo.lotteryType = TYPE_CAIZHONG14;
                betInfo.caizhong = @"300";
                betInfo.wanfa = @"01";
            }else if([self.BetDetailInfo.lotteryId isEqualToString:@"301"]){
                betInfo.lotteryType = TYPE_CAIZHONG9;
                betInfo.caizhong = @"301";
                betInfo.wanfa = @"02";
            }
            
            
            
          
            betInfo.stopMoney = @"0";
           
            
            
            GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] initWithBetInfo:betInfo];
            sheng.title = [NSString stringWithFormat:@"胜负彩%@期", [dataDic objectForKey:@"issue"]];
            
            
            
            sheng.bettingArray = bettingArray;
            [bettingArray release];
            sheng.BetDetailInfo = self.BetDetailInfo;
            sheng.chaodanbool = YES;
            sheng.moneynum = self.BetDetailInfo.programAmount;
           
            sheng.zhushu = [NSString stringWithFormat:@"%d", [self.BetDetailInfo.programAmount intValue]/2];
            sheng.bianjibool = YES;
            sheng.issString = [dataDic objectForKey:@"issue"];
            NSLog(@"iss = %@  , slef = %@", [dataDic objectForKey:@"issue"], [dataDic objectForKey:@"issue"]);
            sheng.qihaostring = [dataDic objectForKey:@"issue"];
            if ([self.BetDetailInfo.lotteryId isEqualToString:@"301"]){
                
                sheng.fenzhong = renjiupiao;
            }else if([self.BetDetailInfo.lotteryId isEqualToString:@"300"]){
                
                sheng.fenzhong = shisichangpiao;
            }
            
            
            //            sheng.isHeMai = self.isHemai;
            //            if (isHemai) {
            //                sheng.hemaibool = YES;
            //            }else{
            sheng.hemaibool = NO;
            //}
            if ([sheng.bettingArray count] != 0) {
                [sheng.navigationController setNavigationBarHidden:YES];
                UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
                [NV setNavigationBarHidden:NO];
                if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
                    PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
                    NSLog(@"%@",VC);
                    
                    [VC.selectedViewController.navigationController pushViewController:sheng animated:YES];
                }
                else {
                    [NV pushViewController:sheng animated:YES];
                }

//                [self.navigationController pushViewController:sheng animated:YES];
            }
            
            [sheng release]; 
            
            [betInfo release];
            
            
            
            //multiplenNum beitou
            
            //            NSLog(@"ddaaaaaaaaaddd");
            //            NSLog(@"ddaaaaaaaaaddd = %@", self.BetDetailInfo.betContentArray);
            //            GCBettingViewController* bet = [[GCBettingViewController alloc] init];
            //            bet.betrecorinfo = self.BetDetailInfo;
            //            bet.issString = self.BetInfo.issue;
            //            if ([self.BetDetailInfo.lotteryId isEqualToString:@"301"]){
            //             bet.bettingstype = bettingStypeRenjiu;
            //            }else if([self.BetDetailInfo.lotteryId isEqualToString:@"300"]){
            //            bet.bettingstype = bettingStypeShisichang;
            //            }
            //            
            //            bet.chaodanbool = YES;
            //            
            //           // NSString * str = [NSString stringWithFormat:@"20%@",cell.myrecord.curIssue];
            //          //  bet.issString = str;//期号
            //            [self.navigationController pushViewController:bet animated:YES];
            //            [bet release];
            
            
        }else if([self.BetDetailInfo.lotteryId isEqualToString:@"201"] || [self.BetDetailInfo.lotteryId isEqualToString:@"200"]){//竞彩
            
            for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
                NSLog(@"ddd = %@", [self.BetDetailInfo.betContentArray objectAtIndex:i]);
            }
            NSLog(@"chuanfa = %@", self.BetDetailInfo.guguanWanfa);
            
//            BOOL danguanbool = NO;
//            NSRange chuanfa = [self.BetDetailInfo.guguanWanfa rangeOfString:@","];
//            if (chuanfa.location != NSNotFound) {
//                NSArray * chuanarr = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@","];
//                for (int i = 0; i < [chuanarr count]; i++) {
//                    if ([[chuanarr objectAtIndex:i] isEqualToString:@"单关"]) {
//                        danguanbool = YES;
//                    }
//                }
//                
//            }else{
//                if ([self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
//                    danguanbool = YES;
//                }
//            }
//            
            
            
            if  ([self.BetDetailInfo.wanfaId isEqualToString:@"01"] || [self.BetDetailInfo.wanfaId isEqualToString:@"05"]||[self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]){
                
                [cellarray removeAllObjects];              
                //  cellarray = [[NSMutableArray alloc] initWithCapacity:0];
                
                
                for (int i = 0; i < [self.BetDetailInfo.betContentArray count]; i++) {
                    NSString * contenstr = [self.BetDetailInfo.betContentArray objectAtIndex:i];
                    NSArray * arrcont = [contenstr componentsSeparatedByString:@";"];
                    
                    GC_BetData * be = [[GC_BetData alloc] init];
                    if ([arrcont count] >= 10) {
                        be.event = [arrcont objectAtIndex:10];
                    }else{
                        be.event = @"";
                    }
                    
                    //be.event = gc.match;
                    //  NSArray * timedata = [gc.deathLineTime componentsSeparatedByString:@" "];
                    //  be.date = [timedata objectAtIndex:0];
                    //  be.time = [timedata objectAtIndex:1];
                    NSString * strdui = [arrcont objectAtIndex:9];
                    NSArray * duiarr = [strdui componentsSeparatedByString:@"VS"];
                    if ([duiarr count] >= 2) {
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", [duiarr objectAtIndex:0], [duiarr objectAtIndex:1], @"0"];
                    }else{
                        be.team = [NSString stringWithFormat:@"%@,%@,%@", @"", @"", @"0"];
                    }
                    
                    //                    be.saishiid = gc.bicaiid;
                    if ([arrcont count] >= 1) {
                        be.numzhou = [arrcont objectAtIndex:0];
                    }else{
                        be.numzhou = @"";
                    }
                    if ([arrcont count] >= 7) {
                         be.changhao = [arrcont objectAtIndex:7];
                    }else{
                         be.changhao = @"";
                    }
                    
                   
                    NSString * danstr = @"";
                    if ([arrcont count] >= 3) {
                        danstr = [arrcont objectAtIndex:3];
                    }
                    // NSArray * nutimearr = [gc.datetime componentsSeparatedByString:@" "];
                    // be.numtime = [nutimearr objectAtIndex:0];
                    if ([danstr isEqualToString:@"1"]) {
                        be.dandan = YES;
                    }
                    
                    
                    NSString *shengpingfustr = @"";
                    if ([arrcont count] >= 8) {
                        shengpingfustr = [arrcont objectAtIndex:8];
                    }
//                    if ([shengpingfustr length] == 2) {
//                        shengpingfustr = [NSString stringWithFormat:@"%@,%@", [shengpingfustr substringWithRange:NSMakeRange(0, 1)], [shengpingfustr substringWithRange:NSMakeRange(1, 1)]];
//                    }else if([shengpingfustr length] == 3){
//                        if([self.BetDetailInfo.wanfaId isEqualToString:@"01"]){
//                            shengpingfustr = [NSString stringWithFormat:@"%@,%@,%@", [shengpingfustr substringWithRange:NSMakeRange(0, 1)], [shengpingfustr substringWithRange:NSMakeRange(1, 1)], [shengpingfustr substringWithRange:NSMakeRange(2, 1)]]; 
//                        }
//                                
//                    }
                    
                    NSRange douhao = [shengpingfustr rangeOfString:@","];
                    if (douhao.location != NSNotFound) {
                        NSArray * spfarr = [shengpingfustr componentsSeparatedByString:@","];
                        
                        if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
                            if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
                                for (int n = 0; n < [spfarr count]; n++) {
                                    NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                    
                                    if (spfzi.location != NSNotFound) {
                                        NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                        if ([arrspf count] >= 1) {
                                            if ([[arrspf objectAtIndex:0] isEqualToString:@"胜"]) {
                                                be.selection1 = YES;
                                                
                                            }else if([[arrspf objectAtIndex:0] isEqualToString:@"平"]){
                                                be.selection2 = YES;
                                                
                                            }else if([[arrspf objectAtIndex:0] isEqualToString:@"负"]){
                                                be.selection3 = YES;
                                            }
                                        }
                                        
                                    }else {
                                        if ([[spfarr objectAtIndex:n] isEqualToString:@"胜"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[spfarr objectAtIndex:n] isEqualToString:@"平"]){
                                            be.selection2 = YES;
                                            
                                        }else if([[spfarr objectAtIndex:n] isEqualToString:@"负"]){
                                            be.selection3 = YES;
                                        }
                                    }
                                    
                                }

                            }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"07"]) {
                                for (int n = 0; n < [spfarr count]; n++) {
                                    NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                    
                                    if (spfzi.location != NSNotFound) {
                                        NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                        if ([arrspf count]>= 1) {
                                            if ([[arrspf objectAtIndex:0] isEqualToString:@"让分主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                                be.selection1 = YES;
                                                
                                            }else if([[arrspf objectAtIndex:0] isEqualToString:@"让分主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                                be.selection2 = YES;
                                                
                                            }
                                        }
                                        
                                    }else {
                                        if ([[spfarr objectAtIndex:n] isEqualToString:@"让分主负"]||[[spfarr objectAtIndex:n] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[spfarr objectAtIndex:n] isEqualToString:@"让分主胜"]||[[spfarr objectAtIndex:n] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }
                                
                            }else  if ([self.BetDetailInfo.wanfaId isEqualToString:@"06"]) {
                                for (int n = 0; n < [spfarr count]; n++) {
                                    NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                    
                                    if (spfzi.location != NSNotFound) {
                                        NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                        if ([arrspf count] >= 1) {
                                            if ([[arrspf objectAtIndex:0] isEqualToString:@"主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                                be.selection1 = YES;
                                                
                                            }else if([[arrspf objectAtIndex:0] isEqualToString:@"主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                                be.selection2 = YES;
                                                
                                            }
                                        }
                                        
                                    }else {
                                        if ([[spfarr objectAtIndex:n] isEqualToString:@"主负"]||[[spfarr objectAtIndex:n] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[spfarr objectAtIndex:n] isEqualToString:@"主胜"]||[[spfarr objectAtIndex:n] isEqualToString:@"主胜"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }
                                
                            }else if ([self.BetDetailInfo.wanfaId isEqualToString:@"09"]) {
                                for (int n = 0; n < [spfarr count]; n++) {
                                    NSRange spfzi = [[spfarr objectAtIndex:n] rangeOfString:@" "];
                                    
                                    if (spfzi.location != NSNotFound) {
                                        NSArray * arrspf = [[spfarr objectAtIndex:n] componentsSeparatedByString:@" "];
                                        if ([arrspf count] >= 1) {
                                            if ([[arrspf objectAtIndex:0] isEqualToString:@"大"]) {
                                                be.selection1 = YES;
                                                
                                            }else if([[arrspf objectAtIndex:0] isEqualToString:@"小"]){
                                                be.selection2 = YES;
                                                
                                            }
                                        }
                                        
                                    }else {
                                        if ([[spfarr objectAtIndex:n] isEqualToString:@"大"]) {
                                            be.selection1 = YES;
                                            
                                        }else if([[spfarr objectAtIndex:n] isEqualToString:@"小"]){
                                            be.selection2 = YES;
                                            
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                        
                        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"05"]||[self.BetDetailInfo.wanfaId isEqualToString:@"08"]||[self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
                            
                            
                            
                            
                            NSMutableArray * bifenarr;
                            if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"]) {
                                bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
                                
                                
                                bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
                                
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
                                bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                                bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
                            }
                            
                            
                            NSMutableArray * shuarr = [[NSMutableArray alloc] initWithCapacity:0];
                            for (int s = 0; s < [bifenarr count]; s++) {
                                [shuarr addObject:@"0"];
                            }
                            
                            for (int a = 0; a < [spfarr count]; a++) {
                                
                                //                                NSString * qianstr = [[spfarr objectAtIndex:a] substringToIndex:1];
                                //                                NSString * houstr = [[spfarr objectAtIndex:a] substringWithRange:NSMakeRange(1, 1)];
                                //                                NSString * zongstr = [NSString stringWithFormat:@"%@:%@", qianstr, houstr];
                                NSString * zongstr = [spfarr objectAtIndex:a];
                                NSRange ssp = [shengpingfustr rangeOfString:@" "];
                                if (ssp.location != NSNotFound) {
                                    NSArray * kongs = [shengpingfustr componentsSeparatedByString:@" "];
                                    if ([kongs count] >= 1) {
                                        shengpingfustr = [kongs objectAtIndex:0];
                                    }
                                    
                                }

                                NSLog(@"zong = %@", zongstr);
                                if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                                
                                    NSArray * bifenarr1 = [NSMutableArray arrayWithObjects:@"客1-5", @"客6-10", @"客11-15", @"客16-20", @"客21-25", @"客26+",@"主1-5", @"主6-10", @"主11-15", @"主16-20", @"主21-25", @"主26+", nil];
                                    for (int b = 0; b < [bifenarr count]; b++) {
                                        if ([zongstr isEqualToString:[bifenarr objectAtIndex:b]]||[zongstr isEqualToString:[bifenarr1 objectAtIndex:b]]) {
                                            
                                            [shuarr replaceObjectAtIndex:b withObject:@"1"];
                                            break;
                                            // [be.bufshuarr replaceObjectAtIndex:b withObject:@"1"];
                                            //                                        [kebianarr replaceObjectAtIndex:j withObject:be];
                                            //                                        [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                                        }
                                    }

                                }else{
                                   
                                    for (int b = 0; b < [bifenarr count]; b++) {
                                        if ([zongstr isEqualToString:[bifenarr objectAtIndex:b]]) {
                                            
                                            [shuarr replaceObjectAtIndex:b withObject:@"1"];
                                            break;
                                            // [be.bufshuarr replaceObjectAtIndex:b withObject:@"1"];
                                            //                                        [kebianarr replaceObjectAtIndex:j withObject:be];
                                            //                                        [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                                        }
                                    }

                                
                                }
                                                                
                            }
                            NSLog(@"arr = %@", shuarr);
                            be.bufshuarr = shuarr;
                            [shuarr release];
                            
                            
                            
                            
                            NSString * strbi = @"";
                            for (int q = 0; q < [be.bufshuarr count]; q++) {
                                if ([[be.bufshuarr objectAtIndex:q] isEqualToString:@"1"]) {
                                    
                                    strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:q]];
                                    
                                    
                                }
                            }
                            
                            if ([strbi length] > 0) {
                                strbi =  [strbi substringToIndex:[strbi length] -1];
                                be.cellstring = strbi;
                            }else{
                                be.cellstring = @"请选择投注选项";
                            }
                            
                            
                        }
                        
                        
                    }else {
                        if([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"06"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]||[self.BetDetailInfo.wanfaId isEqualToString:@"09"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]){
                            
                            
                            if ([self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"] && [self.BetDetailInfo.lotteryId isEqualToString:@"201"]) {
                                
                                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                                [cai showMessage:@"此玩法暂不支持抄单"];
                                return;
                            }
                            
                            
                            if ([self.BetDetailInfo.wanfaId isEqualToString:@"01"]||[self.BetDetailInfo.wanfaId isEqualToString:@"10"]) {
                                NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                    if ([arrspf count] >= 1) {
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"胜"]) {
                                            be.selection1 = YES;
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"平"]){
                                            be.selection2 = YES;
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"负"]){
                                            be.selection3 = YES;
                                        }
                                    }
                                    
                                    
                                }else {
                                    if ([shengpingfustr isEqualToString:@"胜"]) {
                                        be.selection1 = YES;
                                    }else if([shengpingfustr isEqualToString:@"平"]){
                                        be.selection2 = YES;
                                    }else if([shengpingfustr isEqualToString:@"负"]){
                                        be.selection3 = YES;
                                    }
                                }
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"07"]){
                                NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                    if ([arrspf count] >= 1) {
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"让分主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"让分主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                        }
                                    }
                                    
                                }else {
                                    if ([shengpingfustr isEqualToString:@"让分主负"]||[shengpingfustr isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                    }else if([shengpingfustr isEqualToString:@"让分主胜"]||[shengpingfustr isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"06"]){
                                NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                    if ([arrspf count] >= 1) {
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"主负"]||[[arrspf objectAtIndex:0] isEqualToString:@"负"]) {
                                            be.selection1 = YES;
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"主胜"]||[[arrspf objectAtIndex:0] isEqualToString:@"胜"]){
                                            be.selection2 = YES;
                                        }
                                    }
                                   
                                }else {
                                    if ([shengpingfustr isEqualToString:@"主负"]||[shengpingfustr isEqualToString:@"负"]) {
                                        be.selection1 = YES;
                                    }else if([shengpingfustr isEqualToString:@"主胜"]||[shengpingfustr isEqualToString:@"胜"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"09"]){
                                NSRange spfzi = [shengpingfustr rangeOfString:@" "];
                                
                                if (spfzi.location != NSNotFound) {
                                    NSArray * arrspf = [shengpingfustr componentsSeparatedByString:@" "];
                                    if ([arrspf count] >= 1) {
                                        if ([[arrspf objectAtIndex:0] isEqualToString:@"大"]) {
                                            be.selection1 = YES;
                                        }else if([[arrspf objectAtIndex:0] isEqualToString:@"小"]){
                                            be.selection2 = YES;
                                        }
                                    }
                                    
                                    
                                }else {
                                    if ([shengpingfustr isEqualToString:@"大"]) {
                                        be.selection1 = YES;
                                    }else if([shengpingfustr isEqualToString:@"小"]){
                                        be.selection2 = YES;
                                    }
                                }
                                
                            }
                           
                            
                            
                            
                            
                        }else if([self.BetDetailInfo.wanfaId isEqualToString:@"05"]||[self.BetDetailInfo.wanfaId isEqualToString:@"03"]||[self.BetDetailInfo.wanfaId isEqualToString:@"04"]||[self.BetDetailInfo.wanfaId isEqualToString:@"07"]){
                            
                            
                            NSMutableArray * bifenarr= nil;
                            if ([self.BetDetailInfo.wanfaId isEqualToString:@"05"]) {
                                bifenarr = [NSMutableArray arrayWithObjects:@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",@"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",@"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他", nil];
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"03"]){
                                
                                
                                bifenarr = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7+", nil];
                                
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"04"]){
                                bifenarr = [NSMutableArray arrayWithObjects:@"胜胜", @"胜平", @"胜负", @"平胜", @"平平", @"平负", @"负胜", @"负平", @"负负", nil];
                            }else if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                                bifenarr = [NSMutableArray arrayWithObjects:@"客胜1-5", @"客胜6-10", @"客胜11-15", @"客胜16-20", @"客胜21-25", @"客胜26+",@"主胜1-5", @"主胜6-10", @"主胜11-15", @"主胜16-20", @"主胜21-25", @"主胜26+", nil];
                            }

                            
                            
                            
                            
                            NSMutableArray * shuarr = [[NSMutableArray alloc] initWithCapacity:0];
                            for (int s = 0; s < [bifenarr count]; s++) {
                                [shuarr addObject:@"0"];
                            }
                            
                            if([self.BetDetailInfo.wanfaId isEqualToString:@"08"]){
                                NSArray * bifenarr1 = [NSMutableArray arrayWithObjects:@"客1-5", @"客6-10", @"客11-15", @"客16-20", @"客21-25", @"客26+",@"主1-5", @"主6-10", @"主11-15", @"主16-20", @"主21-25", @"主26+", nil];
                                for (int a = 0; a < [bifenarr count]; a++) {
                                    if ([[bifenarr objectAtIndex:a] isEqualToString:shengpingfustr]||[[bifenarr1 objectAtIndex:a] isEqualToString:shengpingfustr]) {
                                        //  [be.bufshuarr replaceObjectAtIndex:a withObject:@"1"];
                                        [shuarr replaceObjectAtIndex:a withObject:@"1"];
                                        //                                    [kebianarr replaceObjectAtIndex:j withObject:be];
                                        //                                    [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                                        //
                                    }
                                }
                            }else{
                               
                                for (int a = 0; a < [bifenarr count]; a++) {
                                    if ([[bifenarr objectAtIndex:a] isEqualToString:shengpingfustr]) {
                                        //  [be.bufshuarr replaceObjectAtIndex:a withObject:@"1"];
                                        [shuarr replaceObjectAtIndex:a withObject:@"1"];
                                        //                                    [kebianarr replaceObjectAtIndex:j withObject:be];
                                        //                                    [kebianzidian replaceObjectAtIndex:i withObject:kebianarr];
                                        //
                                    }
                                }
                            
                            }
                            
                           
                            be.bufshuarr = shuarr;
                            [shuarr release];
                            NSString * strbi = @"";
                            for (int q = 0; q < [be.bufshuarr count]; q++) {
                                if ([[be.bufshuarr objectAtIndex:q] isEqualToString:@"1"]) {
                                    
                                    strbi = [NSString stringWithFormat:@"%@%@,", strbi, [bifenarr objectAtIndex:q]];
                                    
                                    
                                }
                            }
                            
                            if ([strbi length] > 0) {
                                strbi =  [strbi substringToIndex:[strbi length] -1];
                                be.cellstring = strbi;
                            }else{
                                be.cellstring = @"请选择投注选项";
                            }
                              NSLog(@"arr = %@", strbi);
                            
                        }
                        
                        
                    }
                    
                    
                    [cellarray addObject:be];
                    [be release];
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
                //            if (matchenum  == matchEnumShengPingFuGuoGuan){
                //                sheng.fenzhong = jingcaipiao;
                //            }else{
                //                sheng.fenzhong = jingcaibifen;
                //            }
                //zhushuDic = [[NSMutableDictionary  alloc] initWithCapacity:0];
                [zhushuDic removeAllObjects];
                NSRange chuanfa = [self.BetDetailInfo.guguanWanfa rangeOfString:@","];
                if (chuanfa.location != NSNotFound) {
                    // labelch.text = @"多串...";
                    NSArray * douarr = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@","];
                    for (int i = 0; i < [douarr count]; i++) {
                        NSArray * arrchuan = [[douarr objectAtIndex:i] componentsSeparatedByString:@"x"];
                        if ([arrchuan count] >= 2) {
                            NSString * chuanfastr = [NSString stringWithFormat:@"%@串%@", [arrchuan objectAtIndex:0], [arrchuan objectAtIndex:1]];
                            if (i == [douarr count]-1) {
                                NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[self.BetDetailInfo.programAmount longLongValue]];
                                [zhushuDic setObject:longNum forKey:chuanfastr];
                                [longNum release];
                                
                            }else{
                                NSNumber *longNum = [[NSNumber alloc] initWithLongLong:0];
                                [zhushuDic setObject:longNum forKey:chuanfastr];
                                [longNum release];
                            }
                        }
                       
                    }
                    
                    
                }else{
                    
                    if ([self.BetDetailInfo.guguanWanfa isEqualToString:@"单关"]) {
                      
                        
                        NSString * chuanfastr = @"单关";
                        
                        NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[self.BetDetailInfo.programAmount longLongValue]];
                        [zhushuDic setObject:longNum forKey:chuanfastr];
                        [longNum release];
                    }else{
                        NSArray * arrchuan = [self.BetDetailInfo.guguanWanfa componentsSeparatedByString:@"x"];
                        if ([arrchuan count] >= 2) {
                            NSString * chuanfastr = [NSString stringWithFormat:@"%@串%@", [arrchuan objectAtIndex:0], [arrchuan objectAtIndex:1]];
                            
                            NSNumber *longNum = [[NSNumber alloc] initWithLongLong:[self.BetDetailInfo.programAmount longLongValue]];
                            [zhushuDic setObject:longNum forKey:chuanfastr];
                            [longNum release];
                        }
                        
                        
                        
                    }
                   
                }
                
                //                alldict = zhushuDic;
                //                allcellarr = cellarray;
                
                NSLog(@"all = %@", [zhushuDic allKeys]);
                
                [self chaoDanYuJiJiangJin];
                
                
                //            [yuji release];
                
                
            }else{
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"此玩法暂不支持抄单"];
            }
            
            
            
            
            
            
            
            
            
            //            NSLog(@"wanfa = %@", self.BetDetailInfo.wanfaId);
            //            if  ([self.BetDetailInfo.wanfaId isEqualToString:@"01"] || [self.BetDetailInfo.wanfaId isEqualToString:@"05"]){
            //                GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
            //                gcjc.chaodanbool = YES;
            //                gcjc.betrecorinfo = self.BetDetailInfo;
            //                [self.navigationController pushViewController:gcjc animated:YES];
            //                [gcjc release];
            //            }else{
            //                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            //                [cai showMessage:@"此玩法暂不支持抄单"];
            //            }
            //           
            //            
            //         NSLog(@"cccccc");
        }else{
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"此玩法暂不支持抄单"];
        }
        
        
        
        
        
    
}


- (void)jingcaichaodan{
    NSLog(@"lotteryClassCode = %d", [[dataDic objectForKey:@"lotteryClassCode"] intValue]);
    NSLog(@"lotteryId = %d", [[dataDic objectForKey:@"lotteryId"] intValue]);
    NSLog(@"fee = %d", [[dataDic objectForKey:@"fee"] intValue]);
    NSLog(@"ggfs = %@", [dataDic objectForKey:@"ggfs"]);
    NSLog(@"issue = %@", [dataDic objectForKey:@"issue"] );
    
    NSArray * matchVS = [dataDic objectForKey:@"matchVS"];
    GC_BetRecordDetail * record = [[GC_BetRecordDetail alloc] init];
    NSMutableArray * infoarr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [matchVS count]; i++) {
        NSDictionary * dictd = [matchVS objectAtIndex:i];
        
        NSLog(@"changCi = %@", [dictd objectForKey:@"changCi"]);
        NSLog(@"dan = %d", [[dictd objectForKey:@"dan"] intValue]);
        NSLog(@"endTime = %@", [dictd objectForKey:@"endTime"]);
        NSLog(@"letBall = %@", [dictd objectForKey:@"letBall"]);
        NSLog(@"matchId = %d", [[dictd objectForKey:@"matchId"] intValue]);
        NSLog(@"matchNumber = %@", [dictd objectForKey:@"matchNumber"]);
        NSLog(@"matchStartTime = %@", [dictd objectForKey:@"matchStartTime"]);
        NSLog(@"touZhu = %@", [dictd objectForKey:@"touZhu"]);
        NSString * touzhustr = [dictd objectForKey:@"touZhu"];
        
        if ([[dataDic objectForKey:@"lotteryId"] intValue] == 22 ||[[dataDic objectForKey:@"lotteryId"] intValue] == 49) {
            if ([touzhustr length] == 3) {
                NSString * str1 = [touzhustr substringToIndex:1];
                NSString * str2 = [touzhustr substringWithRange:NSMakeRange(1, 1)];
                NSString * str3 = [touzhustr substringWithRange:NSMakeRange(2, 1)];
                touzhustr = [NSString stringWithFormat:@"%@,%@,%@", str1, str2, str3];
            }else if([touzhustr length] == 2){
                NSString * str1 = [touzhustr substringToIndex:1];
                NSString * str2 = [touzhustr substringWithRange:NSMakeRange(1, 1)];
                
                touzhustr = [NSString stringWithFormat:@"%@,%@", str1, str2];
                
            }

        }
               
        
        NSLog(@"touzhustr = %@", touzhustr);
        NSString * infostring = [NSString stringWithFormat:@"%@; ; ;%d; ; ; ;%d;%@;%@;%@", [dictd objectForKey:@"matchNumber"], [[dictd objectForKey:@"dan"] intValue], [[dictd objectForKey:@"matchId"] intValue], touzhustr, [dictd objectForKey:@"changCi"], [dictd objectForKey:@"leagueName"]];
        NSLog(@"info = %@", infostring);
        [infoarr addObject:infostring];
    }
    record.betsNum = [dataDic objectForKey:@"zhushu"];
    record.betContentArray = infoarr;
    record.lotteryId = [NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryClassCode"] intValue]];
    record.guguanWanfa = [dataDic objectForKey:@"ggfs"];
    
    
    if ([[dataDic objectForKey:@"lotteryId"] intValue] == 22) {
         record.wanfaId = @"01";
        //[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    }else if ([[dataDic objectForKey:@"lotteryId"] intValue] == 23) {
        record.wanfaId = @"05";//[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    }else if ([[dataDic objectForKey:@"lotteryId"] intValue] == 24) {
        record.wanfaId = @"03";//[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    }else if ([[dataDic objectForKey:@"lotteryId"] intValue] == 25) {
        record.wanfaId = @"04";//[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    }else if ([[dataDic objectForKey:@"lotteryId"] intValue] == 26) {
        record.wanfaId = @"06";//[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    }else if ([[dataDic objectForKey:@"lotteryId"] intValue] == 27) {
        record.wanfaId = @"07";//[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    }else if ([[dataDic objectForKey:@"lotteryId"] intValue] == 28) {
        record.wanfaId = @"08";//[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    }else if ([[dataDic objectForKey:@"lotteryId"] intValue] == 29) {
        record.wanfaId = @"09";//[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    }else if([[dataDic objectForKey:@"lotteryId"] intValue] == 49){
        record.wanfaId = @"10";
    }
    
    
    //record.wanfaId = [NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    record.multiplenNum = @"1";
    record.programAmount = [NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"fee"] intValue]];
    [infoarr release];
    
    self.BetDetailInfo = record;
    [record release];
    
    
    [self chaodan];
    
    
    
    
    
}




- (void)shengfucaichaodan{
    
    NSLog(@"lotteryClassCode = %d", [[dataDic objectForKey:@"lotteryClassCode"] intValue]);
    NSLog(@"lotteryId = %d", [[dataDic objectForKey:@"lotteryId"] intValue]);
    NSLog(@"fee = %d", [[dataDic objectForKey:@"fee"] intValue]);
    NSLog(@"ggfs = %@", [dataDic objectForKey:@"ggfs"] );
    NSLog(@"issue = %@", [dataDic objectForKey:@"issue"] );
    NSArray * matchVS = [dataDic objectForKey:@"matchVS"];
    GC_BetRecordDetail * record = [[GC_BetRecordDetail alloc] init];
    NSMutableArray * infoarr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [matchVS count]; i++) {
        NSDictionary * dictd = [matchVS objectAtIndex:i];
        
        NSLog(@"changCi = %@", [dictd objectForKey:@"changCi"]);
        NSLog(@"dan = %d", [[dictd objectForKey:@"dan"] intValue]);
        NSLog(@"endTime = %@", [dictd objectForKey:@"endTime"]);
        NSLog(@"letBall = %@", [dictd objectForKey:@"letBall"]);
        NSLog(@"matchId = %d", [[dictd objectForKey:@"matchId"] intValue]);
        NSLog(@"matchNumber = %@", [dictd objectForKey:@"matchNumber"]);
        NSLog(@"matchStartTime = %@", [dictd objectForKey:@"matchStartTime"]);
        NSLog(@"touZhu = %@", [dictd objectForKey:@"touZhu"]);
        
        
        NSString * infostring = [NSString stringWithFormat:@"%d;%@;%@; ; ; ; ;%@",i+1,[dictd objectForKey:@"changCi"], [dictd objectForKey:@"touZhu"],[dictd objectForKey:@"leagueName"]];
        NSLog(@"info = %@", infostring);
        [infoarr addObject:infostring];
        
    }
    
    
    record.betsNum = [dataDic objectForKey:@"zhushu"];
    record.betContentArray = infoarr;
    record.lotteryId = [NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryClassCode"] intValue]];
    record.guguanWanfa = [dataDic objectForKey:@"ggfs"];
    record.wanfaId = [NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryId"] intValue]];
    record.multiplenNum = @"1";
    record.programAmount = [NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"zhushu"] intValue]*2];
    [infoarr release];
    
    self.BetDetailInfo = record;
    [record release];

    
    [self chaodan];
    
    
    
    
    
}

- (void)goBuy {
    if ([[dataDic objectForKey:@"orderId"] length]) {
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
        info.nikeName = info.BetDetailInfo.sponsorsName;
        info.orderId = [dataDic objectForKey:@"orderId"];
        if ([[dataDic objectForKey:@"issue"] length]) {
            info.issure = [NSString stringWithFormat:@"%@", [dataDic objectForKey:@"issue"]];
        }
        else {
//            info.issure = @"-";
        }
        
        NSLog(@"info.issure = %@", [NSString stringWithFormat:@"%@", [dataDic objectForKey:@"issue"]] );//issue
        info.lottoryName =[[dataDic objectForKey:@"lotteryId"] lotteryIdChange];
        UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        [NV setNavigationBarHidden:NO];
        [info.navigationController setNavigationBarHidden:NO];
        if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
            PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
            NSLog(@"%@",VC);
            
            [VC.selectedViewController.navigationController pushViewController:info animated:YES];
        }
        else {
            [NV pushViewController:info animated:YES];
        }
        
        [info release];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    }
    else {
        
        if ([[dataDic objectForKey:@"lotteryClassCode"] intValue] == 201 || [[dataDic objectForKey:@"lotteryClassCode"] intValue] == 200) {//竞彩
            
            
           
            if ([dataDic objectForKey:@"issue"]) {
                 NSLog(@"issaaa = %@", [dataDic objectForKey:@"issue"] );
                
                
                
                
                if ([[dataDic objectForKey:@"iscanCaoD"] intValue] == 1) {
                    
                    
                    if ([[dataDic objectForKey:@"ggfs"] isEqualToString:@"单关"] && [[dataDic objectForKey:@"lotteryClassCode"] intValue] == 201) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持抄单"];
                    }
                    
                    [self jingcaichaodan];
                }else{
                    if ([self.BetDetailInfo.lotteryId isEqualToString:@"22"]||[self.BetDetailInfo.lotteryId isEqualToString:@"23"]||[self.BetDetailInfo.lotteryId isEqualToString:@"49"]) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"不是当前期不支持抄单"];
                    }else{
                        [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持抄单"];
                    }
                    
                
                }
                
                
                
            }else{
                
                [[caiboAppDelegate getAppDelegate] showMessage:@"不是当前期不支持抄单"];
            }
            
             
            
        }else if ([[dataDic objectForKey:@"lotteryClassCode"] intValue] == 300||[[dataDic objectForKey:@"lotteryClassCode"] intValue] == 301) {//胜负彩
            
            NSMutableData *postData = [[GC_HttpService sharedInstance] panDuanDangQianQiIssue:[dataDic objectForKey:@"issue"] caizhong:[NSString stringWithFormat:@"%d", [[dataDic objectForKey:@"lotteryClassCode"] intValue]]];
            [httprequest clearDelegatesAndCancel];
            self.httprequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [httprequest setDidFinishSelector:@selector(panduandangqianqi:)];
            [httprequest setDidFailSelector:@selector(didFailSelector:)];
            [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httprequest setRequestMethod:@"POST"];
            [httprequest setPostBody:postData];
            [httprequest setDelegate:self];
            [httprequest addCommHeaders];
            [httprequest startAsynchronous];

        
        }

            

        
                
        
  

    }
    
   
   // [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}


- (void)panduandangqianqi:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
       
      DangQianQiData  * dangqian = [[DangQianQiData alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        
        if ([dangqian.returnVal isEqualToString:@"1"]) {
            
            
            if ([[dataDic objectForKey:@"lotteryClassCode"] intValue] == 201 ||[[dataDic objectForKey:@"lotteryClassCode"] intValue] == 200) {//竞彩
                
                if ([[dataDic objectForKey:@"lotteryId"] intValue] == 22 ||[[dataDic objectForKey:@"lotteryId"] intValue] == 23||[[dataDic objectForKey:@"lotteryId"] intValue] == 24||[[dataDic objectForKey:@"lotteryId"] intValue] == 25||[[dataDic objectForKey:@"lotteryId"] intValue] == 26||[[dataDic objectForKey:@"lotteryId"] intValue] == 27||[[dataDic objectForKey:@"lotteryId"] intValue] == 28||[[dataDic objectForKey:@"lotteryId"] intValue] == 29||[[dataDic objectForKey:@"lotteryId"] intValue] == 49) {//竞彩胜平负
                    
                    if ([[dataDic objectForKey:@"ggfs"] isEqualToString:@"单关"] && [[dataDic objectForKey:@"lotteryClassCode"] intValue] == 201) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持抄单"];
                    }
                    
                    [self jingcaichaodan];
                    [dangqian release];
                    return;
                    
                }else {
                    [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持此彩种抄单"];
                    
                    
                    
                }
            }else if ([[dataDic objectForKey:@"lotteryClassCode"] intValue] == 300||[[dataDic objectForKey:@"lotteryClassCode"] intValue] == 301) {//胜负彩
                
                [self shengfucaichaodan];
                
            }else{
                
                [[caiboAppDelegate getAppDelegate] showMessage:@"暂不支持此彩种抄单"];
                
                
            }

        }else{
            [[caiboAppDelegate getAppDelegate] showMessage:@"不是当前期不支持抄单"];
        }
        [dangqian release];
         [self removeFromSuperview];
    }
    
    
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![dataDic objectForKey:@"matchVS"] && dataDic) {
        return 1;
    }
	return [[dataDic objectForKey:@"matchVS"] count];
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [dataDic objectForKey:@"msg"];
        
    }
    if (![dataDic objectForKey:@"matchVS"]) {
        return cell;
    }
	if (touZhuShowType == TouZhuShowTypeZC ||touZhuShowType == TouZhuShowTypeRQSPF||(touZhuShowType >=TouZhuShowTypeLanqiuRangFenShengFu && touZhuShowType <= TouZhuShowTypeLanqiuShengfencha)) {
		static NSString *CellIdentifier1 = @"Cell1";
		
		JingCaiZuQiuCell *cell1 = (JingCaiZuQiuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[JingCaiZuQiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
		}
		if (indexPath.row == 0) {
			[cell1 LoadData:[[dataDic objectForKey:@"matchVS"]objectAtIndex:indexPath.row] IsFirst:YES LotteryId:[dataDic objectForKey:@"lotteryId"]];
		}
		else {
			[cell1 LoadData:[[dataDic objectForKey:@"matchVS"]objectAtIndex:indexPath.row] IsFirst:NO LotteryId:[dataDic objectForKey:@"lotteryId"]];
		}
		if (indexPath.row%2 == 0) {
            [cell1 setLabelColor:[UIColor colorWithRed:194/255.0 green:240/255.0 blue:252/255.0 alpha:1]];
		}
		else {
            [cell1 setLabelColor:[UIColor colorWithRed:130/255.0 green:215/255.0 blue:235/255.0 alpha:1.0]];
		}

		return cell1;
	}
	if (touZhuShowType == TouZhuShowTypeZC) {
		static NSString *CellIdentifier1 = @"Cell1";
		
		JingCaiZuQiuCell *cell1 = (JingCaiZuQiuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[JingCaiZuQiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
		}
		if (indexPath.row == 0) {
			[cell1 LoadData:[[dataDic objectForKey:@"matchVS"]objectAtIndex:indexPath.row] IsFirst:YES LotteryId:[dataDic objectForKey:@"lotteryId"]];
		}
		else {
			[cell1 LoadData:[[dataDic objectForKey:@"matchVS"]objectAtIndex:indexPath.row] IsFirst:NO LotteryId:[dataDic objectForKey:@"lotteryId"]];
		}
		if (indexPath.row%2 == 0) {
			cell1.contentView.backgroundColor = [UIColor whiteColor];
		}
		else {
			cell1.contentView.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:245/255.0 blue:1 alpha:1];
		}
		return cell1;
	}
	if (touZhuShowType == TouZhuShowTypeSPF) {
		static NSString *CellIdentifier1 = @"Cell1";
		
		ShenFuCaiCell *cell1 = (ShenFuCaiCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[ShenFuCaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
		}
		[cell1 LoadData:[[dataDic objectForKey:@"matchVS"]objectAtIndex:indexPath.row]];
		if (indexPath.row%2 == 0) {
            [cell1 setLabelColor:[UIColor colorWithRed:194/255.0 green:240/255.0 blue:252/255.0 alpha:1]];
		}
		else {
            [cell1 setLabelColor:[UIColor colorWithRed:130/255.0 green:215/255.0 blue:235/255.0 alpha:1.0]];
		}
		return cell1;
	}
	if (touZhuShowType == TouZhuShowType4JQ) {
		static NSString *CellIdentifier1 = @"Cell1";
		
		ZuCaiJinQiuCell *cell1 = (ZuCaiJinQiuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[ZuCaiJinQiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
		}
		[cell1 LoadData:[[dataDic objectForKey:@"matchVS"]objectAtIndex:indexPath.row] Is4:YES];
        if (indexPath.row%2 == 0) {
            [cell1 setLabelColor:[UIColor colorWithRed:194/255.0 green:240/255.0 blue:252/255.0 alpha:1]];
		}
		else {
            [cell1 setLabelColor:[UIColor colorWithRed:130/255.0 green:215/255.0 blue:235/255.0 alpha:1.0]];
		}
		return cell1;
	}
	if (touZhuShowType == TouZhuShowType6JQ) {
		static NSString *CellIdentifier1 = @"Cell1";
		
		ZuCaiJinQiuCell *cell1 = (ZuCaiJinQiuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[ZuCaiJinQiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
		}
		[cell1 LoadData:[[dataDic objectForKey:@"matchVS"]objectAtIndex:indexPath.row] Is4:NO];
        if (indexPath.row%2 == 0) {
            [cell1 setLabelColor:[UIColor colorWithRed:194/255.0 green:240/255.0 blue:252/255.0 alpha:1]];
		}
		else {
            [cell1 setLabelColor:[UIColor colorWithRed:130/255.0 green:215/255.0 blue:235/255.0 alpha:1.0]];
		}
		return cell1;
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (dataDic) {
		return 70;
	}
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger heght = 30;
	NSDictionary *dic = [[dataDic objectForKey:@"matchVS"]objectAtIndex:indexPath.row];
	switch (touZhuShowType) {
		case TouZhuShowTypeZC:
		{
			if (indexPath.row == 0) {
				heght = 45;
			}
			else {
				heght = 31;
			}
			CGSize maxSize = CGSizeMake(80, 1000);
			CGSize expectedSize = [[dic objectForKey:@"touZhu"] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
			if (heght<expectedSize.height) {
				heght = expectedSize.height;
			}
		}
			break;
		case TouZhuShowTypeRQSPF:{
			if (indexPath.row == 0) {
				heght = 45;
			}
			else {
				heght = 31;
			}

			CGSize maxSize = CGSizeMake(60, 1000);
			CGSize expectedSize = [[dic objectForKey:@"touZhu"] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
			if (heght<expectedSize.height) {
				heght = expectedSize.height;
			}}
			break;

		case TouZhuShowTypeSPF:
			heght = 21;
			break;
			
		case TouZhuShowType4JQ:
			heght = 42;
			break;
		case TouZhuShowType6JQ:
			heght = 42;
			break;
        case TouZhuShowTypeLanqiuRangFenShengFu:
		{
			if (indexPath.row == 0) {
				heght = 45;
			}
			else {
				heght = 31;
			}
			CGSize maxSize = CGSizeMake(80, 1000);
			CGSize expectedSize = [[dic objectForKey:@"touZhu"] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
			if (heght<expectedSize.height) {
				heght = expectedSize.height;
			}
		}
			break;
        case TouZhuShowTypeLanqiuShengfu:
		{
			if (indexPath.row == 0) {
				heght = 45;
			}
			else {
				heght = 31;
			}
			CGSize maxSize = CGSizeMake(80, 1000);
			CGSize expectedSize = [[dic objectForKey:@"touZhu"] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
			if (heght<expectedSize.height) {
				heght = expectedSize.height;
			}
		}
			break;
        case TouZhuShowTypeLanqiuShengfencha:
		{
			if (indexPath.row == 0) {
				heght = 45;
			}
			else {
				heght = 31;
			}
			CGSize maxSize = CGSizeMake(80, 1000);
			CGSize expectedSize = [[dic objectForKey:@"touZhu"] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
			if (heght<expectedSize.height) {
				heght = expectedSize.height;
			}
		}
			break;
        case TouZhuShowTypeLanqiuDaXiaoFen:
		{
			if (indexPath.row == 0) {
				heght = 45;
			}
			else {
				heght = 31;
			}
			CGSize maxSize = CGSizeMake(80, 1000);
			CGSize expectedSize = [[dic objectForKey:@"touZhu"] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
			if (heght<expectedSize.height) {
				heght = expectedSize.height;
			}
		}
			break;

		default:
			break;
	}
	return heght;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *v = [[[UIView alloc] init] autorelease];
	v.userInteractionEnabled = NO;
    v.backgroundColor = [UIColor whiteColor];
	UIImageView *v2 = [[UIImageView alloc] init];
	
	v2.frame = CGRectMake(0, 0, 310, 50);
	v2.backgroundColor = [UIColor colorWithRed:130/255.0 green:215/255.0 blue:235/255.0 alpha:1.0];
    v2.image = UIImageGetImageFromName(@"FAZSS960");
	switch (touZhuShowType) {
		case TouZhuShowTypeZC:
		{
			if ([dataDic objectForKey:@"lotteryId"]) {
				issLabel  = [[UILabel alloc] init];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.font = [UIFont systemFontOfSize:14];
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
                
                UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
				nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
				[nameLabel release];
				
				UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor whiteColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				[numLabel setBackgroundColor:[UIColor clearColor]];
				numLabel.textAlignment = NSTextAlignmentCenter;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];				
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
                
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
				
				UILabel *touzhuLabel = [[UILabel alloc] init];
				touzhuLabel.backgroundColor = [UIColor clearColor];
				touzhuLabel.font = [UIFont systemFontOfSize:12];
				touzhuLabel.textAlignment = NSTextAlignmentCenter;
                touzhuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                touzhuLabel.layer.masksToBounds = YES;
                touzhuLabel.layer.cornerRadius = 2.0;
				[v addSubview:touzhuLabel];
				
				UILabel *danLabel = [[UILabel alloc] init];
				danLabel.backgroundColor = [UIColor clearColor];
				danLabel.font = [UIFont systemFontOfSize:12];
				danLabel.textAlignment = NSTextAlignmentCenter;
                danLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                danLabel.layer.masksToBounds = YES;
                danLabel.layer.cornerRadius = 2.0;
				[v addSubview:danLabel];
								
				numLabel.frame = CGRectMake(3, 50, 40, 20);
				numLabel.text = @"场次";
				saishiLabel.frame = CGRectMake(44, 50, 40, 20);
				saishiLabel.text = @"赛事";
				duizhenLabel.frame = CGRectMake(85, 50, 120, 20);
				duizhenLabel.text = @"对阵";
				touzhuLabel.frame = CGRectMake(206, 50, 80, 20);
				touzhuLabel.text = @"投注";
				danLabel.frame = CGRectMake(287, 50, 20, 20);
				danLabel.text = @"胆";
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[touzhuLabel release];
				[danLabel release];
								
			}
		}
			break;
		case TouZhuShowTypeRQSPF:
		{
			if ([dataDic objectForKey:@"lotteryId"]) {

				issLabel  = [[UILabel alloc] init];
				issLabel.font = [UIFont systemFontOfSize:14];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				else {
					issLabel.text = nil;
				}

				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
                
                UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
				nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
				[nameLabel release];
				
				UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor whiteColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				[numLabel setBackgroundColor:[UIColor clearColor]];
				numLabel.textAlignment = NSTextAlignmentCenter;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];
								
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
                
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
				
				UILabel *touzhuLabel = [[UILabel alloc] init];
				touzhuLabel.backgroundColor = [UIColor clearColor];
				touzhuLabel.font = [UIFont systemFontOfSize:12];
				touzhuLabel.textAlignment = NSTextAlignmentCenter;
                touzhuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                touzhuLabel.layer.masksToBounds = YES;
                touzhuLabel.layer.cornerRadius = 2.0;
				[v addSubview:touzhuLabel];
				
				UILabel *danLabel = [[UILabel alloc] init];
				danLabel.backgroundColor = [UIColor clearColor];
				danLabel.font = [UIFont systemFontOfSize:12];
				danLabel.textAlignment = NSTextAlignmentCenter;
                danLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                danLabel.layer.masksToBounds = YES;
                danLabel.layer.cornerRadius = 2.0;
				[v addSubview:danLabel];
				
								
				numLabel.frame = CGRectMake(3, 50, 40, 20);
				numLabel.text = @"场次";
				saishiLabel.frame = CGRectMake(44, 50, 40, 20);
				saishiLabel.text = @"赛事";
				duizhenLabel.frame = CGRectMake(85, 50, 120, 20);
				duizhenLabel.text = @"对阵";
				touzhuLabel.frame = CGRectMake(206, 50, 80, 20);
				touzhuLabel.text = @"投注";
				danLabel.frame = CGRectMake(287, 50, 20, 20);
				danLabel.text = @"胆";
				
				if ([[dataDic objectForKey:@"lotteryId"] isEqualToString:@"200"]||[[dataDic objectForKey:@"lotteryId"] isEqualToString:@"22"]||[[dataDic objectForKey:@"lotteryId"] isEqualToString:@"49"]) {
					UILabel *label = [[UILabel alloc] init];
					label.backgroundColor = [UIColor clearColor];
					label.text = @"让";
					label.font = [UIFont systemFontOfSize:12];
					label.textAlignment = NSTextAlignmentCenter;
					label.frame = CGRectMake(206, 50, 20, 20);
                    label.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                    label.layer.masksToBounds = YES;
                    label.layer.cornerRadius = 2.0;
					touzhuLabel.frame = CGRectMake(227, 50, 60, 20);
                    danLabel.frame = CGRectMake(288, 50, 20, 20);
					[v addSubview:label];
					[label release];
				}
				
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[touzhuLabel release];
				[danLabel release];
				
								
			}
		}
			break;
		case TouZhuShowTypeSPF:
			if ([dataDic objectForKey:@"lotteryId"]) {
				issLabel  = [[UILabel alloc] init];
			//	issLabel.font = [UIFont systemFontOfSize:14];
                issLabel.font = [UIFont systemFontOfSize:14];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
                
                UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
				nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
				[nameLabel release];
				
				UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor whiteColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				[numLabel setBackgroundColor:[UIColor clearColor]];
				numLabel.textAlignment = NSTextAlignmentCenter;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
                
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
								
				
				UILabel *shengLabel = [[UILabel alloc] init];
				shengLabel.backgroundColor = [UIColor clearColor];
                shengLabel.font =[UIFont systemFontOfSize:12];
				shengLabel.textAlignment = NSTextAlignmentCenter;
                shengLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                shengLabel.layer.masksToBounds = YES;
                shengLabel.layer.cornerRadius = 2.0;
				[v addSubview:shengLabel];
				
				UILabel *pingLabel = [[UILabel alloc] init];
				pingLabel.backgroundColor = [UIColor clearColor];
                pingLabel.font = [UIFont systemFontOfSize:12];
				pingLabel.textAlignment = NSTextAlignmentCenter;
                pingLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                pingLabel.layer.masksToBounds = YES;
                pingLabel.layer.cornerRadius = 2.0;
				[v addSubview:pingLabel];
				
				UILabel *fuLabel = [[UILabel alloc] init];
				fuLabel.backgroundColor = [UIColor clearColor];
                fuLabel.font = [UIFont systemFontOfSize:12];
				fuLabel.textAlignment = NSTextAlignmentCenter;
                fuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                fuLabel.layer.masksToBounds = YES;
                fuLabel.layer.cornerRadius = 2.0;
				[v addSubview:fuLabel];
				
				
				numLabel.text = @"场次";
				saishiLabel.text = @"赛事";
				duizhenLabel.text = @"对阵";
				shengLabel.text = @"胜";
				pingLabel.text = @"平";
				fuLabel.text = @"负";
                numLabel.frame = CGRectMake(3, 50, 40, 20);
				saishiLabel.frame = CGRectMake(44, 50, 50, 20);
				duizhenLabel.frame = CGRectMake(95, 50, 135, 20);
                shengLabel.frame = CGRectMake(231, 50, 24, 20);
                pingLabel.frame = CGRectMake(256, 50, 24, 20);
                fuLabel.frame = CGRectMake(281, 50, 24, 20);
				
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[shengLabel release];
				[pingLabel release];
				[fuLabel release];
								
			}
			break;
		case TouZhuShowType6JQ:
			if ([dataDic objectForKey:@"lotteryId"]) {
				issLabel  = [[UILabel alloc] init];
				//issLabel.font = [UIFont systemFontOfSize:14];
                issLabel.font = [UIFont systemFontOfSize:14];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
				
				UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
			//	nameLabel.font = [UIFont systemFontOfSize:14];
                nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
				[nameLabel release];
                
                UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor clearColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				numLabel.textAlignment = NSTextAlignmentCenter;
				numLabel.numberOfLines = 0;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];
                
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
				
				UILabel *sheng0Label = [[UILabel alloc] init];
				sheng0Label.backgroundColor = [UIColor clearColor];
				sheng0Label.font = [UIFont systemFontOfSize:12];
				sheng0Label.textAlignment = NSTextAlignmentCenter;
                sheng0Label.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                sheng0Label.layer.masksToBounds = YES;
                sheng0Label.layer.cornerRadius = 2.0;
				[v addSubview:sheng0Label];
				
				UILabel *shengLabel = [[UILabel alloc] init];
				shengLabel.backgroundColor = [UIColor clearColor];
				shengLabel.font = [UIFont systemFontOfSize:12];
				shengLabel.textAlignment = NSTextAlignmentCenter;
                shengLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                shengLabel.layer.masksToBounds = YES;
                shengLabel.layer.cornerRadius = 2.0;
				[v addSubview:shengLabel];
				
				UILabel *pingLabel = [[UILabel alloc] init];
				pingLabel.backgroundColor = [UIColor clearColor];
				pingLabel.font = [UIFont systemFontOfSize:12];
				pingLabel.textAlignment = NSTextAlignmentCenter;
                pingLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                pingLabel.layer.masksToBounds = YES;
                pingLabel.layer.cornerRadius = 2.0;
				[v addSubview:pingLabel];
				
				UILabel *fuLabel = [[UILabel alloc] init];
				fuLabel.backgroundColor = [UIColor clearColor];
				fuLabel.font = [UIFont systemFontOfSize:12];
				fuLabel.textAlignment = NSTextAlignmentCenter;
                fuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                fuLabel.layer.masksToBounds = YES;
                fuLabel.layer.cornerRadius = 2.0;
				[v addSubview:fuLabel];
				
				numLabel.text = @"场次";
				saishiLabel.text = @"赛事";
				duizhenLabel.text = @"对阵";
				shengLabel.text = @"胜";
				pingLabel.text = @"平";
				fuLabel.text = @"负";
                
                numLabel.frame = CGRectMake(2, 50, 40, 20);
				saishiLabel.frame = CGRectMake(43, 50, 40, 20);
				duizhenLabel.frame = CGRectMake(84,50, 131, 20);
				shengLabel.frame = CGRectMake(216, 50, 30, 20);
				pingLabel.frame = CGRectMake(247, 50, 30, 20);
				fuLabel.frame = CGRectMake(278, 50, 30, 20);
								
				
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[shengLabel release];
				[pingLabel release];
				[fuLabel release];
                [sheng0Label release];
								
			}
			break;
		case TouZhuShowType4JQ:
			if ([dataDic objectForKey:@"lotteryId"]) {
				issLabel  = [[UILabel alloc] init];
				issLabel.font = [UIFont systemFontOfSize:14];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
				
				UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
				nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
                
				[nameLabel release];
				
				UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor clearColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				numLabel.textAlignment = NSTextAlignmentCenter;
				numLabel.numberOfLines = 0;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];
								
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
				
				UILabel *sheng0Label = [[UILabel alloc] init];
				sheng0Label.backgroundColor = [UIColor clearColor];
				sheng0Label.font = [UIFont systemFontOfSize:12];
				sheng0Label.textAlignment = NSTextAlignmentCenter;
                sheng0Label.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                sheng0Label.layer.masksToBounds = YES;
                sheng0Label.layer.cornerRadius = 2.0;
				[v addSubview:sheng0Label];
				
				UILabel *shengLabel = [[UILabel alloc] init];
				shengLabel.backgroundColor = [UIColor clearColor];
				shengLabel.font = [UIFont systemFontOfSize:12];
				shengLabel.textAlignment = NSTextAlignmentCenter;
                shengLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                shengLabel.layer.masksToBounds = YES;
                shengLabel.layer.cornerRadius = 2.0;
				[v addSubview:shengLabel];
				
				UILabel *pingLabel = [[UILabel alloc] init];
				pingLabel.backgroundColor = [UIColor clearColor];
				pingLabel.font = [UIFont systemFontOfSize:12];
				pingLabel.textAlignment = NSTextAlignmentCenter;
                pingLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                pingLabel.layer.masksToBounds = YES;
                pingLabel.layer.cornerRadius = 2.0;
				[v addSubview:pingLabel];
				
				UILabel *fuLabel = [[UILabel alloc] init];
				fuLabel.backgroundColor = [UIColor clearColor];
				fuLabel.font = [UIFont systemFontOfSize:12];
				fuLabel.textAlignment = NSTextAlignmentCenter;
                fuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                fuLabel.layer.masksToBounds = YES;
                fuLabel.layer.cornerRadius = 2.0;
				[v addSubview:fuLabel];
				
				
				numLabel.text = @"场次";
				saishiLabel.text = @"赛事";
				duizhenLabel.text = @"对阵";
				sheng0Label.text = @"0";
				shengLabel.text = @"1";
				pingLabel.text = @"2";
				fuLabel.text = @"3+";
                numLabel.frame = CGRectMake(2, 50, 40, 20);
                saishiLabel.frame = CGRectMake(43, 50, 60, 20);
                duizhenLabel.frame = CGRectMake(104,50, 80, 20);
                sheng0Label.frame = CGRectMake(185, 50, 30, 20);
                shengLabel.frame = CGRectMake(216, 50, 30, 20);
                pingLabel.frame = CGRectMake(247, 50, 30, 20);
                fuLabel.frame = CGRectMake(278, 50, 30, 20);
                            
				
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[sheng0Label release];
				[shengLabel release];
				[pingLabel release];
				[fuLabel release];
			}
			break;
        case TouZhuShowTypeLanqiuRangFenShengFu:
		{
			if ([dataDic objectForKey:@"lotteryId"]) {
				issLabel  = [[UILabel alloc] init];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.font = [UIFont systemFontOfSize:14];
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
				
                UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
				nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
				[nameLabel release];
				
				UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor whiteColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				[numLabel setBackgroundColor:[UIColor clearColor]];
				numLabel.textAlignment = NSTextAlignmentCenter;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
                
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
				
				UILabel *touzhuLabel = [[UILabel alloc] init];
				touzhuLabel.backgroundColor = [UIColor clearColor];
				touzhuLabel.font = [UIFont systemFontOfSize:12];
				touzhuLabel.textAlignment = NSTextAlignmentCenter;
                touzhuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                touzhuLabel.layer.masksToBounds = YES;
                touzhuLabel.layer.cornerRadius = 2.0;
				[v addSubview:touzhuLabel];
				
				UILabel *danLabel = [[UILabel alloc] init];
				danLabel.backgroundColor = [UIColor clearColor];
				danLabel.font = [UIFont systemFontOfSize:12];
				danLabel.textAlignment = NSTextAlignmentCenter;
                danLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                danLabel.layer.masksToBounds = YES;
                danLabel.layer.cornerRadius = 2.0;
				[v addSubview:danLabel];
                
                				
				numLabel.frame = CGRectMake(3, 50, 40, 20);
				numLabel.text = @"场次";
				saishiLabel.frame = CGRectMake(44, 50, 40, 20);
				saishiLabel.text = @"赛事";
				duizhenLabel.frame = CGRectMake(85, 50, 120, 20);
				duizhenLabel.text = @"对阵";
				touzhuLabel.frame = CGRectMake(206, 50, 80, 20);
				touzhuLabel.text = @"投注";
				danLabel.frame = CGRectMake(287, 50, 20, 20);
				danLabel.text = @"胆";
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[touzhuLabel release];
				[danLabel release];
                
                UILabel *label = [[UILabel alloc] init];
                label.backgroundColor = [UIColor clearColor];
                label.text = @"让分";
                label.font = [UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentCenter;
                label.frame = CGRectMake(206, 50, 30, 20);
                label.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                label.layer.masksToBounds = YES;
                label.layer.cornerRadius = 2.0;
                touzhuLabel.frame = CGRectMake(237, 50, 50, 20);
                danLabel.frame = CGRectMake(288, 50, 20, 20);
                [v addSubview:label];
                [label release];
								
			}
		}
			break;
        case TouZhuShowTypeLanqiuShengfu:
		{
			if ([dataDic objectForKey:@"lotteryId"]) {
				issLabel  = [[UILabel alloc] init];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.font = [UIFont systemFontOfSize:14];
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
				
				UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
				nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
				[nameLabel release];
				
				UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor whiteColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				[numLabel setBackgroundColor:[UIColor clearColor]];
				numLabel.textAlignment = NSTextAlignmentCenter;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];
								
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
                
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
				
				UILabel *touzhuLabel = [[UILabel alloc] init];
				touzhuLabel.backgroundColor = [UIColor clearColor];
				touzhuLabel.font = [UIFont systemFontOfSize:12];
				touzhuLabel.textAlignment = NSTextAlignmentCenter;
                touzhuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                touzhuLabel.layer.masksToBounds = YES;
                touzhuLabel.layer.cornerRadius = 2.0;
				[v addSubview:touzhuLabel];
				
				UILabel *danLabel = [[UILabel alloc] init];
				danLabel.backgroundColor = [UIColor clearColor];
				danLabel.font = [UIFont systemFontOfSize:12];
				danLabel.textAlignment = NSTextAlignmentCenter;
                danLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                danLabel.layer.masksToBounds = YES;
                danLabel.layer.cornerRadius = 2.0;
				[v addSubview:danLabel];
				
				numLabel.frame = CGRectMake(3, 50, 40, 20);
				numLabel.text = @"场次";
				saishiLabel.frame = CGRectMake(44, 50, 40, 20);
				saishiLabel.text = @"赛事";
				duizhenLabel.frame = CGRectMake(85, 50, 120, 20);
				duizhenLabel.text = @"对阵";
				touzhuLabel.frame = CGRectMake(206, 50, 80, 20);
				touzhuLabel.text = @"投注";
				danLabel.frame = CGRectMake(287, 50, 20, 20);
				danLabel.text = @"胆";
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[touzhuLabel release];
				[danLabel release];
								
			}
		}
			break;
        case TouZhuShowTypeLanqiuShengfencha:
		{
			if ([dataDic objectForKey:@"lotteryId"]) {
				issLabel  = [[UILabel alloc] init];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.font = [UIFont systemFontOfSize:14];
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
				
                
                UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
				nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
				[nameLabel release];
				
				UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor whiteColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				[numLabel setBackgroundColor:[UIColor clearColor]];
				numLabel.textAlignment = NSTextAlignmentCenter;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
                
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
				
				UILabel *touzhuLabel = [[UILabel alloc] init];
				touzhuLabel.backgroundColor = [UIColor clearColor];
				touzhuLabel.font = [UIFont systemFontOfSize:12];
				touzhuLabel.textAlignment = NSTextAlignmentCenter;
                touzhuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                touzhuLabel.layer.masksToBounds = YES;
                touzhuLabel.layer.cornerRadius = 2.0;
				[v addSubview:touzhuLabel];
				
				UILabel *danLabel = [[UILabel alloc] init];
				danLabel.backgroundColor = [UIColor clearColor];
				danLabel.font = [UIFont systemFontOfSize:12];
				danLabel.textAlignment = NSTextAlignmentCenter;
                danLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                danLabel.layer.masksToBounds = YES;
                danLabel.layer.cornerRadius = 2.0;
				[v addSubview:danLabel];
                
                numLabel.frame = CGRectMake(3, 50, 40, 20);
				numLabel.text = @"场次";
				saishiLabel.frame = CGRectMake(44, 50, 40, 20);
				saishiLabel.text = @"赛事";
				duizhenLabel.frame = CGRectMake(85, 50, 120, 20);
				duizhenLabel.text = @"对阵";
				touzhuLabel.frame = CGRectMake(206, 50, 80, 20);
				touzhuLabel.text = @"投注";
				danLabel.frame = CGRectMake(287, 50, 20, 20);
				danLabel.text = @"胆";
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[touzhuLabel release];
				[danLabel release];
								
			}
		}
			break;
        case TouZhuShowTypeLanqiuDaXiaoFen:
		{
			if ([dataDic objectForKey:@"lotteryId"]) {
				issLabel  = [[UILabel alloc] init];
				if ([dataDic objectForKey:@"issue"]) {
					issLabel.text = [NSString stringWithFormat:@"%@期 ",[dataDic objectForKey:@"issue"]];
				}
				issLabel.frame = CGRectMake(10, 0, 100, 40);
				issLabel.font = [UIFont systemFontOfSize:14];
				issLabel.backgroundColor = [UIColor clearColor];
				[v2 addSubview:issLabel];
                
                
                UILabel *nameLabel = [[UILabel alloc] init];
				[v2 addSubview:nameLabel];
				nameLabel.font = [UIFont systemFontOfSize:14];
				NSString *lotteryId = [dataDic objectForKey:@"lotteryId"];
				nameLabel.text = [lotteryId lotteryIdChange];
				nameLabel.backgroundColor = [UIColor clearColor];
				nameLabel.frame = CGRectMake([issLabel.text sizeWithFont:issLabel.font].width +10, 0, 150, 40);
				[nameLabel release];
				
				UILabel *numLabel = [[UILabel alloc] init];
				numLabel.backgroundColor = [UIColor whiteColor];
				numLabel.font = [UIFont systemFontOfSize:12];
				[numLabel setBackgroundColor:[UIColor clearColor]];
				numLabel.textAlignment = NSTextAlignmentCenter;
                numLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                numLabel.layer.masksToBounds = YES;
                numLabel.layer.cornerRadius = 2.0;
				[v addSubview:numLabel];
				
				
				UILabel *saishiLabel = [[UILabel alloc] init];
				saishiLabel.backgroundColor = [UIColor clearColor];
				saishiLabel.font = [UIFont systemFontOfSize:12];
				saishiLabel.textAlignment = NSTextAlignmentCenter;
                saishiLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                saishiLabel.layer.masksToBounds = YES;
                saishiLabel.layer.cornerRadius = 2.0;
                
				[v addSubview:saishiLabel];
				
				UILabel *duizhenLabel = [[UILabel alloc] init];
				duizhenLabel.backgroundColor = [UIColor clearColor];
				duizhenLabel.font = [UIFont systemFontOfSize:12];
				duizhenLabel.textAlignment = NSTextAlignmentCenter;
                duizhenLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                duizhenLabel.layer.masksToBounds = YES;
                duizhenLabel.layer.cornerRadius = 2.0;
				[v addSubview:duizhenLabel];
				
				UILabel *touzhuLabel = [[UILabel alloc] init];
				touzhuLabel.backgroundColor = [UIColor clearColor];
				touzhuLabel.font = [UIFont systemFontOfSize:12];
				touzhuLabel.textAlignment = NSTextAlignmentCenter;
                touzhuLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                touzhuLabel.layer.masksToBounds = YES;
                touzhuLabel.layer.cornerRadius = 2.0;
				[v addSubview:touzhuLabel];
				
				UILabel *danLabel = [[UILabel alloc] init];
				danLabel.backgroundColor = [UIColor clearColor];
				danLabel.font = [UIFont systemFontOfSize:12];
				danLabel.textAlignment = NSTextAlignmentCenter;
                danLabel.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                danLabel.layer.masksToBounds = YES;
                danLabel.layer.cornerRadius = 2.0;
				[v addSubview:danLabel];
				
				numLabel.frame = CGRectMake(3, 50, 40, 20);
				numLabel.text = @"场次";
				saishiLabel.frame = CGRectMake(44, 50, 40, 20);
				saishiLabel.text = @"赛事";
				duizhenLabel.frame = CGRectMake(85, 50, 115, 20);
				duizhenLabel.text = @"对阵";
				touzhuLabel.frame = CGRectMake(240, 50, 50, 20);
				touzhuLabel.text = @"投注";
				danLabel.text = @"胆";
				[numLabel release];
				[saishiLabel release];
				[duizhenLabel release];
				[touzhuLabel release];
				[danLabel release];
                
                UILabel *label = [[UILabel alloc] init];
                label.backgroundColor = [UIColor clearColor];
                label.text = @"预设总分";
                label.font = [UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentCenter;
                label.frame = CGRectMake(201, 50, 55, 20);
                label.backgroundColor = [UIColor colorWithRed:72/255.0 green:182/255.0 blue:207/255.0 alpha:1.0];
                label.layer.masksToBounds = YES;
                label.layer.cornerRadius = 2.0;
                touzhuLabel.frame = CGRectMake(257, 50, 30, 20);
                danLabel.frame = CGRectMake(touzhuLabel.frame.origin.x+touzhuLabel.frame.size.width + 1, 50, 20, 20);
                [v addSubview:label];
                [label release];
			}
		}
			break;
			break;
		default:
			break;
	}
    [v addSubview:v2];
	[v2 release];

//	v.backgroundColor = [UIColor colorWithRed:130/255.0 green:215/255.0 blue:235/255.0 alpha:1.0];
    return v;
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self hidenSelf];
    // Navigation logic may go here. Create and push another view controller.
    /*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

- (void)dealloc {
    [httprequest clearDelegatesAndCancel];
    [httprequest release];
    [zhushuDic release];
    [cellarray release];
    BetDetailInfo = nil;
	[myrequest clearDelegatesAndCancel];
	self.myrequest = nil;
	[issLabel release];
	[myTableView release];
	[dataDic release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    