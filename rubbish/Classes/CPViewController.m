//
//  CPViewController.m
//  caibo
//
//  Created by yaofuyu on 12-12-12.
//
//

#import "CPViewController.h"
#import "WangqiKaJiangList.h"
#import "MobClick.h"
#import "SharedMethod.h"
#import "caiboAppDelegate.h"

@interface CPViewController ()

@end

@implementation CPViewController
//@synthesize view = _mainView;
@synthesize mainView = _mainView;
//@synthesize realView = _view;
@synthesize CP_navigation = _CP_navigation;
@synthesize isRealNavigationBarHidden;
@synthesize cpbackScrollView = _cpbackScrollView;
@synthesize cpissArray = _cpissArray;
@synthesize isIOS7Pianyi;
@synthesize isBianPing;
//@synthesize cpBottomImageView;
@synthesize cpHistoryBGImageView;
//@synthesize cpTopImageView;
//@synthesize cpVerticalBackScrollView;
@synthesize isKuaiSan;
@synthesize isHigher;
@synthesize cpLowermostScrollView;
@synthesize headYiLouView;
@synthesize cpLotteryName;
@synthesize yiLouView;
@synthesize yiLouViewHight, headHight;
//@synthesize shuZiBottomView;
//@synthesize jingCaiBottomView;
//@synthesize betInfoBottomView;

#define HISTORY_LINE_HEIGHT 33
#define HISTORY_LINE_COUNT 7
#define HISTORY_FONT [UIFont systemFontOfSize:15]

#define LUCKYBLUE_WIDTH 24


- (void)changeCSTitileColor {
    self.CP_navigation.backgroundColor = CS_NAVAGATION_COLOR;
    self.CP_navigation.barImage.backgroundColor = self.CP_navigation.backgroundColor;
    self.CP_navigation.titleLabel.textColor = [UIColor whiteColor];
    self.CP_navigation.lineView.hidden = YES;
    if ([self.navigationController.viewControllers count] > 1 && self.CP_navigation.leftBarButtonItem) {
        UIButton *btn = (UIButton *)self.CP_navigation.leftBarButtonItem.customView;
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"csnavawhiteback.png"] forState:(UIControlStateNormal)];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)changeCSTitle {
    [self changeOYTitle];
    return;
    
    if (![self.CP_navigation.backgroundColor isEqual:[UIColor colorWithRed:223/255.0 green:48/255.0 blue:49/255.0 alpha:1.0]]) {
        self.CP_navigation.backgroundColor = [UIColor colorWithRed:223/255.0 green:48/255.0 blue:49/255.0 alpha:1.0];
        self.CP_navigation.titleLabel.textColor = [UIColor whiteColor];
        self.CP_navigation.titleLabel.font = [UIFont systemFontOfSize:16];
        self.CP_navigation.barImage.backgroundColor = self.CP_navigation.backgroundColor;;
        self.CP_navigation.lineView.hidden = NO;
        if (self.CP_navigation.leftBarButtonItem) {
            self.CP_navigation.leftBarButtonItem =  [Info backItemTarget:self action:@selector(doBack) normalImage:@"CS_PopBack.png" highlightedImage:nil];
        }
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

- (void)changeOYTitle {
    if (![self.CP_navigation.backgroundColor isEqual:[UIColor colorWithRed:247/255.0 green:249/255.0 blue:253/255.0 alpha:1.0]]) {
        self.CP_navigation.backgroundColor = [UIColor colorWithRed:247/255.0 green:249/255.0 blue:253/255.0 alpha:1.0];
        self.CP_navigation.titleLabel.textColor = [UIColor blackColor];
        self.CP_navigation.titleLabel.font = [UIFont systemFontOfSize:16];
        self.CP_navigation.barImage.backgroundColor = self.CP_navigation.backgroundColor;

        if (self.CP_navigation.leftBarButtonItem) {
            if (!_independentLeftBarButtonItem) {
                self.CP_navigation.leftBarButtonItem =  [Info backItemTarget:self action:@selector(doBack) normalImage:@"OY_back.png" highlightedImage:nil];
            }
        }
        self.CP_navigation.lineView.hidden = NO;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadInitFunc{
    isRealNavigationBarHidden = NO;
    isBackScrollView = NO;
    isIOS7Pianyi = 0;
#ifndef isHaoLeCai
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        isIOS7Pianyi = 20;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
    isBianPing = YES;
    
    isVerticalBackScrollView = NO;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isRealNavigationBarHidden = NO;
        isBackScrollView = NO;
        isIOS7Pianyi = 0;
#ifndef isHaoLeCai
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            isIOS7Pianyi = 20;
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
#endif
        isBianPing = YES;
        
        isVerticalBackScrollView = NO;
    }
    return self;
}

#ifdef isHaoLeCai
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}
#endif



- (void)setIsRealNavigationBarHidden:(BOOL)isRealNavigationBarHidden1 {
    isRealNavigationBarHidden = isRealNavigationBarHidden1;
    if (isRealNavigationBarHidden1 == YES) {
        _CP_navigation.hidden = YES;
        _mainView.frame = CGRectMake(0, isIOS7Pianyi, self.view.frame.size.width, self.view.frame.size.height);
    }
    else {
        _CP_navigation.hidden = NO;
        _mainView.frame = CGRectMake(0,44, self.view.frame.size.width, self.view.frame.size.height -44);
        
    }
}



- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.CP_navigation.title = title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _CP_navigation = [[CPNavigationItem alloc] initWithFrame:CGRectMake(0, isIOS7Pianyi, 320, 44)];
#ifdef isCaiPiaoForIPad
    _CP_navigation.frame = CGRectMake(0, 0, 390, 44);
    _CP_navigation.image = UIImageGetImageFromName(@"daohangimage.png");
#else
//    _CP_navigation.image = UIImageGetImageFromName(@"daohang.png");
#endif
    if (isBianPing) {
//        self.CP_navigation.image = UIImageGetImageFromName(@"biaotilan.png");
        self.CP_navigation.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1];
        self.CP_navigation.barImage.backgroundColor = self.CP_navigation.backgroundColor;
    }else{
        self.CP_navigation.barImage.backgroundColor = self.CP_navigation.backgroundColor;
        
    }
    if (self.title) {
        _CP_navigation.title = self.title;
    }
    [self.view addSubview:_CP_navigation];
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0,44 + isIOS7Pianyi, self.view.frame.size.width, self.view.frame.size.height -44 - isIOS7Pianyi)];
        if (isBackScrollView) {
#ifdef isHaoLeCai
            _cpbackScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,44 +isIOS7Pianyi, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height  -44)];
#else
            _cpbackScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,44 +isIOS7Pianyi, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 20 -44)];
#endif
            [self.view addSubview:_cpbackScrollView];
            [_cpbackScrollView addSubview:_mainView];
            _cpbackScrollView.showsHorizontalScrollIndicator = NO;
            _cpbackScrollView.showsVerticalScrollIndicator = NO;
            _cpbackScrollView.delegate = self;
            _cpbackScrollView.bounces = NO;
//            _cpbackScrollView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
            _cpbackScrollView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];

            _cpbackScrollView.contentSize = CGSizeMake(320+260, _cpbackScrollView.bounds.size.height);
            
            _mainView.frame = CGRectMake(260, 0 + isIOS7Pianyi, _mainView.bounds.size.width, _mainView.bounds.size.height);
            [_cpbackScrollView scrollRectToVisible:CGRectMake(260, 0, 320, _cpbackScrollView.bounds.size.height) animated:NO];
            [_cpbackScrollView release];
            _cpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 260, _cpbackScrollView.bounds.size.height)];
            _cpTableView.delegate = self;
            _cpTableView.dataSource = self;
            _cpTableView.showsVerticalScrollIndicator = NO;
            [_cpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            _cpTableView.backgroundColor = [UIColor clearColor];
            [_cpbackScrollView addSubview:_cpTableView];
            [_cpTableView release];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                _cpbackScrollView.frame = CGRectMake(0, 44+ isIOS7Pianyi, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 44 -isIOS7Pianyi);
                _cpbackScrollView.contentSize = CGSizeMake(320+260, _cpbackScrollView.bounds.size.height);
                [_cpbackScrollView scrollRectToVisible:CGRectMake(260, 0, 320, _cpbackScrollView.bounds.size.height) animated:NO];
                _cpTableView.frame = CGRectMake(0, 0, 260, _cpbackScrollView.bounds.size.height);
            }
            
        }else if (isVerticalBackScrollView == YES){
            _mainView.backgroundColor = [UIColor clearColor];
            
            UIImageView * cpLowermostBG = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
            if (isKuaiSan) {
//                cpLowermostBG.image = UIImageGetImageFromName(@"kuaisanback.jpg");
                cpLowermostBG.backgroundColor = [UIColor colorWithRed:10/255.0 green:153/255.0 blue:122/255.0 alpha:1];
            }else{
//                cpLowermostBG.image = UIImageGetImageFromName(@"login_bgn.png");
                cpLowermostBG.backgroundColor = DEFAULT_BACKGROUNDCOLOR_SHUZI;
            }
            cpLowermostBG.tag = 5566;
            [self.view addSubview:cpLowermostBG];
            
            cpLowermostScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 44 + isIOS7Pianyi, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:cpLowermostScrollView];
            cpLowermostScrollView.bounces = NO;
            cpLowermostScrollView.scrollEnabled = YES;
            cpLowermostScrollView.delegate = self;
            cpLowermostScrollView.backgroundColor = [UIColor clearColor];
            cpLowermostScrollView.showsHorizontalScrollIndicator = NO;
            cpLowermostScrollView.showsVerticalScrollIndicator = NO;
            
            cpHistoryBGImageView = [[UIImageView alloc] init];
            cpHistoryBGImageView.frame = CGRectMake(0, 0, 320, HISTORY_LINE_COUNT * HISTORY_LINE_HEIGHT);
                if (cpLotteryName == kuailePukeType) {
                    cpHistoryBGImageView.image = UIImageGetImageFromName(@"NormalHistoryBG.png");
                }else{
                    cpHistoryBGImageView.backgroundColor = [UIColor colorWithRed:221/255.0 green:220/255.0 blue:212/255.0 alpha:1];
                }
            cpHistoryBGImageView.userInteractionEnabled = YES;
            [cpLowermostScrollView addSubview:cpHistoryBGImageView];
            
            for (int i = 0; i < HISTORY_LINE_COUNT; i++) {
                UIImageView * historyBGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,  i*HISTORY_LINE_HEIGHT, 320, HISTORY_LINE_HEIGHT)];
                if (i%2 == 0 && isKuaiSan) {
                    historyBGImageView.backgroundColor = [UIColor colorWithRed:4/255.0 green:95/255.0 blue:75/255.0 alpha:1];
                }
                else if (i%2 != 0 && isKuaiSan) {
                    historyBGImageView.backgroundColor = [UIColor colorWithRed:5/255.0 green:118/255.0 blue:93/255.0 alpha:1];
                }
                else if (i%2 == 0 && !isKuaiSan) {
                    historyBGImageView.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:231/255.0 alpha:1];
                }
                [cpHistoryBGImageView addSubview:historyBGImageView];
                [historyBGImageView release];
            }
            
            UILabel * topLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, cpHistoryBGImageView.frame.size.width, HISTORY_LINE_HEIGHT)] autorelease];
            topLabel.text = @"点击以下开奖号区域可查看更多";
            topLabel.font = HISTORY_FONT;
            if (isKuaiSan) {
                topLabel.textColor = [UIColor colorWithRed:249/255.0 green:252/255.0 blue:165/255.0 alpha:1];
            }else{
                topLabel.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
            }
            topLabel.textAlignment = 1;
            [cpHistoryBGImageView addSubview:topLabel];
            topLabel.backgroundColor = [UIColor clearColor];
            
            UIButton * historyButton = [[[UIButton alloc] initWithFrame:cpHistoryBGImageView.bounds] autorelease];
            [cpHistoryBGImageView addSubview:historyButton];
            historyButton.backgroundColor = [UIColor clearColor];
            historyButton.tag = 800;
            
            _mainView.frame = CGRectMake(0, ORIGIN_Y(cpHistoryBGImageView), 320, self.view.frame.size.height - 44 - isIOS7Pianyi);
            
            cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + (44 + isIOS7Pianyi));
            cpLowermostScrollView.contentOffset = CGPointMake(0, cpHistoryBGImageView.frame.size.height);
            
            [cpLowermostScrollView addSubview:_mainView];
        }
        else {
            [self.view addSubview:_mainView];
        }
        
    }
#ifdef isCaiPiaoForIPad
    
    if (isBackScrollView) {
        _cpbackScrollView.frame = CGRectMake(0, 44, 390, 768 - 20 -44);
        _cpbackScrollView.contentSize = CGSizeMake(390+260, _cpbackScrollView.bounds.size.height);
        [_cpbackScrollView scrollRectToVisible:CGRectMake(260, 0, 390, _cpbackScrollView.bounds.size.height) animated:NO];
        _mainView.frame = CGRectMake(260,0, 390, 768 - 20 -44);
    }
    else {
        _mainView.frame = CGRectMake(0,44, 390, 768 - 20 -44);
    }
#else
    if (isBackScrollView) {
#ifdef isHaoLeCai
        _mainView.frame = CGRectMake(260,0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height  - 44);
#else
        _mainView.frame = CGRectMake(260,0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44);
#endif
    }
    else if(isVerticalBackScrollView){
        
    }
    else {
#ifdef isHaoLeCai
        _mainView.frame = CGRectMake(0,44, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 44);
#else
        _mainView.frame = CGRectMake(0,44 + isIOS7Pianyi, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44);
        
#endif
    }
    
    
#endif
    
    
	// Do any additional setup after loading the view.
}

- (void)scrollViewYiLou:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= ORIGIN_Y(yiLouView)-headYiLouView.frame.size.height) {
        
        headYiLouView.frame = CGRectMake(headYiLouView.frame.origin.x,  ORIGIN_Y(_CP_navigation) - (scrollView.contentOffset.y - (ORIGIN_Y(yiLouView) - headYiLouView.frame.size.height)), headYiLouView.frame.size.width, headYiLouView.frame.size.height);
        
    }else{
        if (scrollView.contentOffset.y <= ORIGIN_Y(yiLouView)-headYiLouView.frame.size.height) {
            headYiLouView.frame =CGRectMake(0, ORIGIN_Y(_CP_navigation), headYiLouView.frame.size.width, headYiLouView.frame.size.height);//头部
        }
        
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (showYiLou) {
        //        NSLog(@"cpLowermostScrollView.y = %f , yiLouView = %f, xx = %f, z = %f", cpLowermostScrollView.contentOffset.y, ORIGIN_Y(yiLouView),  ORIGIN_Y(_CP_navigation) - (cpLowermostScrollView.contentOffset.y - (ORIGIN_Y(yiLouView) - headYiLouView.frame.size.height)), ORIGIN_Y(yiLouView)-headYiLouView.frame.size.height);
//        if (cpLotteryName == shiyixuanwuType || cpLotteryName == kuaileshifenType || cpLotteryName == kuaisanType || cpLotteryName == shuangseqiuType) {
            [self scrollViewYiLou:cpLowermostScrollView];
//        }
//        else if (cpLotteryName == daletouType){
//            [self scrollViewYiLou:_cpbackScrollView];
//        }
        
    }
    
    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (showYiLou == NO) {
        if (scrollView == _cpbackScrollView) {
            if (decelerate) {
                return;
            }
            if (scrollView.contentOffset.x < 200) {
                scrollView.contentOffset = CGPointMake(0, 0);
            }
            else {
                scrollView.contentOffset = CGPointMake(260, 0);
                
            }
        }else if (scrollView == cpLowermostScrollView) {
            NSLog(@"~~~~%f~~~~~%f",_mainView.bounds.origin.y,cpHistoryBGImageView.frame.size.height);
            if (!decelerate && scrollView.contentOffset.y <= cpHistoryBGImageView.frame.size.height/2) {
                [scrollView setContentOffset:CGPointZero animated:YES];
            }else if (!decelerate && scrollView.contentOffset.y <= cpHistoryBGImageView.frame.size.height) {
                [scrollView setContentOffset:CGPointMake(0, cpHistoryBGImageView.frame.size.height) animated:YES];
            }else if (decelerate) {
                
            }
            else{
                
            }
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrllTo {
    [_cpbackScrollView scrollRectToVisible:CGRectMake(0, 0, 320, _cpbackScrollView.bounds.size.height) animated:YES];
    [self performSelector:@selector(scrollBack) withObject:nil afterDelay:1];
}

- (void)scrollBack {
    [_cpbackScrollView scrollRectToVisible:CGRectMake(260, 0, 320, _cpbackScrollView.bounds.size.height) animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view bringSubviewToFront:_CP_navigation];

    

//     || [NSStringFromClass(self.class) isEqualToString:@"NeoHomeViewController"] || [NSStringFromClass(self.class) isEqualToString:@"GenDanViewController"] || [NSStringFromClass(self.class) isEqualToString:@"GouCaiHomeViewController"]
    if ([NSStringFromClass(self.class) hasPrefix:@"OY_"]|| [NSStringFromClass(self.class) isEqualToString:@"NeoHomeViewController"] || [NSStringFromClass(self.class) isEqualToString:@"GenDanViewController"] || [NSStringFromClass(self.class) isEqualToString:@"GouCaiHomeViewController"]) {
        [self changeOYTitle];
    }
    else if ([NSStringFromClass(self.class) hasPrefix:@"CS_"]) {
        if ([NSStringFromClass(self.class) isEqualToString:@"CS_HomeViewController"] || [NSStringFromClass(self.class) isEqualToString:@"CS_ConsultViewController"] || [NSStringFromClass(self.class) isEqualToString:@"CS_LotteryViewController"] || [NSStringFromClass(self.class) isEqualToString:@"CS_GuessViewController"] || [NSStringFromClass(self.class) isEqualToString:@"CS_QuizRecordViewController"] || [NSStringFromClass(self.class) isEqualToString:@"CS_PersonalCenterViewController"]){
            [self changeCSTitileColor];
        }else{
            [self changeOYTitle];
        }
    }
    else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
     [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",self.class]];
    if (isBackScrollView && [[[NSUserDefaults standardUserDefaults] valueForKey:@"showHistory"] intValue] <= 2) {
        [self performSelector:@selector(scrllTo) withObject:nil afterDelay:1];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"showHistory"] intValue] + 1] forKey:@"showHistory"];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@",self.class]];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc {
    [_mainView release];
    [_CP_navigation release];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    //    [cpTopImageView release];
    [cpHistoryBGImageView release];
    //    [cpBottomImageView release];
    //    [cpVerticalBackScrollView release];
    [cpLowermostScrollView release];
//    [shuZiBottomView release];
//    [jingCaiBottomView release];
//    [betInfoBottomView release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark Table view data source




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
    
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    return cell;
}

-(void)addHistoryWithArray:(NSArray *)historyArray
{
    float labelWidth = 0,a = 0;
    for (int i = 0; i < historyArray.count; i++) {
        float newX = 17;
        for (int j = 0; j < [[historyArray objectAtIndex:i] count]; j++) {
            UILabel * label = (UILabel *)[cpHistoryBGImageView viewWithTag:100 + 10*i + j];
            if (!label) {
                label = [[UILabel alloc] init];
                [cpHistoryBGImageView addSubview:label];
                label.tag = 100 + 10*i + j;
                label.font = HISTORY_FONT;
                label.backgroundColor = [UIColor clearColor];
                [label release];
            }
            label.text = [[historyArray objectAtIndex:i] objectAtIndex:j];
            
            CGSize labelSize = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000,HISTORY_LINE_HEIGHT) lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel * firstLabel = (UILabel *)[cpHistoryBGImageView viewWithTag:100 + j];
            
            label.frame = CGRectMake(newX, HISTORY_LINE_HEIGHT + i*HISTORY_LINE_HEIGHT, labelSize.width, HISTORY_LINE_HEIGHT);
            
            if (i == 1 && j > 0) {
                firstLabel.frame = CGRectMake(label.frame.origin.x + (label.frame.size.width - firstLabel.frame.size.width)/2, firstLabel.frame.origin.y, firstLabel.frame.size.width, firstLabel.frame.size.height);
            }
            
            if (i != 0) {
                label.frame = CGRectMake(firstLabel.frame.origin.x + (firstLabel.frame.size.width - labelSize.width)/2, HISTORY_LINE_HEIGHT + i * HISTORY_LINE_HEIGHT, labelSize.width, HISTORY_LINE_HEIGHT);
            }
            
            int first = 0;
            
            if (i == 0) {
                label.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
                float width = 0;
                if (historyArray.count > 1) {
                    first = 1;
                }
                for (int k = 0; k < [[historyArray objectAtIndex:first] count] - 1; k++) {
                    CGSize labelSize = [[[historyArray objectAtIndex:first] objectAtIndex:k + 1] sizeWithFont:label.font constrainedToSize:CGSizeMake(1000,HISTORY_LINE_HEIGHT) lineBreakMode:NSLineBreakByWordWrapping];
                    width += labelSize.width;
                }
                if (j == 0) {
                    UIImageView * yellowImageView = (UIImageView *)[cpHistoryBGImageView viewWithTag:999];
                    if (!yellowImageView) {
                        yellowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(label) + 19 - ([[historyArray objectAtIndex:i] count]) * 3, ORIGIN_Y(label) + 12, 6, 6)];
                        yellowImageView.tag = 999;
                        if (isKuaiSan) {
                            yellowImageView.image = UIImageGetImageFromName(@"HistoryYellow.png");
                        }else{
                            yellowImageView.image = UIImageGetImageFromName(@"HistoryOrange.png");
                        }
                        [cpHistoryBGImageView addSubview:yellowImageView];
                        [yellowImageView release];
                    }
                    
                    newX = ORIGIN_X(yellowImageView);
                    labelWidth = newX;
                    
                    float b = (320 - ORIGIN_X(yellowImageView) - width)/[[historyArray objectAtIndex:first] count];
                    a = b;
                }
            }else{
                if (j == 0) {
                    if (i == 1) {
                        label.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
                    }
                    else{
                        label.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
                    }
                    newX = labelWidth;
                }
                else if (j == 1)
                {
                    label.textColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
                }
                else{
                    label.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
                }
            }
            if (isKuaiSan) {
                label.textColor = [UIColor colorWithRed:78/255.0 green:181/255.0 blue:159/255.0 alpha:1];
            }
            if ([label.text hasPrefix:@"+"]) {
                label.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
                UILabel * lastLabel = (UILabel *)[cpHistoryBGImageView viewWithTag:100 + 10*i + j - 1];
                
                label.frame = CGRectMake(cpHistoryBGImageView.frame.size.width - 17 - labelSize.width, lastLabel.frame.origin.y, labelSize.width, lastLabel.frame.size.height);
                label.text = [label.text stringByReplacingOccurrencesOfString:@"+" withString:@" "];
                
                lastLabel.frame = CGRectMake(label.frame.origin.x - lastLabel.frame.size.width, lastLabel.frame.origin.y, lastLabel.frame.size.width, lastLabel.frame.size.height);
                
                UILabel * firstLabel = (UILabel *)[cpHistoryBGImageView viewWithTag:100 + j - 1];
                firstLabel.frame = CGRectMake(lastLabel.frame.origin.x + (lastLabel.frame.size.width + label.frame.size.width - firstLabel.frame.size.width)/2, firstLabel.frame.origin.y, firstLabel.frame.size.width, firstLabel.frame.size.height);
            }
            if ([label.text hasPrefix:@"*"]) {
                UILabel * redLabel = (UILabel *)[cpHistoryBGImageView viewWithTag:100 + 10*i + j - 2];
                redLabel.frame = CGRectMake(redLabel.frame.origin.x - LUCKYBLUE_WIDTH + 10, redLabel.frame.origin.y, redLabel.frame.size.width, redLabel.frame.size.height);
                
                UILabel * blueLabel = (UILabel *)[cpHistoryBGImageView viewWithTag:100 + 10*i + j - 1];
                blueLabel.frame = CGRectMake(blueLabel.frame.origin.x - LUCKYBLUE_WIDTH + 10, blueLabel.frame.origin.y, blueLabel.frame.size.width, blueLabel.frame.size.height);
                
                label.frame = CGRectMake(ORIGIN_X(blueLabel), blueLabel.frame.origin.y, labelSize.width, blueLabel.frame.size.height);
                label.text = [label.text stringByReplacingOccurrencesOfString:@"*" withString:@" "];
                label.textColor = [UIColor whiteColor];
                
                UILabel * image = (UILabel *)[cpHistoryBGImageView viewWithTag:1000 + i];
                if (!image) {
                    UIImageView * luckyblueImageView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"luckyblue.png")];
                    [cpHistoryBGImageView addSubview:luckyblueImageView];
                    luckyblueImageView.frame = CGRectMake(ORIGIN_X(blueLabel), blueLabel.frame.origin.y + (HISTORY_LINE_HEIGHT - LUCKYBLUE_WIDTH)/2 + 1, LUCKYBLUE_WIDTH, LUCKYBLUE_WIDTH);
                    [cpHistoryBGImageView insertSubview:luckyblueImageView belowSubview:label];
                    luckyblueImageView.tag = 1000 + i;
                    [luckyblueImageView release];
                }
            }
            if (j == 0) {
                newX += a;
            }else{
                newX += label.frame.size.width + a;
            }
        }
    }
    
    UIButton * historyButton = (UIButton *)[cpHistoryBGImageView viewWithTag:800];
    [cpHistoryBGImageView bringSubviewToFront:historyButton];
}

//遗漏图

- (void)scrollViewFrameSize:(UIScrollView *)scrollView{
    
    _mainView.frame = CGRectMake(0, ORIGIN_Y(yiLouView), 320, _mainView.frame.size.height - 44);
    
    
    if (_mainView.frame.size.height < self.view.frame.size.height - ORIGIN_Y(_CP_navigation) - 44) {
        
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - ORIGIN_Y(_CP_navigation) - 44);
    }
    
    scrollView.frame = CGRectMake(self.view.frame.origin.x, 44 + isIOS7Pianyi , self.view.frame.size.width, self.view.frame.size.height - ORIGIN_Y(_CP_navigation) - 44);
//    if (cpLotteryName == daletouTye){
//        scrollView.contentSize = CGSizeMake(0,  ORIGIN_Y(_mainView));
//    }else{
        scrollView.contentSize = CGSizeMake(0,  ORIGIN_Y(_mainView));
//    }
    
    scrollView.contentOffset = CGPointMake(0, 0);
    
}
- (void)showYiLouView{
    
    if (!yiLouView) {
        
        headYiLouView = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_CP_navigation), 320, headHight)];//头部
        headYiLouView.backgroundColor = [UIColor clearColor];
        //            [self.view addSubview:headYiLouView];
        [self.view insertSubview:headYiLouView belowSubview:_CP_navigation];
        [headYiLouView release];
        
        yiLouView = [[UIView alloc] initWithFrame:CGRectMake(0, headYiLouView.frame.size.height, 320, yiLouViewHight)];//遗漏显示 self.view.frame.size.height - 44 - 44 - isIOS7Pianyi - headYiLouView.frame.size.height
        yiLouView.backgroundColor = [UIColor clearColor];
//        if (cpLotteryName == shiyixuanwuType || cpLotteryName == kuaisanType || cpLotteryName == kuaileshifenType || cpLotteryName == shuangseqiuType) {
            [cpLowermostScrollView addSubview:yiLouView];
//        }else{
//            [_cpbackScrollView addSubview:yiLouView];
//            
//        }
        
        [yiLouView release];
        
        
        
    }
    yiLouView.hidden = NO;
    headYiLouView.hidden = NO;
    headYiLouView.frame = CGRectMake(0, ORIGIN_Y(_CP_navigation), 320, headHight);
    yiLouView.frame = CGRectMake(0, headYiLouView.frame.size.height, 320, yiLouViewHight);
    cpHistoryBGImageView.hidden = YES;
    
//    if (cpLotteryName == shiyixuanwuType || cpLotteryName == kuaisanType || cpLotteryName == kuaileshifenType || cpLotteryName == shuangseqiuType) {
        [self scrollViewFrameSize:cpLowermostScrollView];
//    }else{
//        _cpTableView.hidden = YES;
//        [self scrollViewFrameSize: _cpbackScrollView];
//    }
    
    
}

- (void)disappearYiLouView{
    
//    if (cpLotteryName == shiyixuanwuType || cpLotteryName == kuaisanType || cpLotteryName == kuaileshifenType || cpLotteryName == shuangseqiuType) {
    
        yiLouView.hidden = YES;
        headYiLouView.hidden = YES;
        cpHistoryBGImageView.hidden = NO;
        cpLowermostScrollView.frame = CGRectMake(self.view.frame.origin.x, 44 + isIOS7Pianyi, self.view.frame.size.width, self.view.frame.size.height);
        _mainView.frame = CGRectMake(0, ORIGIN_Y(cpHistoryBGImageView), 320, self.view.frame.size.height - 44 - isIOS7Pianyi);
        cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + (44 + isIOS7Pianyi));
        cpLowermostScrollView.contentOffset = CGPointMake(0, cpHistoryBGImageView.frame.size.height);
        
        
//    }
//    else if (cpLotteryName == daletouTye){
//        
//        headYiLouView.hidden = YES;
//        yiLouView.hidden = YES;
//        _cpTableView.hidden = NO;
//        _cpbackScrollView.frame = CGRectMake(0,44 +isIOS7Pianyi, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - isIOS7Pianyi -44);
//        //        _cpbackScrollView.contentSize = CGSizeMake(320+260, _cpbackScrollView.bounds.size.height);
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//            //            _cpbackScrollView.frame = CGRectMake(0, 44+ isIOS7Pianyi, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 44 -isIOS7Pianyi );
//            //            _cpbackScrollView.contentSize = CGSizeMake(320+260, _cpbackScrollView.bounds.size.height);
//            [_cpbackScrollView scrollRectToVisible:CGRectMake(260, 0, 320, _cpbackScrollView.bounds.size.height) animated:NO];
//            
//        }
//        //        _cpTableView.frame = CGRectMake(0, 0, 260,[UIScreen mainScreen].bounds.size.height - 44 -isIOS7Pianyi);
//        _cpbackScrollView.contentSize = CGSizeMake(320+260, _cpbackScrollView.bounds.size.height);
//        if (isBackScrollView) {
//            _mainView.frame = CGRectMake(260,0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44);
//        }
//        _cpbackScrollView.contentOffset = CGPointMake(260, 0);
//        
//    }
    
    
}

- (BOOL)showYiLou{//get方法
    return showYiLou;
}

- (void)setShowYiLou:(BOOL)_showYiLou{//set方法
    showYiLou = _showYiLou;
    if (showYiLou) {
        
        [self showYiLouView];
        
    }else{
        
        [self disappearYiLouView];
        
    }
    
}

-(void)addShuZiBottomView
{
//    if (!shuZiBottomView) {
//        shuZiBottomView = [[ShuZiBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.mainView.frame.size.width, 49)];
//        shuZiBottomView.zhuShuLabel.text = @"0";
//        shuZiBottomView.moneyLabel.text = @"0";
//    }
//    [self.view addSubview:shuZiBottomView];
}

-(void)addJingCaiBottomView
{
//    if (!jingCaiBottomView) {
//        jingCaiBottomView = [[JingCaiBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.mainView.frame.size.width, 49)];
//        [jingCaiBottomView.chuanButton setTitle:@"串法" forState:UIControlStateNormal];
//        jingCaiBottomView.zhuShuLabel.text = @"0";
//        jingCaiBottomView.moneyLabel.text = @"0";
//        jingCaiBottomView.zhuLabel.text = @"场";
//    }
//    [self.view addSubview:jingCaiBottomView];
}

-(void)addBetInfoBottomView
{
//    if (!betInfoBottomView) {
//        betInfoBottomView = [[BetInfoBottomView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height - 49, self.mainView.frame.size.width, 49)];
//        [self.mainView addSubview:betInfoBottomView];
//    }
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    