//
//  GCXianJinLiuShuiController.m
//  caibo
//
//  Created by  on 12-5-23.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCXianJinLiuShuiController.h"
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
#import "Info.h"
#import "GCLiushuiXiangqingController.h"

@implementation GCXianJinLiuShuiController
{
    UIView *viewJia;
}
@synthesize mRefreshView;
@synthesize httpRequest;

@synthesize morecellchong;
@synthesize morecellti;
@synthesize moreCellall;
@synthesize morecelldong;
@synthesize liuShuiIndex;
@synthesize isDrawal;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    xjbAll = NO;
    xjbCZ = NO;
    xjbDJ = NO;
    xjbTX = NO;
    allArray = [[NSMutableArray alloc] initWithCapacity:0];
    czArray = [[NSMutableArray alloc] initWithCapacity:0];
    djArray = [[NSMutableArray alloc] initWithCapacity:0];
    txArry = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    
    UIImageView *backImageV = [[UIImageView alloc] init];
    // backImageV.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:231.0/255.0 alpha:1];
    backImageV.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
	backImageV.frame = self.view.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];
    
    

    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    self.CP_navigation.titleLabel.text = @"现金流水";
    

    
    
    
    UIImageView * view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    view.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1];
    view.userInteractionEnabled = YES;
    [self.mainView addSubview:view];
    
   
    
    NSArray *btnNameArray = [NSArray arrayWithObjects:@"全部",@"充值",@"冻结",@"提现", nil];
    for (int i = 0; i < 4; i ++) {
        CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(83 * i + 2, 0, 65, 25.5);
        [btn loadButonImage:[NSString stringWithFormat:@"liuShuiTypeNormal%d_1.png",i+1] LabelName:[btnNameArray objectAtIndex:i]];
        NSString *selectName = [NSString stringWithFormat:@"liuShuiTypeHight%d_1.png",i+1];
        btn.selectImage = UIImageGetImageFromName(selectName);
        btn.buttonImage.frame = CGRectMake(0, 0, 29, 25.5);
        btn.buttonImage.center = CGPointMake(btn.bounds.size.width/2.0, btn.bounds.size.height/2);
        btn.buttonName.frame = CGRectMake(1 * i+1 , btn.frame.origin.y+btn.frame.size.height, 60, 20);
        btn.buttonName.font = [UIFont systemFontOfSize:10];
        btn.nomorTextColor = [UIColor colorWithRed:185.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
        btn.selectTextColor = [UIColor yellowColor];
        [view addSubview:btn];
        btn.tag = i;
        if(isDrawal)
        {
            if(btn.tag == 3)
            {
                btn.selected = YES;
            }
        }
        else{
            if (btn.tag == 0) {
                btn.selected = YES;
            }
        }

        [btn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
    
    
    
    
    
    myTableView = [[UITableView alloc] init];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	myTableView.delegate = self;
	myTableView.dataSource = self;
    
    
    
    
#ifdef isCaiPiaoForIPad
    myTableView.frame = CGRectMake(35, 0, 320, self.mainView.frame.size.height);
    
#else
   myTableView.frame = CGRectMake(0, 45, 320, self.mainView.frame.size.height - 45);
#endif
	
	myTableView.backgroundColor = [UIColor clearColor];
	[myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    
    
    
    CBRefreshTableHeaderView *headerview =
	[[CBRefreshTableHeaderView alloc] 
	 initWithFrame:CGRectMake(0, -(myTableView.frame.size.height), myTableView.frame.size.width, myTableView.frame.size.height)];
	self.mRefreshView = headerview;
	mRefreshView.backgroundColor = [UIColor clearColor];
	mRefreshView.delegate = self;
	[myTableView addSubview:mRefreshView];
	[headerview release];
    
    if(isDrawal)
    {
        [self xianjinTiXianRequest];
        xjlsType = XianJinLiuShuitixiana;
    }
    else{
        [self xianjinAllRequest];
        xjlsType = XianJinLiuShuialla;
    }

    
   

    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (xjlsType == XianJinLiuShuialla) {
        return [allArray count]+1;
    }else if(xjlsType == XianJinLiuShuichongzhia){
        return [czArray count]+1;
    }else if(xjlsType == XianJinLiuShuidongjiea){
        return [djArray count]+1;
    }else if(xjlsType == XianJinLiuShuitixiana){
        return [txArry count]+1;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
     if (xjlsType == XianJinLiuShuialla)
     {
         if (indexPath.row == allArray.count ) {
             return 75;
         }
         else
         {
             GCLiushuiDataInfo *lisdata = [allArray objectAtIndex:indexPath.row];
             if (lisdata.oneBool) {
                 return 125;
             }
             else
                 return 75;
         }
        
     }else if (xjlsType == XianJinLiuShuichongzhia) {
        if (indexPath.row == czArray.count) {
            return 75;
        }
        else
        {
            RechargeInfor *lisdata = [czArray objectAtIndex:indexPath.row];
            if (lisdata.oneBool) {
                return 125;
            }
            else
                return 75;
        
        }
        
        
    }else  if (xjlsType == XianJinLiuShuidongjiea) {
       
        if (indexPath.row == djArray.count) {
            return 75;
        }else
        {
            FreezeDetailInfor *lsddata = [djArray objectAtIndex:indexPath.row];
            if (lsddata.oneBool) {
                return 125;
            }
            else
                return 75;
        }
       
    }else{
        if (indexPath.row == txArry.count) {
            return 75;
        }
        else
        {
            WithdrawalsInfor *lisdata = [txArry objectAtIndex:indexPath.row];
            if (lisdata.oneBool) {
                return 125;
            }
            else
                return 75;
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
   
    if (xjlsType == XianJinLiuShuialla) {
        
        if (indexPath.row ==[allArray count])
        {
            NSString *  CellIdentifier1 = @"MoreLoadCell1";
            MoreLoadCell *cell1 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell1 == nil) {
                cell1 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
                [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
                moreCellall.backgroundColor = [UIColor clearColor];
            }
            if (moreCellall == nil) {
                self.moreCellall = cell1;
            }
            
//            [moreCellall spinnerStartAnimating];
//            [self xianjinAllRequest];
            
            return cell1;
        }
        else
        {
            
            GCLiushuiDataInfo * lsdInfo = [allArray objectAtIndex:indexPath.row];
             if  (lsdInfo.oneBool)
            {
                
                
                NSString *cellidentifier = @"yearFirst";
                GCLiushuiCell *cell2 = (GCLiushuiCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
                if (cell2 == nil) {
                    cell2 = [[[GCLiushuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier] autorelease];
//                    UIView *xianView = [[UIView alloc] initWithFrame:CGRectMake(95, 75+50, 320-95, 0.5)];
//                    xianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
//                    [cell2 addSubview:xianView];
//                    [xianView release];
                    cell2.xianView.hidden = YES;
                    cell2.xianView2.hidden = NO;
                    
                    UIView *verticalLine3 = [[UIView alloc] initWithFrame:CGRectMake(75, 0, 0.5, 15)];
                    verticalLine3.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
                    [cell2 addSubview:verticalLine3];
                    [verticalLine3 release];
                    
                    // 加横线
                    UIView *hengXianView = [[[UIView alloc] init] autorelease];
                    hengXianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
                    hengXianView.frame = CGRectMake(95, 124.5, 320-95, 0.5);
                    [cell2 addSubview:hengXianView];
                    
                }
                
                cell2.info = lsdInfo;
                cell2.backgroundColor = [UIColor clearColor];
                cell2.verticalLine2.frame = CGRectMake(75, -10, 0.5, 28);
                cell2.view.frame = CGRectMake(0, 50, 320, 75);
                if ([lsdInfo.caozuodate length] > 4) {
                    cell2.yearLabel.text = [lsdInfo.caozuodate substringToIndex:4];
                }
                
                
                
                return cell2;
                
            }
            else
            {
                NSString * cellid = @"shuiall";
                GCLiushuiCell * cell = (GCLiushuiCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
                if (cell == nil) {
                    cell = [[[GCLiushuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
                    // 分割线
                    UIView *hengXianView = [[[UIView alloc] init] autorelease];
                    hengXianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
                    hengXianView.frame = CGRectMake(95, 74.5, 320-95, 0.5);
                    [cell addSubview:hengXianView];
                }
                
                GCLiushuiDataInfo * lsdInfo = [allArray objectAtIndex:indexPath.row];
                cell.info = lsdInfo;
                cell.yearLabel.hidden = YES;
                cell.backgroundColor = [UIColor clearColor];
                return cell;
            }
            
        }
        
    }else if(xjlsType == XianJinLiuShuidongjiea){
        if (indexPath.row ==[djArray count]) {
            
            NSString * CellIdentifier2 = @"MoreLoadCell2";
            
            MoreLoadCell *cell2 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            
            if (cell2 == nil) {
                cell2 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2] autorelease];
                [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
                morecelldong.backgroundColor = [UIColor clearColor];
            }
            
            if (morecelldong == nil) {
               self.morecelldong = cell2;
            }
            
//            [self.morecelldong spinnerStartAnimating];//
//            [self xianjinDongJieRequest];
            
            return cell2;
        }else{
            
            
            FreezeDetailInfor * lsdInfo = [djArray objectAtIndex:indexPath.row];
            if  (lsdInfo.oneBool)
            {
                
                
                NSString *cellidentifier = @"yearFirst";
                GCLiushuiCell *cell2 = (GCLiushuiCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
                if (cell2 == nil) {
                    cell2 = [[[GCLiushuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier] autorelease];
                    // 加横线
                    UIView *hengXianView = [[[UIView alloc] init] autorelease];
                    hengXianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
                    hengXianView.frame = CGRectMake(95, 124.5, 320-95, 0.5);
                    [cell2 addSubview:hengXianView];
                }
                
                cell2.freeinfo = lsdInfo;
                cell2.backgroundColor = [UIColor clearColor];
                cell2.view.frame = CGRectMake(0, 50, 320, 75);
                return cell2;
            }
            else
            {
                NSString * cellid = @"shuiall";
                GCLiushuiCell * cell = (GCLiushuiCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
                if (cell == nil) {
                    cell = [[[GCLiushuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
                    
                    // 加横线
                    UIView *hengXianView = [[[UIView alloc] init] autorelease];
                    hengXianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
                    hengXianView.frame = CGRectMake(95, 74.5, 320-95, 0.5);
                    [cell addSubview:hengXianView];
                }
                FreezeDetailInfor * lsdInfo = [djArray objectAtIndex:indexPath.row];
                cell.freeinfo = lsdInfo;
                cell.backgroundColor = [UIColor clearColor];
                cell.yearLabel.hidden = YES;
                return cell;
                

            
            }
            
            
        }
        
    }else if(xjlsType == XianJinLiuShuichongzhia){
        if (indexPath.row ==[czArray count]) {
            
            NSString * CellIdentifier3 = @"MoreLoadCell3";
            MoreLoadCell *cell3 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
            
            if (cell3 == nil) {
                cell3 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease];
                [cell3 setSelectionStyle:UITableViewCellSelectionStyleNone];
                morecellchong.backgroundColor = [UIColor clearColor];
            }
            
            if (morecellchong == nil) {
                self.morecellchong = cell3;
            }
            
//            [morecellchong spinnerStartAnimating];//
//            [self xianjinChongZhiRequest];
            
            return cell3;
        }else{
            
            RechargeInfor * lsdInfo = [czArray objectAtIndex:indexPath.row];
            if  (lsdInfo.oneBool)
            {
                
                
                NSString *cellidentifier = @"yearFirst";
                GCLiushuiCell *cell2 = (GCLiushuiCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
                if (cell2 == nil) {
                    cell2 = [[[GCLiushuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier] autorelease];
                    
                    // 加横线
                    UIView *hengXianView = [[[UIView alloc] init] autorelease];
                    hengXianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
                    hengXianView.frame = CGRectMake(95, 124.5, 320-95, 0.5);
                    [cell2 addSubview:hengXianView];
                    
                }
                
                cell2.rechinfo = lsdInfo;
                cell2.backgroundColor = [UIColor clearColor];
                cell2.view.frame = CGRectMake(0, 50, 320, 75);
                return cell2;
            }else{
            
                NSString * cellid = @"shuiall";
                GCLiushuiCell * cell = (GCLiushuiCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
                if (cell == nil) {
                    cell = [[[GCLiushuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
                    // 加横线
                    UIView *hengXianView = [[[UIView alloc] init] autorelease];
                    hengXianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
                    hengXianView.frame = CGRectMake(95, 74.5, 320-95, 0.5);
                    [cell addSubview:hengXianView];
                    
                    
                }
                RechargeInfor * lsdInfo = [czArray objectAtIndex:indexPath.row];
                cell.rechinfo = lsdInfo;
                cell.backgroundColor = [UIColor clearColor];
                cell.yearLabel.hidden = YES;
                return cell;
            }

            
            
            
            
            
        }
    }else if(xjlsType == XianJinLiuShuitixiana){
        if (indexPath.row ==[txArry count]) {
            
            NSString *  CellIdentifier4 = @"MoreLoadCell4";
            MoreLoadCell *cell4 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            
            if (cell4 == nil) {
                cell4 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4] autorelease];
                [cell4 setSelectionStyle:UITableViewCellSelectionStyleNone];
                morecellti.backgroundColor = [UIColor clearColor];
            }
            
            if (morecellti == nil) {
                self.morecellti = cell4;
            }
            
//            [morecellti spinnerStartAnimating];//
//            [self xianjinTiXianRequest];
            
            return cell4;
        }else{
            WithdrawalsInfor * lsdInfo = [txArry objectAtIndex:indexPath.row];
            if  (lsdInfo.oneBool)
            {
                
                
                NSString *cellidentifier = @"yearFirst";
                GCLiushuiCell *cell2 = (GCLiushuiCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
                if (cell2 == nil) {
                    cell2 = [[[GCLiushuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier] autorelease];
                    
                    // 加横线
                    UIView *hengXianView = [[[UIView alloc] init] autorelease];
                    hengXianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
                    hengXianView.frame = CGRectMake(95, 124.5, 320-95, 0.5);
                    [cell2 addSubview:hengXianView];
                    
                }
                
                cell2.withinfo = lsdInfo;
                cell2.backgroundColor = [UIColor clearColor];
                cell2.view.frame = CGRectMake(0, 50, 320, 75);
                return cell2;
            }
            else {
                
                NSString * cellid = @"shuiall";
                GCLiushuiCell * cell = (GCLiushuiCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
                if (cell == nil) {
                    cell = [[[GCLiushuiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
                    
                    // 加横线
                    UIView *hengXianView = [[[UIView alloc] init] autorelease];
                    hengXianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
                    hengXianView.frame = CGRectMake(95, 74.5, 320-95, 0.5);
                    [cell addSubview:hengXianView];
                }
                WithdrawalsInfor * lsdInfo = [txArry objectAtIndex:indexPath.row];
                cell.withinfo = lsdInfo;
                cell.backgroundColor = [UIColor clearColor];
                cell.yearLabel.hidden = YES;
                return cell;
                
            }
            
            
            
        }
    }
    
	// Configure the cell...
	
	return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    NSArray * arrayinfo;
    if (xjlsType == XianJinLiuShuialla) {
        if (indexPath.row == [allArray count]) {
            
            [moreCellall spinnerStartAnimating];
            [self xianjinAllRequest];
            
        }else{
            GCLiushuiDataInfo * lsdInfo = [allArray objectAtIndex:indexPath.row];
            
            UIImageView *imageJia = (UIImageView *)[myTableView viewWithTag:66669];
            imageJia.hidden = YES;
            UILabel *labelJia = (UILabel *) [myTableView viewWithTag: 66669];
            labelJia.hidden = YES;
            
            NSString * str1 = lsdInfo.caozuodate;
            NSString *  str2;
            if ([lsdInfo.erleixing isEqualToString:@"20"]) {
                str2 = lsdInfo.bencijiang; 
            }else{
                str2 = lsdInfo.benmoney;
            }
            
            NSString * str3 = lsdInfo.ermingcheng;
            NSString * str4 = lsdInfo.dingdanhao;
            NSString * str5 = lsdInfo.beizhu;
            arrayinfo = [NSArray  arrayWithObjects:str1, str2, str3, str4, str5, nil];
            
            GCLiushuiXiangqingController * qing = [[GCLiushuiXiangqingController alloc] init];
            qing.allarray = arrayinfo;
            qing.xiangqingtype = xiangqingquanbu;
            [self.navigationController pushViewController:qing animated:YES];
            [qing release];
            
            

        }
                
    }else if(xjlsType == XianJinLiuShuidongjiea){
        if (indexPath.row == [djArray count]) {
            [self.morecelldong spinnerStartAnimating];//
            [self xianjinDongJieRequest];
        }else{
            FreezeDetailInfor * lsdInfo = [djArray objectAtIndex:indexPath.row];
            NSString * str1 = lsdInfo.freezeTime;
            NSString * str2 = lsdInfo.totolAmount;
            NSString * str3 = lsdInfo.type;
            NSString * str4 = lsdInfo.state;
            NSString * str5 = lsdInfo.orderNo;/////////
            NSString * str6 = lsdInfo.resouce;
            arrayinfo = [NSArray  arrayWithObjects:str1, str2, str3, str4, str5, str6, nil];
            
            GCLiushuiXiangqingController * qing = [[GCLiushuiXiangqingController alloc] init];
            qing.allarray = arrayinfo;
            qing.xiangqingtype = xiangqingdongjie;
            [self.navigationController pushViewController:qing animated:YES];
            [qing release];

        
        }
        
               
    }else if(xjlsType == XianJinLiuShuichongzhia){
        if (indexPath.row == [czArray count]) {
            [morecellchong spinnerStartAnimating];//
            [self xianjinChongZhiRequest];
        }else{
        
            RechargeInfor * lsdInfo = [czArray objectAtIndex:indexPath.row];
            NSString * str1 = lsdInfo.rechargeTime;
            NSString * str2 = lsdInfo.amount;
            NSString * str3 = lsdInfo.style;
            NSString * str4 = [NSString stringWithFormat:@"%@", lsdInfo.stateExplain];
            NSString * str5 = lsdInfo.orderNo;
            NSString * str6 = lsdInfo.explain;
            arrayinfo = [NSArray  arrayWithObjects:str1, str2, str3, str4, str5, str6, nil];
            
            GCLiushuiXiangqingController * qing = [[GCLiushuiXiangqingController alloc] init];
            qing.allarray = arrayinfo;
            qing.xiangqingtype = xiangqingchongzhi;
            [self.navigationController pushViewController:qing animated:YES];
            [qing release];
        }
        
        
        
    }else if(xjlsType == XianJinLiuShuitixiana){
        if (indexPath.row == [txArry count]) {
            [morecellti spinnerStartAnimating];//
            [self xianjinTiXianRequest];
        }else{
            WithdrawalsInfor * lsdInfo = [txArry objectAtIndex:indexPath.row];
            NSString * str1 = lsdInfo.operDate;
            NSString * str2 = lsdInfo.award;
            NSString * str3 = lsdInfo.type;
            NSString * str4 = lsdInfo.state;
            NSString * str5 = lsdInfo.orderNo;
            NSString * str6 = lsdInfo.remarks;
            arrayinfo = [NSArray  arrayWithObjects:str1, str2, str3, str4, str5, str6, nil];
            
            GCLiushuiXiangqingController * qing = [[GCLiushuiXiangqingController alloc] init];
            qing.allarray = arrayinfo;
            qing.xiangqingtype = xiangqingtixian;
            [self.navigationController pushViewController:qing animated:YES];
            [qing release];

        }
        
        
    }
    
    
	[tableView deselectRowAtIndexPath: indexPath animated: YES];
}




- (void)xianJinLiuShui:(ASIHTTPRequest*)request{
    
        GCLiushuiData *personalData = [[GCLiushuiData alloc] initWithResponseData:[request responseData] WithRequest:request];
        NSLog(@"pers = %d", (int)personalData.allarray.count);
        if (allArray.count < 7) {
            xjbAll = YES;
        }
            if (xjbAll) {
                [allArray removeAllObjects];
            }
        
        [allArray addObjectsFromArray:personalData.allarray];
    
    
    if (viewJia.hidden == NO) {
        viewJia.hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:0])).hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:1])).hidden = YES;

    }
        if ([allArray count]==0 && xjlsType == XianJinLiuShuialla  ) {
            [self showNoMessageView];
        }
    
    NSString * priorYear = @"";
        
        for (int i = 0; i < [allArray count]; i++) {
            
            GCLiushuiDataInfo * dataInfo = [allArray objectAtIndex:i];
            NSString * currentYear = [dataInfo.caozuodate substringToIndex:4] ;
            
            if (i == 0) {
                priorYear = currentYear;
                dataInfo.oneBool = YES;
            }else{
                
                if ([priorYear isEqualToString:currentYear]) {
                    dataInfo.oneBool = NO;
                }else{
                    
                    dataInfo.oneBool = YES;
                    priorYear = currentYear;
                }
            }
            [allArray replaceObjectAtIndex:i withObject:dataInfo];
        }
    
    
        [myTableView reloadData];
    
    
    
   
    
    
    if (allArray.count%7 != 0) {
        [personalData release];
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        self.moreCellall.type = MSG_TYPE_LOAD_NODATA;
		[cai showMessage:@"加载完毕"];
        [moreCellall spinnerStopAnimating];
        [moreCellall setInfoText:@"加载完毕"];
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        isLoading = NO;
       
        return;
	}else{
    
        //    xjbAll = NO;
        isLoading = NO;
        if (personalData.allarray.count <= 7) {
            [self.moreCellall spinnerStopAnimating];
        }
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        [self performSelector:@selector(alljiazaiwanbi:) withObject:personalData afterDelay:0];
        [personalData release];
    }
}
- (void)alljiazaiwanbi:(GCLiushuiData *)fd{
    
    if ([fd.allarray count] == 0 || fd.allarray == nil) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCellall spinnerStopAnimating];
        self.moreCellall.type = MSG_TYPE_LOAD_NODATA;
        [moreCellall setInfoText:@"加载完毕"];
        
        
    }
    else
    {
    

        
    }
    xjbAll = NO;
}

- (void)xianjinAllRequest{
    NSInteger countshu = 0;
#ifdef isCaiPiaoForIPad
    countshu = 20;
#else
    countshu = 7;
#endif
    NSInteger page = [allArray count]/countshu +1;
    if (xjbAll) {
       
        page = 1;
    }
    [moreCellall spinnerStartAnimating];
    [moreCellall spinnerStopAnimating];
    
	NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetXianJinLiuShuitiaoshu:(int)countshu page:(int)page];
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(xianJinLiuShui:)];
    [httpRequest startAsynchronous];
    

}

-(void)changeType:(UIButton *)sender
{
   
    if (viewJia.hidden == NO) {
        viewJia.hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:0])).hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:1])).hidden = YES;
        
    }
    
    for (UIButton *btn2 in sender.superview.subviews) {
        btn2.selected = NO;
    }
    sender.selected = YES;
    
    if (sender.tag == 0) {
        xjlsType = XianJinLiuShuialla;
        if(allArray.count == 0){
            
            [self xianjinAllRequest];
            
        }
    }else if(sender.tag == 1){
        xjlsType = XianJinLiuShuichongzhia;
        if (czArray.count == 0) {
            [self xianjinChongZhiRequest];
            
        }
    }else if(sender.tag == 2){
        xjlsType = XianJinLiuShuidongjiea;
        if (djArray.count == 0) {
            [self xianjinDongJieRequest];
            
        }
    }else{
        xjlsType = XianJinLiuShuitixiana;
        if (txArry.count == 0) {
            [self xianjinTiXianRequest];
            

            
        }
    }
     [myTableView reloadData];
}

//- (void)pressAllBtutton:(UIButton *)sender{
//   xuanLabel.text = @"现金流水(全部)";
//    [allArray removeAllObjects];
//    xjlsType = XianJinLiuShuialla;
//    [self xianjinAllRequest];
//    [bgviewdown removeFromSuperview];
//}
//充值
//- (void)pressChongZhiBut:(UIButton *)sender{
//    xuanLabel.text = @"现金流水(充值)";
//    [czArray removeAllObjects];
//    xjlsType = XianJinLiuShuichongzhia;
//    [self xianjinChongZhiRequest];
//    [bgviewdown removeFromSuperview];
//    
//}

- (void)xianjinChongZhiRequest{
    NSInteger countshu = 0;
#ifdef isCaiPiaoForIPad
    countshu = 20;
#else
    countshu = 7;
#endif
    NSInteger page = [czArray count]/countshu +1;
    if (xjbCZ) {
        page = 1;
    }
    [morecellchong spinnerStartAnimating];


    NSMutableData *postData = [[GC_HttpService sharedInstance] reRechangeRecord:5 countOfPage:(int)countshu currentPage:(int)page];
    [httpRequest clearDelegatesAndCancel];
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(xianjinChongZhi:)];
    [httpRequest startAsynchronous];
    
   
    
    

    
    
    
}


- (void)xianjinChongZhi:(ASIHTTPRequest *)request{
   
    
    
		GCRechangeRecord *rr = [[GCRechangeRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
    if (czArray.count < 7) {
        xjbCZ = YES;
    }
        if (xjbCZ) {
            [czArray removeAllObjects];
        }
    [czArray addObjectsFromArray:rr.rrInforArray];
    
    
    if (viewJia.hidden == NO) {
        viewJia.hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:0])).hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:1])).hidden = YES;
        
    }
    if ([czArray count]==0&&xjlsType == XianJinLiuShuichongzhia) {
        [self showNoMessageView];
    }
    
    

    
    
    NSString *previouslyYear = @"";
    for (int i = 0 ; i < czArray.count; i++) {
        RechargeInfor *rInfor = [czArray objectAtIndex:i];
        NSString *currentYear = [rInfor.rechargeTime substringToIndex:4];
        if (i == 0) {
            previouslyYear = currentYear;
            rInfor.oneBool = YES;
        }else
        {
            if ([previouslyYear isEqualToString: currentYear]) {
                rInfor.oneBool = NO;
            }
            else
            {
                rInfor.oneBool = YES;
                previouslyYear = currentYear;
            }
            
        }
        [czArray replaceObjectAtIndex:i withObject:rInfor];
    }
  
    
    
    
    
    [myTableView reloadData];
    
    
    
    
    if ([czArray count]%7 != 0) {
        [rr release];
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        self.morecellchong.type = MSG_TYPE_LOAD_NODATA;
		[cai showMessage:@"加载完毕"];
        [morecellchong spinnerStopAnimating];
        [morecellchong setInfoText:@"加载完毕"];
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        isLoading = NO;
        return;
	}else{
        isLoading = NO;
        if (rr.rrInforArray.count <= 7) {
            [self.morecellchong spinnerStopAnimating];
        }
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        [self performSelector:@selector(chongzhijiazaiwanbi:) withObject:rr afterDelay:0];
        [rr release];
    }
}

- (void)chongzhijiazaiwanbi:(GCRechangeRecord *)fd{
    
    if ([fd.rrInforArray count] == 0) {
        self.morecellchong.type = MSG_TYPE_LOAD_NODATA;
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [morecellchong spinnerStopAnimating];
        [morecellchong setInfoText:@"加载完毕"];
        
    }
    xjbCZ = NO;
}


- (void)xianjinDongJieRequest{
    NSInteger countshu = 0;
#ifdef isCaiPiaoForIPad
    countshu = 20;
#else
    countshu = 7;
#endif
    NSInteger page = [djArray count]/countshu +1;
    
    if (xjbDJ) {
        page = 1;
    }
    [morecelldong spinnerStartAnimating];

    [self.httpRequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] refreezeDetail:(int)countshu currentPage:(int)page];
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(xianjinliushuiDongJie:)];
    [httpRequest startAsynchronous];
    
  
    
    
//    UIImageView *allImageView = (UIImageView *)[self.mainView viewWithTag:66666];
//    allImageView.hidden = YES;
//    UILabel *allLabel = (UILabel *)[self.mainView viewWithTag:77776];
//    allLabel.hidden = YES;
//    
//    UIImageView *czImageView = (UIImageView *)[self.mainView viewWithTag:66667];
//    czImageView.hidden = YES;
//    UILabel *czLabel = (UILabel *)[self.mainView viewWithTag:77777];
//    czLabel.hidden = YES;
//    
//    if (!djArray.count&&!allImageView&&!czImageView)
//    {
//        UIImageView *imageJia=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]] autorelease];
//        imageJia.tag = 66668;
//        imageJia.frame=CGRectMake(107.5, 80, 100, 100);
//        
//        UILabel *labelJia=[[[UILabel alloc]initWithFrame:CGRectMake(0, 200, 320, 30)] autorelease];
//        labelJia.text=@"暂无相关记录";
//        labelJia.tag = 77778;
//        labelJia.backgroundColor=[UIColor clearColor];
//        labelJia.font=[UIFont systemFontOfSize:12];
//        labelJia.textColor=[UIColor colorWithRed:166.0/255.0 green:157.0/255.0 blue:137.0/255.0 alpha:1];
//        labelJia.textAlignment = NSTextAlignmentCenter;
//        [myTableView addSubview:imageJia];
//        [myTableView addSubview:labelJia];
//        
//    }
    
    
    
    
    
}



- (void)xianjinliushuiDongJie:(ASIHTTPRequest *)mrequest{
    if (viewJia.hidden == NO) {
        viewJia.hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:0])).hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:1])).hidden = YES;
        
    }
   
    
    GC_FreezeDetail *fd = [[GC_FreezeDetail alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
    if (djArray.count < 7) {
        xjbDJ = YES;
    }
    if (xjbDJ) {
        [djArray removeAllObjects];
    }
    [djArray addObjectsFromArray:fd.fdInforArray];
    
    
    
    
    
    if ([djArray count]==0&&xjlsType == XianJinLiuShuidongjiea) {
        [self showNoMessageView];
    }
    
    
    
    
        for (int i = 0; i < [fd.fdInforArray count]; i++) {
            FreezeDetailInfor *fdInfor = [djArray objectAtIndex:i];
            if (fdInfor) {
                NSLog(@"冻结时间 %@", fdInfor.freezeTime);
                NSLog(@"冻结总金额 %@", fdInfor.totolAmount);
                NSLog(@"冻结现金 %@", fdInfor.cash);
                NSLog(@"冻结奖励账户金额 %@", fdInfor.accountAmount);
                NSLog(@"冻结类型 %@", fdInfor.type);
                NSLog(@"冻结状态 %@", fdInfor.state);
                NSLog(@"冻结订单号 %@", fdInfor.orderNo);
                NSLog(@"冻结原因 %@", fdInfor.resouce);
            }
        }
        
        
        
        // 判断是否是第一天
        NSString *previouslyYear = @"";
        for (int i = 0; i< djArray.count ; i++) {
            FreezeDetailInfor *fdInfor = [djArray objectAtIndex:i];
            NSString *currentYear = [fdInfor.freezeTime substringToIndex:4];
            if (i == 0) {
                previouslyYear = currentYear;
                fdInfor.oneBool = YES;
            }
            else
            {
                if ([previouslyYear isEqualToString:currentYear]) {
                    fdInfor.oneBool = NO;
                }
                else
                {
                    fdInfor.oneBool = YES;
                    previouslyYear = currentYear;
                }
            }
        }
        
        
        
        
        [myTableView reloadData];
        
        
        
        
        if ([djArray count]%7 != 0) {
            [fd release];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            self.morecelldong.type = MSG_TYPE_LOAD_NODATA;
            [cai showMessage:@"加载完毕"];
            [morecelldong setInfoText:@"加载完毕"];
            
            [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
            isLoading = NO;
            return;
        }else{
            isLoading = NO;
            if (fd.fdInforArray.count <= 7) {
                [self.morecelldong spinnerStopAnimating];
            }
            [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
            [self performSelector:@selector(dongjiejiazaiwanbi:) withObject:fd afterDelay:0];
            [fd release];
        }

}


- (void)dongjiejiazaiwanbi:(GC_FreezeDetail *)fd{
    if ([fd.fdInforArray count] == 0) {
        self.morecelldong.type = MSG_TYPE_LOAD_NODATA;
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [self.morecelldong spinnerStopAnimating];
        [self.morecelldong setInfoText:@"加载完毕"];
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    }

    xjbDJ = NO;
}
////提现
//- (void)pressTiXianButton:(UIButton *)sender{
//    xuanLabel.text = @"现金流水(提现)";
//    [txArry removeAllObjects];
//    xjlsType = XianJinLiuShuitixiana;
//    [self xianjinTiXianRequest];
//    [bgviewdown removeFromSuperview];
//}

- (void)yanchilogin{
 [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
}

- (void)xianjinTiXianRequest{
    NSInteger countshu = 0;
#ifdef isCaiPiaoForIPad
    countshu = 20;
#else
    countshu = 7;
#endif
    NSInteger page = [txArry count]/countshu +1;
    if (xjbTX) {
        page = 1;
    }
    [morecellti spinnerStartAnimating];
    [moreCellall spinnerStopAnimating];

    if (self.morecellti.type != MSG_TYPE_LOAD_NODATA) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] reWithdrawals:0
                                                                           state:0
                                                                       startTime:@"-"
                                                                         endTime:@"-"
                                                                       sortField:@"-"
                                                                       sortStyle:@"desc"
                                                                     countOfPage:(int)countshu
                                                                     currentPage:(int)page];
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(xianjinTiXian:)];
        [httpRequest startAsynchronous];
    }
    
    
    
}

- (void)showNoMessageView
{

    viewJia=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width , self.mainView.frame.size.height)];
    viewJia.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    
    // 480-800.png
    UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
    imageJia.frame=CGRectMake(108, 80, 100, 100);
    
    
    UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(125, 200, 80, 30)];
    labelJia.text=@"暂无相关记录";
    labelJia.backgroundColor=[UIColor clearColor];
    labelJia.font=[UIFont systemFontOfSize:12.0];
    labelJia.textColor=[UIColor grayColor];
    [viewJia addSubview:imageJia];
    [viewJia addSubview:labelJia];
    [myTableView addSubview:viewJia];
    [viewJia release];
    [imageJia release];
    [labelJia release];
    return;

    
}



- (void)xianjinTiXian:(ASIHTTPRequest *)mrequest{
    if (viewJia.hidden == NO) {
        viewJia.hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:0])).hidden = YES;
        ((UIView *)([viewJia.subviews objectAtIndex:1])).hidden = YES;
        
    }
    
    
    GC_Withdrawals *w = [[GC_Withdrawals alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
    if (txArry.count < 7) {
        xjbTX = YES;
    }
        if (xjbTX) {
            [txArry removeAllObjects];
        }
        [txArry addObjectsFromArray:w.wInforArray];
    
    
    
    
    if ([txArry count]==0&&xjlsType == XianJinLiuShuitixiana) {
        [self showNoMessageView];
    }
    
    
    
    
    
    
    NSString *previouslyYear = @"";
    for (int i = 0 ; i< txArry.count; i ++) {
        
        WithdrawalsInfor *wInfor = [txArry objectAtIndex:i];
        NSString *currentYear = [wInfor.operDate substringToIndex:4];
        if (i == 0) {
            previouslyYear = currentYear;
            wInfor.oneBool = YES;
            
        }else
        {
            if ([previouslyYear isEqualToString:currentYear]) {
                wInfor.oneBool = NO;
            }else
            {
                
                wInfor.oneBool = YES;
                previouslyYear = currentYear;
            }
            
        }
    }
    [myTableView reloadData];
    
    
  
    
    
    
    
    if ([txArry count]%7 != 0) {
        
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        self.morecellti.type = MSG_TYPE_LOAD_NODATA;
		[cai showMessage:@"加载完毕"];
        [morecellti setInfoText:@"加载完毕"];
        [self performSelector:@selector(yanchilogin) withObject:self afterDelay:0.1];
        [self performSelector:@selector(tixianjiazaiwanbi:) withObject:w afterDelay:0];
        isLoading = NO;
        [w release];
        return;
	}else{
        isLoading = NO;
        if (w.wInforArray.count <= 6) {
            [self.morecellti spinnerStopAnimating];
        }
        self.morecellti.type = MSG_TYPE_LOAD_MORE;
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
//        [self performSelector:@selector(tixianjiazaiwanbi:) withObject:w afterDelay:0];
        [w release];
    }
}

- (void)tixianjiazaiwanbi:(GC_Withdrawals *)fd{
    if ([fd.wInforArray count] == 0) {
        self.morecellchong.type = MSG_TYPE_LOAD_NODATA;
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [morecellti spinnerStopAnimating];
        [morecellti setInfoText:@"加载完毕"];
        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    }
    xjbTX = NO;
}


- (void)pressdownbutton:(UIButton *)sender{
    [bgviewdown removeFromSuperview];
}



- (void)doBack {
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
	//[self reloadSegmentData];
    isLoading = YES;
	if (xjlsType == XianJinLiuShuialla) {
        xjbAll = YES;
        
        [self xianjinAllRequest];
    }else if(xjlsType == XianJinLiuShuitixiana){
        xjbTX = YES;
        [self xianjinTiXianRequest];
    }else if(xjlsType == XianJinLiuShuichongzhia){
        xjbCZ = YES;
        [self xianjinChongZhiRequest];
    }else if (xjlsType == XianJinLiuShuidongjiea){
        xjbDJ = YES;
        [self xianjinDongJieRequest];
    }
    
    [mRefreshView setState:CBPullRefreshLoading];
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
- (void)reloadTableViewDataSource{
	isLoading = YES;
    
}
// 数据接收完成调用
- (void)dismissRefreshTableHeaderView
{
    isLoading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	
	[mRefreshView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0 && myTableView.contentSize.height-scrollView.contentOffset.y >= 120) {
		
		if (xjlsType == XianJinLiuShuialla) {
            if (!xjbAll) {
                [self performSelector:@selector(xianjinAllRequest) withObject:nil afterDelay:0.5];
//                 [moreCellall spinnerStartAnimating];
            }
           
        }else if(xjlsType == XianJinLiuShuidongjiea){
            if (!xjbDJ) {
                [self performSelector:@selector(xianjinDongJieRequest) withObject:nil afterDelay:0.5];
            }
        
        }else if (xjlsType == XianJinLiuShuitixiana){
            if (!xjbTX) {
                [self performSelector:@selector(xianjinTiXianRequest) withObject:nil afterDelay:0.5];
            }
          
        }else if(xjlsType == XianJinLiuShuichongzhia){
            if (!xjbCZ) {
                [self performSelector:@selector(xianjinChongZhiRequest) withObject:nil afterDelay:0.5];
            }
           
        }
		
	}	
	
	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
	
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}
- (void)dealloc {
    [czArray release];
    [djArray release];
    [txArry release];
    [allArray release];
	[self.httpRequest clearDelegatesAndCancel];
	self.httpRequest = nil;
	self.moreCellall = nil;
    self.morecellchong = nil;
    self.morecelldong = nil;
    self.morecellti = nil;
    [myTableView release];
    [super dealloc];
	
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    