//
//  AboutOurViewController.m
//  caibo
//
//  Created by  on 12-5-13.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "AboutOurViewController.h"
#import "Info.h"
#import "YijianViewController.h"
#import "AboutOurInfoController.h"
#import "caiboAppDelegate.h"
//视频
#import "GC_BaFangShiPingViewController.h"
#import "Info.h"
#import "MobClick.h"
#import "ColorView.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "DetailedViewController.h"
#import "CPSetViewController.h"
#import "JSON.h"

#define MAP_URL @"http://map.sogou.com/m/webapp/m.html?c=12966607,4839284,15&uids=1_12001511684&page=1,10"

#define GuangWang_URl @"http://www.caipiao365.com"
#define zucaiWang_URL @"http://www.zgzcw.com"
@implementation AboutOurViewController
@synthesize httprequest;
@synthesize httpRequest;
@synthesize urlVersion;

- (void)dealloc
{
    [httprequest clearDelegatesAndCancel];
    [httpRequest clearDelegatesAndCancel];
    [super dealloc];
}

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

- (void)LoadiPhoneView {
    self.CP_navigation.title = @"关于我们";
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    self.mainView.backgroundColor = [UIColor colorWithRed:244/255.0 green:240/255.0 blue:231/255.0 alpha:1];
    
    
//    UIButton  *exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [exitLoginButton setBounds:CGRectMake(0, 0, 70, 40)];
//    [exitLoginButton addTarget:self action:@selector(setup) forControlEvents:UIControlEventTouchUpInside];
    
  
    //右侧按钮
//    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20.5, 20.5)];
//    imagevi.backgroundColor = [UIColor clearColor];
//    imagevi.image = [UIImageGetImageFromName(@"guanyushezhi.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
//    [exitLoginButton addSubview:imagevi];//TXWZBG960
//    [imagevi release];
//    
//    UILabel *beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(27.5, 10, 30, 20.5)];
//    beginLabel.backgroundColor = [UIColor clearColor];
//    beginLabel.textColor = [UIColor whiteColor];
//    beginLabel.text = @"设置";
//    beginLabel.font = [UIFont systemFontOfSize:15];
//    beginLabel.textAlignment = NSTextAlignmentCenter;
//    
//    [exitLoginButton addSubview:beginLabel];
//    [beginLabel release];
//    
   
    
    
    
//    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:exitLoginButton];
//    self.CP_navigation.rightBarButtonItem = barBtnItem;
//    [barBtnItem release];
    
    
    
    UIScrollView * mainScrollView = [[[UIScrollView alloc] initWithFrame:self.mainView.bounds] autorelease];
    [self.mainView addSubview:mainScrollView];
    mainScrollView.backgroundColor = [UIColor clearColor];
    
//    UIImageView * logoImageView = [[[UIImageView alloc] initWithFrame:CGRectMake((320-133.5)/2, 30, 133.5, 120)] autorelease];
    UIImageView * logoImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(((320 - 174.5 - 63.5)/2) + 63.5, 33.5, 174.5, 154)] autorelease];
    [mainScrollView addSubview:logoImageView];
    logoImageView.image = UIImageGetImageFromName(@"AboutUs_logo.png");
    

    
    
//    UILabel * mainTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(127, 163, 70, 15)] autorelease];
//    mainTitleLabel.text = @"身边的投注站";
//    mainTitleLabel.textColor = [UIColor colorWithRed:34/255.0 green:23/255.0 blue:20/255.0 alpha:1];
//    mainTitleLabel.font = [UIFont systemFontOfSize:11];
//    mainTitleLabel.backgroundColor = [UIColor clearColor];
//    [mainScrollView addSubview:mainTitleLabel];
    
    
    
    
    
    
    NSDictionary * infoDict = [[NSBundle mainBundle] infoDictionary];

    ColorView * versionLabel = [[[ColorView alloc] initWithFrame:CGRectMake(110, 163+6, 100, 25)] autorelease];
    versionLabel.text = [NSString stringWithFormat:@"版本号 <V%@>", [infoDict objectForKey:@"CFBundleVersion"]];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.font = [UIFont systemFontOfSize:15];
    versionLabel.colorfont = [UIFont systemFontOfSize:15];
    versionLabel.changeColor = [UIColor colorWithRed:106/255.0 green:105/255.0 blue:102/255.0 alpha:1];
    [mainScrollView addSubview:versionLabel];

    ColorView * channelLabel = [[[ColorView alloc] initWithFrame:CGRectMake(85, 188+10, 200, 25)] autorelease];
    channelLabel.text = [NSString stringWithFormat:@"渠道号 <%@>", [infoDict objectForKey:@"SID"]];
    channelLabel.backgroundColor = [UIColor clearColor];
    channelLabel.font = [UIFont systemFontOfSize:15];
    channelLabel.colorfont = [UIFont systemFontOfSize:15];
    channelLabel.textColor =    [UIColor colorWithRed:201/255.0 green:205/255.0 blue:198/255.0 alpha:1];
    channelLabel.changeColor = [UIColor colorWithRed:201/255.0 green:205/255.0 blue:198/255.0 alpha:1];
    [mainScrollView addSubview:channelLabel];
    
    UIImageView * synopsisBGImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 223+6, 320, 456-30)] autorelease];
    // synopsisBGImageView.image = [UIImageGetImageFromName(@"wenzibeijing.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    synopsisBGImageView.backgroundColor = [UIColor whiteColor];
    synopsisBGImageView.userInteractionEnabled = YES;//wenziBG.png
    [mainScrollView addSubview:synopsisBGImageView];
    
    UITextView * detailLabel = [[[UITextView alloc] initWithFrame:CGRectMake(10, 45, 280, 164)] autorelease];
    detailLabel.userInteractionEnabled  = NO;
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
#ifdef isHaoLeCai
    detailLabel.frame = CGRectMake(10, 45, 280, 330);
    detailLabel.text = @"       好乐彩，是北京鲜柚科技有限公司与第一视频集团旗下投注站联合推出的一款极致彩票软件。软件依托第一视频集团资源优势，融合视频直播、比分直播、八方预测、手机购彩及微博互动等功能，是国内首款综合型手机彩票工具。\n       第一视频集团（0082.HK）是国有控股上市公司，是目前国内拥有资质和许可证最为齐全的新媒体产业集团，主要业务覆盖互联网和移动终端，经营第一视频网、彩票、手机游戏等业务。彩票产品包含“投注站”、“中国足彩网”和“第一彩”，覆盖中国福利彩票和体育彩票上亿用户，是目前国内最具影响力的彩票服务提供商。";
#else
//    detailLabel.text = @"       投注站是国内首个下载突破5000万的手机彩票应用。由直属于民政部中国社工协会，业内唯一国有控股上市公司第一视频集团(0082.HK)运营。作为中国唯一融合手机视频直播，足球比分直播，独家八方预测，全国彩票开奖及安全手机购彩等功能于一体的手机客户端产品。";
//    detailLabel.text = @"       投注站是国内首个下载突破5000万的手机彩票应用。是业内唯一国有控股上市公司第一视频集团(0082.HK)运营。作为中国唯一融合手机视频直播，足球比分直播，独家八方预测，全国彩票开奖及安全手机购彩等功能于一体的手机客户端产品。";
    detailLabel.text = @"       投注站，是国内首个下载突破1亿的手机彩票应用，是中国移动互联网彩票第一巨奖诞生地，目前已累计诞生8个500万大奖，25个百万大奖，是各大苹果和安卓应用市场排名第一的彩票APP。";
#endif
    detailLabel.font = [UIFont systemFontOfSize:15];
    [synopsisBGImageView addSubview:detailLabel];
    
#ifdef isHaoLeCai
    synopsisBGImageView.frame = CGRectMake(0, 223, 320, 475);
    NSArray * titleArray = @[@"客服电话",@"官方网站"];
    NSArray * detailArray = @[@"QQ：3254056760",@"www.caipiao365.com"];
    
    
    for (int i = 0; i < 2; i++) {
            UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 135 + i * 50, 310, 0.5)];
            lineImageView.image = UIImageGetImageFromName(@"AboutUs_line.png");
            [synopsisBGImageView addSubview:lineImageView];
            [lineImageView release];

            if (i == 0) {
                lineImageView.frame = CGRectMake(0, ORIGIN_Y(detailLabel) + 9, 310, 0.5);
            }
            if (i == 1) {
                lineImageView.frame = CGRectMake(0, ORIGIN_Y(detailLabel) + 54, 310, 0.5);
            }
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150 + 50*i, 55, 18)];
        if (i == 0) {
            titleLabel.frame=CGRectMake(10, ORIGIN_Y(lineImageView) + 10,75 , 20);
        }
        if (i == 1) {
            titleLabel.frame=CGRectMake(10, ORIGIN_Y(lineImageView) + 10,75 , 20);
        }
        titleLabel.text = [titleArray objectAtIndex:i];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.backgroundColor = [UIColor clearColor];
        [synopsisBGImageView addSubview:titleLabel];
        [titleLabel release];
        
        
        
        
        
        
        UILabel * detailLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(124, titleLabel.frame.origin.y - 8, 155, 35)];

        detailLabel1.backgroundColor = [UIColor clearColor];
        detailLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        if (i==0) {
            
            detailLabel1.textColor = [UIColor colorWithRed:0/255.0 green:118/255.0 blue:228/255.0 alpha:1];
            detailLabel1.font = [UIFont systemFontOfSize:17];
        }
        else if(i==1)
        {
            detailLabel1.textColor=[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            detailLabel1.font = [UIFont systemFontOfSize:15];
        }

        detailLabel1.numberOfLines = 0;
        detailLabel1.lineBreakMode = 0;
        detailLabel1.text = [detailArray objectAtIndex:i];
        [synopsisBGImageView addSubview:detailLabel1];
        [detailLabel1 release];
    }

   
    
    
    //客服电话
    UIButton *kefuButton=[[UIButton alloc]initWithFrame:CGRectMake(0, ORIGIN_Y(detailLabel) + 1, 300, 53)];
    kefuButton.backgroundColor=[UIColor clearColor];
    [synopsisBGImageView addSubview:kefuButton];
    [kefuButton addTarget:self action:@selector(kefuDianhua) forControlEvents:UIControlEventTouchUpInside];
    [kefuButton release];
#else
    NSArray * titleArray = @[@"客服电话",@"官方网站",@"新浪微博",@"中国足彩网",@"公司地址"];
    NSArray * detailArray = @[@"QQ：3254056760",@"www.caipiao365.com",@"@投注站",@"www.zgzcw.com",@"北京市朝阳区望京东路8号锐创国际中心1号楼16-18层"];
    
   
    
    
    for (int i = 0; i < 5; i++) {
        if (i != 2 && i != 3) {
            UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 135 + i * 50, 300, 0.5)];
            lineImageView.image = UIImageGetImageFromName(@"AboutUs_line.png");
            [synopsisBGImageView addSubview:lineImageView];
            [lineImageView release];
            if (i == 4) {
                lineImageView.frame = CGRectMake(10, 381-30, 300, 0.5);
            }
            
            if (i == 0) {
                 lineImageView.frame = CGRectMake(10, 206-30, 300, 0.5);
            }
            if (i == 1) {
                lineImageView.frame = CGRectMake(10, 279-30, 300, 0.5);
            }
        }
        
        
        
        
        UIImageView *lineImageView1 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 320, 0.5)] autorelease];
        lineImageView1.image = UIImageGetImageFromName(@"AboutUs_line.png");
        [synopsisBGImageView addSubview:lineImageView1];
        
        UIImageView *lineImageView2 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, synopsisBGImageView.frame.size.height , 320, 0.5)] autorelease];
        lineImageView2.image = UIImageGetImageFromName(@"AboutUs_line.png");
        [synopsisBGImageView addSubview:lineImageView2];
        
        
        
        
     
        
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150 + 50*i, 55, 18)];
        if (i == 0) {
            titleLabel.frame=CGRectMake(10, 236-30,75 , 20);
        }
        if (i == 1) {
            titleLabel.frame=CGRectMake(10, 292-30,75 , 20);
        }
        if ( i == 2) {
             titleLabel.frame=CGRectMake(10, 321-30,75 , 18);
        }
        if (i==3) {
            titleLabel.frame=CGRectMake(10, 350-30,80 , 18);
        }
        
        if ( i == 4) {
            titleLabel.frame=CGRectMake(10, 393-30, 75, 18);
        }
        titleLabel.text = [titleArray objectAtIndex:i];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.backgroundColor = [UIColor clearColor];
        [synopsisBGImageView addSubview:titleLabel];
        [titleLabel release];
        
        UILabel * detailLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(124, titleLabel.frame.origin.y - 8, 155, 35)];
        
        
        
        
        detailLabel1.backgroundColor = [UIColor clearColor];
        detailLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        if (i==0) {
            
                detailLabel1.textColor = [UIColor colorWithRed:0/255.0 green:118/255.0 blue:228/255.0 alpha:1];
            detailLabel1.font = [UIFont systemFontOfSize:17];
        }
        else if(i==1)
        {
            detailLabel1.textColor=[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            detailLabel1.font = [UIFont systemFontOfSize:15];
        }
        else if (i==3)
        {
            detailLabel1.textColor=[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            detailLabel1.font = [UIFont systemFontOfSize:15];
        }
        else if (i == 4) {
            detailLabel1.textColor = [UIColor colorWithRed:0/255.0 green:118/255.0 blue:228/255.0 alpha:1];
            detailLabel1.font = [UIFont systemFontOfSize:15];
            
            detailLabel1.frame = CGRectMake(124, titleLabel.frame.origin.y - 14, 155, 80);
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(183,431-30, 9, 12.5)];
            imageView.image = UIImageGetImageFromName(@"mapTuBiao.png");
            [synopsisBGImageView addSubview:imageView];
            [imageView release];
        }
        
        
        
        detailLabel1.numberOfLines = 0;
        detailLabel1.lineBreakMode = 0;
        detailLabel1.text = [detailArray objectAtIndex:i];
        [synopsisBGImageView addSubview:detailLabel1];
        [detailLabel1 release];
    }
    //客服电话
    UIButton *kefuButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 210-30, 300, 53)];
    kefuButton.backgroundColor=[UIColor clearColor];
    [synopsisBGImageView addSubview:kefuButton];
    [kefuButton addTarget:self action:@selector(kefuDianhua) forControlEvents:UIControlEventTouchUpInside];
    [kefuButton release];
    
    //官网
    UIButton *guanWangButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 287-30, 300, 30)];
    guanWangButton.backgroundColor=[UIColor clearColor];
    [synopsisBGImageView addSubview:guanWangButton];
    [guanWangButton addTarget:self action:@selector(toGuanWang) forControlEvents:UIControlEventTouchUpInside];
    [guanWangButton release];
    
    //足彩网
    UIButton *zuicaiWang=[[UIButton alloc]initWithFrame:CGRectMake(0, 345-30, 300, 30)];
    zuicaiWang.backgroundColor=[UIColor clearColor];
    [synopsisBGImageView addSubview:zuicaiWang];
    [zuicaiWang addTarget:self action:@selector(zucaiWang) forControlEvents:UIControlEventTouchUpInside];
    [zuicaiWang release];
    
    
    //地图
    UIButton * mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 381-30, 300, 73)];
    mapButton.backgroundColor = [UIColor clearColor];
    [synopsisBGImageView addSubview:mapButton];
    [mapButton addTarget:self action:@selector(toMap) forControlEvents:UIControlEventTouchUpInside];
    [mapButton release];
#endif
    
    
    UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 17)] autorelease];
#ifdef isHaoLeCai
    titleLabel.text = @"好乐彩简介";
#else
    titleLabel.text = @"投注站简介";
#endif
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [synopsisBGImageView addSubview:titleLabel];
    
#ifndef isHaoLeCai
    UIImageView * mapImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(8.5, 705+10-30, 303, 147)] autorelease];
    mapImageView.image = UIImageGetImageFromName(@"AboutUs_map.png");
    [mainScrollView addSubview:mapImageView];
    mapImageView.userInteractionEnabled = YES;
    
    UIImageView * eventsTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 878.5-30, 67.5, 23)] autorelease];
    eventsTitleImageView.image = UIImageGetImageFromName(@"AboutUs_events.png");
    [mainScrollView addSubview:eventsTitleImageView];
    
    UILabel * eventsTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(7, 0, 63.5, 23)] autorelease];
    eventsTitleLabel.text = @"大事记";
    eventsTitleLabel.backgroundColor = [UIColor clearColor];
    eventsTitleLabel.textColor = [UIColor whiteColor];
    eventsTitleLabel.font = [UIFont systemFontOfSize:15];
    [eventsTitleImageView addSubview:eventsTitleLabel];
//    2014年7月，投注站获评“2014年度最佳彩票APP”  ID:74788526
//    2014年6月，投注站第八个500万大奖诞生   ID:74788332
//    2014年5月，投注站下载用户突破5000万   ID:74788309
//    2014年5月，投注站联合易方达基金推出互联网理财产品  ID:74788324
//    2014年4月，投注站赞助北京国安足球俱乐部  ID:74788072
//    2014年8月，“ 投注站&北京国安”公益活动走进中国互联网大会 ID:75069843
//2014年8月，  投注站荣获中国互联网20年最具价值产品大奖   ID:75069965 

    // 二维数组
    NSArray * eventsArray = @[
  @[@"2014-12",@"投注站牵手宜信投米 开启“0”元购彩时代",@"77761572"],
  @[@"2014-12",@"投注站荣膺年度最佳彩票娱乐应用",@"77761297"],
  @[@"2014-11",@"投注站下载用户数突破1亿",@"77761041"],
  @[@"2014-11",@"投注站 CEO彭锡涛应邀出席APEC工商管理人峰会",@"77760955"],
  @[@"2014-10",@"投注站获评“中国好应用”，率先入驻4G入口",@"77760496"],
  @[@"2014-8",@"“投注站&北京国安”中国互联网大会公益行",@"75069843"],
  @[@"2014-8",@"投注站获评中国互联网20年最具价值产品",@"75069965"],
  @[@"2014-7",@"投注站获评“2014年度最佳彩票APP”",@"74788526"],
  @[@"2014-6",@"投注站第八个500万大奖诞生",@"74788332"],
  @[@"2014-5",@"投注站下载用户突破5000万",@"74788309"],
  @[@"2014-5",@"投注站联合易方达基金推出互联网理财产品”",@"74788324"],
  @[@"2014-4",@"投注站赞助北京国安足球俱乐部”",@"74788072"],
  @[@"2013-12",@"诞生中国手机彩票第一巨奖",@"49914921"],
  @[@"2013-12",@"投注站当选中国影响力品牌",@"49914626"],
  @[@"2013-11",@"投注站下载用户超过3000万",@"49914525"],
  @[@"2013-11",@"荣获91无线年度热门应用TOP100",@"49914347"],
  @[@"2013-11",@"诞生超级大乐透522万元大奖",@"49914176"],
  @[@"2013-8",@"荣获中国互联网生活创想之星",@"49914030"],
  @[@"2013-6",@"收购河北体彩电话/互联网购彩",@"49913747"],
  @[@"2013-6",@"投注站下载用户突破1000万",@"49913590"],
  @[@"2013-4",@"投注站赞助中超辽宁足球队",@"49913415"],
  @[@"2013-3",@"诞生528万足彩大奖",@"49913311"],
  @[@"2013-1",@"投注站获中国十大服务创新奖",@"49913154"],
  @[@"2012-9",@"工信部部长苗圩参观投注站",@"49913051"],
  @[@"2012-6",@"投注站手机客户端正式发布",@"49912902"],
  @[@"2011-11",@"收购青海体彩电话/互联网购彩",@"49912732"],
  @[@"2010-12",@"斥资1亿收购“中国足彩网”",@"49912533"],
  @[@"2010-7",@"收购黑龙江省福彩无纸化平台",@"49912311"]
  ];
    
    float originY = 48;
    float contentSizeHeight = 0;
    
    for (int i = 0; i < eventsArray.count; i++) {
        UIView * eventsView = [[UIView alloc] init];
        eventsView.backgroundColor = [UIColor clearColor];
        [mainScrollView addSubview:eventsView];
        
        UILabel * eventsTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 100, 13)];
        eventsTimeLabel.textColor = [UIColor colorWithRed:112/255.0 green:112/255.0 blue:112/255.0 alpha:1];
        eventsTimeLabel.font = [UIFont systemFontOfSize:12];
        eventsTimeLabel.backgroundColor = [UIColor clearColor];
        eventsTimeLabel.text = [[eventsArray objectAtIndex:i] objectAtIndex:0];
        [eventsView addSubview:eventsTimeLabel];
        [eventsTimeLabel release];
        
        UILabel * eventsContentLabel = [[UILabel alloc] init];
        eventsContentLabel.textColor = [UIColor colorWithRed:0/255.0 green:118/255.0 blue:228/255.0 alpha:1];
        eventsContentLabel.font = [UIFont systemFontOfSize:14];
        eventsContentLabel.backgroundColor = [UIColor clearColor];
        eventsContentLabel.lineBreakMode = 0;
        eventsContentLabel.numberOfLines = 0;
        eventsContentLabel.text = [[eventsArray objectAtIndex:i] objectAtIndex:1];
        [eventsView addSubview:eventsContentLabel];
        CGSize eventsContentSize = [eventsContentLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(266.5,2000) lineBreakMode:NSLineBreakByWordWrapping];
        eventsContentLabel.frame = CGRectMake(0, 36, 266.5, eventsContentSize.height);
        [eventsContentLabel release];
        
//        float height = eventsContentLabel.frame.origin.y + eventsContentLabel.frame.size.height + 5;
        eventsView.frame = CGRectMake(19,  860+ 72 * i + originY-30, 284.5, 72);
        eventsView.backgroundColor = [UIColor clearColor];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(270, eventsContentLabel.frame.origin.y, 12, eventsContentSize.height)];
        label.text = @">";
        label.textColor = [UIColor colorWithRed:0/255.0 green:118/255.0 blue:228/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        [eventsView addSubview:label];
        [label release];
        
        [eventsView release];
//        
//        if (height != originY) {
//            originY = height;
//        }
//        
        UIButton * button = [[UIButton alloc] initWithFrame:eventsView.bounds];
        button.backgroundColor = [UIColor clearColor];
        button.tag = [[eventsArray objectAtIndex:i] objectAtIndex:2];
        [button addTarget:self action:@selector(toWeiBo:) forControlEvents:UIControlEventTouchUpInside];
        [eventsView addSubview:button];
        [button release];
        
        UIImageView * circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(eventsTimeLabel.frame.origin.x - 8, eventsTimeLabel.frame.origin.y + 3, 5.5, 5.5)];
        circleImageView.image = UIImageGetImageFromName(@"AboutUs_circle.png");
        [eventsView addSubview:circleImageView];
        [circleImageView release];
        
        UIImageView * lineImageView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"AboutUs_line1.png")];
        if (i != eventsArray.count - 1) {
            UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, eventsView.frame.size.height - 0.5, eventsView.frame.size.width, 0.5)];
            line.image = UIImageGetImageFromName(@"AboutUs_line.png");
            [eventsView addSubview:line];
            [line release];
            
            lineImageView.frame = CGRectMake(circleImageView.frame.origin.x + 2.75, circleImageView.frame.origin.y + circleImageView.frame.size.height + 2, 0.5, 62);
        }else{
            lineImageView.frame = CGRectMake(circleImageView.frame.origin.x + 2.75, circleImageView.frame.origin.y + circleImageView.frame.size.height + 2, 0.5, 45);
            contentSizeHeight = eventsView.frame.origin.y + eventsView.frame.size.height + 45;
        }
        [eventsView addSubview:lineImageView];
        [lineImageView release];
    }
    mainScrollView.contentSize = CGSizeMake(320, contentSizeHeight+60);
#endif
    //新加更新按钮------------------------------
//    UIButton *gengxin=[[UIButton alloc] initWithFrame:CGRectMake(203, 158+6, 70.5, 21)];
//    gengxin.backgroundColor=[UIColor clearColor];
//    
//    UIImageView * buttonbg = [[UIImageView alloc] initWithFrame:gengxin.bounds];
//    buttonbg.backgroundColor = [UIColor clearColor];
//    buttonbg.image = UIImageGetImageFromName(@"gengxin.png");
//    [gengxin addSubview:buttonbg];
//    [buttonbg release];
//    
//    UILabel *gengxinLabel=[[UILabel alloc]initWithFrame:CGRectMake(9, 0, 80, 21)];
//    gengxinLabel.text=@"查看更新";
//    gengxinLabel.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    gengxinLabel.backgroundColor=[UIColor clearColor];
//   
//    gengxinLabel.font=[UIFont systemFontOfSize:14];
//    [gengxin setImage:[UIImage imageNamed:@"gengxin.png"] forState:UIControlStateNormal];
//    [gengxin addSubview:gengxinLabel];
//    [gengxinLabel release];
//    [gengxin addTarget:self action:@selector(gengxin) forControlEvents:UIControlEventTouchUpInside];
//    [mainScrollView addSubview:gengxin];
//    [gengxin release];
    
    
    
    
//    UIView *viewDown=[[UIView alloc]initWithFrame:CGRectMake(10, self.mainView.frame.size.height-41, 300, 40)];
#ifdef isHaoLeCai
    UIButton *buttonDown=[[UIButton alloc]initWithFrame:CGRectMake(10, ORIGIN_Y(synopsisBGImageView) + 15, 300, 40)];
    mainScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(buttonDown)+15);
#else
    UIButton *buttonDown=[[UIButton alloc]initWithFrame:CGRectMake(10, contentSizeHeight, 300, 40)];
   // [viewDown addSubview:buttonDown];
#endif
    [buttonDown addTarget:self action:@selector(pingfen) forControlEvents:UIControlEventTouchUpInside];
    UILabel *labelDown=[[UILabel alloc]initWithFrame:CGRectMake(buttonDown.frame.size.width/2-15, 10, 50, 20)];
    labelDown.backgroundColor=[UIColor clearColor];
    labelDown.text=@"评分";
    labelDown.textColor=[UIColor whiteColor];
    [buttonDown addSubview:labelDown];
    [buttonDown setImage:[UIImage imageNamed:@"pingfen.png"] forState:UIControlStateNormal];
    [buttonDown setImage:[UIImage imageNamed:@"pingfen2.png"] forState:UIControlStateHighlighted];
    
    [mainScrollView addSubview:buttonDown];
//    [viewDown release];
    [buttonDown release];
    [labelDown release];
    
    
    
}

//新加方法

////设置
//-(void)setup
//{
//        CPSetViewController * cpset = [[CPSetViewController alloc] init];
//        [self.navigationController pushViewController:cpset animated:YES];
//       [cpset release];
//}
-(void)gengxin
{
    
     [self sendVersionCheck];

}

//客服电话
-(void)kefuDianhua
{
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
    [actionSheet showInView:self.mainView];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
    }
    [actionSheet release];

}

//评分
-(void)pingfen
{
    [MobClick event:@"event_about_pingfen"];
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",caipiaoAppleID];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",caipiaoAppleID];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}
//搜狗地图
-(void)toMap
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MAP_URL]];
}

//官网
-(void)toGuanWang
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:GuangWang_URl]];
}
//足彩网
-(void)zucaiWang
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:zucaiWang_URL]];
}
-(void)toWeiBo:(UIButton *)button

{
    NSDictionary *dic =  [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Weibo.plist" ofType:nil]];
    
    NSString *result = [dic valueForKey:button.tag];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];
    [detailed setHidesBottomBarWhenPushed:NO];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    
    [mStatus release];
//    [httprequest clearDelegatesAndCancel];
//    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:button.tag]];
//    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [httprequest setDelegate:self];
//    [httprequest setDidFinishSelector:@selector(requestFinish:)];
//    [httprequest setTimeOutSeconds:20.0];
//    [httprequest startAsynchronous];
}

-(void)requestFinish:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];
    [detailed setHidesBottomBarWhenPushed:NO];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    
    [mStatus release];
}

- (void)sendVersionCheck {
    

    [httpRequest setDidFinishSelector:@selector(reqCheckFinished:)];
    
    [self.httpRequest clearDelegatesAndCancel];
    
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL checkUpDateFunc]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(reqCheckFinished:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
}

- (void)reqCheckFinished:(ASIHTTPRequest *)request {
    NSString *responseStr = [request responseString];
    
    NSLog(@"responsestr = %@", responseStr);
    NSDictionary * dict = [responseStr JSONValue];
    NSString * versionstr = [dict objectForKey:@"version"];
    NSString * upDatastr = [dict objectForKey:@"isUpdate"];
    NSArray * infoArray = [dict objectForKey:@"info"];
    self.urlVersion = [NSString stringWithFormat:@"%@",[dict objectForKey:@"add"] ];
    NSLog(@"ulversion = %@", self.urlVersion);
    NSMutableString * msgString = [[NSMutableString alloc] init];
    
    if ([infoArray count] > 0) {
        for (int i = 0; i < [infoArray count]; i++) {
            NSDictionary * dictmsg = [infoArray objectAtIndex:i];
            [msgString appendFormat:@"%@\n", [dictmsg objectForKey:@"line"]];
        }
    }
    
    if ([upDatastr isEqualToString:@"0"]) {
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                              message:@"已经是最新版本!"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"确定", nil];
        
        [alert show];
#ifdef isCaiPiaoForIPad
        alert.frame = CGRectMake(0, 0, 540, 560);
#endif
        
        [alert release];
        
        
        
        
    }else if([upDatastr isEqualToString:@"1"]){
        NSString * msg = @"";
        if ([msgString length] > 0) {
            msg = [NSString stringWithFormat:@"%@",msgString];
        }else{
            msg = [NSString stringWithFormat:@"发现新版本 %@\n是否更新", versionstr];
        }
        [[NSUserDefaults standardUserDefaults] setValue:versionstr forKey:@"newestversion"];
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                              message:msg
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"更新", nil];
        alert.tag = 2;
        alert.delegate = self;
        [alert show];
        [alert release];
        
        
        
    }else if([upDatastr isEqualToString:@"2"]){
        NSString * msg = @"";
        if ([msgString length] > 0) {
            msg = [NSString stringWithFormat:@"%@", msgString];
        }else{
            msg = [NSString stringWithFormat:@"发现新版本 %@\n请更新", versionstr];
        }
        [[NSUserDefaults standardUserDefaults] setValue:versionstr forKey:@"newestversion"];
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                              message:msg
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:@"更新", nil];
        alert.tag = 3;
        alert.delegate = self;
        [alert show];
        [alert release];
        
    }
    [msgString release];
    

}
- (void)LoadiPadView {

    [self.navigationController setNavigationBarHidden:YES];
    self.CP_navigation.image = UIImageGetImageFromName(@"daohangtiao.png");//更换导航栏    
    self.CP_navigation.title = @"关于我们";
    self.CP_navigation.frame = CGRectMake(0, 0, 540, 44);
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    //背景
    UIImageView *baimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 540, 570)];
    baimage.image = UIImageGetImageFromName(@"bejing.png");
    [self.mainView addSubview:baimage];
    [baimage release];
    
    UIImageView *logoimage = [[UIImageView alloc] initWithFrame:CGRectMake(90, 30, 370, 155)];
    logoimage.image = UIImageGetImageFromName(@"about-back.png");
    [self.mainView addSubview:logoimage ];
    [logoimage release];
    
    UIImageView *logoimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(93, 38, 166, 73)];
    logoimage2.image = UIImageGetImageFromName(@"about-logo1.png");
    [logoimage addSubview:logoimage2 ];
    [logoimage2 release];
    
    UIImageView *logoimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(270, 10, 40, 25)];
    logoimage3.image = UIImageGetImageFromName(@"about-logo2.png");
    [logoimage addSubview:logoimage3];
    [logoimage3 release];


    
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"info = %@", infoDict);
    
    NSString *Version = [infoDict objectForKey:@"CFBundleVersion"];
    NSLog(@"%@", Version);
    
    
    UIImageView *banbenima = [[UIImageView alloc] initWithFrame:CGRectMake(90, 200, 368, 45.5)];
    banbenima.backgroundColor = [UIColor clearColor];
    banbenima.image = UIImageGetImageFromName(@"set-input2.png");
    
    UILabel* banbenlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 330, 40)];
    banbenlabel.text = [NSString stringWithFormat:@"当前版本                                                      V%@", Version];
    //banbenlabel.textAlignment = NSTextAlignmentCenter;
    banbenlabel.backgroundColor = [UIColor clearColor];
    banbenlabel.font = [UIFont systemFontOfSize:15];
    [banbenima addSubview:banbenlabel];
    [banbenlabel release];
    [self.mainView addSubview:banbenima];
    [banbenima release];
    
    UIImageView * banbenima2 = [[UIImageView alloc] initWithFrame:CGRectMake(90, 245.5, 368, 45.5)];
    banbenima2.backgroundColor = [UIColor clearColor];
    banbenima2.image = UIImageGetImageFromName(@"set-input3.png");
    
    UILabel* banbenlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 330, 40)];
    banbenlabel2.text = [NSString stringWithFormat:@"渠道号                                             %@", [infoDict objectForKey:@"SID"]];
    //banbenlabel2.textAlignment = NSTextAlignmentCenter;
    banbenlabel2.backgroundColor = [UIColor clearColor];
    banbenlabel2.font = [UIFont systemFontOfSize:15];
    [banbenima2 addSubview:banbenlabel2];
    [banbenlabel2 release];
    [self.mainView addSubview:banbenima2];
    [banbenima2 release];
    
    UIImageView * image2 = [[UIImageView alloc] initWithFrame:CGRectMake(17, 15, 22, 22)];
    image2.image = UIImageGetImageFromName(@"about-tel.png");
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, 50)];
    label2.text = @"客服电话:QQ：3254056760";
    label2.textAlignment = NSTextAlignmentLeft;
    // label2.textColor = [UIColor grayColor];
    label2.backgroundColor = [UIColor clearColor];
    label2.font = [UIFont systemFontOfSize:15];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(90, 306, 368, 45.5);
    button2.enabled = NO;
    [button2 addTarget:self action:@selector(pressbuttonkefu:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * hiu = [[UIImageView alloc] initWithFrame:button2.bounds];
    hiu.image = UIImageGetImageFromName(@"set-input2.png");
    [button2 addSubview:hiu];
    [hiu release];
    
    
    //关于彩票
    UIImageView * hou3 = [[UIImageView alloc] initWithFrame:CGRectMake(348, 18, 9, 14)];
    hou3.image = UIImageGetImageFromName(@"login_arr.png");
    
    UIImageView * image3 = [[UIImageView alloc] initWithFrame:CGRectMake(17, 13, 22, 22)];
    image3.image = UIImageGetImageFromName(@"about-download.png");
    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, 50)];
    
    label3.text = @"关于投注站";
    
    label3.textAlignment = NSTextAlignmentLeft;
    // label3.textColor = [UIColor grayColor];
    label3.backgroundColor = [UIColor clearColor];
    label3.font = [UIFont systemFontOfSize:15];
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(90, 351.5, 368, 45.5);
    [button3 setImage:UIImageGetImageFromName(@"set-input3.png") forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(pressjieshao:) forControlEvents:UIControlEventTouchUpInside];
        
    [button2 addSubview:label2];
    [button2 addSubview:image2];
    
    [self.mainView addSubview:button2];
    [label2 release];
    [image2 release];
    
    
    [button3 addSubview:label3];
    [button3 addSubview:image3];
    [button3 addSubview:hou3];
    [self.mainView addSubview:button3];
    [label3 release];
    [image3 release];
    [hou3 release];

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef isCaiPiaoForIPad
    
    [self LoadiPadView];
    
#else
    
    [self LoadiPhoneView];
    
#endif
    
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    if ((alertView.tag == 2 && buttonIndex != 0) || alertView.tag == 3) {
        NSLog(@"url = %@", self.urlVersion);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlVersion]];
        
        
    }
    
   
}

- (void)pressjieshao:(UIButton *)sender{
    [MobClick event:@"event_shezhi_guanyuwomen_guanyucaipiao365"];
    AboutOurInfoController *aboutViewController = [[AboutOurInfoController alloc] initWithNibName: nil bundle: nil];
    [self.navigationController pushViewController: aboutViewController animated: YES];
    [aboutViewController release];
}


- (void)pressbuttonkefu:(UIButton *)sender{
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//    [actionSheet showInView:self.mainView];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
//    }
//    [actionSheet release];
}
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
//    }
}

- (void)pressbuttonyijian:(UIButton *)sender{
    YijianViewController * yi = [[YijianViewController alloc] init];
    [self.navigationController pushViewController:yi animated:YES];
    [yi release];

}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)gotohome{
    

    GC_BaFangShiPingViewController * shipin = [[GC_BaFangShiPingViewController alloc] init];
    [self.navigationController pushViewController:shipin animated:YES];
    [shipin release];
    
    
    
//原来的    
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
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


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    