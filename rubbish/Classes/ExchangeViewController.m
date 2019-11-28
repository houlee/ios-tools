//
//  ExchangeViewController.m
//  caibo
//
//  Created by cp365dev on 14-5-12.
//
//

#import "ExchangeViewController.h"
#import "Info.h"
#import "ColorView.h"
#import "GC_HttpService.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "CP_UIAlertView.h"
#import "GC_WinningInfoList.h"
#import "PointExchangeJieXi.h"
#import "PointInfoViewController.h"
#import "SharedMethod.h"
#import "DuiHuanYHMCell.h"
#import "DuiHuanCJBCell.h"
#import "GC_YHMInfoParser.h"
#import "GouCaiViewController.h"
#import "caiboAppDelegate.h"
#import "CP_TabBarViewController.h"
#import "GCHeMaiInfoViewController.h"
@interface ExchangeViewController ()

@end

@implementation ExchangeViewController
@synthesize myRequest;
@synthesize myRequest2;
@synthesize exChangePoint;
@synthesize winningList;
@synthesize yhmList;
@synthesize caijinList;
@synthesize winningList1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    self.CP_navigation.titleLabel.text = @"兑换";
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.frame = CGRectMake(0, 44, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:232/255.0 alpha:1];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor clearColor];
    [backImage release];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBounds:CGRectMake(0, 0, 70, 40)];
    [btn1 addTarget:self action:@selector(pointExplain) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(30, 9, 23, 23)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = UIImageGetImageFromName(@"GC_icon8.png");
    [btn1 addSubview:imagevi];
    [imagevi release];
    
    UIBarButtonItem *barBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.CP_navigation.rightBarButtonItem = barBtnItem1;
    [barBtnItem1 release];


    
    UIImageView *bluebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    bluebg.backgroundColor = [SharedMethod getColorByHexString:@"10518d"];
    [self.mainView addSubview:bluebg];
    [bluebg release];
    
    //我的积分
    jifen = [[UILabel alloc] init];
    Info *info = [Info getInstance];
    if(![info.jifen isEqualToString:@"(null)"] && info.jifen != nil && info.jifen.length != 0){
        
        jifen.text = [NSString stringWithFormat:@"我的积分 %@",info.jifen];

    }
    else{
        jifen.text = @"我的积分 0";
    }
    jifen.font = [UIFont systemFontOfSize:12];

    CGSize size1 =CGSizeMake(320, 30);
    CGSize size = [jifen.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:size1 lineBreakMode:NSLineBreakByCharWrapping];
    jifen.frame = CGRectMake(15, 0, size.width, 30);
    jifen.backgroundColor = [UIColor clearColor];
    jifen.textColor = [UIColor whiteColor];
    [bluebg addSubview:jifen];
    [jifen release];
    
    //每人每可兑换一次
    UILabel *everyDayOnce = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(jifen)+8, 0, 120, 30)];
    everyDayOnce.text = @"(每人每天可兑换 1 次)";
    everyDayOnce.font = [UIFont systemFontOfSize:12];
    everyDayOnce.backgroundColor = [UIColor clearColor];
    everyDayOnce.textColor = [SharedMethod getColorByHexString:@"79b7d4"];
    [bluebg addSubview:everyDayOnce];
    [everyDayOnce release];
    
    UIView *whitebg = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(bluebg), 320, 61)];
    whitebg.backgroundColor  =[UIColor whiteColor];
    [self.mainView addSubview:whitebg];
    [whitebg release];
    
    duihuanbackImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 16, 280, 29)];
    duihuanbackImage.userInteractionEnabled = YES;
    duihuanbackImage.image = UIImageGetImageFromName(@"duihuanBack1.png");
    [whitebg addSubview:duihuanbackImage];
    [duihuanbackImage release];
    
    UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(whitebg), 320, 1)];
    xian1.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
    [self.mainView addSubview:xian1];
    [xian1 release];
    
    exchangeyouhuima = [UIButton buttonWithType:UIButtonTypeCustom];
    exchangeyouhuima.titleLabel.backgroundColor = [UIColor clearColor];
    [exchangeyouhuima setTitle:@"兑换充值优惠码" forState:UIControlStateNormal];
    [exchangeyouhuima setFrame:CGRectMake(0, 0, 145, 29)];
    [exchangeyouhuima setTag:101];
    [exchangeyouhuima addTarget:self action:@selector(ChangeView:) forControlEvents:UIControlEventTouchUpInside];
    [exchangeyouhuima.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [exchangeyouhuima setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [duihuanbackImage addSubview:exchangeyouhuima];
    
    exchangecaijinbao = [UIButton buttonWithType:UIButtonTypeCustom];
    [exchangecaijinbao setTitle:@"兑换彩金包" forState:UIControlStateNormal];
    exchangecaijinbao.titleLabel.backgroundColor = [UIColor clearColor];
    [exchangecaijinbao setFrame:CGRectMake(145, 0, 145, 29)];
    [exchangecaijinbao setTag:102];
    [exchangecaijinbao setTitleColor:[UIColor colorWithRed:32/255.0 green:142/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    exchangecaijinbao.selected = NO;
    [exchangecaijinbao addTarget:self action:@selector(ChangeView:) forControlEvents:UIControlEventTouchUpInside];
    [exchangecaijinbao.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [duihuanbackImage addSubview:exchangecaijinbao];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(whitebg)+1, 320, self.mainView.bounds.size.height - ORIGIN_Y(whitebg))];
    myScrollView.contentSize = CGSizeMake(640, myScrollView.bounds.size.height);
    [self.mainView addSubview:myScrollView];
    myScrollView.pagingEnabled = YES;
    myScrollView.tag = 1234;
    myScrollView.delegate = self;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.backgroundColor = [UIColor clearColor];
    [myScrollView release];
    
    
    tableview1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, myScrollView.contentSize.height)];
    tableview1.delegate = self;
    tableview1.dataSource = self;
    tableview1.tag = 301;
    tableview1.backgroundColor = [UIColor clearColor];
    [tableview1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myScrollView addSubview:tableview1];
    [tableview1 release];
    
    tableview2 = [[UITableView alloc] initWithFrame:CGRectMake(320, 0, 320, myScrollView.contentSize.height)];
    tableview2.delegate = self;
    tableview2.dataSource = self;
    tableview2.tag = 302;
    tableview2.backgroundColor = [UIColor clearColor];
    [tableview2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myScrollView addSubview:tableview2];
    [tableview2 release];
    
    cjbRequestFinish = NO;
    yhmReqeustFinish = NO;
    
    //可兑换充值优惠码
    [self canExchangeYHM:@"2"];
}
//积分说明
-(void)pointExplain
{
    PointInfoViewController *pointinfo = [[PointInfoViewController alloc] init];
    [self.navigationController pushViewController:pointinfo animated:YES];
    [pointinfo release];
    
}
-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//抽奖 、 中奖名单 按钮
-(void)ChangeView:(UIButton *)sender
{
    //充值优惠码
    if(sender.tag == 101)
    {
        
        [myScrollView scrollRectToVisible:CGRectMake(0, 91, 320, self.mainView.bounds.size.height - 91) animated:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView commitAnimations];
    }
    //彩金
    if(sender.tag == 102)
    {
        
        [myScrollView scrollRectToVisible:CGRectMake(320, 91, 320, self.mainView.bounds.size.height - 91) animated:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView commitAnimations];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(tableView.tag == 301){
    
        return self.winningList1.zhongjiangArray1.count;
    }
    if(tableView.tag == 302){
    
        return self.winningList.zhongjiangArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag == 301){
        
        static NSString *pointCell = @"cell";
        DuiHuanYHMCell *cell = [tableView dequeueReusableCellWithIdentifier:pointCell];
        if(!cell){
            cell = [[[DuiHuanYHMCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pointCell] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if(indexPath.row < [self.winningList1.zhongjiangArray1 count]){
            
            CanExChangeYHMList *list = [self.winningList1.zhongjiangArray1 objectAtIndex:indexPath.row];
            
            [cell LoadData:list.chong getM:list.de points:list.needPoint people:list.alreadyExchangePeople];
            
        }
        
        return cell;

    }
    if(tableView.tag == 302){
    
        static NSString *pointCell = @"cell";
        DuiHuanCJBCell *cell = [tableView dequeueReusableCellWithIdentifier:pointCell];
        if(!cell){
            cell = [[[DuiHuanCJBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pointCell] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if(indexPath.row < [self.winningList.zhongjiangArray count]){
        
            CanExChangeCaiJinList *list = [self.winningList.zhongjiangArray objectAtIndex:indexPath.row];

            [cell LoadData:list.caijinJE points:list.needPoint people:list.alreadyExchangePeople];
            
        }
        
        return cell;

    }
        
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(tableView.tag == 301){
    
        hadSussYHM = (int)indexPath.row;
 
        [self exChangePress1:(int)indexPath.row];


    }
    if(tableView.tag == 302){
    
        hadSussCJ = (int)indexPath.row;

        [self exChangePress:(int)indexPath.row];
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if(scrollView.tag == 1234){
        
        if(scrollView.contentOffset.x == 0){
            
            if(!yhmReqeustFinish){
                
                [self canExchangeYHM:@"2"];

            }

            [duihuanbackImage setImage:UIImageGetImageFromName(@"duihuanBack1.png")];
            
            [exchangeyouhuima setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            [exchangecaijinbao setTitleColor:[UIColor colorWithRed:32/255.0 green:142/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        }
        else if(scrollView.contentOffset.x/320.0 == 1){
            
            if(!cjbRequestFinish){
                
                [self canExchangeCJB:@"1"];
                
            }

            [duihuanbackImage setImage:UIImageGetImageFromName(@"duihuanBack2.png")];

            [exchangeyouhuima setTitleColor:[UIColor colorWithRed:32/255.0 green:142/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            [exchangecaijinbao setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        }
        
    }

}


-(void)canExchangeYHM:(NSString *)_type
{
    NSMutableData *postData = [[GC_HttpService sharedInstance] canExchangeWithType:_type];
    [myRequest2 clearDelegatesAndCancel];
    self.myRequest2 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest2 setRequestMethod:@"POST"];
    [myRequest2 addCommHeaders];
    [myRequest2 setPostBody:postData];
    [myRequest2 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest2 setDelegate:self];
    [myRequest2 setDidFinishSelector:@selector(requestCanDuiHuanYHMFinished:)];
    [myRequest2 setDidFailSelector:@selector(requestCanDuiHuanYHMFailed:)];
    [myRequest2 startAsynchronous];
}
#pragma mark 可兑换优惠码 Request Finished
-(void)requestCanDuiHuanYHMFinished:(ASIHTTPRequest *)request
{
    NSLog(@"可兑换优惠码Finished: %@",request.responseString);
    GC_WinningInfoList *jiexi = [[GC_WinningInfoList alloc] initWithResponseData:request.responseData WithRequest:request andlistType:CANEXCHANGE_YHM_TYPE];
    if(jiexi.returnId != 3000)
    {
        self.winningList1 = jiexi;
        
        yhmReqeustFinish = YES;
        
    }
    
    [jiexi release];
    
    [tableview1 reloadData];
    
}
-(void)requestCanDuiHuanYHMFailed:(ASIHTTPRequest *)request
{
    NSLog(@"可兑换优惠码Failed: %@",request.responseString);
    
    [[caiboAppDelegate getAppDelegate] showMessage:@"请检查您的网络后重试"];

    
}
//可兑换的彩金项、充值优惠码
-(void)canExchangeCJB:(NSString *)_type
{
    NSMutableData *postData = [[GC_HttpService sharedInstance] canExchangeWithType:_type];
    [myRequest2 clearDelegatesAndCancel];
    self.myRequest2 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest2 setRequestMethod:@"POST"];
    [myRequest2 addCommHeaders];
    [myRequest2 setPostBody:postData];
    [myRequest2 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest2 setDelegate:self];
    [myRequest2 setDidFinishSelector:@selector(requestCanDuiHuanCJBFinished:)];
    [myRequest2 setDidFailSelector:@selector(requestCanDuiHuanCJBFailed:)];
    [myRequest2 startAsynchronous];
}
#pragma mark 可兑换彩金项 Request Finished
-(void)requestCanDuiHuanCJBFinished:(ASIHTTPRequest *)request
{
    NSLog(@"可兑换彩金项Finished: %@",request.responseString);
    GC_WinningInfoList *jiexi = [[GC_WinningInfoList alloc] initWithResponseData:request.responseData WithRequest:request andlistType:CANEXCHANGE_CaiJin_TYPE];
    if(jiexi.returnId != 3000)
    {
        self.winningList = jiexi;
        
        cjbRequestFinish = YES;
        
    }
    
    [jiexi release];
    

    [tableview2 reloadData];
    
    
    
}
-(void)requestCanDuiHuanCJBFailed:(ASIHTTPRequest *)request
{
    NSLog(@"可兑换彩金项Failed: %@",request.responseString);
    
    [[caiboAppDelegate getAppDelegate] showMessage:@"请检查您的网络后重试"];

}
//兑换充值优惠码
-(void)exChangePress1:(int)_num{


    if(self.winningList1.zhongjiangArray1 && self.winningList1.zhongjiangArray1.count)
    {
        CanExChangeYHMList *list = [self.winningList1.zhongjiangArray1 objectAtIndex:_num];
        
        self.yhmList = list;
        
        exChangePoint = self.yhmList.needPoint;
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"兑换确认" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即使用",nil];
        alert.tag = 200;
        alert.alertTpye = exChangeSure;
        alert.exChangeSureFirstCell = [NSString stringWithFormat:@"优惠码面值   <%d元>",[self.yhmList.de intValue]-[self.yhmList.chong intValue]];
        alert.exChangeSureSecondCell = [NSString stringWithFormat:@"使用条件   <充值%@元以上可用>",self.yhmList.chong];
        alert.exChangeSureThirdCell = [NSString stringWithFormat:@"消耗积分   <%@>",exChangePoint];
        [alert show];
        [alert release];
        
    }
    
}
//兑换彩金
-(void)exChangePress:(int)_num
{
    
    
    
    if(self.winningList.zhongjiangArray && self.winningList.zhongjiangArray.count)
    {
        CanExChangeCaiJinList *list = [self.winningList.zhongjiangArray objectAtIndex:_num];
        
        self.caijinList = list;
        
        exChangePoint = self.caijinList.needPoint;

        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"兑换确认" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即兑换",nil];
        alert.tag = 100;
        alert.alertTpye = exChangeSure;
        alert.exChangeSureFirstCell = [NSString stringWithFormat:@"彩金面值   <%@元>",self.caijinList.caijinJE];
        alert.exChangeSureSecondCell = @"适用范围   <任何彩种>";
        alert.exChangeSureThirdCell = [NSString stringWithFormat:@"消耗积分   <%@>",exChangePoint];
        [alert show];
        [alert release];

    }
    
}

#pragma mark 积分兑优惠码 Request Finished

-(void)requestDuiHuanYHMFinished:(ASIHTTPRequest *)request{

    PointExchangeJieXi *jiexi = [[PointExchangeJieXi alloc] initWithResponseData:request.responseData WithRequest:request];
    if(jiexi.returnId != 3000)
    {
        if(jiexi.exchangeState == 0)
        {
            
            CanExChangeYHMList *list = [self.winningList1.zhongjiangArray1 objectAtIndex:hadSussYHM];
            list.alreadyExchangePeople = [NSString stringWithFormat:@"%d",[list.alreadyExchangePeople intValue]+1];
            [tableview1 reloadData];
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"恭喜您" message:@"兑换成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            alert.alertTpye = ChongzhiSuccType;
            [alert show];
            [alert release];
        }
        else
        {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"温馨提示" message:jiexi.exchangeMess delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            alert.alertTpye = ExchangePointFailType;
            [alert show];
            [alert release];
        }
    }
    [jiexi release];
    


}
-(void)requestDuiHuanYHMFailed:(ASIHTTPRequest *)request
{
    NSLog(@"积分兑换彩金Failed: %@",request.responseString);
    
    [[caiboAppDelegate getAppDelegate] showMessage:@"请检查您的网络后重试"];

    
}
#pragma mark 积分兑换彩金 Request Finished

-(void)requestDuiHuanCJFinished:(ASIHTTPRequest *)request
{
    NSLog(@"积分兑换彩金: %@",request.responseString);
    
    PointExchangeJieXi *jiexi = [[PointExchangeJieXi alloc] initWithResponseData:request.responseData WithRequest:request];
    if(jiexi.returnId != 3000)
    {
        if(jiexi.exchangeState == 0)
        {
            int yuanPoint = [[[Info getInstance] jifen] intValue];
            int xiaohaoPOint = [exChangePoint intValue];
            
            if(yuanPoint > xiaohaoPOint)
            {
                jifen.text = [NSString stringWithFormat:@"我的积分 %d",yuanPoint-xiaohaoPOint];
            }
            
            CanExChangeCaiJinList *list = [self.winningList.zhongjiangArray objectAtIndex:hadSussCJ];
            list.alreadyExchangePeople = [NSString stringWithFormat:@"%d",[list.alreadyExchangePeople intValue]+1];
            [tableview2 reloadData];
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"恭喜您" message:@"兑换成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            alert.alertTpye = ChongzhiSuccType;
            [alert show];
            [alert release];
        }
        else
        {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"温馨提示" message:jiexi.exchangeMess delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            alert.alertTpye = ExchangePointFailType;
            [alert show];
            [alert release];
        }
    }
    [jiexi release];



}

-(void)requestDuiHuanCJFailed:(ASIHTTPRequest *)request
{
    NSLog(@"积分兑换彩金Failed: %@",request.responseString);
    
    [[caiboAppDelegate getAppDelegate] showMessage:@"请检查您的网络后重试"];

}
-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 100)
    {
        if(buttonIndex == 1)
        {
            if([[[Info getInstance] jifen] doubleValue] >= [self.caijinList.needPoint doubleValue]){
            
                NSMutableData *postData = [[GC_HttpService sharedInstance] pointDuiHuanCaiJinWithUserName:[[Info getInstance] userName]andCaiJin:self.caijinList.caijinJE point:self.caijinList.needPoint];
                [myRequest clearDelegatesAndCancel];
                self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
                [myRequest setRequestMethod:@"POST"];
                [myRequest addCommHeaders];
                [myRequest setPostBody:postData];
                [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [myRequest setDelegate:self];
                [myRequest setDidFinishSelector:@selector(requestDuiHuanCJFinished:)];
                [myRequest setDidFailSelector:@selector(requestDuiHuanCJFailed:)];
                [myRequest startAsynchronous];
            }
            else{
            
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"温馨提示" message:@"对不起|您的积分不足,不能兑换!" delegate:self cancelButtonTitle:@"赚取积分" otherButtonTitles:@"取消",nil];
                alert.alertTpye = ExchangePointFailType;
                alert.tag = 300;
                [alert show];
                [alert release];
            }

        }
    }
    if(alertView.tag == 200){
    
        if(buttonIndex == 1){
            if([[[Info getInstance] jifen] doubleValue] >= [self.yhmList.needPoint doubleValue]){
                
                NSMutableData *postData = [[GC_HttpService sharedInstance] req_pointExChangeYHM:[[Info getInstance] userName] withCode:self.yhmList.code];
                [myRequest clearDelegatesAndCancel];
                self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
                [myRequest setRequestMethod:@"POST"];
                [myRequest addCommHeaders];
                [myRequest setPostBody:postData];
                [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [myRequest setDelegate:self];
                [myRequest setDidFinishSelector:@selector(requestDuiHuanYHMFinished:)];
                [myRequest setDidFailSelector:@selector(requestDuiHuanYHMFailed:)];
                [myRequest startAsynchronous];
                
            }
            else{
            
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"温馨提示" message:@"对不起|您的积分不足,不能兑换!" delegate:self cancelButtonTitle:@"赚取积分" otherButtonTitles:@"取消",nil];
                alert.alertTpye = ExchangePointFailType;
                alert.tag = 400;
                [alert show];
                [alert release];
            }

        }
    }
    if(alertView.tag == 300 || alertView.tag == 400){
    
        if(buttonIndex == 0){
        
            [self goBuy];
            
        }
    }
}

- (void)goBuy {
    
    
    GouCaiViewController *gou = [[GouCaiViewController alloc] init];
    gou.title = @"购买彩票";
    GouCaiViewController *gou2 = [[GouCaiViewController alloc] init];
    gou2.title = @"购买彩票";
    gou2.fistPage = 1;
    
    GCHeMaiInfoViewController * hemaiinfotwo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfotwo.hmdtBool = YES;
    hemaiinfotwo.paixustr = @"ADC";
    hemaiinfotwo.goucaibool = YES;
    hemaiinfotwo.isNeedPopToRoot = YES;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:gou, gou2, hemaiinfotwo, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"数字彩"];
    [labearr addObject:@"足篮彩"];
    [labearr addObject:@"合买大厅"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"goucaishuzibai.png"];
    [imagestring addObject:@"goucaizubai.png"];
    [imagestring addObject:@"goucaihemaibai.png"];
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"tabbg_shuzi.png"];
    [imageg addObject:@"tabbg_zulan.png"];
    [imageg addObject:@"tabbg_hemai.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    CP_TabBarViewController * tabarvc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabarvc.goucaibool = YES;
    tabarvc.showXuanZheZhao = YES;
    tabarvc.selectedIndex = 0;
    tabarvc.delegateCP = self;
    
    tabarvc.navigationController.navigationBarHidden = YES;
    tabarvc.backgroundImage.backgroundColor=[UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];
    [self.navigationController pushViewController:tabarvc animated:YES];
    
    [tabarvc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [gou release];
    [gou2 release];
    [hemaiinfotwo release];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{

    [myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    [myRequest2 clearDelegatesAndCancel];
    self.myRequest2 = nil;
    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    