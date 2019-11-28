//
//  MyPointViewController.m
//  caibo
//
//  Created by cp365dev on 14-5-12.
//
//

#import "MyPointViewController.h"
#import "Info.h"
#import "ColorView.h"
#import "HeaderLabel.h"
#import "PointCell.h"
#import "ASIHTTPRequest.h"
#import "GC_HttpService.h"
#import "JSON.h"
#import "PointInfoViewController.h"
#import "SharedMethod.h"
#import "Point_YouHuiMaCell.h"
#import "Point_JiangPinCell.h"
#import "GC_MyPrizeInfo.h"
#import "GC_YHMInfoParser.h"
#import "GC_TopUpViewController.h"
#import "caiboAppDelegate.h"
@interface MyPointViewController ()

@end

@implementation MyPointViewController
@synthesize myRequest = myRequest_;
@synthesize winingList;
@synthesize prizeRequest = prizeRequest_;
@synthesize YHMRequest = YHMRequest_;
@synthesize YHMInfoList;
@synthesize prizeInfoList;
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
    self.CP_navigation.titleLabel.text = @"我的积分";
    
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

    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.frame = CGRectMake(0, 44, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:232/255.0 alpha:1];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor clearColor];
    [backImage release];
    

    
    UIImageView *upBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 62)];
    upBgView.backgroundColor = [UIColor whiteColor];
    upBgView.tag = 500;
    upBgView.userInteractionEnabled = YES;
    [self.mainView addSubview:upBgView];
    [upBgView release];
    
    //虚线
    UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 61, 320, 1)];
    xian1.backgroundColor = [UIColor colorWithRed:206/255.0 green:205/255.0 blue:199/255.0 alpha:1];
    [upBgView addSubview:xian1];
    [xian1 release];
    
    
    UIImageView *shuxian1 = [[UIImageView alloc] initWithFrame:CGRectMake(106, 20, 1, 22)];
    shuxian1.backgroundColor = [UIColor colorWithRed:206/255.0 green:205/255.0 blue:199/255.0 alpha:1];
    [upBgView addSubview:shuxian1];
    [shuxian1 release];
    
    UIImageView *shuxian2 = [[UIImageView alloc] initWithFrame:CGRectMake(213, 20, 1, 22)];
    shuxian2.backgroundColor = [UIColor colorWithRed:206/255.0 green:205/255.0 blue:199/255.0 alpha:1];
    [upBgView addSubview:shuxian2];
    [shuxian2 release];
    
    Info *info = [Info getInstance];

    
    NSArray *nameArray = [NSArray arrayWithObjects:@"奖品包",@"优惠码",@"积分",nil];
    for(int i = 0;i<3;i++){
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(107*i, 0, 106, 62)];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(pointPress:) forControlEvents:UIControlEventTouchUpInside];
        [upBgView addSubview:btn];
        
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 106, 15)];
        if(i==2){
            numLabel.text = [info jifen];

        }
        else if(i==0){
        
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"MyPrizeAllCount"] && ![[[NSUserDefaults standardUserDefaults] valueForKey:@"MyPrizeAllCount"] isEqualToString:@"null"]){
                
                numLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MyPrizeAllCount"]];

            }
            else{
            
                numLabel.text = @"-";
            }

        }
        else if(i == 1){
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"MyYHMAllCount"] && ![[[NSUserDefaults standardUserDefaults] valueForKey:@"MyYHMAllCount"] isEqualToString:@"null"]){
                
                numLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MyYHMAllCount"]];

            }
            else{
                numLabel.text = @"-";

            }
        }
        numLabel.tag = 501+i;
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:15];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
        [btn addSubview:numLabel];
        [numLabel release];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(numLabel)+4.5, 106, 12)];
        nameLabel.text = [nameArray objectAtIndex:i];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = [SharedMethod getColorByHexString:@"a3a3a3"];
        [btn addSubview:nameLabel];
        [nameLabel release];
        
        if(i == 0){
        
            qiehuan = [[UIImageView alloc] initWithFrame:CGRectMake(214, 53, 106, 9)];
            qiehuan.image = UIImageGetImageFromName(@"point_qiehuan.png");
            qiehuan.backgroundColor = [UIColor clearColor];
            [upBgView addSubview:qiehuan];
            [qiehuan release];
        }
        
    }
    

    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(upBgView), 320, self.view.bounds.size.height-ORIGIN_Y(upBgView))];
    myScrollView.delegate = self;
    myScrollView.pagingEnabled = YES;
    myScrollView.tag = 400;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(320*3, myScrollView.frame.size.height);
    [myScrollView scrollRectToVisible:CGRectMake(640, 0, 320, myScrollView.frame.size.height) animated:NO];
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    
    UIView *bgview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, myScrollView.frame.size.height)];
    bgview1.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:bgview1];
    [bgview1 release];
    
    UIView *bgview2 = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, myScrollView.frame.size.height)];
    bgview2.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:bgview2];
    [bgview2 release];
    
    UIView *bgview3 = [[UIView alloc] initWithFrame:CGRectMake(640, 0, 320, myScrollView.frame.size.height)];
    bgview3.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:bgview3];
    [bgview3 release];
    
    
    //获得积分
    huode = [[ColorView alloc] initWithFrame:CGRectMake(10, 15, 320, 15)];
    huode.text = @"近一个月获得积分  <0>";
    huode.backgroundColor = [UIColor clearColor];
    huode.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    huode.changeColor = [UIColor colorWithRed:255.0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    huode.font = [UIFont systemFontOfSize:12];
    huode.hidden = YES;
    [bgview3 addSubview:huode];
    [huode release];
    //消耗积分
    xiaohao = [[ColorView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(huode)+7, 320, 15)];
    xiaohao.text = @"近一个月消耗积分  <0>";
    xiaohao.backgroundColor = [UIColor clearColor];
    xiaohao.hidden = YES;
    xiaohao.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    xiaohao.changeColor = [SharedMethod getColorByHexString:@"13a3ff"];
    xiaohao.font = [UIFont systemFontOfSize:12];
    [bgview3 addSubview:xiaohao];
    [xiaohao release];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(11, ORIGIN_Y(xiaohao)+7, 298, self.mainView.frame.size.height-130) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.tag = 203;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgview3 addSubview:myTableView];
    [myTableView release];
    
    //优惠码
    myYouhuima = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 100, 12)];
    myYouhuima.backgroundColor = [UIColor clearColor];
    myYouhuima.text = @"我的优惠码";
    myYouhuima.hidden = YES;
    myYouhuima.textColor = [SharedMethod getColorByHexString:@"505050"];
    myYouhuima.font = [UIFont systemFontOfSize:12];
    [bgview2 addSubview:myYouhuima];
    [myYouhuima release];
    
    xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, 320, 1)];
    xian2.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
    xian2.hidden = YES;
    [bgview2 addSubview:xian2];
    [xian2 release];
    
    youhuimaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(xian2), 320, self.mainView.frame.size.height-ORIGIN_Y(xian2) - 60) style:UITableViewStylePlain];
    youhuimaTableView.delegate = self;
    youhuimaTableView.dataSource = self;
    youhuimaTableView.tag = 202;;
    youhuimaTableView.backgroundColor = [UIColor clearColor];
    youhuimaTableView.showsVerticalScrollIndicator = NO;
    youhuimaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgview2 addSubview:youhuimaTableView];
    [youhuimaTableView release];
    
    
    //奖品包
    myJiangpin = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 100, 12)];
    myJiangpin.backgroundColor = [UIColor clearColor];
    myJiangpin.text = @"我的奖品包";
    myJiangpin.hidden = YES;
    myJiangpin.textColor = [SharedMethod getColorByHexString:@"505050"];
    myJiangpin.font = [UIFont systemFontOfSize:12];
    [bgview1 addSubview:myJiangpin];
    [myJiangpin release];
    
    myJiangpinXian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, 320, 1)];
    myJiangpinXian.hidden = YES;
    myJiangpinXian.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
    [bgview1 addSubview:myJiangpinXian];
    [myJiangpinXian release];
    
    
    jiangpinTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(myJiangpinXian), 320, self.mainView.frame.size.height-ORIGIN_Y(xian2)-60) style:UITableViewStylePlain];
    jiangpinTableView.delegate = self;
    jiangpinTableView.dataSource = self;
    jiangpinTableView.tag = 201;;
    jiangpinTableView.backgroundColor = [UIColor clearColor];
    jiangpinTableView.showsVerticalScrollIndicator = NO;
    jiangpinTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgview1 addSubview:jiangpinTableView];
    [jiangpinTableView release];
    
    [self getMyPointListWithPage:1];
    
    hadReqYHM = NO;
    hadReqJPB = NO;
    
    
}

-(void)pointPress:(UIButton *)sender{
    
    int i = (int)sender.tag-100;
    
    qiehuan.frame = CGRectMake(107*i, 53, 106, 9);
    
    [myScrollView scrollRectToVisible:CGRectMake(320*i, 0, 320, myScrollView.frame.size.height) animated:YES];
}
//积分说明
-(void)pointExplain
{
    PointInfoViewController *pointinfo = [[PointInfoViewController alloc] init];
    [self.navigationController pushViewController:pointinfo animated:YES];
    [pointinfo release];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 203){
        
        if(self.winingList.zhongjiangArray.count)
        {
            return [self.winingList.zhongjiangArray count]+1;
        }
    }
    else if(tableView.tag == 202){
    
        if(self.YHMInfoList.YHMInfoArray.count){
        
            return [self.YHMInfoList.YHMInfoArray count] + 1;
        }
    }
    else if(tableView.tag == 201){
        
        if(self.prizeInfoList.prizeArray.count){
        
            return self.prizeInfoList.prizeArray.count+1;

        }
    }

    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 203){
    
        return 50;
    }
    else if(tableView.tag == 202){
    
        return 85;
    }
    else if(tableView.tag == 201){
        
        return 63;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == 203){
    
        return 27;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == 203){
    
        //蓝色Label
        HeaderLabel *header = [[[HeaderLabel alloc] initWithFrame:CGRectMake(11, 0, 298, 27) andLabel1Text:@"时间" andLabelWed:86 andLabel2Text:@"类型" andLabel2Wed:73 andLabelText3:@"获得积分" andLabel3Wed:70 andLaelText4:@"消耗积分" andLabel4Frame:69 isJiangJiDouble:NO] autorelease];
        
        return header;
    }

    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView.tag == 203){
    
        if (indexPath.row == self.winingList.zhongjiangArray.count) {
            static NSString *CellIdentifier = @"Cell3";
            moreCell = (MoreLoadCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!moreCell) {
                moreCell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                [moreCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [moreCell setInfoText:@"加载更多"];
            }
            
            moreCell.backgroundColor = [UIColor clearColor];
            return moreCell;
        }
        
        static NSString *pointCell = @"pointCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pointCell];
        if(!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pointCell] autorelease];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //纵线
            for(int i = 0;i<5;i++)
            {
                UIImageView *xianImage = [[UIImageView alloc] init];
                xianImage.tag = 100+i;
                if(i == 0)
                    xianImage.frame = CGRectMake(0, 0, 1, 50);
                if(i==1)
                    xianImage.frame = CGRectMake(86, 0, 1, 50);
                if(i == 2)
                    xianImage.frame = CGRectMake(159, 0, 1, 50);
                if(i == 3)
                    xianImage.frame = CGRectMake(229, 0, 1, 50);
                if(i == 4)
                    xianImage.frame = CGRectMake(297, 0, 1, 50);
                [cell.contentView addSubview:xianImage];
                [xianImage release];
            }
            
            
            //时间
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 86, 50)];
            timeLabel.numberOfLines = 0;
            timeLabel.tag = 111;
            timeLabel.textAlignment = NSTextAlignmentCenter;
            timeLabel.font = [UIFont systemFontOfSize:14];
            timeLabel.backgroundColor = [UIColor clearColor];
            timeLabel.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
            [cell.contentView addSubview:timeLabel];
            [timeLabel release];
            //类型
            UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(86, 0, 73, 50)];
            typeLabel.numberOfLines = 0;
            typeLabel.tag = 112;
            typeLabel.textAlignment = NSTextAlignmentCenter;
            typeLabel.font = [UIFont systemFontOfSize:14];
            typeLabel.backgroundColor = [UIColor clearColor];
            typeLabel.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
            [cell.contentView addSubview:typeLabel];
            [typeLabel release];
            
            //获得积分
            
            UILabel *getLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 0, 70, 50)];
            getLabel.backgroundColor = [UIColor clearColor];
            getLabel.tag = 113;
            getLabel.textAlignment = NSTextAlignmentCenter;
            getLabel.backgroundColor = [UIColor clearColor];
            getLabel.textColor = [UIColor redColor];
            getLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:getLabel];
            [getLabel release];
            //消耗积分
            
            UILabel *postLabel = [[UILabel alloc] initWithFrame:CGRectMake(229, 0, 70, 50)];
            postLabel.textColor = [SharedMethod getColorByHexString:@"13a3ff"];
            postLabel.backgroundColor = [UIColor clearColor];
            postLabel.tag = 114;
            postLabel.textAlignment = NSTextAlignmentCenter;
            postLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:postLabel];
            [postLabel release];
            
            //横线
            UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
            xian.tag = 105;
            [cell.contentView addSubview:xian];
            [xian release];
            
        }
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:111];
        UILabel *typeLabel = (UILabel *)[cell.contentView viewWithTag:112];
        
        
        MyPointMessage *point = nil;
        if(indexPath.row < self.winingList.zhongjiangArray.count)
        {
            point = [self.winingList.zhongjiangArray objectAtIndex:indexPath.row];
        }
        timeLabel.text = point.pointTime;
        typeLabel.text = point.pointType;
        
        if(![point.getPoint isEqualToString:@""])
        {
            UILabel *getLabel = (UILabel *)[cell.contentView viewWithTag:113];
            getLabel.text = point.getPoint;
            
        }
        else
        {
            UILabel *getLabel = (UILabel *)[cell.contentView viewWithTag:113];
            getLabel.text = nil;
        }
        
        
        if(![point.xiaohaoPoint isEqualToString:@""])
        {
            UILabel *postLabel = (UILabel *)[cell.contentView viewWithTag:114];
            postLabel.text = point.xiaohaoPoint;
        }
        else
        {
            UILabel *postLabel = (UILabel *)[cell.contentView viewWithTag:114];
            postLabel.text = nil;
        }
        
        
        for(int i = 0;i<5;i++)
        {
            UIImageView *xianImage = (UIImageView *)[cell.contentView viewWithTag:100+i];
            if(indexPath.row == self.winingList.zhongjiangArray.count)
                [xianImage setImage:nil];
            else
                [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
            
        }
        
        UIImageView *xian = (UIImageView *)[cell.contentView viewWithTag:105];
        [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
        
        
        return cell;
    }
    else if(tableView.tag == 202){
    
    
        if (indexPath.row == self.YHMInfoList.YHMInfoArray.count) {
            static NSString *CellIdentifier = @"Cell2";
            youhuimamoreCell = (MoreLoadCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!youhuimamoreCell) {
                youhuimamoreCell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                [youhuimamoreCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [youhuimamoreCell setInfoText:@"加载更多"];
            }
            
            youhuimamoreCell.backgroundColor = [UIColor clearColor];
            return youhuimamoreCell;
        }
        
        static NSString *youhuimaCell = @"cell";
        Point_YouHuiMaCell *cell = [tableView dequeueReusableCellWithIdentifier:youhuimaCell];
        if(!cell){
            cell = [[[Point_YouHuiMaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:youhuimaCell] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        YHMInfo *yhminfo = nil;
        if(indexPath.row < self.YHMInfoList.YHMInfoArray.count){
        
            yhminfo = [self.YHMInfoList.YHMInfoArray objectAtIndex:indexPath.row];
        }
        
        [cell LoadData:yhminfo.YHM_Type WithMes:yhminfo.YHM_mes andTime:yhminfo.YHM_time];
        
        
        UIImageView *cellXian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 84.5, 320, 0.5)];
        cellXian.backgroundColor = [SharedMethod getColorByHexString:@"cccccc"];
        [cell.contentView addSubview:cellXian];
        [cellXian release];
        
        
        return cell;
    }
    else if(tableView.tag == 201){
        
        if (indexPath.row == self.prizeInfoList.prizeArray.count) {
            static NSString *CellIdentifier = @"Cell1";
            jiangpinmoreCell = (MoreLoadCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!jiangpinmoreCell) {
                jiangpinmoreCell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                [jiangpinmoreCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [jiangpinmoreCell setInfoText:@"加载更多"];
            }
            
            jiangpinmoreCell.backgroundColor = [UIColor clearColor];
            return jiangpinmoreCell;
        }
        
        static NSString *jiangpinCell = @"cell1";
        Point_JiangPinCell *cell = [tableView dequeueReusableCellWithIdentifier:jiangpinCell];
        if(!cell){
            cell = [[[Point_JiangPinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jiangpinCell] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        PrizeInfo *prizeinfo =  nil;
        if(self.prizeInfoList.prizeArray.count){
        
            prizeinfo = [self.prizeInfoList.prizeArray objectAtIndex:indexPath.row];
        }

        
        [cell LoadData:prizeinfo.get_type prizeType:prizeinfo.prize_type numString:prizeinfo.prize_info_count unitString:prizeinfo.prize_info_count1 andKindsName:prizeinfo.prize_info_type andTime:prizeinfo.prize_time];

        
        UIImageView *cellXian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 62.5, 320, 0.5)];
        cellXian.backgroundColor = [SharedMethod getColorByHexString:@"cccccc"];
        [cell.contentView addSubview:cellXian];
        [cellXian release];
        
        
        return cell;
    }

    return nil;
}
#pragma mark UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 203){
        
        if(indexPath.row >= self.winingList.zhongjiangArray.count)
        {
            [moreCell spinnerStartAnimating];
            [self getMyPointListWithPage:(int)winingList.curPage+1];
        }
        
    }

    if(tableView.tag == 202){
    
        YHMInfo *yhminfo = nil;
        if(indexPath.row < self.YHMInfoList.YHMInfoArray.count){
            
            yhminfo = [self.YHMInfoList.YHMInfoArray objectAtIndex:indexPath.row];
            
            if([@"0" isEqualToString:yhminfo.YHM_Type]){
                
                GC_TopUpViewController *chongzhi = [[GC_TopUpViewController alloc] init];
                [self.navigationController pushViewController:chongzhi animated:YES];
                [chongzhi release];
            }
        }
        if(indexPath.row >= self.YHMInfoList.YHMInfoArray.count){
        
            [youhuimamoreCell spinnerStartAnimating];
            [self getMyYHMListWithPage:yhmNowPage+1];
        }

        
    }
    if(tableView.tag == 201){
        
        if(indexPath.row >= self.prizeInfoList.prizeArray.count){
            
            [jiangpinmoreCell spinnerStartAnimating];
            [self getMyPrizeWithPage:jpbPage+1];
        }
        
        
    }
}
#pragma mark Http Request
//优惠码
-(void)getMyYHMListWithPage:(int)page{

    yhmNowPage = page;
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetUserYHMListStatus:@"1" pageNum:page pageCount:10];
    
    [YHMRequest_ clearDelegatesAndCancel];
    
    self.YHMRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];;
    
    [YHMRequest_ setRequestMethod:@"POST"];
    [YHMRequest_ addCommHeaders];
    [YHMRequest_ setPostBody:postData];
    [YHMRequest_ setDefaultResponseEncoding:NSUTF8StringEncoding];
    [YHMRequest_ setDelegate:self];
    [YHMRequest_ setDidFinishSelector:@selector(reqUserYHMListFinished:)];
    [YHMRequest_ setDidFailSelector:@selector(reqUserYHMListFailed:)];
    [YHMRequest_ startAsynchronous];
}
-(void)reqUserYHMListFinished:(ASIHTTPRequest *)requests{

    if(![requests.responseString isEqualToString:@"fail"]){
        
        GC_YHMInfoParser *prizeinfo = [[GC_YHMInfoParser alloc] initWithResponseData:requests.responseData WithRequest:requests];
        if(prizeinfo.returnId != 3000){
            
            //prizeinfo.allCount == 0
            if(prizeinfo.allCount == 0){
                
                UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(320, 0, 320, myScrollView.frame.size.height)];
                viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
                
                // 480-800.png
                UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
                imageJia.frame=CGRectMake(60, 60, 200, 200);
                
                UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
                labelJia.text=@"您还没有优惠码";
                labelJia.textAlignment = NSTextAlignmentCenter;
                labelJia.backgroundColor=[UIColor clearColor];
                labelJia.font=[UIFont systemFontOfSize:20.0];
                labelJia.textColor=[UIColor grayColor];
                [viewJia addSubview:imageJia];
                [viewJia addSubview:labelJia];
                [myScrollView addSubview:viewJia];
                [viewJia release];
                [imageJia release];
                [labelJia release];
                
                myYouhuima.hidden = YES;
                xian2.hidden = YES;
                
                youhuimaTableView.hidden = YES;
            }
            else{
                
                myYouhuima.hidden = NO;
                xian2.hidden = NO;
            
                if (self.YHMInfoList) {
                    
                    if (prizeinfo.curCount > 0) {
                        [self.YHMInfoList.YHMInfoArray addObjectsFromArray:prizeinfo.YHMInfoArray];
                    }
                    if ([prizeinfo.YHMInfoArray count] < 10) {
                        [youhuimamoreCell setInfoText:@"加载完毕"];
                        [youhuimamoreCell setType:MSG_TYPE_LOAD_NODATA];
                    }
                }
                else {
                    
                    self.YHMInfoList = prizeinfo;
                }
                
                hadReqYHM = YES;

            }
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",(int)prizeinfo.allCount] forKey:@"MyYHMAllCount"];
            
            UIImageView *img = (UIImageView *)[self.mainView viewWithTag:500];
            if([img isKindOfClass:[UIImageView class]]){
            
                UIButton *btn = (UIButton *)[img viewWithTag:101];
                if([btn isKindOfClass:[UIButton class]]){
                
                    UILabel *label = (UILabel *)[btn viewWithTag:502];
                    if([label isKindOfClass:[UILabel class]]){
                    
                        label.text = [NSString stringWithFormat:@"%d",(int)prizeinfo.allCount];
                    }
                }
            }
            
            
        }
        [youhuimaTableView reloadData];

        [prizeinfo release];
    }
}
-(void)reqUserYHMListFailed:(ASIHTTPRequest *)requests{

    NSLog(@"reqUserYHMListFailed %@",requests.responseString);
    
    [[caiboAppDelegate getAppDelegate] showMessage:@"请检查您的网络后重试"];

}
//奖品包
-(void)getMyPrizeWithPage:(NSInteger)page{
    
    jpbPage = (int)page;

    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetMyPrizeMes:[[Info getInstance] userName] pageNum:page pageSize:10];
    [self.prizeRequest clearDelegatesAndCancel];
    
    self.prizeRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    //[req release];
    [prizeRequest_ setRequestMethod:@"POST"];
    [prizeRequest_ addCommHeaders];
    [prizeRequest_ setPostBody:postData];
    [prizeRequest_ setDefaultResponseEncoding:NSUTF8StringEncoding];
    [prizeRequest_ setDelegate:self];
    [prizeRequest_ setDidFinishSelector:@selector(reqMyPrizeFinished:)];
    [prizeRequest_ setDidFailSelector:@selector(reqMyPrizeFailed:)];
    [prizeRequest_ startAsynchronous];

}
- (void)reqMyPrizeFinished:(ASIHTTPRequest*)request{

    if(![request.responseString isEqualToString:@"fail"]){
    
        GC_MyPrizeInfo *prizeinfo = [[GC_MyPrizeInfo alloc] initWithResponseData:request.responseData WithRequest:request];
        if(prizeinfo.returnId != 3000){
            //prizeinfo.prizeCount == 0
            if(prizeinfo.prizeCount == 0){
            
                UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, myScrollView.frame.size.height)];
                viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
                
                // 480-800.png
                UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
                imageJia.frame=CGRectMake(60, 60, 200, 200);
                
                UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
                labelJia.text=@"您还没有奖品";
                labelJia.textAlignment = NSTextAlignmentCenter;
                labelJia.backgroundColor=[UIColor clearColor];
                labelJia.font=[UIFont systemFontOfSize:20.0];
                labelJia.textColor=[UIColor grayColor];
                [viewJia addSubview:imageJia];
                [viewJia addSubview:labelJia];
                [myScrollView addSubview:viewJia];
                [viewJia release];
                [imageJia release];
                [labelJia release];
                
                myJiangpin.hidden = YES;
                myJiangpinXian.hidden = YES;
                
                jiangpinTableView.hidden = YES;
                
            }
            else{
            
                myJiangpin.hidden = NO;
                myJiangpinXian.hidden = NO;
                
                if (self.prizeInfoList) {
                    
                    if (prizeinfo.pageCount > 0) {
                        [self.prizeInfoList.prizeArray addObjectsFromArray:prizeinfo.prizeArray];
                    }
                    if ([prizeinfo.prizeArray count] < 10) {
                        [jiangpinmoreCell setInfoText:@"加载完毕"];
                        [jiangpinmoreCell setType:MSG_TYPE_LOAD_NODATA];
                    }
                }
                else {
                    
                    self.prizeInfoList = prizeinfo;
                }
                
                hadReqJPB = YES;
            }
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",(int)prizeinfo.prizeCount] forKey:@"MyPrizeAllCount"];

            
            UIImageView *img = (UIImageView *)[self.mainView viewWithTag:500];
            if([img isKindOfClass:[UIImageView class]]){
                
                UIButton *btn = (UIButton *)[img viewWithTag:100];
                if([btn isKindOfClass:[UIButton class]]){
                    
                    UILabel *label = (UILabel *)[btn viewWithTag:501];
                    if([label isKindOfClass:[UILabel class]]){
                        
                        label.text = [NSString stringWithFormat:@"%d",(int)prizeinfo.prizeCount];
                    }
                }
            }
            

        
        }
        
        [jiangpinTableView reloadData];
        
        [prizeinfo release];
    }
}
- (void)reqMyPrizeFailed:(ASIHTTPRequest*)request{

    NSLog(@"reqMyPrizeFailed %@",request.responseString);
    
    [[caiboAppDelegate getAppDelegate] showMessage:@"请检查您的网络后重试"];

}

//获取我的积分列表
-(void)getMyPointListWithPage:(int)page
{
    nowPage = page;
    
    [moreCell spinnerStartAnimating];
    NSMutableData *postData = [[GC_HttpService sharedInstance] pointMessageWithUserID:[[Info getInstance] userName] andcurPage:page pageCount:20];
    [self.myRequest clearDelegatesAndCancel];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    self.myRequest = req;
    //[req release];
    [myRequest_ setRequestMethod:@"POST"];
    [myRequest_ addCommHeaders];
    [myRequest_ setPostBody:postData];
    [myRequest_ setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest_ setDelegate:self];
    [myRequest_ setDidFinishSelector:@selector(requestPointListFinished:)];
    [myRequest_ startAsynchronous];
    
}
// 我的积分详情名单
#pragma mark 积分详情 Request Finished
- (void)requestPointListFinished:(ASIHTTPRequest*)request
{
    NSLog(@"积分详情: %@",request.responseString);
    [moreCell spinnerStopAnimating];

    if(![request.responseString isEqualToString:@"fail"]){
    
    GC_WinningInfoList *jiexi = [[GC_WinningInfoList alloc] initWithResponseData:request.responseData WithRequest:request andlistType:MYPOINT_MES_TYPE];
    if (jiexi.returnId != 3000) {
        
        //jiexi.zhongjiangArray.count
        if(jiexi.zhongjiangArray.count==0){
        
            UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(640, 0, 320, myScrollView.frame.size.height)];
            viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
            
            // 480-800.png
            UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
            imageJia.frame=CGRectMake(60, 60, 200, 200);
            
            UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
            labelJia.text=@"最近三个月无相关记录";
            labelJia.textAlignment = NSTextAlignmentCenter;
            labelJia.backgroundColor=[UIColor clearColor];
            labelJia.font=[UIFont systemFontOfSize:20.0];
            labelJia.textColor=[UIColor grayColor];
            [viewJia addSubview:imageJia];
            [viewJia addSubview:labelJia];
            [myScrollView addSubview:viewJia];
            [viewJia release];
            [imageJia release];
            [labelJia release];
            
            huode.hidden = YES;
            xiaohao.hidden = YES;
            
            myTableView.hidden = YES;
        }
        else{
            
            huode.hidden = NO;
            xiaohao.hidden = NO;
            
            if(![jiexi.mouthHuoDePoint isEqualToString:@"(null)"] && jiexi.mouthHuoDePoint != nil && jiexi.mouthHuoDePoint.length !=0)
            {
                huode.text = [NSString stringWithFormat:@"近一个月获得积分  <%@>",jiexi.mouthHuoDePoint];
            }
            if(![jiexi.mouthXiaoHaoPoint isEqualToString:@"(null)"] && jiexi.mouthXiaoHaoPoint != nil && jiexi.mouthXiaoHaoPoint.length != 0)
            {
                xiaohao.text = [NSString stringWithFormat:@"近一个月消耗积分  <%@>",jiexi.mouthXiaoHaoPoint];
            }
            
            if (self.winingList) {
                if (jiexi.curCount > 0 && nowPage > self.winingList.curPage) {
                    self.winingList.curPage = nowPage;
                    [self.winingList.zhongjiangArray addObjectsFromArray:jiexi.zhongjiangArray];
                }
                if ([jiexi.zhongjiangArray count] < 20) {
                    [moreCell setInfoText:@"加载完毕"];
                    [moreCell setType:MSG_TYPE_LOAD_NODATA];
                }
            }
            else {
                self.winingList = jiexi;
            }
            
        }

    }
    [myTableView reloadData];
    [jiexi release];
    }
    
}


#pragma mark UIScrollView Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if(scrollView.tag == 203){
    
        if (myTableView.contentSize.height-scrollView.contentOffset.y<=360) {
            if (moreCell && moreCell.type != MSG_TYPE_LOAD_NODATA) {
                [moreCell spinnerStartAnimating];
                [self getMyPointListWithPage:(int)winingList.curPage+1];
            }
        }
        //[self getMyPointListWithPage:(int)winingList.curPage+1];
    }
    if(scrollView.tag == 202){
    
        if (youhuimaTableView.contentSize.height-scrollView.contentOffset.y<=360) {
            if (youhuimamoreCell && youhuimamoreCell.type != MSG_TYPE_LOAD_NODATA) {
                [youhuimamoreCell spinnerStartAnimating];
                [self getMyYHMListWithPage:yhmNowPage+1];
            }
        }
    }
    if(scrollView.tag == 201){
        
        if (jiangpinTableView.contentSize.height-scrollView.contentOffset.y<=360) {
            if (jiangpinmoreCell && moreCell.type != MSG_TYPE_LOAD_NODATA) {
                [jiangpinmoreCell spinnerStartAnimating];
                [self getMyPrizeWithPage:jpbPage+1];
            }
        }
    }

    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    NSLog(@"%f",scrollView.contentOffset.x);
    
    if(scrollView.tag == 400){
        
        if(scrollView.contentOffset.x == 0){
            
            qiehuan.frame = CGRectMake(0, 53, 106, 9);
            
            if(!hadReqJPB){
                [self getMyPrizeWithPage:1];

            }
            
        }else if(scrollView.contentOffset.x/320.0 == 1){
            
            qiehuan.frame = CGRectMake(107, 53, 106, 9);
            
            if(!hadReqYHM){
                [self getMyYHMListWithPage:1];

            }

            
        }else if(scrollView.contentOffset.x/320.0 == 2){
            
            qiehuan.frame = CGRectMake(214, 53, 106, 9);
        }
        
    }

}
-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc
{
    [myRequest_ clearDelegatesAndCancel];
    self.myRequest = nil;
    [prizeRequest_ clearDelegatesAndCancel];
    self.prizeRequest = nil;
    [YHMRequest_ clearDelegatesAndCancel];
    self.YHMRequest = nil;
    [super dealloc];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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