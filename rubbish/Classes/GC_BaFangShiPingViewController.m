//
//  GC_BaFangShiPingViewController.m
//  caibo
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_BaFangShiPingViewController.h"
#import "Info.h"
#import "ShiPinCell.h"
#import "NetURL.h"
#import "JSON.h"
#import "CustomMoviePlayerViewController.h"
#import "MobClick.h"
#import "CP_PTButton.h"

@implementation GC_BaFangShiPingViewController

@synthesize request;


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

- (void)LoadIphoneView {
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
#ifdef  isCaiPiao365AndPPTV
    //pptv样式界面
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, 320, self.mainView.bounds.size.height -    90) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
#else
    //原始界面
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, 320, self.mainView.bounds.size.height - 110) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
#endif
}

- (void)LoadIpadView {
#ifdef  isCaiPiao365AndPPTV
    //pptv样式界面
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 + 35, 65, 320, self.mainView.bounds.size.height -    90) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
#else
    //原始界面
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 + 35, 65, 320, self.mainView.bounds.size.height - 110) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
#endif
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:@"event_saishizhibo"];
    dateArray = [[NSMutableArray alloc] initWithCapacity:0];
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    
    self.title = @"赛事直播";
    allDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    pptvDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    shipindata = [[ShiPinData alloc] init];
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif
	
    NSLog(@"url = %@",[NetURL baFangShiPing]);
    self.request = [ASIHTTPRequest requestWithURL:[NetURL baFangShiPing]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDidFinishSelector:@selector(reBaFangShiPing:)];
    [request setDelegate:self];
    [request startAsynchronous];

  
}

- (void)reBaFangShiPing:(ASIHTTPRequest *)mrequest{
    
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    
    #ifdef  isCaiPiao365AndPPTV
    NSDictionary *dic = [str JSONValue];
    NSArray *caipiaoArray = [dic objectForKey:@"bfsp"];
//    NSArray *pptvArray = [dic objectForKey:@"pptv"];
    
    //pptv解析
    for (NSDictionary *dict2 in caipiaoArray) {
        NSString *datestring = [dict2 objectForKey:@"date"];
        if (![datestring isEqualToString:@"now"]) {
            NSMutableArray * mutarray = [[NSMutableArray alloc] initWithCapacity:0];
            NSArray *infoarr = [dict2 objectForKey:@"data"];
            for (NSDictionary *dic in infoarr) {
                ShiPinData *shipd = [[ShiPinData alloc] init];
                shipd.content = [dic objectForKey:@"content"];
                shipd.time = [dic objectForKey:@"time"];
                shipd.islive = [dic objectForKey:@"islive"];
                shipd.urlstring = [dic objectForKey:@"url_i"];
                NSLog(@"url_i = %@", shipd.urlstring);
                [mutarray addObject:shipd];
                [shipd release];
            }
            [dateArray addObject:datestring];
            [allDict setObject:mutarray forKey:datestring];
            [mutarray release];
        }else
        {
            NSArray *infoarr = [dict2 objectForKey:@"data"];
            for (NSDictionary *dic in infoarr) {
                
                shipindata.content = [dic objectForKey:@"content"];
                NSLog(@"content = %@", shipindata.content);
                shipindata.time = [dic objectForKey:@"time"];
                shipindata.islive = [dic objectForKey:@"islive"];
                shipindata.urlstring = [dic objectForKey:@"url_i"];
                NSLog(@"url_i = %@", shipindata.urlstring);
            }
            
        }
        
    }
//    for (NSDictionary *dict1 in pptvArray) {
//        
//        NSString *datestring = [dict1 objectForKey:@"date"];
//        NSLog(@"ss = %@", datestring);
//        if (![datestring isEqualToString:@"now"]) {
//            NSMutableArray * muArray = [[NSMutableArray alloc] initWithCapacity:0];
//            NSArray *infoarr = [dict1 objectForKey:@"data"];
//            for (NSDictionary *dic in infoarr) {
//                ShiPinData *data = [[ShiPinData alloc] init];
//                data.content = [dic objectForKey:@"content"];
//                data.time = [dic objectForKey:@"time"];
//                data.jc = [dic objectForKey:@"jc"];
//                data.jcmathid = [dic objectForKey:@"jcmathid"];
//                data.lcmatchid = [dic objectForKey:@"lcmathid"];
//                data.zc = [dic objectForKey:@"zc"];
//                data.status = [dic objectForKey:@"status"];
//                data.end_time = [dic objectForKey:@"end_time"];
//                data.zcissue = [dic objectForKey:@"zcissue"];
//                data.section_id = [dic objectForKey:@"section_id"];
//                
//                [muArray addObject:data];
//                [data release];
//            }
//            [dateArray addObject:datestring];
//            [pptvDict setObject:muArray forKey:datestring];
//            [muArray release];
//        }else
//        {
//            NSArray *infoarr = [dict1 objectForKey:@"data"];
//            for (NSDictionary *dic in infoarr) {
//                
//                shipindata.content = [dic objectForKey:@"content"];
//                shipindata.time = [dic objectForKey:@"time"];
//                shipindata.jc = [dic objectForKey:@"jc"];
//                shipindata.jcmathid = [dic objectForKey:@"jcmathid"];
//                shipindata.lcmatchid = [dic objectForKey:@"lcmathid"];
//                shipindata.zc = [dic objectForKey:@"zc"];
//                shipindata.status = [dic objectForKey:@"status"];
//                shipindata.end_time = [dic objectForKey:@"end_time"];
//                shipindata.zcissue = [dic objectForKey:@"zcissue"];
//                shipindata.section_id = [dic objectForKey:@"section_id"];
//                
//            }
//            
//        }
//        
//    }
    #else
    
    //投注站解析
    NSArray *caipiaoArray = [str JSONValue];
    for (NSDictionary *dict2 in caipiaoArray) {
        NSString *datestring = [dict2 objectForKey:@"date"];
        if (![datestring isEqualToString:@"now"]) {
            NSMutableArray * mutarray = [[NSMutableArray alloc] initWithCapacity:0];
            NSArray *infoarr = [dict2 objectForKey:@"data"];
            for (NSDictionary *dic in infoarr) {
                ShiPinData *shipd = [[ShiPinData alloc] init];
                shipd.content = [dic objectForKey:@"content"];
                shipd.time = [dic objectForKey:@"time"];
                shipd.islive = [dic objectForKey:@"islive"];
                shipd.urlstring = [dic objectForKey:@"url_i"];
                NSLog(@"url_i = %@", shipd.urlstring);
                [mutarray addObject:shipd];
                [shipd release];
            }
            [dateArray addObject:datestring];
            [allDict setObject:mutarray forKey:datestring];
            [mutarray release];
        }else
        {
            NSArray *infoarr = [dict2 objectForKey:@"data"];
            for (NSDictionary *dic in infoarr) {
                
                shipindata.content = [dic objectForKey:@"content"];
                NSLog(@"content = %@", shipindata.content);
                shipindata.time = [dic objectForKey:@"time"];
                shipindata.islive = [dic objectForKey:@"islive"];
                shipindata.urlstring = [dic objectForKey:@"url_i"];
                NSLog(@"url_i = %@", shipindata.urlstring);
            }
            
        }
        
    }
    #endif
    

    buffer[0] = 1;//
    buffer[[allDict allKeys].count] = 1;
    [myTableView reloadData];
    [self returnTabelViewHeadView];
    
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai showMessagetishi:@"建议在wifi环境中播放视频"];
    NSLog(@"datearr = %@", dateArray);
  
            

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai.keFuButton calloff];

    [cai hidenMessage];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (caiboappdelegate.keFuButton.markbool) {
        caiboappdelegate.keFuButton.show = YES;
    }else{
        caiboappdelegate.keFuButton.show = NO;
        }
    
    NSLog(@"h =%f,y =%f",caiboappdelegate.window.frame.size.height,caiboappdelegate.window.frame.origin.y);
    
}

- (void)doBack{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnTabelViewHeadView{
    
    UIImageView * viewret = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 87)];
#ifdef isCaiPiaoForIPad
    viewret.frame = CGRectMake(35, 0, 320, 67);
#endif
    
    viewret.image = UIImageGetImageFromName(@"ZZBFAN960.png");
    viewret.userInteractionEnabled = YES;
    [self.mainView addSubview:viewret];
    [viewret release];
    
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(21, 0, 46, 18)];
    [viewret addSubview:imageV1];
    imageV1.image = UIImageGetImageFromName(@"ZhiBoBack1.png");
    UILabel *lable1 = [[UILabel alloc] initWithFrame:imageV1.bounds];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.textColor = [UIColor whiteColor];
    lable1.font = [UIFont boldSystemFontOfSize:9];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.text = @"正在播放";
    [imageV1 addSubview:lable1];
    [imageV1 release];
    [lable1 release];
    
    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(67, 0, 23, 18)];
    [viewret addSubview:imageV2];
    imageV2.image = UIImageGetImageFromName(@"ZhiBoBack2.png");
    UILabel *lable2 = [[UILabel alloc] initWithFrame:imageV2.bounds];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.textColor = [UIColor whiteColor];
    lable2.font = [UIFont boldSystemFontOfSize:9];
    lable2.textAlignment = NSTextAlignmentCenter;
    if ([shipindata.islive intValue] == 1) {
        lable2.text = @"直播";
    }
    else {
        lable2.text = @"录播";
    }
    
    [imageV2 addSubview:lable2];
    [imageV2 release];
    [lable2 release];
    
    UIImageView *infBack = [[UIImageView alloc] initWithFrame:CGRectMake(15, 22, 290, 47)];
    [viewret addSubview:infBack];
    infBack.userInteractionEnabled = YES;
    infBack.image = UIImageGetImageFromName(@"BFSPContonBack.png");
    [infBack release];
    
    
    //直播信息
    UILabel * infotext = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 230, 33)];
    infotext.backgroundColor = [UIColor clearColor];
    infotext.font = [UIFont boldSystemFontOfSize:12];
    infotext.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
    infotext.text = shipindata.content;
    NSLog(@"info text = %@", infotext.text);
    infotext.numberOfLines = 0;
    infotext.textAlignment = NSTextAlignmentLeft;
    [infBack addSubview:infotext];
    [infotext release];

    
    CP_PTButton *playButton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake(240, 0, 47, 47);
    [playButton loadButonImage:@"BFAN960.png" LabelName:nil];
    playButton.buttonImage.frame = CGRectMake(10, 10, 28, 28);
    playButton.hightImage = UIImageGetImageFromName(@"BFLOGO960.png");
    [playButton addTarget:self action:@selector(pressPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    [infBack addSubview:playButton];
    
    
    
    
//     if ([shipindata.islive intValue] == 1) {
//         //直播的图片
//         UIImageView * zhiboImage = [[UIImageView alloc] initWithFrame:CGRectMake(150, 8, 20, 11)];
//         zhiboImage.image = UIImageGetImageFromName(@"sp_32.png");
//         zhiboImage.backgroundColor = [UIColor clearColor];
//         [viewret addSubview:zhiboImage];
//         [zhiboImage release];
//         
//     }
    
    [self.mainView addSubview:myTableView];
    
}

//点击播放  shipindata.urlstring 是传入的url shipindata.content是内容
- (void)pressPlayButton:(UIButton *)sender{
    NSLog(@"content = %@", shipindata.content);
	CustomMoviePlayerViewController *cus  = [[CustomMoviePlayerViewController alloc] initWithPath:shipindata.urlstring];
	cus.content = shipindata.content;
	[self.navigationController pushViewController:cus animated:YES];
	[cus release];
}


//
- (void)pressBgHeader:(UIButton *)sender{
    
    
    
    if (buffer[sender.tag] == 0) {
        buffer[sender.tag] = 1;
        
        // [sender setImage:UIImageGetImageFromName(@"zhankai_0.png") forState:UIControlStateNormal];
    }else{
        buffer[sender.tag] = 0;
        
        // [sender setImage:UIImageGetImageFromName(@"weizhankai.png") forState:UIControlStateNormal];
    }
    
    [myTableView reloadData];
    
    if (buffer[sender.tag] == 1) {
       
        [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
   

}
//pptv节目列表收放
- (void)pressPPTVBgHeader:(UIButton *)sender{
    if (buffer[sender.tag] == 0) {
        buffer[sender.tag] = 1;
        
    }else{
        buffer[sender.tag] = 0;
        
    }
    [myTableView reloadData];
    
    if (buffer[sender.tag] == 1 && [myTableView numberOfRowsInSection:sender.tag]> 0) {
        
        [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
}

//返回段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    if (section < [[allDict allKeys] count]) {
        
        UIButton *bgheader = [UIButton buttonWithType:UIButtonTypeCustom];
        bgheader.tag = section;
        bgheader.frame = CGRectMake(0, 10, 320, 30);
        bgheader.backgroundColor = [UIColor clearColor];
        UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)];
        imageV1.image = [UIImageGetImageFromName(@"ZhiBoHengTiao.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        [bgheader addSubview:imageV1];
        [imageV1 release];
        if (buffer[section] == 0) {
            UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(288, 5, 18, 18)];
            image1.image = UIImageGetImageFromName(@"ZhiBoJianTouUp.png");
            [bgheader addSubview:image1];
            [image1 release];
        }else{
            UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(288, 5, 18, 18)];
            image2.image = UIImageGetImageFromName(@"ZhiBoJianTouDown.png");
            [bgheader addSubview:image2];
            [image2 release];
            
        }
        [bgheader addTarget:self action:@selector(pressBgHeader:) forControlEvents:UIControlEventTouchUpInside];
            
                
        
        
        UILabel *la   = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, 294, 14)];
        la.backgroundColor = [UIColor clearColor];
        la.textAlignment = NSTextAlignmentLeft;
        la.textColor = [UIColor whiteColor];
        la.font = [UIFont boldSystemFontOfSize:12];
        la.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        la.text = [NSString stringWithFormat:@"%@ 节目表",[dateArray objectAtIndex:section]];
        [bgheader addSubview:la];
        [la release];
        
        
        return bgheader;

    }
//     else
//     {
//        
//         //pptv节目列表背景图
//         UIButton *pptvButton = [UIButton buttonWithType:UIButtonTypeCustom];
//         pptvButton.frame = CGRectMake(0, 10, 320, 116);
//         pptvButton.tag = section;
//         
//         UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
//         imageV1.image = [UIImageGetImageFromName(@"ZhiBoHengTiao.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
//         [pptvButton addSubview:imageV1];
//         [imageV1 release];
//         
//         pptvButton.backgroundColor = [UIColor clearColor];
//         [pptvButton setImage:UIImageGetImageFromName(@"PPTVBG960.png") forState:UIControlStateNormal];
//         if (buffer[section] == 0) {
//             UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(288, 20, 18, 18)];
//             image3.image = UIImageGetImageFromName(@"ZhiBoJianTouUp.png");
//             [pptvButton addSubview:image3];
//             [image3 release];
//         }else{
//             UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(288, 20, 18, 18)];
//             image4.image = UIImageGetImageFromName(@"ZhiBoJianTouDown.png");
//             [pptvButton addSubview:image4];
//             [image4 release];
//             
//         }
//         [pptvButton addTarget:self action:@selector(pressPPTVBgHeader:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//         //pptv节目表标签
//         UILabel *la   = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 294, 28)];
//         la.backgroundColor = [UIColor clearColor];
//         la.textColor = [UIColor whiteColor];
//         la.font = [UIFont boldSystemFontOfSize:18];
//         la.text = @"PPTV节目表";
//         la.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
//         [pptvButton addSubview:la];
//         [la release];
//         
//         //pptvLOGO按钮
//         UIButton *pptvlogoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//         pptvlogoButton.frame = CGRectMake(200, 7, 80.5, 43.5);
//         [pptvlogoButton setImage:UIImageGetImageFromName(@"PPTVAN960.png") forState:UIControlStateNormal];
//         [pptvlogoButton addTarget:self action:@selector(pptvStart) forControlEvents:UIControlEventTouchUpInside];
//         [pptvButton addSubview:pptvlogoButton];
//         
//         
//        return pptvButton;
//
//    }
    return nil;
}


//判断是否安装pptv客户端
- (void)pptvStart
{
    NSURL *pptvURL = [NSURL URLWithString:@"pptvsports://from=caipiao365"];
    BOOL b = [[UIApplication sharedApplication] canOpenURL:pptvURL];
    if (b) {
        [[UIApplication sharedApplication] openURL:pptvURL];
    }else
    {
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/pptv-ti-yu/id627781309?mt=8"]];
    }
    
}

//段高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section < [[allDict allKeys] count]) {
        return 24;
    }
    return 0;
    
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger numofRow = 0,section = indexPath.section;
    NSArray * allkey = [allDict allKeys];
    if ([allkey count] == 0||allkey == nil) {
//        numofRow = 0;
    }
    
    if (buffer[section] == 0) {
        numofRow = 0;
    }else{
        if (section < [allDict allKeys].count) {
            NSArray * allarray = [allDict  objectForKey:[dateArray objectAtIndex:section]];
            
            numofRow = [allarray count];
            
        }else{
            if ([allDict count] >= [dateArray count]) {

            }
            NSArray * allarray = [pptvDict  objectForKey:[dateArray objectAtIndex:[[allDict allKeys] count]]];
            numofRow = [allarray count];
            
        }
    }
    if (indexPath.row == numofRow - 1) {
        return 50;
    }
    else if (indexPath.row == 0) {
    }
    return 46;
}

//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * allkey = [allDict allKeys];
    if ([allkey count] == 0||allkey == nil) {
        return 0;
    }

    if (buffer[section] == 0) {
        return 0;
    }else{
        if (section < [allDict allKeys].count) {
            NSArray * allarray = [allDict  objectForKey:[dateArray objectAtIndex:section]];
            return [allarray count];
            
        }else{
            if ([allDict count] >= [dateArray count]) {
                NSArray * allarray = [pptvDict  objectForKey:[dateArray objectAtIndex:[dateArray count] - 1]];
                return [allarray count];
            }
            NSArray * allarray = [pptvDict  objectForKey:[dateArray objectAtIndex:[[allDict allKeys] count]]];
            return [allarray count];
            
        }
    }
    
        
   
    return 0;
}

//返回段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        
    
        #ifdef  isCaiPiao365AndPPTV
    //增加pptv段
    NSArray * allkey = [allDict allKeys];
    if ([allkey count] == 0||allkey == nil) {
        
        return 0;
    }
    return [allkey count]+1;
        #else
    NSArray * allkey = [allDict allKeys];
    if ([allkey count] == 0||allkey == nil) {
        return 0;
    }
    return [allkey count];

        #endif
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
    
        NSString * cellid = @"cellid";
        ShiPinCell * cell = (ShiPinCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[ShiPinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        }
        
    if (indexPath.section < [allDict allKeys].count) {
        NSArray * allarr = [allDict objectForKey:[dateArray objectAtIndex:indexPath.section]];
        cell.shipindata = [allarr objectAtIndex:indexPath.row];
    }else
    {
        NSArray * allarr = [pptvDict objectForKey:[dateArray objectAtIndex:indexPath.section]];
        cell.shipindata = [allarr objectAtIndex:indexPath.row];

    }
        return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //播放pptv列表直播节目
    if (indexPath.section == 0) {
        
    }
    else if (indexPath.section == [[allDict allKeys] count]) {
       // if (indexPath.section ==1) {
            NSArray * allarr = [pptvDict objectForKey:[dateArray objectAtIndex:indexPath.section]];
            ShiPinData *shipin = [allarr objectAtIndex:indexPath.row];
                    
            NSURL *pptvURL = [NSURL URLWithString:[NSString stringWithFormat:@"pptvsports://from=caipiao365&sectionid=%@",shipin.section_id]];
            BOOL b = [[UIApplication sharedApplication] canOpenURL:pptvURL];
            if (b) {
                [[UIApplication sharedApplication] openURL:pptvURL];
            }
            else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/pptv-ti-yu/id627781309?mt=8"]];
            }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(NSUInteger)supportedInterfaceOrientations{
    return (1 << UIInterfaceOrientationPortrait);
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
#ifdef isCaiPiaoForIPad
    return NO;
#endif
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (void)dealloc{
    [shipindata release];
    [allDict release];
    [pptvDict release];
    [request clearDelegatesAndCancel];
    [request release];
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    