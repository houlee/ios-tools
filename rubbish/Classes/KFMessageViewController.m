//
//  KFMessageViewController.m
//  caibo
//
//  Created by cp365dev6 on 14-8-9.
//
//

#import "KFMessageViewController.h"
#import "MailList.h"
#import "KFSiXinCell.h"
#import "Info.h"
#import "NSStringExtra.h"
#import "NetURL.h"
#import "JSON.h"
#import <QuartzCore/QuartzCore.h>
#import "GCSearchViewController.h"
#import "FAQView.h"
#import "UIImageExtra.h"
#import "CP_PTButton.h"
#import "CP_TabBarViewController.h"
#import "MessageViewController.h"

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? YES : NO)

@interface KFMessageViewController ()

@end

@implementation KFMessageViewController

@synthesize mReqData;
@synthesize request;
@synthesize newBool;
@synthesize newpost;
@synthesize newpostBool;

@synthesize selectImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)chulaitiao{
    caiboAppDelegate * caibo  = [caiboAppDelegate getAppDelegate];
    caibo.keFuButton.hidden = NO;
    [caibo.keFuButton callShow];
    if (caibo.keFuButton.markbool) {
        caibo.keFuButton.show = YES;
    }else{
        caibo.keFuButton.show = NO;
    }
    
    
    [UIView beginAnimations:@"800" context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    caibo.keFuButton.frame = CGRectMake(-127, 303, 173, 48);
    
    
    [UIView commitAnimations];
}

- (void)setShowBool:(BOOL)_showBool{
    showBool = _showBool;
    //请求
    
    if (_showBool) {
        //  [self kefusixinfunc];
    }else{
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(kefusixinfunc) object:self] ;
        
    }
    
}

- (BOOL)showBool{
    return showBool;
}

- (void)kefusixinfunc{
    [request clearDelegatesAndCancel];
	//@"965912"
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL keFuSiXinUserID: [[Info getInstance] userId]]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(kefusixinrequest:)];
    [request setDidFailSelector:@selector(keFuSiXinFail:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];// 异步获取
}

- (void)cbUserMailList{
    [request clearDelegatesAndCancel];
	
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL KFCBusersMailList:[[Info getInstance]userId]
                                                                      userId2:@"965912"//@"965912"
                                                                      pageNum:@"1"
                                                                     pageSize:@"50"
                                                                     mailType:@"1"
                                                                         mode:@"0"]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(notieListDataBackData:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];// 异步获取
    
}
- (void)returnSiXinCount{
    
    
    if (showBool) {
        //        if (newBool) {
        //            [self cbUserMailList];
        //            NSLog(@"sixin1111111111111111111111111111111111111111111111111111111");
        //        }else{
        //            if ([dataArray count] == 0) {
        //                [self cbUserMailList];
        //                NSLog(@"sixin222222222222222222222222222222222222222222222222222");
        //            }
        //        }
        
        [self cbUserMailList];
        
        NSLog(@"sixin1111111111111111111111111111111111111111111111111111111");
        
        
    }
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //清空存储的客服私信
    //CheckNew_soundSet_allsx
    
    int kfsx = [[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckNew_soundSet_kfsx"] intValue];
    int allsx = [[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckNew_soundSet_allsx"] intValue];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"CheckNew_soundSet_kfsx"];
    if(allsx>=kfsx){
    
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",allsx-kfsx] forKey:@"CheckNew_soundSet_allsx"];

    }
    
#ifdef isCaiPiaoForIPad
        
        
        caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
        UINavigationController *a = (UINavigationController *)appcaibo.window.rootViewController;
        NSArray * views = a.viewControllers;
        
        for (int n = 0; n < [views count]; n++) {
            UIViewController * newhome = [views objectAtIndex:n];
            if ([newhome isKindOfClass:[GCSearchViewController  class]]) {
                [[(GCSearchViewController *)newhome PKsearchBar] resignFirstResponder];
            }
        }
        
        
        
        
        dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSLog(@"userid = %@",[[Info getInstance]userId]);
        
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UIButton *bgbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgbutton.frame = frame;
        bgbutton.backgroundColor = [UIColor clearColor];
        [bgbutton addTarget:self action:@selector(pressBgButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bgbutton];
        
        
//        bgkefuimage = [[UIImageView alloc] initWithFrame:CGRectMake(120, 200, 520, 620)];
//        bgkefuimage.image = UIImageGetImageFromName(@"bejing.png");
//        bgkefuimage.backgroundColor = [UIColor clearColor];
//        bgkefuimage.userInteractionEnabled = YES;
//        
//        UIButton *kbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//        kbutton.frame = CGRectMake(20, 13, 22.5, 22.5);
//        kbutton.backgroundColor = [UIColor clearColor];
//        [kbutton setImage:UIImageGetImageFromName(@"kf-tel.png") forState:UIControlStateNormal];
//        [kbutton addTarget:self action:@selector(pressPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
//        [bgkefuimage addSubview:kbutton];
//        
//        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(47, 15, 200, 20)];
//        label2.text = @"客服电话:QQ：3254056760";
//        label2.backgroundColor = [UIColor clearColor];
//        label2.font = [UIFont systemFontOfSize:13];
//        [bgkefuimage addSubview:label2];
    
        UIButton *quxiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [quxiaoButton setImage:UIImageGetImageFromName(@"kf-quxiao.png") forState:UIControlStateNormal];
        quxiaoButton.frame = CGRectMake(470, 13, 22.5, 22.5);
        [quxiaoButton addTarget:self action:@selector(pressQuXiaoButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgkefuimage addSubview:quxiaoButton];
        
        takeimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 46, 475, 500)];
        takeimage.image = [UIImageGetImageFromName(@"kf-input.png") stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        takeimage.backgroundColor = [UIColor clearColor];
        takeimage.userInteractionEnabled = YES;
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 465, 490)];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.backgroundColor = [UIColor clearColor];
        myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [takeimage addSubview:myTableView];
        
        [bgkefuimage addSubview:takeimage];
        [takeimage release];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
        
        [self addSubview:bgkefuimage];
        [bgkefuimage release];
        
        //textview
        textimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 560, 475, 45)];
        textimage.image  = [UIImageGetImageFromName(@"kf-input.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        textimage.backgroundColor = [UIColor clearColor];
        textimage.userInteractionEnabled = YES;
        
        myTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 2, 420, 40)];
        myTextView.backgroundColor = [UIColor clearColor];
        myTextView.font = [UIFont systemFontOfSize:13];
        myTextView.returnKeyType = UIReturnKeySend;
        myTextView.delegate = self;
        [textimage addSubview:myTextView];
        
        xbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        xbutton.frame = CGRectMake(405, 23, 15, 15);
        [xbutton setImage:UIImageGetImageFromName(@"xxx960.png")  forState:UIControlStateNormal];
        [xbutton addTarget:self action:@selector(pressXButton:) forControlEvents:UIControlEventTouchUpInside];
        //        [textimage addSubview:xbutton];
        
        sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame = CGRectMake(425, 11, 45, 28);
        [sendButton setImage:UIImageGetImageFromName(@"FAN960.png") forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(pressSendButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * sendlabel = [[UILabel alloc] initWithFrame:sendButton.bounds];
        sendlabel.backgroundColor = [UIColor clearColor];
        sendlabel.textColor = [UIColor whiteColor];
        sendlabel.font = [UIFont systemFontOfSize:13];
        sendlabel.textAlignment = NSTextAlignmentCenter;
        sendlabel.text = @"发送";
        [sendButton addSubview:sendlabel];
        [sendlabel release];
        
        //        [textimage addSubview:sendButton];
        
        [bgkefuimage addSubview:textimage];
        [textimage release];
        
        if ([myTextView.text length] > 0) {
            sendButton.enabled = YES;
            xbutton.hidden = NO;
        }else{
            sendButton.enabled = NO;
            xbutton.hidden = YES;
        }
        
        //旋转
        //caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
        rotationAnimation.duration = 0.0f;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [bgkefuimage.layer addAnimation:rotationAnimation forKey:@"run"];
        bgkefuimage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
        
        //[app.window addSubview:bgkefuimage];
        
    
    
#else
    
    if(!dataArray){
        dataArray = [[NSMutableArray alloc] initWithCapacity:0];

    }
    
    NSLog(@"userid = %@",[[Info getInstance]userId]);
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *headView=[[UIView alloc]init];
    headView.frame=CGRectMake(0, 0, 320, 44+(IOS7?20:0));
    headView.backgroundColor=[UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    [self.view addSubview:headView];
    [headView release];
    
    UILabel *lab=[[[UILabel alloc]initWithFrame:CGRectMake(0, headView.frame.size.height-44, 320, 44)]autorelease];
    lab.backgroundColor=[UIColor clearColor];
    lab.textColor=[UIColor whiteColor];
    lab.text=@"客服";
    lab.font=[UIFont systemFontOfSize:22];
    lab.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:lab];
    
    UIButton *leftBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn1 setImage:[UIImage imageNamed:@"wb58.png"] forState:UIControlStateNormal];
    [leftBtn1 setImage:[UIImage imageNamed:@"wb58.png"] forState:UIControlStateHighlighted];
    leftBtn1.frame=CGRectMake(5, headView.frame.size.height-44, 60, 44);
    [leftBtn1 addTarget:self action:@selector(pressQuXiaoButton:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:leftBtn1];
    
    
    UIView *headBaise=[[UIView alloc]init];
    headBaise.backgroundColor=[UIColor whiteColor];
    headBaise.userInteractionEnabled=YES;
    headBaise.frame=CGRectMake(0, headView.frame.size.height, 320, 60);
    [self.view addSubview:headBaise];
    [headBaise release];
    
    
    bgkefuimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, headBaise.frame.size.height+headBaise.frame.origin.y, 320, self.view.bounds.size.height-headBaise.frame.size.height-headBaise.frame.origin.y)];
    bgkefuimage.backgroundColor = [UIColor clearColor];
    bgkefuimage.userInteractionEnabled = YES;
    
        
    UIButton *kbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    kbutton.frame = CGRectMake(15, 15, 137, 30);
    kbutton.backgroundColor = [UIColor clearColor];
    [kbutton setBackgroundImage:[UIImageGetImageFromName(@"kefulankuang.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [kbutton setBackgroundImage:[UIImageGetImageFromName(@"kefulankuangdianji.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [kbutton setTitle:@"QQ：3254056760" forState:UIControlStateNormal];
    [kbutton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [kbutton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateHighlighted];
    kbutton.titleLabel.font=[UIFont systemFontOfSize:15];
    kbutton.titleLabel.textAlignment=NSTextAlignmentCenter;
    [kbutton addTarget:self action:@selector(pressPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [headBaise addSubview:kbutton];

    UIImageView *lineIma=[[UIImageView alloc]init];
    lineIma.frame=CGRectMake(0, headBaise.frame.size.height-0.5, 320, 0.5);
    lineIma.backgroundColor=[UIColor clearColor];
    lineIma.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [headBaise addSubview:lineIma];
    [lineIma release];
    
    takeimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, bgkefuimage.frame.size.height)];
    takeimage.backgroundColor = [UIColor clearColor];
    takeimage.userInteractionEnabled = YES;
        
        
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, takeimage.frame.size.height-50)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:242/255.0 alpha:1];
    myTableView.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.hidden = YES;
    [takeimage addSubview:myTableView];
    [bgkefuimage addSubview:takeimage];
    [takeimage release];
    
    UIView *headerView=[[UIView alloc]init];
    headerView.backgroundColor=[UIColor clearColor];
    headerView.frame=CGRectMake(0, 0, 320, 10);
    myTableView.tableHeaderView=headerView;
    [headerView release];
        
        
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view addSubview:bgkefuimage];
    [bgkefuimage release];
        
    
    textimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, 320, 50)];
    textimage.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    textimage.userInteractionEnabled = YES;
        
    photoButton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    photoButton.frame = CGRectMake(15, 10, 30, 30);
    [photoButton addTarget:self action:@selector(pressPhotoButton:) forControlEvents:UIControlEventTouchUpInside];
    [photoButton loadButonImage:@"paizhaohui.png" LabelName:@""];
    [textimage addSubview:photoButton];
        
        
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(60, 10, 210, 30)];
    myTextView.backgroundColor = [UIColor whiteColor];
    myTextView.layer.borderWidth=0.5;
    myTextView.layer.cornerRadius=4;
    myTextView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    myTextView.font = [UIFont systemFontOfSize:13];
    myTextView.delegate = self;
    [textimage addSubview:myTextView];
        
        
        
    NSString * str = @"请直接输入问题,将在1小时内回复,紧急请致电";
    CGSize labelSize = [str sizeWithFont:[UIFont systemFontOfSize:9]
                       constrainedToSize:CGSizeMake(200, 25)
                           lineBreakMode:UILineBreakModeCharacterWrap];
    UILabel *yszLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, labelSize.width, labelSize.height)];
    yszLabel.backgroundColor = [UIColor clearColor];
    yszLabel.font = [UIFont systemFontOfSize:9];
    yszLabel.lineBreakMode = NSLineBreakByCharWrapping;
    yszLabel.numberOfLines = 0;
    yszLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
    yszLabel.tag = 2007;
    [myTextView addSubview:yszLabel];
    [yszLabel release];
        
    xbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    xbutton.frame = CGRectMake(235+10, 15, 15, 15);
    [xbutton setImage:UIImageGetImageFromName(@"xxxshanchu.png")  forState:UIControlStateNormal];
    [xbutton addTarget:self action:@selector(pressXButton:) forControlEvents:UIControlEventTouchUpInside];
    [textimage addSubview:xbutton];
        
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(270, 11, 45, 28);
    [sendButton addTarget:self action:@selector(pressSendButton:) forControlEvents:UIControlEventTouchUpInside];
        
    UILabel * sendlabel = [[UILabel alloc] initWithFrame:sendButton.bounds];
    sendlabel.backgroundColor = [UIColor clearColor];
    sendlabel.textColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    sendlabel.font = [UIFont systemFontOfSize:15];
    sendlabel.textAlignment = NSTextAlignmentCenter;
    sendlabel.text = @"发送";
    [sendButton addSubview:sendlabel];
    [sendlabel release];
    [textimage addSubview:sendButton];
    
    [self.view addSubview:textimage];
    [textimage release];
    
    if ([myTextView.text length] > 0) {
        sendButton.enabled = YES;
        xbutton.hidden = NO;
    }else{
        sendButton.enabled = NO;
        xbutton.hidden = YES;
    }
    
    //FAQ按钮
    UIButton *faqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    faqButton.frame = CGRectMake(137+31, 15, 137, 30);
    [faqButton setBackgroundImage:[UIImageGetImageFromName(@"kefulankuang.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [faqButton setBackgroundImage:[UIImageGetImageFromName(@"kefulankuangdianji.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [faqButton addTarget:self action:@selector(pressFAQ) forControlEvents:UIControlEventTouchUpInside];
    faqButton.tag = 002;
    FAQ = YES;
    [headBaise addSubview:faqButton];
    
    [faqButton setTitle:@"常见问题" forState:UIControlStateNormal];
    [faqButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [faqButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateHighlighted];
    faqButton.titleLabel.font=[UIFont systemFontOfSize:15];
    faqButton.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    //提示信息
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 25)];
    tsLabel.backgroundColor = [UIColor clearColor];
    tsLabel.text = @"您可与客服私信沟通,忙碌中可能稍后回复。";
    tsLabel.font = [UIFont systemFontOfSize:12];
    tsLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    tsLabel.tag = 004;
    [takeimage addSubview:tsLabel];
    tsLabel.hidden = YES;
    [tsLabel release];
        
    [self tsInfoHidden];
    
    wbBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 220)];
    wbBgImage.backgroundColor=[UIColor whiteColor];
    wbBgImage.userInteractionEnabled = YES;
    [self.view addSubview:wbBgImage];
    [wbBgImage release];
        
    potButton1 = [[CP_PTButton alloc] initWithFrame:CGRectMake(20, 60, 280, 40)];
    [potButton1 loadButonImage:@"dengluanniu_1.png" LabelName:@"拍 照"];
    potButton1.buttonName.font = [UIFont boldSystemFontOfSize:20];
    potButton1.buttonImage.frame = potButton1.bounds;
    potButton1.buttonName.textColor  =[UIColor whiteColor];
    potButton1.buttonImage.image = [potButton1.buttonImage.image stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [potButton1 addTarget:self action:@selector(pressPotButtona1:) forControlEvents:UIControlEventTouchUpInside];
    
        
    potButton2 = [[CP_PTButton alloc] initWithFrame:CGRectMake(20, 120, 280, 40)];
    [potButton2 loadButonImage:@"dengluanniu_1.png" LabelName:@"相 册"];
    potButton2.buttonName.font = [UIFont boldSystemFontOfSize:20];
    potButton2.buttonImage.frame = potButton2.bounds;
    potButton2.buttonName.textColor  =[UIColor whiteColor];
    potButton2.buttonImage.image = [potButton2.buttonImage.image stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    [potButton2 addTarget:self action:@selector(pressPotButtonb2:) forControlEvents:UIControlEventTouchUpInside];
    
        
    potimage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, 120, 120)];
    potimage.hidden = YES;
    
    
    delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    delButton.frame = CGRectMake(potimage.frame.size.width+100-15, 50-15, 30, 30);
    [delButton setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
    delButton.hidden = YES;
    [delButton addTarget:self action:@selector(pressdelButton:) forControlEvents:UIControlEventTouchUpInside];
    [wbBgImage addSubview:potimage];
    [wbBgImage addSubview:delButton];
    [wbBgImage addSubview:potButton1];
    [wbBgImage addSubview:potButton2];
    [potButton1 release];
    [potimage release];
    [potButton2 release];
    selectImage = nil;

#endif
    
}
#pragma mark 打开相机 相册
- (void)pressPotButtona1:(UIButton *)sender{//打开相机
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){// 判断是否有摄像头
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
        //         [(UINavigationController *)caiboapp.window.rootViewController pushViewController:picker animated:YES];
        
        UINavigationController *a = (UINavigationController *)caiboapp.window.rootViewController;
        NSArray * views = a.viewControllers;
        NSLog(@"views = %lu", (unsigned long)[views count]);
        if ([views count] > 1) {
            
            
            
            if(newpost){
                [newpost presentViewController:picker animated: YES completion:nil];
            }else{
                [(UINavigationController *)caiboapp.window.rootViewController presentViewController:picker animated: YES completion:nil];
            }
            
            
            
            
        }else{
            
            [(UINavigationController *)caiboapp.window.rootViewController presentViewController:picker animated: YES completion:nil];
        }
        
//        self.hidden = YES;
        [picker release];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error",nil)
													   message:NSLocalizedString(@"have no camera",nil)
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    
    
}

- (void)pressPotButtonb2:(UIButton *)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
#ifdef isCaiPiaoForIPad
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        UIPopoverController *popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        popoverController.delegate=self;
        [popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
#else
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.delegate = self;
        
        picker.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
        caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
        UINavigationController *a = (UINavigationController *)caiboapp.window.rootViewController;
        NSArray * views = a.viewControllers;
        NSLog(@"views = %lu", (unsigned long)[views count]);
        if ([views count] > 1) {
            
            
            
            if (newpost){
                [newpost presentViewController:picker animated: YES completion:nil];
            }else{
                [(UINavigationController *)caiboapp.window.rootViewController presentViewController:picker animated: YES completion:nil];
            }
            
            
            
            
        }else{
            [(UINavigationController *)caiboapp.window.rootViewController presentViewController:picker animated: YES completion:nil];
            
        }
//        self.hidden = YES;
        [picker release];
#endif
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
														message:NSLocalizedString(@"have no camera",nil)
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    
}
- (void)pressdelButton:(UIButton *)sender{
    potimage.hidden = YES;
    delButton.hidden = YES;
    potButton1.hidden = NO;
    potButton2.hidden = NO;
    potimage.image = nil;
    selectImage = nil;
}

// 接收图片
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if ([mediaType isEqualToString:@"public.image"]) {
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		if (image) {
			if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
				NSLog(@"111111");
			} else {
				UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
                NSLog(@"222222");
			}
			
            
            
            //            potimage.image = image;
            
            CGSize suoxiao = [UIImage imageWithThumbnail:image size:CGSizeMake(480, 480)];
            UIImage * suoxiaoimage = [image imageByScalingAndCroppingForSize:suoxiao];
            
            self.selectImage = suoxiaoimage;
            sendButton.enabled = YES;
            //            UIImageWriteToSavedPhotosAlbum(suoxiaoimage, nil, nil,nil);
            
            CGSize imageSize = [UIImage imageWithThumbnail:image size:CGSizeMake(170, 170)];
            
            NSLog(@"yuan image = %f, %f", image.size.width, image.size.height);
            NSLog(@"imagesize = %f, %f", imageSize.width, imageSize.height);
            
            potimage.frame = CGRectMake((320-imageSize.width)/2, (220-imageSize.height)/2, imageSize.width, imageSize.height);
            
            if (imageSize.height<120 && imageSize.width < 120) {
                potimage.frame = CGRectMake((320-imageSize.width)/2, (220-imageSize.height)/2, 120, 120);
                potimage.image = image;
            }else{
                potimage.image = [image imageByScalingAndCroppingForSize:imageSize];
            }
            delButton.frame = CGRectMake((320-imageSize.width)/2+imageSize.width-15, (220-imageSize.height)/2-15, 30, 30);
            
            potimage.hidden = NO;
            potButton1.hidden = YES;
            potButton2.hidden = YES;
            delButton.hidden = NO;
            
            //            NSData *data = nil;
            //            data = UIImageJPEGRepresentation(potimage.image,1.0);
            //            if ([data length] > 3646056) {//GIFDATALength*2.3
            //
            //				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"图片大于2MB，会耗费较多流量，是否继续？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
            //                alert.tag = 1112;
            //				[alert show];
            //				[alert release];
            //
            //			}
            
		} else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                            message:@"无法读取图片，请重试"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 223;
            [alert show];
            [alert release];
		}
	}
    
    [picker dismissViewControllerAnimated: YES completion: nil];
//    self.hidden = NO;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated: YES completion: nil];
//    self.hidden = NO;
}


- (void)phothShow{
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    
//    wbBgImage.frame = CGRectMake(0, self.bounds.size.height-220, 320, 220);
    wbBgImage.frame = CGRectMake(0, self.view.bounds.size.height-220, 320, 220);
    [photoButton loadButonImage:@"paizhaolan.png" LabelName:@""];
    
    
    [UIView commitAnimations];
}

- (void)phothDisappear{
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    
//    wbBgImage.frame = CGRectMake(0, self.bounds.size.height, 320, 220);
    wbBgImage.frame = CGRectMake(0, self.view.bounds.size.height, 320, 220);
    
    [photoButton loadButonImage:@"paizhaohui.png" LabelName:@""];
    
    [UIView commitAnimations];
}

- (void)pressPhotoButton:(UIButton *)sender{//照片按钮点击事件
    
    
    
    if (photoShowDis == NO) {
        [myTextView resignFirstResponder];
        [self phothShow];
        photoShowDis = YES;
    }else{
        [self phothDisappear];
        photoShowDis = NO;
    }
    
    
    if (photoShowDis) {
        
        NSString * str = myTextView.text;
        NSLog(@"str = %@", str);
        CGSize  size = CGSizeMake(175, 300);
        UIFont * font = [UIFont systemFontOfSize:13];
        CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        if (labelSize.height < 28) {
            labelSize.height = 28;
        }
        
//        myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 175, labelSize.height);
        myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 210, labelSize.height);
        
        //        textimage.frame = CGRectMake(0, 341 - labelSize.height-15 , 320, labelSize.height+22);
        
//        textimage.image  = [UIImageGetImageFromName(@"FSBG960.png") stretchableImageWithLeftCapWidth:160 topCapHeight:25];
        textimage.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        
        
        
//        myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 175, labelSize.height);
        myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 210, labelSize.height);
        
//        textimage.frame = CGRectMake(textimage.frame.origin.x, self.frame.size.height- 220- myTextView.frame.size.height- 22, 320, labelSize.height+22);
        textimage.frame = CGRectMake(textimage.frame.origin.x, self.view.bounds.size.height- 220- myTextView.frame.size.height- 22, 320, labelSize.height+22);
        
        
        if (IS_IPHONE_5) {
//            myTableView.frame = CGRectMake(0, 5, 289, self.frame.size.height - textimage.frame.origin.y-50-16);
//            myTableView.frame = CGRectMake(0, 5, 289, self.view.bounds.size.height - textimage.frame.origin.y-50-16);
        }else{
//            myTableView.frame = CGRectMake(0, 5, 289, 287+50 - textimage.frame.origin.y - 16);
        }
        myTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - textimage.frame.origin.y-50-16);
        NSLog(@"tableview hight = %f", myTableView.frame.size.height);
        
        
    }else{
        [self upDate];
        
    }
    
}

- (void)tsInfo {
    
    UILabel *lab = (UILabel *)[takeimage viewWithTag:004];
    lab.hidden = NO;
    myTableView.hidden = YES;
    
    //提示信息4秒之后自动消失
    [self performSelector:@selector(tsInfoHidden) withObject:self afterDelay:4];
    
}
//提示信息消失
- (void)tsInfoHidden {
    
    UILabel *lab = (UILabel *)[takeimage viewWithTag:004];
    lab.hidden = YES;
    myTableView.hidden = NO;
    [myTableView reloadData];
}

#pragma mark 界面消失 按钮的触发函数
- (void)pressJianPanBG:(UIButton *)sender{
    
//    [jianpanbg removeFromSuperview];
    jianpanbg = nil;
    [myTextView resignFirstResponder];
    
}

- (void)pressXButton:(UIButton *)sender{
    
    myTextView.text = @"";
    [self upDate];
}

- (void)padRemoveFromSuperViewFunc{
    showBool = NO;
    
    [request clearDelegatesAndCancel];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(kefusixinfunc) object:self] ;
    //    [myTextView resignFirstResponder];
    
    [self.view removeFromSuperview];
    self.newpostBool = NO;
    //    self.newpost = nil;
}

- (void)pressBgButton:(UIButton *)sender{
    
    if ([myTextView isFirstResponder]) {
        [myTextView resignFirstResponder];
    }else{
        if ([myTextView.text length] > 0) {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定 放弃编辑的内容吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [aler show];
            [aler release];
            return;
        }
#ifdef isCaiPiaoForIPad
        [self padRemoveFromSuperViewFunc];
#else
        showBool = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(kefusixinfunc) object:self] ;
        [self.view removeFromSuperview];
        //        self.newpost = nil;
        self.newpostBool = NO;
        [self chulaitiao];
        
        
#endif
        
        
    }
    
    
}
- (void)pressQuXiaoButton:(UIButton *)sender{
    
    
    if ([myTextView.text length] > 0) {
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定 放弃编辑的内容吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
        return;
    }
    
    
#ifdef isCaiPiaoForIPad
    [self padRemoveFromSuperViewFunc];
#else
//    showBool = NO;
//    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(kefusixinfunc) object:self] ;
//    [self.view removeFromSuperview];
//    //    self.newpost = nil;
//    self.newpostBool = NO;
//    [self chulaitiao];
    
    [self.navigationController popViewControllerAnimated:YES];
    
#endif
    
    
}

- (void)pressPhoneButton:(UIButton *)sender{
    
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//    [actionSheet showInView:self.view];
//    [actionSheet release];
}

- (void)sendRequestImgeUrl:(NSString *)imageUrl{
    
    [request clearDelegatesAndCancel];
    
    NSString * textstr = @"";
    if (selectImage && [myTextView.text length] <= 0) {
        textstr = @"";
//        textstr=@"";
    }else{
        textstr = myTextView.text;
    }
	//@"965912"
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsendMail:[[Info getInstance] userId] taUserId:@"965912" content:textstr imageUrl:imageUrl]]];
	
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(addAdPicViewSuc:)];
    [request setTimeOutSeconds:20];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];// 异步获取
}

- (void)uploadHeadImage:(NSData*)imageData {//图片上传
    
    
    
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    NSString *urlString = @"http://t.diyicai.com/servlet/UploadGroupPic";
    
    NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] init];
    [request2 setURL:[NSURL URLWithString:urlString]];
    [request2 setHTTPMethod:@"POST"];
    //
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request2 addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"vim_go.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request2 setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
    NSString *returnStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    if (!returnStr) {
        return;
    }
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    [self sendRequestImgeUrl:returnStr];
    
//    NSURL *serverURL = [NSURL URLWithString:@"http://t.diyicai.com/servlet/UploadGroupPic"];
//    
//    [mReqData clearDelegatesAndCancel];
//    self.mReqData = [ASIFormDataRequest requestWithURL:serverURL];
//    [mReqData addData:imageData withFileName:@"george.jpg" andContentType:@"image/jpeg" forKey:@"photos"];
//    [mReqData setUsername:@"upload"];
//    [mReqData setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [mReqData setTimeOutSeconds:20];
//    //    [mReqData setDidFinishSelector:@selector(uploadFinish:)];
//    [mReqData setDelegate:self];
//    [mReqData startAsynchronous];
    NSLog(@"%@", mReqData.url);
}

- (void)requestFinished:(ASIHTTPRequest *)requests{
    NSString *result = [requests responseString];
    NSLog(@"=======Result：%@", result);
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    // 上传图片
    if ([requests.username isEqualToString:@"upload"]) {
        
        
        if (!result) {
            return;
        }
        
        loadview = [[UpLoadView alloc] init];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
        [self sendRequestImgeUrl:result];
    }
    
}

- (void)pressSendButton:(UIButton *)sender{
    
    UILabel *lab = (UILabel *)[takeimage viewWithTag:004];
    if (lab.hidden == NO) {
        [self tsInfoHidden];
    }
    
    
    if (selectImage == nil) {
        [self sendRequestImgeUrl:@""];
    }else{
        NSLog(@"selectimage = %f, %f", selectImage.size.width, selectImage.size.height);
        [self uploadHeadImage:UIImageJPEGRepresentation(selectImage, 1.0)];
        
    }
    
    
    
    
    // 发送私信请求
    
    
}

//FAQ按钮触发事件
- (void)pressFAQ {
    
    [self tsInfoHidden];
//    
////    FAQView *faq = [[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds superView:self];
//    FAQView *faq = [[FAQView alloc] init];
//    faq.frame=self.view.bounds;
//    faq.faqdingwei = Other;
//    //#ifdef isCaiPiaoForIPad
//    //    [faq Show:self];
//    //#else
//    [faq Show];
//    //#endif
//    [faq release];
    
    QuestionViewController *qvc=[[QuestionViewController alloc]init];
    qvc.question = OtherType;
    [self.navigationController pushViewController:qvc animated:YES];
    [qvc release];
    
}

#pragma mark actionSheet 回调函数
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        //        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://4008130001"]]) {
//        //            showBool = NO;
//        //        }
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (alertView.tag == 1112) {
        
        if (buttonIndex == 1) {
            potimage.image = nil;
            selectImage = nil;
            potimage.hidden = YES;
            potButton1.hidden = NO;
            potButton2.hidden = NO;
            delButton.hidden = YES;
            
            
        }else{
            NSLog(@"bb");
        }
        
    }else if(alertView.tag == 223){
        
    }else{
        if (buttonIndex == 1) {
            
#ifdef isCaiPiaoForIPad
            [self padRemoveFromSuperViewFunc];
#else
//            myTextView.text = @"";
//            [self upDate];
//            showBool = NO;
//            [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(kefusixinfunc) object:self] ;
//            [self.view removeFromSuperview];
//            //            self.newpost = nil;
//            self.newpostBool = NO;
//            [self chulaitiao];
            [self.navigationController popViewControllerAnimated:YES];
#endif
            //            [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(kefusixinfunc) object:self] ;
            //            [self removeFromSuperview];
            //            [self chulaitiao];
        }
        
    }
    
    
    
}

#pragma mark tableview delegate dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([dataArray count] != 0) {
        
        //        KFSiXinCell * cell = (KFSiXinCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        MailList * mai = [dataArray objectAtIndex:indexPath.row];
        NSString * str = mai.content;
        NSLog(@"str = %@", str);
//        CGSize  size = CGSizeMake(136, 1000);
        CGSize  size = CGSizeMake(136+60-15, 1000);
        UIFont * font = [UIFont systemFontOfSize:14];
        CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        if ([mai.img_url length] > 0) {
            
            //            cell.returnview.frame = CGRectMake(0, 0, 320, labelSize.height+17+12+10+75+11);
//            return labelSize.height+17+12+10+75+11;
            return labelSize.height+17+12+10+75+11+20;
        }
//        return labelSize.height+17+12+10;
        return labelSize.height+17+12+10+20;
        
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * CellIdentifier = @"cellid";
    
    KFSiXinCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[KFSiXinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.delegate = self;
    cell.mailList = [dataArray objectAtIndex:indexPath.row];
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pressJianPanBG:nil];
//    [self phothDisappear];
    
    if (photoShowDis == YES)
    {
        [self phothDisappear];
        photoShowDis = NO;
        [self upDate];
    }
}

- (void)returnHiddeView{
    
//    self.hidden = NO;
}

- (void)returnHiddeViewDisappear{
//    self.hidden = YES;
}


#pragma mark 键盘的监听函数
- (void)keyboardNotification:(NSNotification *)notification {
    
    
    CGRect keybordFrame;
    [[[((NSNotification *)notification) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    //    CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
    //    NSLog(@"keybordHeight----------------------------->%f dddd= %f",keybordHeight,CGRectGetWidth(keybordFrame));
    
#ifdef isCaiPiaoForIPad
    
    if ([[notification name] isEqualToString:UIKeyboardWillShowNotification] || [[notification name] isEqualToString:UIKeyboardWillChangeFrameNotification]) {
        
        
        
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             
                             
                             
                             
                             
                             NSValue * kvalue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
                             keysize = [kvalue CGRectValue].size;
                             
                             //  textimage.frame = CGRectMake(0, self.frame.size.height- keysize.height- myTextView.frame.size.height- 22, 320, 50);//self.frame.size.height- keysize.height);
                             [self upDate];
                             
                             
                             
                         } completion:NULL];
        
        if (!jianpanbg) {
            
            
            //textimage.frame = CGRectMake(20, 560, 475, 45);
            
            jianpanbg = [UIButton buttonWithType:UIButtonTypeCustom];
            //            caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
            
            jianpanbg.frame = CGRectMake(0, 0, 1024, 768);//caiboapp.window.bounds;
            jianpanbg.backgroundColor = [UIColor clearColor];
            [jianpanbg addTarget:self action:@selector(pressJianPanBG:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:jianpanbg];
        
    } else {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             keysize = CGSizeMake(keysize.width, 0);
                             // textimage.frame = CGRectMake(0, 347, 320, 50);
                             
                             [self upDate];
                             
                         } completion:NULL];
        
    }
    
#else
    
    if ([[notification name] isEqualToString:UIKeyboardWillShowNotification]) {
        
        
        
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             
                             
                             
                             NSValue * kvalue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
                             keysize = [kvalue CGRectValue].size;
                             
                             //  textimage.frame = CGRectMake(0, self.frame.size.height- keysize.height- myTextView.frame.size.height- 22, 320, 50);//self.frame.size.height- keysize.height);
                             [self upDate];
                             
                             
                             
                         } completion:NULL];
        
//        if (!jianpanbg) {
//            jianpanbg = [UIButton buttonWithType:UIButtonTypeCustom];
//            jianpanbg.backgroundColor = [UIColor redColor];
//            caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
//            
//            jianpanbg.frame = CGRectMake(0, 0, 320, caiboapp.window.frame.size.height - keysize.height-textimage.frame.size.height);//caiboapp.window.bounds;
//            jianpanbg.backgroundColor = [UIColor clearColor];
//            [jianpanbg addTarget:self action:@selector(pressJianPanBG:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        [self.view addSubview:jianpanbg];
        
    } else {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             keysize = CGSizeMake(keysize.width, 0);
                             // textimage.frame = CGRectMake(0, 347, 320, 50);
                             
                             [self upDate];
                             
                             
                             
                         } completion:NULL];
        
    }
    
#endif
    
}

- (void)upDate{
    
#ifdef isCaiPiaoForIPad
    
    if ([myTextView.text length] > 0) {
        //        sendButton.enabled = YES;
        //        xbutton.hidden = NO;
    }else{
        //        sendButton.enabled = NO;
        //        xbutton.hidden = YES;
    }
    
    NSString * str = myTextView.text;
    NSLog(@"str = %@", str);
    CGSize  size = CGSizeMake(200, 300);
    UIFont * font = [UIFont systemFontOfSize:13];
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    if (labelSize.height < 28) {
        labelSize.height = 28;
    }
    
    NSLog(@"hight = %f",labelSize.height);
    
    if (keysize.height == 0) {
        
        
        if ((341 + labelSize.height+22) > self.frame.size.height) {
            myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 218, 120-22);
            
            textimage.frame = CGRectMake(0, 341, 320, 120);
            textimage.image  = [UIImageGetImageFromName(@"kf-input.png") stretchableImageWithLeftCapWidth:160 topCapHeight:25];
            
            
            
            
            
        }else{
            bgkefuimage.frame = CGRectMake(120, 250, 620, 520);
            takeimage.frame = CGRectMake(20, 46, 475, 500);
            myTextView.frame = CGRectMake(5, 2, 410, 40);
            textimage.frame = CGRectMake(20, 560, 475, 45);
            
        }
        
        
    }else{
        
        
        if (keysize.width > 400) {
            bgkefuimage.frame = CGRectMake(1024 - keysize.width - bgkefuimage.frame.size.height + bgkefuimage.frame.origin.y + 70, 230, 335, 520);
        }else{
            bgkefuimage.frame = CGRectMake(1024 - keysize.width - bgkefuimage.frame.size.height + bgkefuimage.frame.origin.y, 230, 335, 520);
        }
        
        takeimage.frame = CGRectMake(20, 46, 475, 220);
        myTextView.frame = CGRectMake(5, 2, 410, 210);
        
        textimage.frame = CGRectMake(textimage.frame.origin.x, 275, 475, labelSize.height+22);
        
        //        caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
//        jianpanbg.frame = CGRectMake(0, 0, 1024, 768);
    }
    
    //sendButton.frame = CGRectMake(254, textimage.frame.size.height - 11 - 28, 45, 28);
    //xbutton.frame = CGRectMake(237, textimage.frame.size.height - 11 - 15, 15, 15);
    
    [textimage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
#else
    
    if ([myTextView.text length] > 0||selectImage) {
        sendButton.enabled = YES;
        xbutton.hidden = NO;
        
        if ([myTextView.text length] <= 0) {
            xbutton.hidden = YES;
        }
        
    }else{
        sendButton.enabled = NO;
        xbutton.hidden = YES;
    }
    
    NSString * str = myTextView.text;
    NSLog(@"str = %@", str);
    CGSize  size = CGSizeMake(175, 300);
    UIFont * font = [UIFont systemFontOfSize:13];
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    if (labelSize.height < 28) {
        labelSize.height = 28;
    }
    
    NSLog(@"hight = %f",labelSize.height);
    
    if (keysize.height == 0) {
        
        
//        if ((341 + labelSize.height+22) > self.frame.size.height) {
        if ((341 + labelSize.height+22) > 480) {
//            myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 175, 120-22);
            myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 210, 120-22);
            textimage.frame = CGRectMake(0, self.view.bounds.size.height-120, 320, 120);
            textimage.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
            myTableView.frame = CGRectMake(0, 0, 320, takeimage.frame.size.height-50);
            
        }else{
            myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 210, labelSize.height);
            textimage.frame = CGRectMake(0, self.view.bounds.size.height-labelSize.height-22, 320, labelSize.height+22);
            myTableView.frame = CGRectMake(0, 0, 320, takeimage.frame.size.height-50);
            textimage.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        }
        
        
        
        if (photoShowDis) {
            myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 210, labelSize.height);

            textimage.frame = CGRectMake(textimage.frame.origin.x, self.view.bounds.size.height- 220- myTextView.frame.size.height- 22, 320, labelSize.height+22);
            myTableView.frame = CGRectMake(0, 0, 320, takeimage.frame.size.height-50);
            textimage.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        }
        
    }else{
        [self phothDisappear];
        photoShowDis = NO;
        myTextView.frame = CGRectMake(myTextView.frame.origin.x, myTextView.frame.origin.y, 210, labelSize.height);

        textimage.frame = CGRectMake(textimage.frame.origin.x, self.view.bounds.size.height- keysize.height- myTextView.frame.size.height- 22, 320, labelSize.height+22);
        myTableView.frame = CGRectMake(0, 0, 320, textimage.frame.origin.y-50-16-20);
        
        NSLog(@"%f",textimage.frame.origin.y);
        NSLog(@"%f",myTableView.frame.size.height);
        
        textimage.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];

    }
    
    sendButton.frame = CGRectMake(270, textimage.frame.size.height - 11 - 28, 45, 28);
    xbutton.frame = CGRectMake(237+8, textimage.frame.size.height - 11 - 20-2, 15, 15);
    
#endif
    
}

// 监听用户输入；改变字数限制提示
- (void)textViewDidChange:(UITextView *)textView{
    //默认文字消失
    if (textView == myTextView) {
        if ([myTextView.text length] >0) {
            UILabel *lab = (UILabel *)[myTextView viewWithTag:2007];
            lab.hidden = YES;
        }else if ([myTextView.text length] ==0){
            
            UILabel *lab = (UILabel *)[myTextView viewWithTag:2007];
            lab.hidden = NO;
        }
        
    }

    NSLog(@"xxxx = %d", [self countWord:myTextView.text]);
    
    [self performSelector:@selector(sleepSubString) withObject:nil afterDelay:0.1];
    
}

- (void)sleepSubString{
    if ([myTextView.text zifuLong] > 140) {//

        
        for (int i = 0; i < [myTextView.text length]; i++) {
//            NSRange  textRange = myTextView.selectedRange;
            
            NSString * stringstr = [myTextView.text substringToIndex:[myTextView.text length]-1];
            myTextView.selectedRange = NSMakeRange(1, 1);
            myTextView.text = stringstr;
//            if ([self countWord:myTextView.text] <= 140) {
            if ([myTextView.text zifuLong] <= 140) {
//                myTextView.text = stringstr;
                return;
            }
        }
    }

}
- (int)countWord:(NSString*)s {
    int i, n = (int)[s length], l = 0, a = 0, b = 0;
    
    unichar c;
    
    for(i = 0; i < n; i++) {
        c = [s characterAtIndex:i];
        if(isblank(c)) {
            b++;
        } else if(isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    
    if(a == 0 && l == 0) return 0;
    
    return l + (int)ceilf((float)(a + b) / 2.0);
}
- (void)sendMessage:(UITextView *)textView{
    if ([textView.text length] > 0) {
        [self pressSendButton:nil];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    NSLog(@"text = %@, textview = %@", text, textView.text);
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
#ifdef isCaiPiaoForIPad
        [self performSelector:@selector(sendMessage:) withObject:textView afterDelay:0.1];
#else
#endif
        
        
        
        return YES;
    }
    
    
    
    
    
    //     NSString * strlen = [NSString stringWithFormat:@"%@%@", textView.text, text];
    
    
    
    
    [self performSelector:@selector(upDate) withObject:nil afterDelay:0.1];
    
    return YES;
}
#pragma mark - http 回调函数

- (void)kefusixinrequest:(ASIHTTPRequest *)mrequest{
    NSString *result = [mrequest responseString];
    NSLog(@"result = %@", result);
    if (result) {
        NSDictionary * dict = [result JSONValue];
        NSLog(@"%@",dict);
        
        if ([[dict objectForKey:@"number"] intValue] > 0) {
            [self cbUserMailList];
        }
        
        [self performSelector:@selector(kefusixinfunc) withObject:self afterDelay:[[dict objectForKey:@"frequency"] intValue]];//多少秒后继续调这个函数
        
    }
    
    
}

- (void)keFuSiXinFail:(ASIHTTPRequest *)mrequest{
    if([mrequest error]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:@"网络有错误"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
		[alert show];
		[alert release];
        
        [self performSelector:@selector(kefusixinfunc) withObject:self afterDelay:60];
	}
    
}

- (void)addAdPicViewSuc:(ASIHTTPRequest *)mrequrt{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    NSString *result = [mrequrt responseString];
    if (result) {
        
        
        
        NSDictionary * dict = [result JSONValue];
        if ([[dict objectForKey:@"result"] isEqualToString:@"succ"]) {
            
            if (selectImage != nil) {
                
                myTextView.text = @"";
                potimage.hidden = YES;
                delButton.hidden = YES;
                potButton1.hidden = NO;
                potButton2.hidden = NO;
                potimage.image = nil;
                selectImage = nil;
                sendButton.enabled = NO;
                xbutton.hidden = YES;
                
                
                [self cbUserMailList];
            }else{
                MailList * ma3 = [[MailList alloc] init];
                ma3.content = myTextView.text;
                NSString * da = [NSString stringWithFormat:@"%@",[NSDate date]];
                NSArray * datear = [da componentsSeparatedByString:@" "];
                NSString *yueStr= @"";
                if ([datear count] > 0) {
                    NSArray *ary=[[datear objectAtIndex:0] componentsSeparatedByString:@"-"];
                    if ([ary count] > 2) {
                        yueStr=[NSString stringWithFormat:@"%@月%@日",[ary objectAtIndex:1],[ary objectAtIndex:2]];
                    }
                    
                }
                
                
                
                
                NSLog( @"date = %@", da);
                
                NSDate *  senddate=[NSDate date];
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//                [dateformatter setDateFormat:@"HH:mm:ss"];
                NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
                dateformatter.locale = locale;
                [locale release];
                [dateformatter setDateFormat:@"a hh:mm:ss"];
                NSString *  locationString=[dateformatter stringFromDate:senddate];
                
                if(locationString.length>8)
                {
                    locationString=[locationString substringToIndex:8];
                }
                
                NSLog(@"date date = %@", locationString);
//                da = [NSString stringWithFormat:@"%@ %@", [datear objectAtIndex:0], locationString];
                da = [NSString stringWithFormat:@"%@ %@", yueStr, locationString];
                ma3.date = da;
                ma3.senderId = [[Info getInstance]userId];
                [dataArray addObject:ma3];
                [ma3 release];
                myTextView.text = @"";
                [self upDate];
                [myTableView reloadData];
                [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[dataArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                [dateformatter release];
                
            }
            
            
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"发送失败"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
    }
    
    
}

- (void) requestFailed:(ASIHTTPRequest *)req {
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
	if([req error]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:@"网络有错误"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}


// 接收 通知请求 数据
-(void)notieListDataBackData:(ASIHTTPRequest*)mrequest{
	
	NSString *responseString = [mrequest responseString];
    NSLog(@"respon2 = %@", responseString);
	if(responseString){
		
		MailList *maillist = [[MailList alloc]initWithParse:responseString];
		if (maillist) {
            [dataArray removeAllObjects];
            [self insetFirstMessage];
            int asd=0;
            for (int i = (int)[maillist.arryList count]; i > 0; i--) {
                [dataArray addObject:[maillist.arryList objectAtIndex:i-1]];
                asd++;
                //打印数据
                //                MailList * li = [maillist.arryList objectAtIndex:i-1];
                //                NSLog(@"xxxxxxxx url = %@", li.img_url);
            }
            
			//[dataArray addObjectsFromArray:maillist.arryList];
            
            
            
//			[self insetFirstMessage];
			[myTableView reloadData];
            if ([dataArray count] > 0) {
                [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[dataArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
		}
        
        
		[maillist release];
    }
    
    
    [self kefusixinfunc];
	
}

- (void)dealloc{
    [newpost release];
    [selectImage release];
    [mReqData clearDelegatesAndCancel];
    [mReqData release];
    [dataArray release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [request clearDelegatesAndCancel];
    [myTextView release];
    [myTableView release];
    [super dealloc];
}
-(void)insetFirstMessage
{
    if(!dataArray)
        dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    MailList * ma3 = [[MailList alloc] init];
    ma3.content = @"您好，如有问题或建议请直接输入，我们将在1小时内回复您，紧急请致电。";
    NSString * da = [NSString stringWithFormat:@"%@",[NSDate date]];
    NSArray * datear = [da componentsSeparatedByString:@" "];
    NSString *yueStr=@"";
    if ([datear count] > 0) {
        NSArray *ary=[[datear objectAtIndex:0] componentsSeparatedByString:@"-"];
        if ([ary count] > 2) {
             yueStr=[NSString stringWithFormat:@"%@月%@日",[ary objectAtIndex:1],[ary objectAtIndex:2]];
        }
       

    }
    
    
    
    
    NSLog( @"date = %@", da);
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    //                [dateformatter setDateFormat:@"HH:mm:ss"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateformatter.locale = locale;
    [locale release];
    [dateformatter setDateFormat:@"a hh:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    [dateformatter release];
    
    if(locationString.length>8)
    {
        locationString=[locationString substringToIndex:8];
    }
    
    NSLog(@"date date = %@", locationString);
    da = [NSString stringWithFormat:@"%@ %@", yueStr, locationString];
    ma3.date = da;
    [dataArray addObject:ma3];
    [ma3 release];
}

#pragma mark KFMessage Method

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