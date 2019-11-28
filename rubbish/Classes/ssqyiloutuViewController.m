//
//  ssqyiloutuViewController.m
//  caibo
//
//  Created by houchenguang on 13-2-21.
//
//

#import "ssqyiloutuViewController.h"
#import "Info.h"
#import "NetURL.h"
#import "JSON.h"
#import "caiboAppDelegate.h"

@interface ssqyiloutuViewController ()

@end

@implementation ssqyiloutuViewController
@synthesize httpRequest;
@synthesize yiloutu;

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

#pragma mark 期号的ui
- (void)issuefunc{ // 期号的ui

    NSInteger countissue = 0;
#ifdef isCaiPiaoForIPad
    countissue = 36;
#else
    if (IS_IPHONE_5) {
        countissue = 24;
    }else{
        countissue = 19;
    }
    
#endif
    
    for (int i = 0; i < countissue; i++) {
        UIImageView * issueimage = [[UIImageView alloc] init];
        issueimage.backgroundColor = [UIColor colorWithRed:0 green:17/255.0 blue:24/255.0 alpha:1];
       
        
        UIImageView * bgIssueImage = [[UIImageView alloc] init];
        bgIssueImage.backgroundColor = [UIColor colorWithRed:0 green:32/255.0 blue:45/255.0 alpha:1];
        
#ifdef isCaiPiaoForIPad
        if (i == 0) {
            issueimage.frame = CGRectMake(12, 31-3, 23, 25);
        }else{
            issueimage.frame = CGRectMake(12, 56-3+(i-1)*17+i, 23, 17);
        }
#else
        if (i == 0) {
            issueimage.frame = CGRectMake(12, 31, 23, 25);
        }else{
            issueimage.frame = CGRectMake(12, 56+(i-1)*17+i, 23, 17);
        }
#endif
        
        
        bgIssueImage.frame = CGRectMake(1, 1, issueimage.frame.size.width-2, issueimage.frame.size.height-2);
        [issueimage addSubview:bgIssueImage];
        [bgIssueImage release];
//
//         issueimage.image = [UIImageGetImageFromName(@"nrwzbg.png") stretchableImageWithLeftCapWidth:6 topCapHeight:7];
        
        
        UILabel * issuelabel = [[UILabel alloc] init];
        issuelabel.tag = i;
        issuelabel.textColor = [UIColor colorWithRed:31/255.0 green:101/255.0 blue:132/255.0 alpha:1];
        if (i == 0) {
//            NSString * str = @"期号";·
//            UIFont * font = [UIFont boldSystemFontOfSize:10];
//            CGSize  size = CGSizeMake(20, 40);
//            CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//            issuelabel.numberOfLines = 0;
//            issuelabel.font = [UIFont systemFontOfSize:9];
//            issuelabel.text = str;
//            issuelabel.frame = CGRectMake(1, 1, issueimage.frame.size.width-2, issueimage.frame.size.height-2);
            
            UIImageView * issuebgimage = [[UIImageView alloc] initWithFrame:CGRectMake(3, 8, 18, 10)];
            issuebgimage.backgroundColor = [UIColor clearColor];
            issuebgimage.image = UIImageGetImageFromName(@"n11x5qihao.png");
            [issueimage addSubview:issuebgimage];
            [issuebgimage release];
        }else{
//            issuelabel.frame = CGRectMake(0, 0, 32, 20);
            UIImageView * tuimage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, issueimage.frame.size.width-4, issueimage.frame.size.height-4)];
            tuimage.backgroundColor = [UIColor clearColor];
            tuimage.image = [UIImageGetImageFromName(@"issuebg.png") stretchableImageWithLeftCapWidth:10 topCapHeight:7];
            [issueimage addSubview:tuimage];
            [tuimage release];
            issuelabel.font = [UIFont systemFontOfSize:8];
            issuelabel.frame = CGRectMake(2, 2, issueimage.frame.size.width-4, issueimage.frame.size.height-4);
        }
        
        
        
        issuelabel.backgroundColor = [UIColor clearColor];
        issuelabel.textAlignment = NSTextAlignmentCenter;
        [issueimage addSubview:issuelabel];
#ifdef isCaiPiaoForIPad
        [self.mainView addSubview:issueimage];
#else
        [self.mainView addSubview:issueimage];
#endif
        
        [issuelabel release];
        [issueimage release];
        
        
        
    }

}



#pragma mark 遗漏图ui
- (void)allNumberFunc{
    NSInteger counttag = 40;
    NSInteger labeltag = 2000;
    NSInteger imagetag = 3000;
    NSInteger heng = 0;
    NSInteger shu = 0;
#ifdef isCaiPiaoForIPad
    heng = 36;
#else
    if (IS_IPHONE_5) {
        heng = 24;
    }else{
        heng = 19;
    }
    
#endif
    
     
    if (yiloutu == kuaiLeShiFenYiLouType) {
        
        shu = 20;
    }else{
      
        shu = 49;
    }
    
    for (int i = 0; i < heng; i++) {
        for (int j = 0; j < shu; j++) {
            UIImageView * nubimage = [[UIImageView alloc] init];
            nubimage.backgroundColor = [UIColor colorWithRed:0 green:17/255.0 blue:24/255.0 alpha:1];
            if (i == 0) {
                nubimage.frame = CGRectMake(16*j+(j+1), 0, 16, 25);
//                nubimage.backgroundColor = [UIColor redColor];
            }else{
                nubimage.frame = CGRectMake(16*j+(j+1), 25+17*(i-1)+i, 16, 17);
//                nubimage.backgroundColor = [UIColor lightGrayColor];
            }
//            nubimage.image = [UIImageGetImageFromName(@"nrwzbg.png") stretchableImageWithLeftCapWidth:6 topCapHeight:7];
            UIImageView * bgIssueImage = [[UIImageView alloc] init];
            bgIssueImage.backgroundColor = [UIColor colorWithRed:0 green:32/255.0 blue:45/255.0 alpha:1];
            bgIssueImage.frame = CGRectMake(1, 1, nubimage.frame.size.width-2, nubimage.frame.size.height-2);
            [nubimage addSubview:bgIssueImage];
            [bgIssueImage release];

            
            UIImageView * bianimage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 14, 15)];
            bianimage.tag = imagetag;
            bianimage.backgroundColor = [UIColor clearColor];
            [nubimage addSubview:bianimage];
            [bianimage release];
            
            
            UILabel * nublabel = [[UILabel alloc] init];
//            nublabel.tag = (i+1)*(j+1)+18+1000;
            nublabel.tag = labeltag;
            nublabel.backgroundColor = [UIColor clearColor];
            nublabel.textAlignment = NSTextAlignmentCenter;
           
            nublabel.font = [UIFont systemFontOfSize:8];
            
            if (i == 0) {
                 nublabel.frame = CGRectMake(0, 2, 16, 17);
                UIImageView * shuzibg = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, nubimage.frame.size.width-2, nubimage.frame.size.height-2)];
                shuzibg.backgroundColor = [UIColor clearColor];
                shuzibg.image = UIImageGetImageFromName(@"ssqshuzibg.png");
                [nubimage addSubview:shuzibg];
                [shuzibg release];
                
                UIImageView * dianimage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 15, 6, 6)];
                dianimage.backgroundColor = [UIColor clearColor];
                [shuzibg addSubview:dianimage];
                [dianimage release];
                
                nublabel.textColor = [UIColor whiteColor];
                nublabel.font = [UIFont boldSystemFontOfSize:9];
                if (yiloutu == kuaiLeShiFenYiLouType) {
                    if (j < 18) {
                        nublabel.text = [NSString stringWithFormat:@"%d", j+1];
                        dianimage.image = UIImageGetImageFromName(@"XXlQ960.png");
                    }else if((j+1) >18){
                        nublabel.text = [NSString stringWithFormat:@"%d", j+1];
                        //                    nubimage.backgroundColor = [UIColor blueColor];
                        dianimage.image = UIImageGetImageFromName(@"XXHQ960.png");
                        
                    }
//                    else{
//                        nublabel.text = [NSString stringWithFormat:@"%d", j+1];
//                        dianimage.image = UIImageGetImageFromName(@"XXHQ960.png");
//                    }
                }else{
                    if (j < 9) {
                        nublabel.text = [NSString stringWithFormat:@"%d", j+1];
                        dianimage.image = UIImageGetImageFromName(@"XXHQ960.png");
                    }else if((j+1) >33){
                        nublabel.text = [NSString stringWithFormat:@"%d", (j+1) - 33];
                        //                    nubimage.backgroundColor = [UIColor blueColor];
                        dianimage.image = UIImageGetImageFromName(@"XXlQ960.png");
                        
                    }else{
                        nublabel.text = [NSString stringWithFormat:@"%d", j+1];
                        dianimage.image = UIImageGetImageFromName(@"XXHQ960.png");
                    }
                }
                
                
                
                
//                nublabel.font = [UIFont systemFontOfSize:12];
                nublabel.textColor = [UIColor whiteColor];
                
                 nublabel.font = [UIFont boldSystemFontOfSize:9];
            }else{
                nublabel.font = [UIFont systemFontOfSize:9];
                 nublabel.frame = CGRectMake(1, 1, 14, 15);
                nublabel.textColor = [UIColor colorWithRed:31/255.0 green:101/255.0 blue:132/255.0 alpha:1];
                nubimage.tag = counttag;
                counttag++;
                labeltag++;
                imagetag++;
            }
            [nubimage addSubview:nublabel];
            [myScrollView addSubview:nubimage];
            [nublabel release];
            [nubimage release];
            
        }
    }
    
    leftimage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 180, 28, 28)];
    leftimage.backgroundColor = [UIColor clearColor];
    leftimage.image = UIImageGetImageFromName(@"tsjtyou.png");
    leftimage.alpha = 0;
#ifdef isCaiPiaoForIPad
      [self.mainView addSubview:leftimage];
#else
      [self.mainView addSubview:leftimage];
#endif
  
    [leftimage release];
    
    rightimage = [[UIImageView alloc] initWithFrame:CGRectMake(280, 180, 28, 28)];
    rightimage.backgroundColor = [UIColor clearColor];
    rightimage.image = UIImageGetImageFromName(@"tsjtzuo.png");
#ifdef isCaiPiaoForIPad
     [self.mainView addSubview:rightimage];
#else
     [self.mainView addSubview:rightimage];
#endif
   
    [rightimage release];
    
    NSString * countItem = @"";
#ifdef isCaiPiaoForIPad
    countItem = @"35";
#else
    
    if (IS_IPHONE_5) {
        countItem = @"23";
    }else{
        countItem = @"18";
    }
    
    
#endif

    
    if (yiloutu == kuaiLeShiFenYiLouType) {
        myScrollView.contentSize = CGSizeMake(17*20, 18*18+25);//CGRectMake(0, 0, 288, 19*20+20);
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL klsfLouTuLottery:@"kl10" item:countItem category:@""]];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
        [httpRequest setDidFailSelector:@selector(rebuyFail:)];
        [httpRequest startAsynchronous];
    }else if (yiloutu == kuai3FenxiYiLouType) {
        myScrollView.contentSize = CGSizeMake(17*49, 18*18+25);
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL kuai3YiLouTuo:@"kuai3" Item:@"30"]];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
        [httpRequest setDidFailSelector:@selector(rebuyFail:)];
        [httpRequest startAsynchronous];
    }else{
        myScrollView.contentSize = CGSizeMake(17*49, 18*18+25);//CGRectMake(0, 0, 288, 19*20+20);
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetYL:@"ssq"  Item:countItem]];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
        [httpRequest setDidFailSelector:@selector(rebuyFail:)];
        [httpRequest startAsynchronous];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{

//    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
}

#pragma mark viewDidLoad
- (void)goTalk{
     [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (yiloutu == kuaiLeShiFenYiLouType) {
        self.CP_navigation.title = @"快乐十分";
    }else if (yiloutu == kuai3FenxiYiLouType) {
    
        self.CP_navigation.title = @"快3";
    }else{
        self.CP_navigation.title = @"双色球走势图";
    }
#ifdef isCaiPiaoForIPad
    self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, 320, self.mainView.frame.size.height);
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height);
    self.CP_navigation.frame = CGRectMake(self.CP_navigation.frame.origin.x, self.CP_navigation.frame.origin.y, 320, self.CP_navigation.frame.size.height);

    UIBarButtonItem *right = [Info itemInitWithTitle:nil Target:self action:@selector(goTalk) ImageName:@"kf-quxiao2.png"];
    self.CP_navigation.rightBarButtonItem = right;
#endif
    
                     
                
    
//    [NSThread detachNewThreadSelector:@selector(doSomething:) toTarget:self withObject:nil];
//    NSThread* myThread = [[NSThread alloc] initWithTarget:self
//                                                   selector:@selector(doSomething:)
//                                                     object:nil];
//    [myThread start];
    
    allNumArray = [[NSMutableArray alloc] initWithCapacity:0];
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    
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
    [self.mainView  addSubview:bgview];
#else
    [self.mainView addSubview:bgview];
#endif
     bgview.image = [UIImageGetImageFromName(@"zstbg.png") stretchableImageWithLeftCapWidth:160 topCapHeight:210];
   bgview.frame = CGRectMake(0, -1, self.mainView.frame.size.width, self.mainView.frame.size.height + 2);
    [bgview release];
    
    
    myScrollView = [[YiLouTuScrollView alloc] initWithFrame:CGRectMake(35, 31, 273, 366)];
    if (IS_IPHONE_5) {
        myScrollView.frame = CGRectMake(35, 31, 273, 439);
       
    }
    [myScrollView setDelegate:self];
    myScrollView.mdelegate = self;
    [myScrollView setShowsVerticalScrollIndicator:NO];
    [myScrollView setShowsHorizontalScrollIndicator:NO];
    myScrollView.backgroundColor = [UIColor clearColor];
#ifdef isCaiPiaoForIPad
    myScrollView.frame = CGRectMake(35, 31-3, 273, 661);
    [self.mainView addSubview:myScrollView];
#else
    [self.mainView addSubview:myScrollView];
#endif
    
    [myScrollView release];
    

    [self performSelector:@selector(issuefunc) withObject:self afterDelay:0.1];
    [self performSelector:@selector(allNumberFunc) withObject:self afterDelay:0.1];
    
    
//    [self issuefunc];
//    [self allNumberFunc];
    
   
    
    
}

#pragma mark 数据的加载
- (void)uploadData{
    NSLog(@"isscout = %lu", (unsigned long)[issueArray count]);
    for (int i = 1; i < [issueArray count]+1; i++) {
        UILabel * issuelabel = (UILabel *)[self.mainView viewWithTag:i];
        NSString * issuestring = [issueArray objectAtIndex:i-1];
        
        if (yiloutu == kuaiLeShiFenYiLouType) {
            
            if ([issuestring length] > 4) {
                 issuelabel.text = [issuestring substringWithRange:NSMakeRange([issuestring length]-4, 4)];
            }
            
           

        }else{
            if ([issuestring length] > 3) {
                issuelabel.text = [issuestring substringWithRange:NSMakeRange([issuestring length]-3, 3)];
            }

            

        }
        
    }
    NSInteger counttag = 40;
    NSInteger labeltag = 2000;
    NSInteger iamgetag = 3000;
//    NSInteger heng = 0;
    NSInteger shu = 0;
    
#ifdef isCaiPiaoForIPad
    heng = 36;
#else
    if (IS_IPHONE_5) {
//        heng = 24;
    }else{
//        heng = 19;
    }
    
#endif
    if (yiloutu == kuaiLeShiFenYiLouType) {
        
        shu = 20;
    }else{
        
        shu = 49;
    
    }
    
    for (int i = 1; i < [allNumArray count]+1; i++) {
         NSArray * nubarr = [allNumArray objectAtIndex:i-1];
        for (int j = 0; j < shu; j++) {
            UIImageView * nubimage = (UIImageView *)[self.mainView viewWithTag:counttag];
            UILabel * nublable = (UILabel *)[nubimage viewWithTag:labeltag];//(i+1)*(j+1)+18+1000
            UIImageView * bianiamge = (UIImageView *)[nubimage viewWithTag:iamgetag];
            NSString * nubstring = [NSString stringWithFormat:@"%@", [nubarr objectAtIndex:j+1]];
             nublable.text = nubstring;
            if ([nubstring isEqualToString:@"0"]) {
                nublable.textColor = [UIColor whiteColor];
                 nublable.font = [UIFont boldSystemFontOfSize:9];
                if (yiloutu == kuaiLeShiFenYiLouType) {
                    if (j < 18) {
                        //                    nubimage.backgroundColor = [UIColor redColor];
                        
                        if (j < 9) {
                            nublable.text = [NSString stringWithFormat:@"%d", j+1];
                        }else{
                            nublable.text = [NSString stringWithFormat:@"%d", j+1];
                        }
                        bianiamge.image = UIImageGetImageFromName(@"HLXZSAN960.png");
                    }else{
                        bianiamge.image = UIImageGetImageFromName(@"HXZSAN960.png");
                        //                    nubimage.backgroundColor = [UIColor blueColor];
                        if ((j+1) > 18) {
                            NSInteger constdata = j+1;
                            
                           
                                nublable.text = [NSString stringWithFormat:@"%ld", (long)constdata];
                            
                            
                            
                        }
                    }

                }else{
                    if (j < 33) {
                        //                    nubimage.backgroundColor = [UIColor redColor];
                        
                        if (j < 9) {
                            nublable.text = [NSString stringWithFormat:@"%d", j+1];
                        }else{
                            nublable.text = [NSString stringWithFormat:@"%d", j+1];
                        }
                        bianiamge.image = UIImageGetImageFromName(@"HXZSAN960.png");
                    }else{
                        bianiamge.image = UIImageGetImageFromName(@"HLXZSAN960.png");
                        //                    nubimage.backgroundColor = [UIColor blueColor];
                        if ((j+1) > 33) {
                            NSInteger constdata = (j+1)-33;
                            if (counttag < 10) {
                                nublable.text = [NSString stringWithFormat:@"0%ld", (long)constdata];
                            }else{
                                nublable.text = [NSString stringWithFormat:@"%ld", (long)constdata];
                            }
                            
                            
                        }
                    }

                }
                
               
            }
           
            counttag++;
            labeltag++;
            iamgetag++;
        }
    }
     [loadview stopRemoveFromSuperview];
    loadview = nil;
}

#pragma mark 箭头消失
- (void)imageAlpha{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    
    leftimage.alpha = 0;
    rightimage.alpha = 0;
    
    [UIView commitAnimations];
    
}

#pragma mark requestFinished

- (void)rebuyFail:(ASIHTTPRequest *)request{
  [loadview stopRemoveFromSuperview];
    loadview = nil;
}

- (void)reqBuyLotteryFinished:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
	NSLog(@"%@",responseStr);
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        NSArray * array = [responseStr JSONValue];
        for (NSDictionary * dict in array) {
            NSString * issue = [dict objectForKey:@"issue"];
            NSArray * arrnumber = [dict objectForKey:@"arrNumber"];
            NSLog(@"issue = %@", issue);
            [issueArray addObject:issue];
            [allNumArray addObject:arrnumber];
            
            NSLog(@"bonus = %@", [dict objectForKey:@"bonusNumber"]);
        }
        [self uploadData];
        
        
        
        //    [self renturnNumView];
        //    [request clearDelegatesAndCancel];
        
        
//        if (yiloutu == kuaiLeShiFenYiLouType) {
//            myScrollView.contentSize = CGSizeMake(17*20, 18*[issueArray count]+25);//CGRectMake(0, 0, 288, 19*20+20);
//            
//        }else if (yiloutu == kuai3FenxiYiLouType) {
//            myScrollView.contentSize = CGSizeMake(17*49, 18*[issueArray count]+25);
//           
//            [httpRequest startAsynchronous];
//        }else{
//            myScrollView.contentSize = CGSizeMake(17*49, 18*[issueArray count]+25);//CGRectMake(0, 0, 288, 19*20+20);
//           
//        }
        
    }else{
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
   [self performSelector:@selector(imageAlpha) withObject:nil afterDelay:2];
}



#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(scrollView.contentOffset.x <= 0){
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    }
//    if(scrollView.contentOffset.x >= scrollView.contentSize.width - 280){
//        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width-272, scrollView.contentOffset.y);
//    }
    

//    if (scrollView.contentOffset.x <= 0) {
//        leftimage.alpha = 0;
//        rightimage.alpha = 1;
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(imageAlpha) object:nil];
//        [self performSelector:@selector(imageAlpha) withObject:nil afterDelay:1];
//    }else if(scrollView.contentOffset.x >= scrollView.contentSize.width - 288){
//        leftimage.alpha = 1;
//        rightimage.alpha = 0;
//          [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(imageAlpha) object:nil];
//        [self performSelector:@selector(imageAlpha) withObject:nil afterDelay:1];
//    }else{
//        leftimage.alpha = 1;
//        rightimage.alpha = 1;
//          [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(imageAlpha) object:nil];
//        [self performSelector:@selector(imageAlpha) withObject:nil afterDelay:1];
//    }
    
}

- (void)returnScrollViewTouch:(BOOL)touchbool{
    if (touchbool) {
        if (myScrollView.contentOffset.x <= 0) {
            leftimage.alpha = 0;
            rightimage.alpha = 1;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(imageAlpha) object:nil];
            [self performSelector:@selector(imageAlpha) withObject:nil afterDelay:1];
        }else if(myScrollView.contentOffset.x >= myScrollView.contentSize.width - 288){
            leftimage.alpha = 1;
            rightimage.alpha = 0;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(imageAlpha) object:nil];
            [self performSelector:@selector(imageAlpha) withObject:nil afterDelay:1];
        }else{
            leftimage.alpha = 1;
            rightimage.alpha = 1;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(imageAlpha) object:nil];
            [self performSelector:@selector(imageAlpha) withObject:nil afterDelay:1];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark dealloc
- (void)dealloc{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(imageAlpha) object:nil];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [allNumArray release];
    [issueArray release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    