//
//  MyLottoryViewController.m
//  caibo
//
//  Created by yao on 12-5-21.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "MyLottoryViewController.h"
#import "Info.h"
#import "GC_UserInfo.h"
#import "GC_HttpService.h"
#import "caiboAppDelegate.h"
#import "GC_BetRecord.h"
#import "ShuangSeQiuInfoViewController.h"
#import "GC_BetRecordDetail.h"
#import "GCLiushuiData.h"
#import "GCLiushuiCell.h"
#import "GC_FreezeDetail.h"
#import "GC_Withdrawals.h"
#import "GCRechangeRecord.h"
#import "NewPostViewController.h"
#import "ChongZhiData.h"
#import "MyHeMaiList.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "ProfileViewController.h"
#import "LotterySalesCell.h"
#import "NSDate-Helper.h"
#import "BetRecordJiangLi.h"
#import "MobClick.h"
#import "SendMicroblogViewController.h"
#import "zhuiHaoData.h"
#import "SharedDefine.h"

@implementation MyLottoryViewController
@synthesize delegate;
@synthesize httpRequest;
@synthesize accountManage;
@synthesize myLottoryType;
@synthesize caiLottoryType;
@synthesize allRecord;
@synthesize mRefreshView;
@synthesize moreCell;
@synthesize infoBet;
@synthesize userName;
@synthesize nickName;
@synthesize allHemaiList;
@synthesize userid;
@synthesize jiekou;
@synthesize zhuihaodata, microblogBool;
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


#pragma mark -
#pragma mark View Action


- (void)getAllBetRecord {
	NSInteger page = 0;
	
	if (isAllRefresh) {
		page = 1;
	}
	else {
		if (self.myLottoryType == MyLottoryTypeMeHe || self.myLottoryType == MyLottoryTypeOtherHe || self.myLottoryType == MyLottoryTypeZhuiHao) {
            
            if (self.myLottoryType == MyLottoryTypeZhuiHao) {
                if ([self.zhuihaodata.infoList count] == 0) {
                    page = 1;
                }
                else {
                    if ([self.zhuihaodata.infoList count]%20 > 0) {
                        page = [self.zhuihaodata.infoList count]/20 +2;
                    }else{
                        page = [self.zhuihaodata.infoList count]/20 +1;
                    }
                    
                }
            }else{
                if ([self.allHemaiList.brInforArray count] == 0) {
                    page = 1;
                }
                else {
                    if ([self.allHemaiList.brInforArray count]%20 > 0) {
                        page = [self.allHemaiList.brInforArray count]/20 +2;
                    }else{
                        page = [self.allHemaiList.brInforArray count]/20 +1;
                    }
                    
                }
            }
			
		}
        else if (self.myLottoryType == MyLottoryTypeHorse) {
            if ([self.allRecord.brInforArray count] == 0) {
                page = 1;
            }
            else {
                if ([self.allRecord.brInforArray count]%20 > 0) {
                    page = [self.allRecord.brInforArray count]/20 +2;
                }else{
                    page = [self.allRecord.brInforArray count]/20 +1;
                }
                
            }
        }
		else {
			page = self.allRecord.curPage +1;
		}
	}

	NSString *isJiang = @"0";
	if (self.caiLottoryType == CaiLottoryTypeJiang) {
		isJiang = @"1";
	}
	NSString *name = nil;
	if (myLottoryType == MyLottoryTypeMe ||myLottoryType == MyLottoryTypeMeHe || myLottoryType == MyLottoryTypeZhuiHao) {
		name = [[Info getInstance] userName];
        if ([name length] == 0) {
            name = [[[Info getInstance] mUserInfo] user_name];
        }
	}
	else {
		name = userName;
	}
    if ([name length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名参数为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        alert.tag = 1001;
        [alert release];
        return;
    }
    
    
    if (myLottoryType == MyLottoryTypeZhuiHao) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] myLotteryZhuiHaoWithCount:@"20" page:[NSString stringWithFormat:@"%ld" , (long)page] userName:name];
        SEL Finish = @selector(zhuihaoRequestFinish:);
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:Finish];
        [httpRequest startAsynchronous];
        return;
    }
    
    if (jiekou == LingQuJiangLi) {
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] LingQuJiangLi:@"0" countOfPage:20 currentPage:(int)page name:name isJiang:isJiang JiaJiang:@"1"];
        SEL Finish = @selector(LingQuJiangLiFinished:);
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:Finish];
        [httpRequest startAsynchronous];
    }
    else if (jiekou == HorseHistory) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKMyRecordUser:userName recordType:@"0" caizhongId:LOTTERY_ID_SHANDONG_11 pageNum:(int)page pageCount:20];
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqHorseHistoryFinished:)];
        [httpRequest setDidFailSelector:@selector(reqHorseHistoryFail:)];
        [httpRequest startAsynchronous];
    }
    else{
        NSMutableData *postData = [[GC_HttpService sharedInstance] reBetRecord:@"0" countOfPage:20 currentPage:(int)page name:name isJiang:isJiang];
        SEL Finish = @selector(reAllBetRecordFinished:);
        if (self.myLottoryType == MyLottoryTypeMeHe || self.myLottoryType == MyLottoryTypeOtherHe) {
            postData = [[GC_HttpService sharedInstance] reHemaiWithLottery:@"" countOfPage:20 currentPage:(int)page name:name];
            Finish = @selector(reAllHemaiBetRecordFinished:);
        }
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:Finish];
        [httpRequest startAsynchronous];
    }
	
}


- (void)reqHorseHistoryFail:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
}

- (void)reqHorseHistoryFinished:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    if ([request responseData]) {
        GC_PKMyRecordList *br = [[GC_PKMyRecordList alloc]initWithResponseData:request.responseData WithRequest:request];

        if (br.returnId == 3000) {
            [br release];
            return;
        }
        
        GC_BetRecord *br2 = [[GC_BetRecord alloc]init];
        if(!br2.brInforArray)
            br2.brInforArray = [[NSMutableArray alloc]initWithCapacity:0];
        br2.returnId = br.returnId;
        br2.systemTime = br.systemTime;
        br2.reRecordNum = br.numCount;
        br2.totalPage = br.pageCount;

        for(PKMyRecordList *pkr in br.listData)
        {
            BetRecordInfor *brInfor = [[BetRecordInfor alloc]init];
            brInfor.betDate = pkr.createTime;
            brInfor.programNumber = pkr.fanganNum;
            brInfor.issue = pkr.qici;
            brInfor.betStyle = pkr.betContent;
            brInfor.buyStyle = pkr.passType;
            brInfor.betAmount = [NSString stringWithFormat:@"%lld",[pkr.betMoney longLongValue]];
            brInfor.lotteryMoney = [NSString stringWithFormat:@"%lld",[pkr.getMoney longLongValue]];
            brInfor.awardState = pkr.statue;
            if ([pkr.getMoney floatValue] > 0) {
                brInfor.awardState = @"2";
            }
            brInfor.lotteryName = Lottery_Name_Horse;
            brInfor.programState = @"1";
            brInfor.yuliustring = pkr.moreData;
            if ([pkr.wanfa isEqualToString:@"0"]) {
                brInfor.mode = @"多玩法";
            }
            else if ([pkr.wanfa isEqualToString:@"01"]) {
                brInfor.mode = @"独赢";
            }
            else if ([pkr.wanfa isEqualToString:@"11"]) {
                brInfor.mode = @"连赢";
            }
            else if ([pkr.wanfa isEqualToString:@"12"]) {
                brInfor.mode = @"单T";
            }
            [br2.brInforArray addObject:brInfor];
        }
        if (!isAllRefresh && self.allRecord) {
            [self.allRecord.brInforArray addObjectsFromArray:br2.brInforArray];
            
        }
        else {
            self.allRecord = br2;
        }
        self.allRecord.curPage =br2.curPage;
        self.allRecord.totalPage = br2.totalPage;
        isAllRefresh = NO;
        isLoading = NO;
        
        [self seqencingFunc:self.allRecord.brInforArray];
        [self.moreCell spinnerStopAnimating];
        if(br2.brInforArray.count != 0)
            [myTableView reloadData];
        //			[myTableView reloadData];
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        if (self.allRecord.brInforArray.count == 0) {
            
            UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 520)];
            // viewJia.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
            viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
            
            // 480-800.png
            UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
            imageJia.frame=CGRectMake(60, 60, 200, 200);
            
            UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
            labelJia.text=@"最近一个月无相关记录";
            labelJia.backgroundColor=[UIColor clearColor];
            labelJia.font=[UIFont systemFontOfSize:20.0];
            labelJia.textColor=[UIColor grayColor];
            [viewJia addSubview:imageJia];
            [viewJia addSubview:labelJia];
            [myTableView addSubview:viewJia];
            [viewJia release];
            [imageJia release];
            [labelJia release];
            
            
            //  [moreCell setInfoText:@"最近3个月无相关记录!"];
        }else
            if ([br2.brInforArray count] == 0) {
                moreCell.type =MSG_TYPE_LOAD_NODATA;
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"加载完毕"];
                [moreCell spinnerStopAnimating];
                [moreCell setInfoText:@"只能查询近一个月的相关记录！"];
                moreCell.userInteractionEnabled = NO;
                isAllRefresh = YES;
            }
        
        
        [br release];
    }
}


// 追号请求
- (void)zhuihaoRequestFinish:(ASIHTTPRequest *)request{
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    if ([request responseData]) {
		zhuiHaoData *br = [[zhuiHaoData alloc] initWithResponseData:[request responseData] WithRequest:request type:0];
        if (br.sysId == 3000) {
            [br release];
            return;
        }
        
        if (self.zhuihaodata) {
			[self.zhuihaodata.infoList addObjectsFromArray:br.infoList];
			
		}
		else {
			self.zhuihaodata = br;
		}
        

        [self seqencingFuncZhuiHao:self.zhuihaodata.infoList];
        
        isAllRefresh = NO;
        isLoading = NO;
        [self.moreCell spinnerStopAnimating];
        [myTableView reloadData];
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        
        if (self.zhuihaodata.infoList.count == 0) {
            
            
            UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 520)];
            // viewJia.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
            viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
            
            
            
            // 480-800.png
            UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
            imageJia.frame=CGRectMake(60, 60, 200, 200);
            
            UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
            labelJia.text=@"最近三个月无相关记录";
            labelJia.backgroundColor=[UIColor clearColor];
            labelJia.font=[UIFont systemFontOfSize:20.0];
            labelJia.textColor=[UIColor grayColor];
            [viewJia addSubview:imageJia];
            [viewJia addSubview:labelJia];
            [myTableView addSubview:viewJia];
            [viewJia release];
            [imageJia release];
            [labelJia release];
            
            
            
            //   [moreCell setInfoText:@"最近3个月无相关记录!"];
        }
        else
            if([br.infoList count] <20){
                moreCell.type =MSG_TYPE_LOAD_NODATA;
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"加载完毕"];
                [moreCell spinnerStopAnimating];
                [moreCell setInfoText:@"只能查询近3个月的相关记录!"];
                moreCell.userInteractionEnabled = NO;
                isAllRefresh = YES;
            }

        
        [br release];
    }

    
    
}

- (void)getAccountInfoRequest
{
    if ([[[Info getInstance] userName] length] > 0 && [[GC_HttpService sharedInstance].sessionId length]) {
        //获取账户信息
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManagerNew:[[Info getInstance] userName]];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [httpRequest startAsynchronous];
    }
}

- (void)getPersonalInfoRequest
{
 
        [self getAllBetRecord];

    
}

- (void)doBack {
    if (microblogBool) {
        
        if (delegate && [delegate respondsToSelector:@selector(returnDoBack)]) {
            [delegate returnDoBack];
        }
        
        [self dismissViewControllerAnimated: YES completion: nil];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];

    }
	
}

- (void)BackRoot {
    
         [[caiboAppDelegate getAppDelegate] switchToHomeView];
    
	
}

- (void)atHim {
#ifdef isCaiPiaoForIPad
    YtTopic *topic1 = [[YtTopic alloc] init];
	NSMutableString *mTempStr = [[NSMutableString alloc] init];
	[mTempStr appendString:@"@"];
	[mTempStr appendString:nickName];//传用户名
	[mTempStr appendString:@" "];
	topic1.nick_name = mTempStr;
    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic1];
    [topic1 release];
    
#else
    
//	NewPostViewController *publishController = [[NewPostViewController alloc] init];
//	publishController.publishType = kNewTopicController;// 自发彩博
//	YtTopic *topic1 = [[YtTopic alloc] init];
//	NSMutableString *mTempStr = [[NSMutableString alloc] init];
//	[mTempStr appendString:@"@"];
//	[mTempStr appendString:nickName];//传用户名
//	[mTempStr appendString:@" "];
//	topic1.nick_name = mTempStr;
//	publishController.mStatus = topic1;
//
//    [self.navigationController pushViewController:publishController animated:YES];
//	[topic1 release];
//	[mTempStr release];
//	[publishController release];
    
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    YtTopic *topic1 = [[YtTopic alloc] init];
    NSMutableString *mTempStr = [[NSMutableString alloc] init];
    [mTempStr appendString:@"@"];
    [mTempStr appendString:nickName];//传用户名
    [mTempStr appendString:@" "];
    topic1.nick_name = mTempStr;
    publishController.mStatus = topic1;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    [topic1 release];
    [mTempStr release];
#endif
}

- (void)typeChange:(UIButton *)sender {
	tadeBtn.selected = NO;
	hemaiBtn.selected = NO;
	sender.selected =YES;
	if (sender.tag == 0) {
		myLottoryType = MyLottoryTypeOther;
		if ([self.allRecord.brInforArray count] == 0) {
			[self getAllBetRecord];
		}
		else {
			[myTableView reloadData];
		}

	}
	else {
		myLottoryType = MyLottoryTypeOtherHe;
		if ([self.allHemaiList.brInforArray count] == 0) {
			[self getAllBetRecord];
		}
		else {
			[myTableView reloadData];
		}

	}
}


- (BOOL)canRecieveInfo:(NSString *)lotteryId Mode:(NSString *)mode {
	//两步彩、七乐彩、PK拾、快乐8、时时彩、竞彩篮球
	if ([lotteryId isEqualToString:@"001"]) {//双色球
		return YES;
	}
	else if ([lotteryId isEqualToString:@"113"]) {//大乐透
//        if (![mode isEqualToString:@"00"]&&![mode isEqualToString:@"01"]) {
//            return NO;
//        }
		return YES;
	}
	else if ([lotteryId isEqualToString:@"002"]) {//3d
		return YES;
		
	}
	else if ([lotteryId isEqualToString:@"110"]) {//七星彩
		return YES;		
	}
	else if ([lotteryId isEqualToString:@"003"]) {//七乐彩
		return YES;
	}
	else if ([lotteryId isEqualToString:@"111"]) {//22选5
		return YES;
	}
	else if ([lotteryId isEqualToString:@"108"]) {//排列3
		return YES;		
	}
	else if ([lotteryId isEqualToString:@"109"]) {//排列5
		return YES;		
	}
	else if ([lotteryId isEqualToString:@"010"]) {//两步彩
		return NO;
	}
	else if ([lotteryId isEqualToString:@"006"]|| [lotteryId isEqualToString:@"014"]) {//时时彩
		return YES;
	}
	else if ([lotteryId isEqualToString:@"008"]) {//新时时彩
		return NO;		
	}
	else if ([lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [lotteryId isEqualToString:@"119"] || [lotteryId isEqualToString:@"123"] || [lotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) {//11选5
		return YES;
	}
    else if ([lotteryId isEqualToString:@"121"]) {//广东11选5
		return YES;
	}
	else if ([lotteryId isEqualToString:@"016"]) {//快乐8
		return NO;
	}
	else if ([lotteryId isEqualToString:@"017"]) {//PK拾
		return NO;
	}
	else if ([lotteryId isEqualToString:@"200"]) {//竞彩篮球
		return YES;
	}
	else if ([lotteryId isEqualToString:@"300"]) {//胜负彩
		return YES;
	}
	else if ([lotteryId isEqualToString:@"301"]) {//任九
		return YES;
	}
	else if ([lotteryId isEqualToString:@"302"]) {//6场半全场
		return YES;
	}
	else if ([lotteryId isEqualToString:@"303"]) {//四场进球
		return YES;
	}
	else if ([lotteryId isEqualToString:@"201"]) {//竞彩
		return YES;
	}
	else if ([lotteryId isEqualToString:@"400"]) {//单场
		return YES;
	}
    else if ([lotteryId isEqualToString:@"40006"]){//奥运胜负过关
        return NO;
    }
    
    else if ([lotteryId isEqualToString:@"40007"]){//奥运第一名
        return NO;
    }
    
    else if ([lotteryId isEqualToString:@"40008"]){//奥运金银铜
        return NO;
    }
    else if ([lotteryId isEqualToString:@"011"]){//快乐十分
        return YES;
    }
	else if ([lotteryId isEqualToString:@"303"]) {//单场
		return NO;
	}
    else if ([lotteryId isEqualToString:@"012"]) {//快3
		return YES;
	}
    else if ([lotteryId isEqualToString:@"202"]){//胜平负混合
        return YES;
    }
    else if ([lotteryId isEqualToString:@"203"]) {//篮球混投
        return YES;
    }
    else if ([lotteryId isEqualToString:@"122"]) {//快乐扑克
        return YES;
    }
    else if ([lotteryId isEqualToString:@"121"]) {//广东11选5
        return YES;
    }
    else if ([lotteryId isEqualToString:@"013"]) {//江苏快三
        return YES;
    }
    else if ([lotteryId isEqualToString:@"019"]) {//湖北快三
        return YES;
    }
    else if ([lotteryId isEqualToString:LOTTERY_ID_JILIN]) {//吉林快三
        return YES;
    }
    else if ([lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {//吉林快三
        return YES;
    }
	return NO;
	
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    dateArray = [[NSMutableArray alloc] initWithCapacity:0];
    zongArray = [[NSMutableArray alloc] initWithCapacity:0];
	isAllRefresh = NO;
 	UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = left;
	
    if (myLottoryType == MyLottoryTypeHorse) {
        UIImageView * NavImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, isIOS7Pianyi + self.CP_navigation.frame.size.height)];
        NavImageView.image = UIImageGetImageFromName(@"HorseMyBetsNav.png");
        [self.view addSubview:NavImageView];
        
        self.CP_navigation.backgroundColor = [UIColor clearColor];
        
        UIImageView * navigationImageView = [self.CP_navigation.subviews objectAtIndex:1];
        navigationImageView.backgroundColor = [UIColor clearColor];
    }
    
#ifndef isCaiPiaoForIPad
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBounds:CGRectMake(0, 0, 60, 44)];
//    // [btn setImage:UIImageGetImageFromName(@"wb61.png") forState:UIControlStateNormal];
//    //    [btn setImage:UIImageGetImageFromName(@"IZL-960-1.png") forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(BackRoot) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.CP_navigation.rightBarButtonItem = barBtnItem;
//    [barBtnItem release];
#endif
	
    // WithImage:UIImageGetImageFromName(@"login_bgn.png")
	UIImageView *backImageV = [[UIImageView alloc] init];
    backImageV.backgroundColor  = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
	backImageV.frame = self.mainView.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];
	
	myTableView = [[UITableView alloc] init];
	myTableView.delegate = self;
	myTableView.dataSource = self;  
	myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height);
    
    
    
    
	if (myLottoryType == MyLottoryTypeOther) {
        self.CP_navigation.title = @"他的彩票";
    }else if(myLottoryType == MyLottoryTypeOtherHe){
        self.CP_navigation.title = @"他的合买";
    }else if (myLottoryType == MyLottoryTypeZhuiHao){
        self.CP_navigation.title = @"我的追号";
    }
    if (myLottoryType == MyLottoryTypeOther ||myLottoryType == MyLottoryTypeOtherHe) {
        myTableView.frame = CGRectMake(0, 0, 320, self.mainView.bounds.size.height-49);
    }
    
#ifdef isCaiPiaoForIPad
    myTableView.frame = CGRectMake(35, 0, 320, self.mainView.bounds.size.height);
    
    if (myLottoryType == MyLottoryTypeOther ||myLottoryType == MyLottoryTypeOtherHe) {
        myTableView.frame = CGRectMake(35, 0, 320, self.mainView.bounds.size.height-49);
    }
    
#endif
    
    
    
	
	myTableView.backgroundColor = [UIColor clearColor];
	[myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.mainView addSubview:myTableView];
    
    
    // 刷新
	CBRefreshTableHeaderView *headerview = 
	[[CBRefreshTableHeaderView alloc] 
	 initWithFrame:CGRectMake(0, -(myTableView.frame.size.height), myTableView.frame.size.width, myTableView.frame.size.height)];
	self.mRefreshView = headerview;
	mRefreshView.backgroundColor = [UIColor clearColor];
	mRefreshView.delegate = self;
	[myTableView addSubview:mRefreshView];
	[headerview release];
	
	
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    

		[self getAllBetRecord];

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (jiekou == LingQuJiangLi) {
        if (self.allRecord) {
            self.allRecord = nil;
            [self getAllBetRecord];
        }
    }
    
    if (myLottoryType == MyLottoryTypeZhuiHao) {
        [mRefreshView removeFromSuperview];//我的追号  不要下拉刷新
    }
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

//系统时间请求
- (void)pressChongZhi{
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
    [httpRequest startAsynchronous];
  //  NSLog(@"url = %@", [[GC_HttpService sharedInstance] reChangeUrl]);
  //   [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrl]];
}

//充值请求
- (void)returnSysTime:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime] afterDelay:1];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime]];
        [chongzhi release];
    }
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
#pragma mark Table view data source

- (void)pressSectionButton:(UIButton *)sender{
    if (buf[sender.tag] == 0) {
        buf[sender.tag] = 1;
        
        
    }else{
        buf[sender.tag] = 0;
    
    }
    
    [myTableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([zongArray count] > section) {
        UIImageView * returnView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 23)] autorelease];
        returnView.userInteractionEnabled = YES;
        returnView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
        // returnView.image = UIImageGetImageFromName(@"gcheadbg.png");
        UILabel * timelabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 100, 23)];
        timelabel.textColor = [UIColor colorWithRed:80.0 /255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
        timelabel.backgroundColor = [UIColor clearColor];
        timelabel.textAlignment = NSTextAlignmentLeft;
        timelabel.font = [UIFont boldSystemFontOfSize:12];

        NSString * weekstr = [NSString stringWithFormat:@"%@ 00:00:01",[dateArray objectAtIndex:section]];
         NSInteger week = [[NSDate dateFromString:weekstr] weekday];
        NSLog(@"week = %ld  str = %@", (long)week,[dateArray objectAtIndex:section]);
        NSString * nianyueri = [dateArray objectAtIndex:section];
        if([nianyueri rangeOfString:@"-"].location != NSNotFound && [nianyueri length]>5){
            NSArray * nianarr = [nianyueri componentsSeparatedByString:@"-"];
            if ([nianarr count] > 2) {
                nianyueri = [NSString stringWithFormat:@"%@月%@日", [nianarr objectAtIndex:1], [nianarr objectAtIndex:2]];
            }
            
        }
        
        if (week == 2) {
            weekstr = @"星期一";
        }else if(week == 3){
            weekstr = @"星期二";
        }else if(week == 4){
            weekstr = @"星期三";
        }else if(week == 5){
            weekstr = @"星期四";
        }else if(week == 6){
            weekstr = @"星期五";
        }else if(week == 7){
            weekstr = @"星期六";
        }else if(week == 1){
            weekstr = @"星期日";
        }
        timelabel.text = [NSString stringWithFormat:@"%@ %@",nianyueri, weekstr];
        [returnView addSubview:timelabel];
        [timelabel release];
        
        
        // 第一根线
        UIImageView * xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 0.5)];
        xian.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [returnView addSubview:xian];
        [xian release];
        
        
//        // 最后一根线
//        UIView *cellCuttingLine = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
//        cellCuttingLine.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
//        [returnView addSubview:cellCuttingLine];

        return returnView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([zongArray count] > section) {
        return 35;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	
    return [zongArray count]+1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    if (section >= [zongArray count]) {
        return 1;
    }

    return [[zongArray objectAtIndex:section] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 76.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	NSMutableArray *array = nil;
    if ([zongArray count] > 0 && indexPath.section < [zongArray count]) {
        
        
        // 中奖彩票
        if (self.myLottoryType == MyLottoryTypeMeHe||self.myLottoryType == MyLottoryTypeOtherHe) {
            array =  [zongArray objectAtIndex:indexPath.section];//self.allHemaiList.brInforArray;
        }
        else {
            array =  [zongArray objectAtIndex:indexPath.section];//self.allRecord.brInforArray;
        }
    }
	

	if (indexPath.section ==[zongArray count]) {
		
        
        // 更多
		CellIdentifier = @"MoreLoadCell";
		MoreLoadCell *cell1 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell1 == nil) {
			cell1 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
		}
		
		if (moreCell == nil) {
			self.moreCell = cell1;
		}
        
//        [moreCell spinnerStartAnimating];
//        [self getAllBetRecord];
		
		return cell1;
	}
	else {
		if (self.myLottoryType == MyLottoryTypeMeHe||self.myLottoryType == MyLottoryTypeOtherHe || self.myLottoryType == MyLottoryTypeHorse) {
            
            
            // 合买彩票
			static NSString *CellIdentifier = @"hemaiCell";
			
			LotterySalesCell *cell1 = (LotterySalesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell1 == nil) {
				// cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] autorelease];
                cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withIndex:indexPath withCellCount:[array count]] autorelease];
                
			}
			[cell1 LoadHemaiData:[array objectAtIndex:indexPath.row]];
			return cell1;
		}
		else if (myLottoryType == MyLottoryTypeZhuiHao){
            
            
            
            //  追号
            static NSString *CellIdentifier = @"abetCell";
			LotterySalesCell *cell1 = (LotterySalesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell1 == nil) {
				// cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withIndex:indexPath withCellCount:[array count]] autorelease];
			}
//            cell1.countCell = [array count];
//            cell1.lotteryIndex = indexPath;
//            cell1.cellXian.frame = CGRectMake(15, 75, 320, 0.5);
//            if (indexPath.row == array.count) {
//                cell1.cellXian.frame = CGRectMake(0, 75, 320, 0.5);
//            }
            
            cell1.zhuihaoinfo = [array objectAtIndex:indexPath.row];
			return cell1;
        
        }else{
			
            
            
            static NSString *CellIdentifier = @"betCell";
			LotterySalesCell *cell1 = (LotterySalesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell1 == nil) {
				// cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withIndex:indexPath withCellCount:[array count]] autorelease];

			}
			[cell1 LoadData:[array objectAtIndex:indexPath.row]];
			return cell1;
		}
	}
	// Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

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
    
    
    if (microblogBool && (indexPath.section != [zongArray count])) {
        
        if(delegate && [delegate respondsToSelector:@selector(myLottoryReturn:url:infoName:)])
        {
            NSArray * array = [zongArray objectAtIndex:indexPath.section];//allRecord.brInforArray;
            BetRecordInfor * zhuiInfo = [array objectAtIndex:indexPath.row];
            NSString * name = @"";
            
            if (![zhuiInfo.mode isEqualToString:@"-"] && ![zhuiInfo.mode isEqualToString:@""]) {
                name = [NSString stringWithFormat:@"分享%@%@", zhuiInfo.lotteryName, zhuiInfo.mode];
            }else{
                name = [NSString stringWithFormat:@"分享%@", zhuiInfo.lotteryName];
            }
            
       
            
            [delegate myLottoryReturn:self url:[NSString stringWithFormat:@" http://caipiao365.com/faxq=%@ ", zhuiInfo.programNumber] infoName:name];
        }
        
        [self dismissViewControllerAnimated: YES completion: nil];
        return;
    }
    
        NSArray *array = nil;
    if (indexPath.section < [zongArray count]) {
		if (myLottoryType == MyLottoryTypeMe || myLottoryType == MyLottoryTypeOther) {
			array = [zongArray objectAtIndex:indexPath.section];//allRecord.brInforArray;
		}
        else {
            array =[zongArray objectAtIndex:indexPath.section];// allHemaiList.brInforArray;
        }
    }
	

    if (myLottoryType == MyLottoryTypeZhuiHao && indexPath.section < [zongArray count]) {
        
        zhuiHaoDataInfo * zhuiInfo = [array objectAtIndex:indexPath.row];
        ZhuiHaoInfoViewController * zhui = [[ZhuiHaoInfoViewController alloc] init];
        zhui.delegate = self;
        zhui.schemeID = zhuiInfo.zhuiHaoID;
        zhui.title = [NSString stringWithFormat:@"%@追号详情", zhuiInfo.lotteryName];
        [self.navigationController pushViewController:zhui animated:YES];
        [zhui release];
        return;
    }
    
    
		if (indexPath.section == [zongArray count]) {
			[moreCell spinnerStartAnimating];
			[self getAllBetRecord];
		}
		else {
			if (myLottoryType == MyLottoryTypeMe) {
                if (self.caiLottoryType == CaiLottoryTypeJiang) {
                    [MobClick event:@"event_wodecaipiao_zhongjiangcaipiao_fangan_detail"];
                }
                else {
                    [MobClick event:@"event_wodecaipiao_quanbucaipiao_fangan_detail"];
                }
				BetRecordInfor *info = [array objectAtIndex:indexPath.row];
				if ([info.baomiType intValue] == 1 ||([info.baomiType intValue] == 2 && [info.awardState isEqualToString:@"等待开奖"])) {
				}
				if ([self canRecieveInfo:info.lotteryNum Mode:info.mode]) {
					ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
					shuang.BetInfo = [array objectAtIndex:indexPath.row];
//                    shuang.nikeName = shuang.BetInfo.mode;
                    NSLog(@"%@",shuang.BetInfo.buyStyle);
                    if ([info.lingquJiangli isEqualToString:@"1"]) {
                        shuang.isJiangli = YES;
                    }
                    if ([shuang.BetInfo.buyStyle isEqualToString:@"参与合买"]) {
                        shuang.isMine = NO;
                    }
                    else {
                        shuang.isMine = YES;
                    }
					
                    NSLog(@"lot num = %@, pro  num = %@, lot name = %@,mode=%@", shuang.BetInfo.lotteryNum, shuang.BetInfo.programNumber, shuang.BetInfo.lotteryName,shuang.BetInfo.mode);
					[self.navigationController pushViewController:shuang animated:YES];
					[shuang release];
				}
				else {
					caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
					[cai showMessage:@"暂不能显示该方案"];
				}

			}
			else if (myLottoryType == MyLottoryTypeMeHe || myLottoryType == MyLottoryTypeOtherHe) {
				BetHeRecordInfor *info = [array objectAtIndex:indexPath.row];
				if ([self canRecieveInfo:info.lotteryNum Mode:info.mode]) {
				ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
				shuang.BetInfo = [info getBetRecordInforBySelf];
//                shuang.nikeName = shuang.BetInfo.mode;
                    if (myLottoryType == MyLottoryTypeOtherHe) {
                       shuang.isMine = NO;
                        shuang.BetInfo.betStyle = @"1";
                    }
                    else {
                        [MobClick event:@"event_wodecaipiao_hemaicaipiao_detail"];
                        shuang.isMine = ![info.betStyle boolValue];
                    }
				
				[self.navigationController pushViewController:shuang animated:YES];
				[shuang release];
				}
				else {
					caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
					[cai showMessage:@"暂不支持显示该方案"];
				}

			}
            else if (myLottoryType == MyLottoryTypeHorse) {
                ShuangSeQiuInfoViewController * shuang = [[[ShuangSeQiuInfoViewController alloc] init] autorelease];
                shuang.isMine = YES;
                shuang.BetInfo = [array objectAtIndex:indexPath.row];
                [self.navigationController pushViewController:shuang animated:YES];
            }
			else {
				BetRecordInfor *info = [array objectAtIndex:indexPath.row];
				if ([self canRecieveInfo:info.lotteryNum Mode:info.mode]) {
						ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
						shuang.BetInfo = [array objectAtIndex:indexPath.row];
//                       shuang.nikeName = shuang.BetInfo.mode;
						shuang.isMine = NO;
						[self.navigationController pushViewController:shuang animated:YES];
						[shuang release];
				}
				else {
					caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
					[cai showMessage:@"暂不能显示该方案"];
				}
	
			}
		
	}
	[tableView deselectRowAtIndexPath: indexPath animated: YES];
    
//    BetRecordInfor *info = [array objectAtIndex:indexPath.row];
//    NSLog(@"other= %@",info.yuliustring);
}


#pragma mark -
#pragma mark Memory management

- (void)returnTypeAnswer:(NSInteger)answer{
    if (answer == 1) {
        
        [self.zhuihaodata.infoList removeAllObjects];
        self.zhuihaodata = nil;
       
        [self getAllBetRecord];
    }
}

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
    [zhuihaodata release];
    [dateArray release];
    [zongArray release];
	[self.httpRequest clearDelegatesAndCancel];
	self.httpRequest = nil;
	self.moreCell = nil;
	self.infoBet = nil;
	self.userName = nil;
	[allRecord release];
	[mRefreshView release];
	[accountManage release];
	[myTableView release];
	[nickName release];
    [super dealloc];
	
}

#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
	//[self reloadSegmentData];
		isAllRefresh = YES;
        isLoading = YES;
    if (myLottoryType != MyLottoryTypeZhuiHao) {
        [self getAllBetRecord];
    }
		
    moreCell.userInteractionEnabled = YES;
}

// 加载更多
- (void)doMoreLoading
{
    
}

// 判断是否正在刷新状态 
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view
{
	return isLoading; // should return if data source model is reloading	
}

// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed	
}

// 数据接收完成调用
- (void)dismissRefreshTableHeaderView
{
    isLoading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    [self.moreCell spinnerStopAnimating];
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	 if (myLottoryType != MyLottoryTypeZhuiHao) {
         
         [mRefreshView CBRefreshScrollViewDidScroll:scrollView];
     }
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
	
	if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
			if (!isAllRefresh) {
                
			[self performSelector:@selector(getAllBetRecord) withObject:nil afterDelay:0.5];
                [moreCell spinnerStartAnimating];
                
            }
	}
    
    if (myLottoryType != MyLottoryTypeZhuiHao) {
        [mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
    }
	
	
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate 

- (void)rePersonalInfoFinished:(ASIHTTPRequest*)request
{

}



- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
		GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (aManage != nil && aManage.returnId != 3000){
            self.accountManage = aManage;
            [GC_UserInfo sharedInstance].accountManage = aManage;
        }
		[aManage release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{

    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    [self dismissRefreshTableHeaderView];
}


- (void)zongArrayFunc:(NSMutableArray *)arraybrin{
    [zongArray removeAllObjects];
    for (int i = 0; i < [dateArray count]; i++) {
        NSMutableArray * danarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 0; j < [arraybrin count]; j++) {
            NSString * timestring = [dateArray objectAtIndex:i];
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:j];
            
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([[timearr objectAtIndex:0] isEqualToString:timestring]) {
                    
                    [danarray addObject:brIn];
                    
                }
                
            }else{  //不带空格的
                
                if ([brIn.betDate isEqualToString:timestring]) {
                   
                   [danarray addObject:brIn];
                    
                }
                
            }
        }
        [zongArray addObject:danarray];
        [danarray release];
    }
}
- (void)zongArrayFuncZhuiHao:(NSMutableArray *)arraybrin{
    [zongArray removeAllObjects];
    for (int i = 0; i < [dateArray count]; i++) {
        NSMutableArray * danarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 0; j < [arraybrin count]; j++) {
            NSString * timestring = [dateArray objectAtIndex:i];
            zhuiHaoDataInfo *brIn = [arraybrin objectAtIndex:j];
            
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count] >= 1) {
                    if ([[timearr objectAtIndex:0] isEqualToString:timestring]) {
                        
                        [danarray addObject:brIn];
                        
                        
                    }
                }
                
                
            }else{  //不带空格的
                
                if ([brIn.betDate isEqualToString:timestring]) {
                    
                    [danarray addObject:brIn];
                    
                    
                }
                
            }
        }
        [zongArray addObject:danarray];
        [danarray release];
    }
}


- (void)seqencingFunc:(NSMutableArray *)arraybrin{
    if ([arraybrin count] == 0) {//如果为空 return
        return;
    }
    
    //取出第一个当参数
    BetHeRecordInfor *brInfor = [arraybrin objectAtIndex:0];
   
    
    [dateArray removeAllObjects];
    
    if ([brInfor.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
        NSArray * timearr = [brInfor.betDate componentsSeparatedByString:@" "];
        if ([timearr count] >= 1) {
            [dateArray addObject:[timearr objectAtIndex:0]];
        }
        
        
    }else{//不带空格的
         [dateArray addObject:brInfor.betDate];
    }
    
   //拿第一个和其他的去比较
    for (int i = 0; i < [arraybrin count]; i++) {
        BOOL zhongjie = NO;
        for (int j = 0; j < [dateArray count]; j++) {
            
            NSString * timestring = [dateArray objectAtIndex:j];
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:i];
            
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count] >= 1) {
                    if ([[timearr objectAtIndex:0] isEqualToString:timestring]) {
                        //                    [dateArray addObject:[timearr objectAtIndex:0]];
                        zhongjie = YES;
                        break;
                    }
                }
                
                
            }else{  //不带空格的
                
                if ([brIn.betDate isEqualToString:timestring]) {
//                    [dateArray addObject:brIn.betDate];
                    zhongjie = YES;
                    break;
                }
                
            }
        }
        if (!zhongjie) {
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:i];
            NSLog(@"%@",brIn.betDate);
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count] >=1) {
                    [dateArray addObject:[timearr objectAtIndex:0]];
                }
                
                
            }else{
                [dateArray addObject:brIn.betDate];
            }
        }
        
    }
    
    
    NSLog(@"datearray = %@", dateArray);
    [self zongArrayFunc:arraybrin];
}

- (void)seqencingFuncZhuiHao:(NSMutableArray *)arraybrin{
    if ([arraybrin count] == 0) {//如果为空 return
        
        
        UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 520)];
        //viewJia.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
        viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
        
        
        
        // 480-800.png
        UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
        imageJia.frame=CGRectMake(60, 60, 200, 200);
        
        UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
        labelJia.text=@"最近三个月无相关记录";
        labelJia.backgroundColor=[UIColor clearColor];
        labelJia.font=[UIFont systemFontOfSize:20.0];
        labelJia.textColor=[UIColor grayColor];
        [viewJia addSubview:imageJia];
        [viewJia addSubview:labelJia];
        [myTableView addSubview:viewJia];
        [viewJia release];
        [imageJia release];
        [labelJia release];
        return;

        
    }
    
    //取出第一个当参数
    zhuiHaoDataInfo *brInfor = [arraybrin objectAtIndex:0];
    
    [dateArray removeAllObjects];
    
    if ([brInfor.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
        NSArray * timearr = [brInfor.betDate componentsSeparatedByString:@" "];
        if ([timearr count] >= 1) {
            [dateArray addObject:[timearr objectAtIndex:0]];
        }
        
        
    }else{//不带空格的
        [dateArray addObject:brInfor.betDate];
    }
    
    //拿第一个和其他的去比较
    for (int i = 0; i < [arraybrin count]; i++) {
        BOOL zhongjie = NO;
        for (int j = 0; j < [dateArray count]; j++) {
            
            NSString * timestring = [dateArray objectAtIndex:j];
            zhuiHaoDataInfo *brIn = [arraybrin objectAtIndex:i];
            
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count] >= 1) {
                    if ([[timearr objectAtIndex:0] isEqualToString:timestring]) {
                        //  [dateArray addObject:[timearr objectAtIndex:0]];
                        zhongjie = YES;
                        break;
                    }
                }
                
                
            }else{  //不带空格的
                
                if ([brIn.betDate isEqualToString:timestring]) {
                    //  [dateArray addObject:brIn.betDate];
                    zhongjie = YES;
                    break;
                }
                
            }
        }
        if (!zhongjie) {
            zhuiHaoDataInfo *brIn = [arraybrin objectAtIndex:i];
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count]>= 1) {
                    [dateArray addObject:[timearr objectAtIndex:0]];
                }
                
                
            }else{
                [dateArray addObject:brIn.betDate];
            }
        }
    }
    
    
    NSLog(@"datearray = %@", dateArray);
    [self zongArrayFuncZhuiHao:arraybrin];
}

- (void)reAllHemaiBetRecordFinished:(ASIHTTPRequest *)request {
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
	if ([request responseData]) {
		MyHeMaiList *br = [[MyHeMaiList alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (br.returnId == 3000) {
            [br release];
            return;
        }
		if (!isAllRefresh && self.allHemaiList) {
			[self.allHemaiList.brInforArray addObjectsFromArray:br.brInforArray];
			
		}
		else {
			self.allHemaiList = br;
		}
        
		isAllRefresh = NO;
		isLoading = NO;
        
        [self seqencingFunc:self.allHemaiList.brInforArray];
        [self.moreCell spinnerStopAnimating];
		[myTableView reloadData];
		[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        
        if (self.allHemaiList.brInforArray.count == 0) {
            
            
            UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 520)];
            // viewJia.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
            viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
            
            
            
            // 480-800.png
            UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
            imageJia.frame=CGRectMake(60, 60, 200, 200);
            
            UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
            labelJia.text=@"最近三个月无相关记录";
            labelJia.backgroundColor=[UIColor clearColor];
            labelJia.font=[UIFont systemFontOfSize:20.0];
            labelJia.textColor=[UIColor grayColor];
            [viewJia addSubview:imageJia];
            [viewJia addSubview:labelJia];
            [myTableView addSubview:viewJia];
            [viewJia release];
            [imageJia release];
            [labelJia release];

            
        
         //   [moreCell setInfoText:@"最近3个月无相关记录!"];
        }else
        if([br.brInforArray count] == 0){
            moreCell.type =MSG_TYPE_LOAD_NODATA;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"加载完毕"];
            [moreCell spinnerStopAnimating];
            [moreCell setInfoText:@"只能查询近3个月的相关记录!"];
            moreCell.userInteractionEnabled = NO;
            isAllRefresh = YES;
        }
        
        
		[br release];
	}
	
}

//领取奖励解析
- (void)LingQuJiangLiFinished:(ASIHTTPRequest *)request {
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }

    if ([request responseData]) {
        BetRecordJiangLi *br = [[BetRecordJiangLi alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (br.returnId == 3000) {
            [br release];
            return;
        }
        if (!isAllRefresh && self.allRecord) {
            [self.allRecord.brInforArray addObjectsFromArray:br.brInforArray];
            
        }
        else {
            self.allRecord = [br changeToGC_betRecord];
        }
        self.allRecord.curPage =br.curPage;
        self.allRecord.totalPage = br.totalPage;
        isAllRefresh = NO;
        isLoading = NO;
        
        [self seqencingFunc:self.allRecord.brInforArray];
        [self.moreCell spinnerStopAnimating];
        [myTableView reloadData];
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        [br release];
        if (self.myLottoryType == MyLottoryTypeMe) {
            [httpRequest clearDelegatesAndCancel];
            
            [self setHttpRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId]
																				userId2:@"0"
																				pageNum:@"1"
																			   pageSize:@"1"
																			   mailType:@"1"
																				   mode:@"1"]]];
            
            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpRequest setDelegate:self];
            [httpRequest setDidFinishSelector:@selector(clearZhongjiang:)];
            [httpRequest setNumberOfTimesToRetryOnTimeout:2];
            [httpRequest startAsynchronous];
        }
    }		
}
- (void)reAllBetRecordFinished:(ASIHTTPRequest*)request {
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
		if ([request responseData]) {
			GC_BetRecord *br = [[GC_BetRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
            if (br.returnId == 3000) {
                [br release];
                return;
            }
			if (!isAllRefresh && self.allRecord) {
				[self.allRecord.brInforArray addObjectsFromArray:br.brInforArray];
				
			}
			else {
              self.allRecord = br;
			}
		    self.allRecord.curPage =br.curPage;
			self.allRecord.totalPage = br.totalPage;
			isAllRefresh = NO;
			isLoading = NO;
            
            [self seqencingFunc:self.allRecord.brInforArray];
            [self.moreCell spinnerStopAnimating];
            if(br.brInforArray.count != 0)
                [myTableView reloadData];
//			[myTableView reloadData];
			[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
            if (self.allRecord.brInforArray.count == 0) {
                
                UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 520)];
                // viewJia.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
                viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
                
                // 480-800.png
                UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
                imageJia.frame=CGRectMake(60, 60, 200, 200);
                
                UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
                labelJia.text=@"最近三个月无相关记录";
                labelJia.backgroundColor=[UIColor clearColor];
                labelJia.font=[UIFont systemFontOfSize:20.0];
                labelJia.textColor=[UIColor grayColor];
                [viewJia addSubview:imageJia];
                [viewJia addSubview:labelJia];
                [myTableView addSubview:viewJia];
                [viewJia release];
                [imageJia release];
                [labelJia release];
                
                
              //  [moreCell setInfoText:@"最近3个月无相关记录!"];
            }else
            if ([br.brInforArray count] == 0) {
                moreCell.type =MSG_TYPE_LOAD_NODATA;
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"加载完毕"];
                [moreCell spinnerStopAnimating];
                [moreCell setInfoText:@"只能查询近3个月的相关记录！"];
                moreCell.userInteractionEnabled = NO;
                isAllRefresh = YES;
            }
            
            
			[br release];
            
            
            
			if (self.myLottoryType == MyLottoryTypeMe) {
				[httpRequest clearDelegatesAndCancel];
				
				[self setHttpRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId] 
																				userId2:@"0" 
																				pageNum:@"1"
																			   pageSize:@"1"
																			   mailType:@"1" 
																				   mode:@"1"]]];
				
				[httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
				[httpRequest setDelegate:self];
				[httpRequest setDidFinishSelector:@selector(clearZhongjiang:)];
				[httpRequest setNumberOfTimesToRetryOnTimeout:2];
				[httpRequest startAsynchronous];
			}
		}		
}

- (void)clearZhongjiang:(ASIHTTPRequest*)request {
}


- (void)reBetRecordDetailFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
		GC_BetRecordDetail *brd = [[GC_BetRecordDetail alloc] initWithResponseData:[request responseData] WithRequest:request];
		if (brd.returnId != 3000) {
			if (myLottoryType == MyLottoryTypeMe || [brd.secretType intValue] == 0 || (![brd.jackpot isEqualToString:@"未开奖"]&&[brd.secretType intValue] == 2) ) {
				ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
               
				shuang.BetInfo = self.infoBet;
//                   shuang.nikeName = shuang.BetInfo.mode;
				shuang.BetDetailInfo = brd;
				[self.navigationController pushViewController:shuang animated:YES];
				[shuang release];
			}
		}
        isLoading =NO;
		[brd release];
	}
}

#pragma mark_
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSUInteger)supportedInterfaceOrientations{
#ifdef  isCaiPiaoForIPad
    return UIInterfaceOrientationMaskLandscapeRight;
#else
    return (1 << UIInterfaceOrientationPortrait);
#endif
}

- (BOOL)shouldAutorotate {
#ifdef  isCaiPiaoForIPad
    return YES;
#else
    return NO;
#endif
    
}



@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    