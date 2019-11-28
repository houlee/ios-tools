//
//  n115yilouViewController.m
//  caibo
//
//  Created by houchenguang on 13-2-22.
//
//

#import "n115yilouViewController.h"
#import "Info.h"
#import "NetURL.h"
#import "JSON.h"
#import "caiboAppDelegate.h"

@interface n115yilouViewController ()

@end

@implementation n115yilouViewController
@synthesize httpRequest;
@synthesize yiloutwo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark 返回按钮
- (void)doBack{
    [self.navigationController  popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
}



#pragma mark 头上的ui
- (void)headFunc{
    
    
    if (yiloutwo == kuaisantype) {
        
        for (int i = 0; i < 8; i++) {
            UIImageView * headimage = [[UIImageView alloc] init];
            headimage.backgroundColor = [UIColor colorWithRed:0 green:17/255.0 blue:24/255.0 alpha:1];
            
            UIImageView * bgIssueImage = [[UIImageView alloc] init];
            bgIssueImage.backgroundColor = [UIColor colorWithRed:0 green:32/255.0 blue:45/255.0 alpha:1];
            
            
            if (i == 0) {
                headimage.frame = CGRectMake(43, 31, 34, 26);
            }else if(i == 1){
                headimage.frame = CGRectMake(43+34+1, 31, 44, 26);
            
            }else{
                headimage.frame = CGRectMake(43+34+44+(i-2)*23+i, 31, 23, 26);
            }
            //        headimage.image = [UIImageGetImageFromName(@"nrwzbg.png") stretchableImageWithLeftCapWidth:6 topCapHeight:7];
            
            bgIssueImage.frame = CGRectMake(1, 1, headimage.frame.size.width-2, headimage.frame.size.height-2);
            [headimage addSubview:bgIssueImage];
            [bgIssueImage release];
            
            
            
            
            UILabel * headlabel = [[UILabel alloc] init];
            headlabel.frame = headimage.bounds;
            headlabel.backgroundColor = [UIColor clearColor];
            headlabel.textAlignment = NSTextAlignmentCenter;
            headlabel.font = [UIFont boldSystemFontOfSize:12];
            
            if (i == 0) {
                //            headlabel.text = @"期号";
                //            headlabel.textColor = [UIColor colorWithRed:31/255.0 green:101/255.0 blue:132/255.0 alpha:1];
                
                UIImageView * issuebgimage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 18, 10)];
                issuebgimage.backgroundColor = [UIColor clearColor];
                issuebgimage.image = UIImageGetImageFromName(@"n11x5qihao.png");
                [headimage addSubview:issuebgimage];
                [issuebgimage release];
                
            }else if (i == 1){
            
                UIImageView * issuebgimage = [[UIImageView alloc] initWithFrame:CGRectMake((44-57/2)/2, (26-12)/2, 57/2, 12)];
                issuebgimage.backgroundColor = [UIColor clearColor];
                issuebgimage.image = UIImageGetImageFromName(@"kaijianghaoima.png");
                [headimage addSubview:issuebgimage];
                [issuebgimage release];
                
            
            }else{
                UIImageView * issuebgimage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 21, 24)];
                issuebgimage.backgroundColor = [UIColor clearColor];
                issuebgimage.image = UIImageGetImageFromName(@"n11x5hao.png");
                [headimage addSubview:issuebgimage];
                [issuebgimage release];
                
                // headlabel.frame = CGRectMake(1, 1, 23, 24);
                
                headlabel.textColor = [UIColor whiteColor];
                
                
                headlabel.text = [NSString stringWithFormat:@"%d", i-1];
                
            }
            
            [headimage addSubview:headlabel];
            [headlabel release];
            
            [self.mainView addSubview:headimage];
            
            [headimage release];
        }
        
    }else{
        for (int i = 0; i < 12; i++) {
            UIImageView * headimage = [[UIImageView alloc] init];
            headimage.backgroundColor = [UIColor colorWithRed:0 green:17/255.0 blue:24/255.0 alpha:1];
            
            UIImageView * bgIssueImage = [[UIImageView alloc] init];
            bgIssueImage.backgroundColor = [UIColor colorWithRed:0 green:32/255.0 blue:45/255.0 alpha:1];
            
            
            if (i == 0) {
                headimage.frame = CGRectMake(11, 31, 34, 26);
            }else{
                headimage.frame = CGRectMake(11+34+(i-1)*23+i, 31, 23, 26);
            }
            //        headimage.image = [UIImageGetImageFromName(@"nrwzbg.png") stretchableImageWithLeftCapWidth:6 topCapHeight:7];
            
            bgIssueImage.frame = CGRectMake(1, 1, headimage.frame.size.width-2, headimage.frame.size.height-2);
            [headimage addSubview:bgIssueImage];
            [bgIssueImage release];
            
            
            
            
            UILabel * headlabel = [[UILabel alloc] init];
            headlabel.frame = headimage.bounds;
            headlabel.backgroundColor = [UIColor clearColor];
            headlabel.textAlignment = NSTextAlignmentCenter;
            headlabel.font = [UIFont boldSystemFontOfSize:12];
            
            if (i == 0) {
                //            headlabel.text = @"期号";
                //            headlabel.textColor = [UIColor colorWithRed:31/255.0 green:101/255.0 blue:132/255.0 alpha:1];
                
                UIImageView * issuebgimage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 18, 10)];
                issuebgimage.backgroundColor = [UIColor clearColor];
                issuebgimage.image = UIImageGetImageFromName(@"n11x5qihao.png");
                [headimage addSubview:issuebgimage];
                [issuebgimage release];
                
            }else{
                UIImageView * issuebgimage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 21, 24)];
                issuebgimage.backgroundColor = [UIColor clearColor];
                issuebgimage.image = UIImageGetImageFromName(@"n11x5hao.png");
                [headimage addSubview:issuebgimage];
                [issuebgimage release];
                
                //            headlabel.frame = CGRectMake(1, 1, 23, 24);
                
                headlabel.textColor = [UIColor whiteColor];
                
                if(i < 10){
                    headlabel.text = [NSString stringWithFormat:@"%d", i];
                }else{
                    headlabel.text = [NSString stringWithFormat:@"%d", i];
                }
            }
            
            [headimage addSubview:headlabel];
            [headlabel release];
            
            [self.mainView addSubview:headimage];
            
            [headimage release];
        }
    }
    
   

}

#pragma mark 遗漏图的ui
- (void)allnumberFunc{
    
    NSInteger counttag = 1;
    NSInteger labeltag = 1000;
    NSInteger imagetag = 2000;
    NSInteger countall = 0;
#ifdef isCaiPiaoForIPad
    countall = 35;
#else
    countall = 30;
#endif
    
    
    if (yiloutwo == kuaisantype) {
        
        
        for (int i = 0; i < countall; i++) {
            for (int j = 0; j < 8; j++) {
                
                UIImageView * nubimage = [[UIImageView alloc] init];
                nubimage.backgroundColor = [UIColor colorWithRed:0 green:17/255.0 blue:24/255.0 alpha:1];
                nubimage.tag = counttag;
                UILabel * nublabel = [[UILabel alloc] init];
                nublabel.tag = labeltag;
                nublabel.textAlignment = NSTextAlignmentCenter;
                nublabel.backgroundColor = [UIColor clearColor];
                nublabel.font = [UIFont systemFontOfSize:10];
                if (j == 0) {
                    nubimage.frame = CGRectMake(32, i*18+i, 34, 18);
                    nublabel.frame = nubimage.bounds;
                    //                nubimage.backgroundColor = [UIColor grayColor];
                }else if(j == 1){
                    
                    nubimage.frame = CGRectMake(32+34+1, i*18+i, 44, 18);
                    nublabel.frame = nubimage.bounds;
                
                
                }else{
                    nubimage.frame = CGRectMake(34+44+9+(j-1)*23+j, i*18+i, 23, 18);
                    nublabel.frame = CGRectMake(0, 1, nubimage.frame.size.width, nubimage.frame.size.height);
                    //                nubimage.backgroundColor = [UIColor lightGrayColor];
                }
                UIImageView * bgIssueImage = [[UIImageView alloc] init];
                bgIssueImage.backgroundColor = [UIColor colorWithRed:0 green:32/255.0 blue:45/255.0 alpha:1];
                bgIssueImage.frame = CGRectMake(1, 1, nubimage.frame.size.width-2, nubimage.frame.size.height-2);
                [nubimage addSubview:bgIssueImage];
                [bgIssueImage release];
                //            nubimage.image = [UIImageGetImageFromName(@"nrwzbg.png") stretchableImageWithLeftCapWidth:6 topCapHeight:7];
                
                if (j == 0) {
                    UIImageView * tuimage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, nubimage.frame.size.width-4, nubimage.frame.size.height-4)];
                    tuimage.backgroundColor = [UIColor clearColor];
                    tuimage.image = [UIImageGetImageFromName(@"issuebg.png") stretchableImageWithLeftCapWidth:10 topCapHeight:7];
                    [nubimage addSubview:tuimage];
                    [tuimage release];
                }else if(j == 1){
                    UIImageView * bianiamge = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 14, 15)];
                    bianiamge.tag = imagetag;
                    bianiamge.backgroundColor = [UIColor clearColor];
                    [nubimage addSubview:bianiamge];
                    [bianiamge release];
                
                }else{
                    UIImageView * bianiamge = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 14, 15)];
                    bianiamge.tag = imagetag;
                    bianiamge.backgroundColor = [UIColor clearColor];
                    [nubimage addSubview:bianiamge];
                    [bianiamge release];
                }
                
                nublabel.textColor = [UIColor colorWithRed:31/255.0 green:101/255.0 blue:132/255.0 alpha:1];;
                [nubimage addSubview:nublabel];
                [myScrollView addSubview:nubimage];
                [nublabel release];
                [nubimage release];
                counttag++;
                labeltag++;
                imagetag++;
            }
        }
        
        
    }else{
        for (int i = 0; i < countall; i++) {
            for (int j = 0; j < 12; j++) {
                
                UIImageView * nubimage = [[UIImageView alloc] init];
                nubimage.backgroundColor = [UIColor colorWithRed:0 green:17/255.0 blue:24/255.0 alpha:1];
                nubimage.tag = counttag;
                UILabel * nublabel = [[UILabel alloc] init];
                nublabel.tag = labeltag;
                nublabel.textAlignment = NSTextAlignmentCenter;
                nublabel.backgroundColor = [UIColor clearColor];
                nublabel.font = [UIFont systemFontOfSize:10];
                if (j == 0) {
                    nubimage.frame = CGRectMake(0, i*18+i, 34, 18);
                    nublabel.frame = nubimage.bounds;
                    //                nubimage.backgroundColor = [UIColor grayColor];
                }else{
                    nubimage.frame = CGRectMake(34+(j-1)*23+j, i*18+i, 23, 18);
                    nublabel.frame = CGRectMake(0, 1, nubimage.frame.size.width, nubimage.frame.size.height);
                    //                nubimage.backgroundColor = [UIColor lightGrayColor];
                }
                UIImageView * bgIssueImage = [[UIImageView alloc] init];
                bgIssueImage.backgroundColor = [UIColor colorWithRed:0 green:32/255.0 blue:45/255.0 alpha:1];
                bgIssueImage.frame = CGRectMake(1, 1, nubimage.frame.size.width-2, nubimage.frame.size.height-2);
                [nubimage addSubview:bgIssueImage];
                [bgIssueImage release];
                //            nubimage.image = [UIImageGetImageFromName(@"nrwzbg.png") stretchableImageWithLeftCapWidth:6 topCapHeight:7];
                
                if (j == 0) {
                    UIImageView * tuimage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, nubimage.frame.size.width-4, nubimage.frame.size.height-4)];
                    tuimage.backgroundColor = [UIColor clearColor];
                    tuimage.image = [UIImageGetImageFromName(@"issuebg.png") stretchableImageWithLeftCapWidth:10 topCapHeight:7];
                    [nubimage addSubview:tuimage];
                    [tuimage release];
                }else{
                    UIImageView * bianiamge = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 14, 15)];
                    bianiamge.tag = imagetag;
                    bianiamge.backgroundColor = [UIColor clearColor];
                    [nubimage addSubview:bianiamge];
                    [bianiamge release];
                }
                
                nublabel.textColor = [UIColor colorWithRed:31/255.0 green:101/255.0 blue:132/255.0 alpha:1];;
                [nubimage addSubview:nublabel];
                [myScrollView addSubview:nubimage];
                [nublabel release];
                [nubimage release];
                counttag++;
                labeltag++;
                imagetag++;
            }
        }
    }
    
   
    
    
#ifdef isCaiPiaoForIPad
     myScrollView.contentSize = CGSizeMake(320, 35*18+34);
#else
    
         myScrollView.contentSize = CGSizeMake(320, 30*18+29);

    
#endif
    NSString * countItem = @"";
#ifdef isCaiPiaoForIPad
    countItem = @"35";
#else
    countItem = @"30";
#endif
    if (yiloutwo == kuaisantype) {
        [httpRequest clearDelegatesAndCancel];
        NSLog(@"url = %@", [NetURL kuai3YiLouTuo:@"k3" Item:countItem]);
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL kuai3YiLouTuo:@"k3" Item:countItem]];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
        [httpRequest setDidFailSelector:@selector(rebuyFail:)];
        [httpRequest startAsynchronous];
        
    }else{
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL yiLouTuLottery:@"n115" item:[NSString stringWithFormat:@"%ld", (long)countall] category:@""]];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
        [httpRequest setDidFailSelector:@selector(rebuyFail:)];
        [httpRequest startAsynchronous];
    }
    
    
}

#pragma mark viewDidLoad
- (void)goTalk{
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if(yiloutwo == kuaisantype){
        self.CP_navigation.title = @"快3走势图";
    }else{
        self.CP_navigation.title = @"11选5走势图";
    }
    
    
    
#ifdef isCaiPiaoForIPad
    self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, 320, self.mainView.frame.size.height);
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height);
    self.CP_navigation.frame = CGRectMake(self.CP_navigation.frame.origin.x, self.CP_navigation.frame.origin.y, 320, self.CP_navigation.frame.size.height);
    
    UIBarButtonItem *right = [Info itemInitWithTitle:nil Target:self action:@selector(goTalk) ImageName:@"kf-quxiao2.png"];
    self.CP_navigation.rightBarButtonItem = right;
#endif
    
    loadView = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadView];
    [loadView release];
    
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
	backImageV.frame = self.mainView.bounds;
#ifdef isCaiPiaoForIPad
    [self.mainView addSubview:backImageV];
#else
    [self.mainView addSubview:backImageV];
#endif
	
	[backImageV release];
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 395)];
    if (IS_IPHONE_5) {
        bgview.frame = CGRectMake(0, 10, 320, self.mainView.frame.size.height - 20);
    }
  
    bgview.backgroundColor = [UIColor clearColor];
   
#ifdef isCaiPiaoForIPad
    bgview.frame = CGRectMake(0, 10, 320, 695);
    [self.mainView addSubview:bgview];
#else
    [self.mainView addSubview:bgview];
#endif
     bgview.image = [UIImageGetImageFromName(@"zstbg.png") stretchableImageWithLeftCapWidth:160 topCapHeight:210];
    bgview.frame = CGRectMake(0, -1, self.mainView.frame.size.width, self.mainView.frame.size.height + 2);
    [bgview release];
    
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    allNumArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    drawArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(11, 58, 320, 323)];
    if (IS_IPHONE_5) {
        myScrollView.frame = CGRectMake(11, 58, 320, 410);
    }
    [myScrollView setDelegate:self];
    [myScrollView setShowsVerticalScrollIndicator:NO];
    [myScrollView setShowsHorizontalScrollIndicator:NO];
    myScrollView.backgroundColor = [UIColor clearColor];
#ifdef isCaiPiaoForIPad
     myScrollView.frame = CGRectMake(11, 58, 320, 623);
    [self.mainView addSubview:myScrollView];
#else
   [self.mainView addSubview:myScrollView];
#endif
    
    [myScrollView release];
    
    [self performSelector:@selector(headFunc) withObject:self afterDelay:0.1];
    [self performSelector:@selector(allnumberFunc) withObject:self afterDelay:0.1];
//    [self headFunc];
//    [self allnumberFunc];
    
    
    
}

- (void)uploadData{
    
    NSInteger counttag = 1;
    NSInteger labeltag = 1000;
    NSInteger imagetag = 2000;
//    NSInteger countall = 0;
#ifdef isCaiPiaoForIPad
    countall = 35;
#else
//    countall = 30;
#endif
    
    NSInteger numberCount = 0;
    if (yiloutwo == kuaisantype) {
        numberCount = 8;
    }else{
        numberCount = 12;
    }
    
    
    for (int i = 0; i < [issueArray count]; i++) {
        if (i >= [allNumArray count]) {
            break;
        }
        NSArray * nubarr = [allNumArray objectAtIndex:i];
        NSLog(@"nubarr = %@", nubarr);

        for (int j = 0; j < numberCount; j++) {
            UIImageView * nubimage = (UIImageView *)[myScrollView viewWithTag:counttag];
            UILabel * nublabel = (UILabel *)[nubimage viewWithTag:labeltag];
            UIImageView * bianimage = (UIImageView *)[nubimage viewWithTag:imagetag];
            
            
            
            if (yiloutwo == kuaisantype) {
                
                if (j == 0) {
                    NSString * issuestring = [issueArray objectAtIndex:i];
                    nublabel.text = [issuestring substringWithRange:NSMakeRange([issuestring length]-4, 4)];
                }else if (j == 1){
                
                    nublabel.text = [drawArray objectAtIndex:i];
                
                } else{
                    NSString * nubstring = [NSString stringWithFormat:@"%@", [nubarr objectAtIndex:j-2]];
                    NSLog(@"nubstring = %@", nubstring);
                    if ([nubstring isEqualToString:@"0"]) {
                        
                        
                        nublabel.text = [NSString stringWithFormat:@"%d", j-1];
                   
                        //                    nubimage.backgroundColor = [UIColor redColor];
                        nublabel.textColor = [UIColor whiteColor];
                        nublabel.font = [UIFont boldSystemFontOfSize:9];
                        bianimage.image = UIImageGetImageFromName(@"HXZSAN960.png");
                    }else{
                        bianimage.image = nil;
                        nublabel.text = nubstring;
                        nublabel.font = [UIFont systemFontOfSize:9];
                        nublabel.textColor = [UIColor colorWithRed:31/255.0 green:101/255.0 blue:132/255.0 alpha:1];
                    }
                    
                    
                }
                
            }else{
                if (j == 0) {
                    NSString * issuestring = [issueArray objectAtIndex:i];
                    nublabel.text = [issuestring substringWithRange:NSMakeRange([issuestring length]-4, 4)];
                }else{
                    NSString * nubstring = [NSString stringWithFormat:@"%@", [nubarr objectAtIndex:j]];
                    NSLog(@"nubstring = %@", nubstring);
                    if ([nubstring isEqualToString:@"0"]) {
                        
                        if (j < 10) {
                            nublabel.text = [NSString stringWithFormat:@"%d", j];
                        }else{
                            nublabel.text = [NSString stringWithFormat:@"%d", j];
                        }
                        //                    nubimage.backgroundColor = [UIColor redColor];
                        nublabel.textColor = [UIColor whiteColor];
                        nublabel.font = [UIFont boldSystemFontOfSize:9];
                        bianimage.image = UIImageGetImageFromName(@"HXZSAN960.png");
                    }else{
                        bianimage.image = nil;
                        nublabel.text = nubstring;
                        nublabel.font = [UIFont systemFontOfSize:9];
                        nublabel.textColor = [UIColor colorWithRed:31/255.0 green:101/255.0 blue:132/255.0 alpha:1];
                    }
                    
                    
                }
            
            
            }
            
            
             
            counttag++;
            labeltag++;
            imagetag++;
        }
    }

}

#pragma mark requestFinished
- (void)reqBuyLotteryFinished:(ASIHTTPRequest *)request {
    
    NSString *responseStr = [request responseString];
    NSLog(@"%@",responseStr);
    if (![responseStr isEqualToString:@"fail"]) {
        NSLog(@"%@",responseStr);
        NSArray * array = [responseStr JSONValue];
        
        
        if (yiloutwo == kuaisantype) {
            
            for (NSDictionary * dict in array) {
                NSString * issue = [dict objectForKey:@"issue"];
                NSArray * arrnumber = [dict objectForKey:@"k3ArrNumber"];
                NSString * drawString = [dict objectForKey:@"bonusNumber"];
                NSArray * drawArr = [drawString componentsSeparatedByString:@","];
                if ([drawArr count] >= 3) {
                    drawString = [NSString stringWithFormat:@"%d,%d,%d", [[drawArr objectAtIndex:0] intValue], [[drawArr objectAtIndex:1] intValue], [[drawArr objectAtIndex:2] intValue]];
                }
                
                NSLog(@"issue = %@", issue);
                [issueArray addObject:issue];
                [drawArray addObject:drawString];
                [allNumArray addObject:arrnumber];
                
                NSLog(@"bonus = %@", [dict objectForKey:@"bonusNumber"]);
            }
            
            
        }else{
            for (NSDictionary * dict in array) {
                NSString * issue = [dict objectForKey:@"issue"];
                NSArray * arrnumber = [dict objectForKey:@"arrNumber"];
                NSLog(@"issue = %@", issue);
                [issueArray addObject:issue];
                [allNumArray addObject:arrnumber];
                
                NSLog(@"bonus = %@", [dict objectForKey:@"bonusNumber"]);
            }
        
        }
        
        [self uploadData];
        [loadView stopRemoveFromSuperview];
        loadView = nil;
    }else{
        [loadView stopRemoveFromSuperview];
        loadView = nil;
    }
	
}

- (void)rebuyFail:(ASIHTTPRequest *)request{
    [loadView stopRemoveFromSuperview];
    loadView = nil;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if(scrollView.contentOffset.y <= 0){
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [drawArray release];
    
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [issueArray release];
    [allNumArray release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    