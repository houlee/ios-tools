//
//  HRSliderViewController.m
//  caibo
//
//  Created by cp365dev on 14-7-30.
//
//

#import "HRSliderViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "CPSetViewController.h"
#import "GouCaiHomeViewController.h"
#import "Info.h"

#import "caiboAppDelegate.h"
#import "AccountDrawalViewController.h"
#import "MLNavigationController.h"
#import "GCXianJinLiuShuiController.h"

#define ContentOffset 300.0f
#define IOS_7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
@interface HRSliderViewController ()
{
    UIView *_mainContentView;
    UIView *_leftSideView;
    
    UITapGestureRecognizer *_tapGestureRec;
    UIPanGestureRecognizer *_panGestureRec;
    
    MLNavigationController *controller;
    
    BOOL isTransing;
    BOOL isDisAbleOther;
    
}

@end

@implementation HRSliderViewController

- (void)passWordOpenUrl{
    
    
}


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
    
    isTransing = NO;
    self.CP_navigation.hidden = YES;

    [self setIsRealNavigationBarHidden:YES];
    
    [self addTransView];
    
    [self showContentControllerWithModel];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canNotPan:) name:@"CannotPanGestureRecognizer" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canPan:) name:@"CanPanGestureRecognizer" object:nil];
    
}
-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [controller release];
    _mainContentView = nil;
    _leftSideView = nil;
    [_panGestureRec release];
    [_tapGestureRec release];
    [super dealloc];
}
-(void)canNotPan:(NSNotification *)notification
{
    _panGestureRec.enabled = NO;
}
-(void)canPan:(NSNotification *)notification
{
    _panGestureRec.enabled = YES;

}
#pragma mark - 抽屉动画效果

//按钮点击
- (void)setBtnClick:(UIButton *)btn
{
    if(isTransing)
    {
        CGAffineTransform oriT = CGAffineTransformIdentity;
        [UIView beginAnimations:nil context:nil];
        _mainContentView.transform = oriT;
        [UIView commitAnimations];
        isTransing = NO;
    }
    else
    {
        CGAffineTransform conT = [self transformWithDirection];
        
        [self configureViewShadowWithDirection];
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             _mainContentView.transform = conT;
                         }
                         completion:^(BOOL finished) {
                             _tapGestureRec.enabled = YES;
                             isTransing = YES;
                         }];
        
        [self setUserEanble:NO];
    }
    
    
    
}
- (CGAffineTransform)transformWithDirection
{
    CGFloat translateX = -ContentOffset;
    
    NSLog(@"%.2f",translateX);
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(0.8, 0.8);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}
- (void)configureViewShadowWithDirection
{
    CGFloat shadowW = 2.0f;
    
    _mainContentView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    _mainContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainContentView.layer.shadowOpacity = 0.8f;
}

- (void)closeSideBar
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3
                     animations:^{
                         _mainContentView.transform = oriT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = NO;
                         isTransing = NO;
                         
                     }];
    
    [self setUserEanble:YES];
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    
    if (!isDisAbleOther) {
        [(MLNavigationController *)self.navigationController paningGestureReceive:panGes];
    }
    
    
    static CGFloat currentTranslateX;
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        currentTranslateX = _mainContentView.transform.tx;
        
        
    }
    if (panGes.state == UIGestureRecognizerStateChanged)
    {
        CGFloat transX = [panGes translationInView:_mainContentView].x;
        transX = transX + currentTranslateX;
        
        CGFloat sca;
        
        if (transX < 0)
        {
            
            [self.mainView sendSubviewToBack:_leftSideView];
            [self configureViewShadowWithDirection];
            
            if (_mainContentView.frame.origin.x > -ContentOffset)
            {
                sca = 1 - (-_mainContentView.frame.origin.x/ContentOffset) * (1-0.8);
            }
            else
            {
                sca = 0.8;
            }
            
            
            CGAffineTransform transS = CGAffineTransformMakeScale(1, sca);
            CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
            
            CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
            
            _mainContentView.transform = conT;
        }

        
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        CGFloat panX = [panGes translationInView:_mainContentView].x;
        CGFloat finalX = currentTranslateX + panX;
        
        if (finalX < -100 && panX < 0)
        {
            CGAffineTransform conT = [self transformWithDirection];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            isTransing = YES;
            _tapGestureRec.enabled = YES;
            
            [self setUserEanble:NO];
            
            return;
        }
        else
        {
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = oriT;
            [UIView commitAnimations];
            isTransing = NO;
            _tapGestureRec.enabled = YES;
            [self setUserEanble:YES];
        }
    }
}


-(void)setUserEanble:(BOOL)_iseanble
{
    if(!_iseanble){
    
        isDisAbleOther = YES;
    }
    else{
    
        isDisAbleOther = NO;

    }
    
    for(UIView *view in _mainContentView.subviews)
    {
        if([view isKindOfClass:[UIView class]])
        {
            view.userInteractionEnabled = _iseanble;
        }
    }
}

-(void)addTransView
{
    UIView *lv = [[UIView alloc] init];

    if (IOS_7) {
        
        lv.frame = CGRectMake(0, -40, 320, self.mainView.frame.size.height-40);
    }
    else{
        lv.frame =CGRectMake(0, -20, 320, self.mainView.frame.size.height);
    }
    [self.mainView addSubview:lv];
    _leftSideView = lv;
    [lv release];
    
    UIView *mv = [[UIView alloc] init];
    if (IOS_7) {
        
        mv.frame = CGRectMake(0, -20, 320, self.mainView.frame.size.height);
    }
    else{
        mv.frame =self.mainView.frame;
    }
    [self.mainView addSubview:mv];
    _mainContentView = mv;
    [mv release];
    
    
    CPSetViewController *leftSC = [[CPSetViewController alloc] init];
    [self addChildViewController:leftSC];
    [_leftSideView addSubview:leftSC.view];
    [leftSC release];
    
    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    [_mainContentView addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    
    
    
    _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_panGestureRec setDelegate:self];
    [_mainContentView addGestureRecognizer:_panGestureRec];
    
    
    
}


-(void)showContentControllerWithModel
{
    [self closeSideBar];
    
    if (!controller)
    {
        GouCaiHomeViewController *vc = [[GouCaiHomeViewController alloc] init];
        
        controller = [[MLNavigationController alloc] initWithRootViewController:vc];
        controller.isSetNav = YES;
        [vc release];
        
        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        vc.leftBarBtnItem= left;
        
        UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        setBtn.bounds = CGRectMake(0, 12, 44, 44);
        [setBtn setImage:UIImageGetImageFromName(@"shezhi1_1.png") forState:UIControlStateNormal];
        setBtn.backgroundColor = [UIColor clearColor];
        [setBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
        [setBtn addTarget:self action:@selector(setBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:setBtn];
        vc.rightBarBtnItem = barBtnItem;
        [barBtnItem release];
        
        
        
    }
    
    if (_mainContentView.subviews.count > 0)
    {
        UIView *view = [_mainContentView.subviews objectAtIndex:0];
        [view removeFromSuperview];
    }
    if(IOS_7)
    {
        controller.view.frame =CGRectMake(0, 0, 320, self.mainView.frame.size.height);

    }
    else
    {
        controller.view.frame = _mainContentView.frame;

    }

    [_mainContentView addSubview:controller.view];
}



- (void)doBack {
	
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    