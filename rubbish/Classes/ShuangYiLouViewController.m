    //
//  ShuangYiLouViewController.m
//  caibo
//
//  Created by yao on 12-5-19.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "ShuangYiLouViewController.h"
#import "NetURL.h"
#import "Info.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "JSON.h"
#import "GouCaiShuZiInfoViewController.h"
#import "caiboAppDelegate.h"

@implementation ShuangYiLouViewController

@synthesize item;
@synthesize httpRequest;
@synthesize issString;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    cout = 0;
    paixuarray = [[NSMutableArray alloc] initWithCapacity:0];
    arrbutton = [[NSMutableArray alloc] initWithCapacity:0];
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    yiLouShu = [[NSMutableArray  alloc] initWithCapacity:0];
    qiuGeShu = [[NSMutableDictionary alloc] initWithCapacity:0];
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgimage.image = UIImageGetImageFromName(@"login_bg.png");
    [self.view addSubview:bgimage];
    [bgimage release];
    self.title = @"双色球遗漏图";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
	self.navigationItem.leftBarButtonItem = leftItem;      
        rightItem = [Info itemInitWithTitle:@"投注" Target:self action:@selector(pressWriteButton:)];
        [self.navigationItem setRightBarButtonItem:rightItem];
    rightItem.enabled = NO;

    
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetYL:@"ssq"  Item:@"7"]];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
    [httpRequest startAsynchronous];
    
    
    
    qiuimageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 303, 50)];
    qiuimageview.backgroundColor = [UIColor clearColor];
    qiuimageview.image = UIImageGetImageFromName(@"gc_h_11.png");
    qiuimageview.userInteractionEnabled = YES;
    [self.view addSubview:qiuimageview];
    
   
   // [self shuangSeQiuImageView];
    
    qiuscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, 283, 30)];
    
    [qiuscrollView setDelegate:self];
    qiuscrollView.scrollsToTop = NO;
    [qiuscrollView setPagingEnabled:NO];
    [qiuscrollView setShowsVerticalScrollIndicator:NO];
    [qiuscrollView setShowsHorizontalScrollIndicator:YES];
    qiuscrollView.tag = 1;
    qiuscrollView.contentSize = CGSizeMake(qiuscrollView.frame.size.width * 6, qiuscrollView.frame.size.height);
  //  qiuscrollView.backgroundColor = [UIColor blueColor];
    [qiuimageview addSubview:qiuscrollView];
     currView = [[UIView alloc] init];
  //  currView.backgroundColor = [UIColor blackColor];
    [qiuscrollView addSubview:currView];
    
    
    pagecon = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 420, 320, 30)];
    pagecon.hidden = YES;
    [pagecon setNumberOfPages:6];
    [pagecon setCurrentPage:0];
    [pagecon addTarget:self action:@selector(qiuchangePage:) forControlEvents:(UIControlEventValueChanged)];
    
    [self.view addSubview:pagecon];
    
    huaDongImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 0, 49, 10)];
    huaDongImage.image = UIImageGetImageFromName(@"gc_h_97.png");
    
    UIImageView * tiaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(11, 60, 300, 10)];
    tiaoImage.image = UIImageGetImageFromName(@"gc_h_99.png");
    tiaoImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tiaoImage];
    [tiaoImage release];
     
    [tiaoImage addSubview:huaDongImage];
     
     
    numpage = 297;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(13, 70, 297, 350)];
    [scrollView setDelegate:self];
    scrollView.scrollsToTop = NO;
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.tag = 2;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 6, scrollView.frame.size.height);
    [self.view addSubview:scrollView];
  //  scrollView.backgroundColor = [UIColor whiteColor];
    
    
        
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 420, 320, 30)];
    [pageControl setNumberOfPages:6];
    pageControl.hidden = YES;
    [pageControl setCurrentPage:0];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:(UIControlEventValueChanged)];
   // pageControl.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:pageControl];
    
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 191, 35, 35);
    [leftButton setImage:UIImageGetImageFromName(@"gc_h_27.png") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(pressLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(285, 191, 35, 35);
    [rightButton setImage:UIImageGetImageFromName(@"gc_h_29.png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
}
- (void)qiuchangePage:(id)sender{
    int pagee = (int)pagecon.currentPage;
  //  NSLog(@"page = %d", page);
    CGRect frame = qiuscrollView.frame;
    frame.origin.x = frame.size.width * pagee;
    frame.origin.y = 0;
    //  huaDongImage.frame = CGRectMake(2+49*page, 0, 49, 10);
    [qiuscrollView scrollRectToVisible:frame animated:YES];
}

- (void)shuangSeQiuImageView:(NSInteger)sender{
    int max;
    //  UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, coutqiushu*30+50, 30)];
    currView.frame = CGRectMake(0, 0, 10+30*coutqiushu+30, 30); 
    //   currView.backgroundColor = [UIColor blackColor];
//    UIImageView * qiu1 = [[UIImageView alloc] initWithFrame:CGRectMake(coutqiushu*30, 0, 30, 30)];
//    qiu1.tag = sender;
//    qiu1.hidden = NO;
//    if (sender > 33) {
//        blueRed = YES;
//        
//        // qiu1.frame = CGRectMake(30*coutqiushu+bluecout*30, 0, 30, 30);
//    }else{
//        blueRed = NO;
//        // qiu1.frame = CGRectMake(30*coutqiushu, 0, 30, 30);
//    }
//    if (blueRed) {
//        qiu1.image = UIImageGetImageFromName(@"TZQL960.png");
//    }else{
//        qiu1.image = UIImageGetImageFromName(@"GC_redball_2.png");
//    }
//    
//    qiu1.backgroundColor = [UIColor clearColor];
//    
//    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    label1.tag = (coutqiushu+1)*10;
//    label1.textAlignment = NSTextAlignmentCenter;
//    label1.textColor = [UIColor whiteColor];
//    label1.backgroundColor = [UIColor clearColor];
//    label1.font = [UIFont systemFontOfSize:14];
//    
//    if (blueRed) {
//        if (sender - 33 < 10) {
//            label1.text = [NSString stringWithFormat:@"0%d", sender - 33];
//        }else{
//            label1.text = [NSString stringWithFormat:@"%d", sender - 33];
//        }
//    }else{
//        if (sender < 10) {
//            label1.text = [NSString stringWithFormat:@"0%d", sender];
//        }else{
//            label1.text = [NSString stringWithFormat:@"%d", sender];
//        }
//    }
//    
//    [qiu1 addSubview:label1];
    NSNumber * num = [NSNumber numberWithInt:(int)sender];
    
    if ([paixuarray count] == 0) {
        [paixuarray addObject:num];
    }else{
        max = 0;
        if ([[paixuarray objectAtIndex:0] intValue] > sender) {
            max = 0;
            [paixuarray insertObject:num atIndex:max];
        }
        else if ([[paixuarray lastObject] intValue] <sender) {
           // max = [paixuarray count];
            [paixuarray addObject:num];
        }
        else {
            for (int i = 0; i < [paixuarray count]-1; i++) {
                NSNumber * ber = [paixuarray objectAtIndex:i];
                NSNumber * ber2 = nil;
                if (i +1<[paixuarray count]) {
                    ber2  = [paixuarray objectAtIndex:i+1];
                }
                if (ber2 && [ber2 intValue]>sender && [ber intValue] < sender) {
                    max = i+1;
                }
            }
            [paixuarray insertObject:num atIndex:max];
        }
        
    }
   //   [currView removeFromSuperview];
    for (int i = 0 ; i < [paixuarray count]; i++) {
        NSNumber * bumb = [paixuarray objectAtIndex:i];
        UIButton * ima = (UIButton *)[currView viewWithTag:[bumb intValue]];
        
        ima.frame = CGRectMake(30*i, 0, 30, 30);
       if (!ima) {
            ima = [UIButton buttonWithType:UIButtonTypeCustom];
           buf[[bumb intValue]] = 1;
           ima.tag = [bumb intValue];
           ima.frame = CGRectMake(30*i, 0, 30, 30);
           [ima addTarget:self action:@selector(pressButtonShuang:) forControlEvents:UIControlEventTouchUpInside];
            [currView addSubview:ima];
           
            if ([bumb intValue] > 33) {
                blueRed = YES;
                
                // qiu1.frame = CGRectMake(30*coutqiushu+bluecout*30, 0, 30, 30);
            }else{
                blueRed = NO;
                // qiu1.frame = CGRectMake(30*coutqiushu, 0, 30, 30);
            }
            if (blueRed) {
                [ima setImage:UIImageGetImageFromName(@"TZQL960.png") forState:UIControlStateNormal];
              //  ima.image = UIImageGetImageFromName(@"TZQL960.png");
            }else{
                [ima setImage:UIImageGetImageFromName(@"TZQH960.png") forState:UIControlStateNormal];
                //ima.image = UIImageGetImageFromName(@"TZQH960.png");
            }
            
            ima.backgroundColor = [UIColor clearColor];
            
            UILabel * label12 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
           //label12.tag = (coutqiushu+1)*10;
            label12.textAlignment = NSTextAlignmentCenter;
            label12.textColor = [UIColor whiteColor];
            label12.backgroundColor = [UIColor clearColor];
            label12.font = [UIFont systemFontOfSize:14];
           ima.tag = [bumb intValue];
            if (blueRed) {
                if ([bumb intValue] - 33 < 10) {
                    label12.text = [NSString stringWithFormat:@"0%d", [bumb intValue] - 33];
                }else{
                    label12.text = [NSString stringWithFormat:@"%d", [bumb intValue] - 33];
                }
            }else{
                if ([bumb intValue] < 10) {
                    label12.text = [NSString stringWithFormat:@"0%d", [bumb intValue]];
                }else{
                    label12.text = [NSString stringWithFormat:@"%d", [bumb intValue]];
                }
            }
           
            [ima addSubview:label12];
            [label12 release];
           // [ima release];
       }
    }
    //   [currView addSubview:qiu1];
    //[qiu1 release];
    
  //  [label1 release];
    
    
    
    
    
}

- (void)pressLeftButton:(UIButton *)sender{
    
    if (numpage < 297) {
        return;
    }
    
    CGRect frame = scrollView.frame;
    numpage = numpage - frame.size.width;
    huaDongImage.frame = CGRectMake(2+49*(numpage/297), 0, 49, 10);
    frame.origin.x  = numpage;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void)pressButtonShuang:(UIButton *)sender{
    if (buf[sender.tag] == 0) {
        buf[sender.tag] = 1;
        [sender setImage:UIImageGetImageFromName(@"gc_h_5.png") forState:UIControlStateNormal];
        [self shuangSeQiuImageView:sender.tag];
      //  if (sender.tag < 34) {
            coutqiushu++;
        if (coutqiushu > 0) {
            rightItem.enabled = YES;
        }
      //  }else{
            bluecout++;
      //  }
           CGRect frame = currView.frame; 
          [qiuscrollView scrollRectToVisible:frame animated:YES];
        
    }else{
        coutqiushu--;
        if (coutqiushu == 0) {
            rightItem.enabled = NO;
        }
        if (sender.tag < 34) {
             UIButton * ima = (UIButton *)[numView viewWithTag:sender.tag];
             [ima setImage:UIImageGetImageFromName(@"gc_red_04.png") forState:UIControlStateNormal];
        }else{
            UIButton * ima = (UIButton *)[numView viewWithTag:sender.tag];
         [ima setImage:UIImageGetImageFromName(@"gc_n_03.png") forState:UIControlStateNormal];
        }
        
       
        buf[sender.tag] = 0;
        
//        CGRect frame = CGRectMake(0, 0, 0, 30);
//        // frame.origin.x  = currView.frame.origin.x - 30;
//        frame.size.width = coutqiushu*30;
//        NSLog(@"%f", frame.size.width);
        
//        CGRect frame = currView.frame;
//        frame.size.width = currView.frame.size.width - (currView.frame.size.width - 30*coutqiushu);
//        [qiuscrollView scrollRectToVisible:frame animated:YES];
        
        for (int i = 0; i < [paixuarray count]; i++) {
            NSNumber * ber = [paixuarray objectAtIndex:i];
            if ([ber intValue] == sender.tag) {
                UIImageView * ima = (UIImageView *)[currView viewWithTag:sender.tag];
                [ima removeFromSuperview];
                [paixuarray removeObjectAtIndex:i];
            }
        }
        
        for (int i = 0 ; i < [paixuarray count]; i++) {
            NSNumber * bumb = [paixuarray objectAtIndex:i];
            UIImageView * ima = (UIImageView *)[currView viewWithTag:[bumb intValue]];
            
            ima.frame = CGRectMake(30*i, 0, 30, 30);
        
        }
        
//        if ([paixuarray count] == 1) {
//            NSNumber * ber = [paixuarray objectAtIndex:0];
//            if ([ber intValue] == sender.tag) {
//                [paixuarray removeObjectAtIndex:0];
//                [currView removeFromSuperview];
//            }
//        }
//        CGRect frame = currView.frame;
//        frame.size.width = frame.size.width - 30;
//        [qiuscrollView scrollRectToVisible:frame animated:YES];
       
    }
}

- (void)pressRightButton:(UIButton *)sender{
    
    if (numpage > 297*6) {
        return;
    }
    
    CGRect frame = scrollView.frame;
    numpage = numpage + frame.size.width;
    NSLog(@"numpage right = %d", (int)numpage);
    huaDongImage.frame = CGRectMake(2+49*(numpage/297), 0, 49, 10);
    frame.origin.x = numpage;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void)renturnNumView{
    numView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 297*6, 400)];
    numView.backgroundColor = [UIColor clearColor];
    int width = 33;
    int height = 43;
   
    for (int i = 0; i < 7; i++) {
        NSArray * yiqiarr = [yiLouShu objectAtIndex:i]; 
        for (int j = 0; j < 50; j++) {   
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(j*width, i*height, width, height)];
            
            imageview.backgroundColor = [UIColor clearColor];
            
            if (j == 0) {
                imageview.image = UIImageGetImageFromName(@"gc_n_01.png");
                if ([issueArray count] > i) {
                    NSString * str = [issueArray objectAtIndex:i];
                    NSLog(@"str = %@", str);
                    UIFont * font = [UIFont fontWithName:@"Arial" size:13];
                    CGSize  size = CGSizeMake(width, height);
                    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                    UILabel * issLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 10, labelSize.width, labelSize.height)];
                    issLabel.backgroundColor = [UIColor clearColor];
                    issLabel.font = font;
                    issLabel.text = str;
                    issLabel.numberOfLines = 0;
                    issLabel.textAlignment = NSTextAlignmentCenter;
                    issLabel.textColor = [UIColor grayColor];
                    [imageview addSubview:issLabel];
                    [issLabel release];
      
                    
                }
                
                
            }else{
                
                imageview.image = UIImageGetImageFromName(@"gc_n_02.png");
            
                UILabel * numlabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 20, 15)];
                numlabel.textAlignment = NSTextAlignmentRight;
                numlabel.font = [UIFont systemFontOfSize:13];
                numlabel.backgroundColor = [UIColor clearColor];
               
                numlabel.text = [NSString stringWithFormat:@"%d" , [[yiqiarr objectAtIndex:j] intValue]];
                
                
                
                if ([numlabel.text isEqualToString:@"0"]) {
                    numlabel.text = @"0";
                    UIImageView * qiuimage = [[UIImageView alloc] initWithFrame:CGRectMake(3, 9, 30, 30)];
                    qiuimage.backgroundColor = [UIColor clearColor];
                    qiuimage.image = UIImageGetImageFromName(@"TZQH960.png");
                    
                    UILabel * qiuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                    qiuLabel.textAlignment = NSTextAlignmentCenter;
                    qiuLabel.textColor = [UIColor whiteColor];
                    qiuLabel.backgroundColor = [UIColor clearColor];
                    qiuLabel.font = [UIFont systemFontOfSize:12];
                    
                    if (j < 10) {
                        qiuLabel.text = [NSString stringWithFormat:@"0%d", j];
                    }else if(j > 33){
                        qiuimage.image = UIImageGetImageFromName(@"TZQL960.png");
                        if (j-33 < 10) {
                            qiuLabel.text = [NSString stringWithFormat:@"0%d", j-33];
                        }else{
                            qiuLabel.text = [NSString stringWithFormat:@"%d", j-33];
                        }
                        
                    }else {
                        qiuLabel.text = [NSString stringWithFormat:@"%d", j];
                    }
                    
                    
                    [qiuimage addSubview:qiuLabel];
                    [imageview addSubview:qiuimage];
                    [qiuimage release];
                    
                }
                
      
               
                [imageview  addSubview:numlabel];
                [numlabel release];
                    
             }   
                
         
            [numView addSubview:imageview];
            [imageview release];
        }
    }
    
    for (int i = 0; i < 50; i ++) {
        if (i == 0) {
            UIImageView * touzhuimage = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 301, width, height)];
            touzhuimage.image = UIImageGetImageFromName(@"gc_n_01.png");
            
            NSString * str = @"投注";
            NSLog(@"str = %@", str);
            UIFont * font = [UIFont fontWithName:@"Arial" size:18];
            CGSize  size = CGSizeMake(width, height);
            CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            UILabel * touzhulabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, labelSize.width, labelSize.height)];
            touzhulabel.backgroundColor = [UIColor clearColor];
            touzhulabel.font = font;
            touzhulabel.text = str;
            touzhulabel.numberOfLines = 0;
            touzhulabel.textAlignment = NSTextAlignmentCenter;
           // touzhulabel.textColor = [UIColor grayColor];
            [touzhuimage addSubview:touzhulabel];
            [touzhulabel release];

            
            
            [numView addSubview:touzhuimage];
            [touzhuimage release];
        }else{
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            button.frame = CGRectMake(i*width, 301, width, height);
            
            if (i < 34) {
                [button setImage:UIImageGetImageFromName(@"gc_red_04.png") forState:UIControlStateNormal];
            }else{
                [button setImage:UIImageGetImageFromName(@"gc_n_03.png") forState:UIControlStateNormal];
            }
            
            
            [button addTarget:self action:@selector(pressButtonShuang:) forControlEvents:UIControlEventTouchUpInside];
            UILabel * nulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            nulabel.textAlignment = NSTextAlignmentCenter;
            nulabel.textColor = [UIColor whiteColor];
            nulabel.backgroundColor = [UIColor clearColor];
            nulabel.font = [UIFont systemFontOfSize:14];
            if (i < 10) {
                nulabel.text = [NSString stringWithFormat:@"0%d", i];
            }else if(i > 33){
                if (i - 33 < 10) {
                    nulabel.text = [NSString stringWithFormat:@"0%d", i-33];
                    
                }else{
                    nulabel.text = [NSString stringWithFormat:@"%d", i-33];
                }
            }else {
                nulabel.text = [NSString stringWithFormat:@"%d", i];
            }
            
            [button addSubview:nulabel];
            [nulabel release];
            [numView addSubview:button];
            
        }
        
        
    }
    
    
    
    [scrollView addSubview:numView];
}

- (void)changePage:(id)sender{
    int page = (int)pageControl.currentPage;
    NSLog(@"page = %d", page);
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
  //  huaDongImage.frame = CGRectMake(2+49*page, 0, 49, 10);
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void) scrollViewDidScroll:(UIScrollView *)sender {
    if (sender.tag == 2) {
        leftButton.hidden = NO;
        rightButton.hidden = NO;
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
        huaDongImage.frame = CGRectMake(2+49*index, 0, 49, 10);
        pageControl.currentPage = index;
        [self performSelector:@selector(buttonxiaoshi) withObject:nil afterDelay:3];
    }
    if (sender.tag == 1) {
        int index = fabs(qiuscrollView.contentOffset.x) / qiuscrollView.frame.size.width;
        
        pagecon.currentPage = index;
    }
    
}
- (void)buttonxiaoshi{
    leftButton.hidden = YES;
    rightButton.hidden = YES;
}

- (void)pressWriteButton:(id)sender{
    
    
    NSString * stringstr = @"";
    int redco = 0;
    for (int i = 0; i < [paixuarray count]; i++) {
        NSNumber * numb = [paixuarray objectAtIndex:i];
        if ([numb intValue] < 34) {
            redco++;
            if ([numb intValue] < 10) {
                stringstr = [NSString stringWithFormat:@"%@0%d,", stringstr, [numb intValue]];
            }else{
                stringstr = [NSString stringWithFormat:@"%@%d,", stringstr, [numb intValue]];
            }
            
        }
       
    }
    stringstr = [stringstr substringToIndex:[stringstr length] - 1];
    stringstr = [NSString stringWithFormat:@"%@+", stringstr];
    
    NSLog(@"string = %@", stringstr);
    int bulunu=0;
    for (int i = 0; i < [paixuarray count]; i++) {
        NSNumber * numb = [paixuarray objectAtIndex:i];
        if ([numb intValue] > 33) {
            bulunu++;
            if ([numb intValue] - 33 < 10) {
                stringstr = [NSString stringWithFormat:@"%@0%d,", stringstr, [numb intValue]-33];
            }else{
                stringstr = [NSString stringWithFormat:@"%@%d,", stringstr, [numb intValue]-33];
            }
        }
    }
    if (redco < 6) {
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"至少选六个红球" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
    }else if (bulunu == 0) {
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"至少选一个蓝球" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
    }else{
    
        stringstr = [stringstr substringToIndex:[stringstr length] - 1];
        NSLog(@"string = %@", stringstr);
        if ([stringstr length] == 20) {
			stringstr = [NSString stringWithFormat:@"01#%@",stringstr];
		}
		else {
			stringstr = [NSString stringWithFormat:@"02#%@",stringstr];
		}
        
        
        if (!goucai) {
            goucai = [[GouCaiShuZiInfoViewController alloc] init];
        }
        
        if ([goucai.dataArray count] >=50) {
            caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
            [appDelegate showMessage:@"已有50组号码，先去投注吧"];
            [self.navigationController pushViewController:goucai animated:YES];
            return;
        }
        goucai.betInfo.issue = issString;
        [goucai.dataArray addObject:stringstr];
        [self.navigationController pushViewController:goucai animated:YES];
    }
    
   
}

- (void)doBack{
    if ([paixuarray count] != 0) {
        UIAlertView * aleer = [[UIAlertView alloc] initWithTitle:nil message:@"是否放弃选择的号码?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        aleer.tag = 2;
        [aleer show];
        [aleer release];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate



- (void)reqBuyLotteryFinished:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
	NSLog(@"%@",responseStr);
    NSArray * array = [responseStr JSONValue];
    for (NSDictionary * dict in array) {
//        NSString * span = [dict objectForKey:@"spanValue"];
//        NSString * and = [dict objectForKey:@"andValues"];
        NSString * issue = [dict objectForKey:@"issue"];
//        NSString * time = [dict objectForKey:@"bonusTime"];
        NSArray * arrnumber = [dict objectForKey:@"arrNumber"];
        for (NSString * s in arrnumber) {
            NSLog(@"asfsdf = %@", s);
        }
        NSLog(@"issue = %@", issue);
        [issueArray addObject:issue];
        [yiLouShu addObject:arrnumber];
        
        NSLog(@"bonus = %@", [dict objectForKey:@"bonusNumber"]);
    }
    
    [self renturnNumView];
    [request clearDelegatesAndCancel];
    [self performSelector:@selector(buttonxiaoshi) withObject:nil afterDelay:3];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [pagecon release];
    [goucai release];
    [currView release];
    [scrollView release];
    [qiuscrollView release];
    [huaDongImage release];
    [yiLouShu release];
    [issueArray release];
    [qiuGeShu release];
    [qiuimageview release];
	self.item = nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    