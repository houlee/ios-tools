//
//  RedactPrivLetterController.m
//  caibo
//
//  Created by jeff.pluto on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RedactPrivLetterController.h"
#import "QuartzCore/QuartzCore.h"
#import "FolloweesViewController.h"
#import "FaceSystem.h"
#import "ProgressBar.h"
#import "NetURL.h"
#import "JSON.h"
#import "Info.h"

@implementation RedactPrivLetterController

@synthesize mHimId,nickName;

- (void)viewWillAppear:(BOOL)animated{
     [mBackground.editText.internalTextView becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void)loadingIphone{
    self.CP_navigation.title = @"发私信";
//    [self.CP_navigation setHidesBackButton:YES];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(actionCancel:)];
    [self.CP_navigation setLeftBarButtonItem:(leftItem)];
    
    
    UIImageView *sjrBGimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -2, 320, 40)];
    sjrBGimage.image = UIImageGetImageFromName(@"wb19.png");
    sjrBGimage.backgroundColor = [UIColor clearColor];
    sjrBGimage.userInteractionEnabled = YES;
    [self.mainView addSubview:sjrBGimage];
    [sjrBGimage release];
    
    UILabel *sjrLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 25)];
    sjrLabel.text = @"收件人:";
    sjrLabel.font = [UIFont systemFontOfSize:16];
    sjrLabel.backgroundColor = [UIColor clearColor];
    [sjrBGimage addSubview:sjrLabel];
    [sjrLabel release];
    
    mLinkMan = [UIButton buttonWithType:UIButtonTypeCustom];
//    mLinkMan.frame = CGRectMake(80, 10, 120, 25);
    mLinkMan.frame = CGRectMake(80, 10, 160, 25);
    [mLinkMan setTitle:self.nickName forState:(UIControlStateNormal)];
    [mLinkMan setTitleColor:[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2] forState:UIControlStateNormal];
    mLinkMan.backgroundColor = [UIColor clearColor];
    [sjrBGimage addSubview:mLinkMan];
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(270, 0, 50, 40);
    
    UIImageView * addiamge = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
    addiamge.backgroundColor =  [UIColor clearColor];
    addiamge.image = UIImageGetImageFromName(@"wb5.png");
    [addBtn addSubview:addiamge];
    [addiamge release];
    
    //    [addBtn setImage:UIImageGetImageFromName(@"wb5.png") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(actionAddLinkMan:) forControlEvents:UIControlEventTouchUpInside];
    [sjrBGimage addSubview:addBtn];
    
    //    [self.view bringSubviewToFront:linLabel];
    //    [self.view bringSubviewToFront:mLinkMan];
    //    [self.view bringSubviewToFront:addBtn];
    
    //内容
    //    infoText = [[UITextView alloc] initWithFrame:CGRectMake(0, 40, 320, 200)];
    //    [infoText becomeFirstResponder];
    //    infoText.backgroundColor = [UIColor clearColor];
    //    [self.mainView addSubview:infoText];
    //    infoText.delegate = self;
    //    [infoText release];
    //
    mBackground = [[EditText alloc] initWithFrame:CGRectMake(0, 99, 320, 44)];
    [mBackground setDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
	if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.0) {
		mBackground.frame = CGRectMake(0, 165, 320, 44);
	}
    [mBackground.editText setDelegate:self];
    [mBackground.sendBtn addTarget:self action:@selector(actionSendMail:) forControlEvents:(UIControlEventTouchUpInside)];
    [mBackground.mDeleteText addTarget:self action:@selector(actionDeleteText:) forControlEvents:(UIControlEventTouchUpInside)];
    mBackground.editText.internalTextView.backgroundColor = [UIColor clearColor];
#ifdef isCaiPiaoForIPad
    
    [self.mainView addSubview:mBackground];
#else
    [self.view addSubview:mBackground];
#endif
    
    
    faceSystem = [[Face alloc] initWithFrame:CGRectMake(0, 243, 320, 216)];

    [faceSystem setDelegate:self];
    [self.mainView addSubview:faceSystem];
    
    [faceSystem.addLinkM addTarget:self action:@selector(actionTopicOrLinkMan:) forControlEvents:(UIControlEventTouchUpInside)];
    [faceSystem.addTopic addTarget:self action:@selector(actionTopicOrLinkMan:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [mBackground.editText.internalTextView becomeFirstResponder];
}

- (void)loadingIpad{
    self.mainView.frame = CGRectMake(0, 0, 468, 748);
//    self.mainView.frame = CGRectMake(0, 44, 390, 768);//1024-31);
//    self.view.frame = CGRectMake(0, 0, 390, 768);
    self.view.backgroundColor = [UIColor clearColor];

    self.CP_navigation.title = @"发私信";
//    [self.CP_navigation setHidesBackButton:YES];
    
//    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(actionCancel:)];
//    [self.CP_navigation setLeftBarButtonItem:(leftItem)];
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(actionCancel:)];
	[self.CP_navigation setLeftBarButtonItem:leftItem];
    
    
    UIImageView * bgviewimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 390, 768)];
    bgviewimage.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:bgviewimage];
    [bgviewimage release];
    
    UIImageView *sjrBGimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 390, 40)];
    sjrBGimage.image = UIImageGetImageFromName(@"wb19.png");
    sjrBGimage.backgroundColor = [UIColor clearColor];
    sjrBGimage.userInteractionEnabled = YES;
    [self.mainView addSubview:sjrBGimage];
    [sjrBGimage release];
    
    UILabel *sjrLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 25)];
    sjrLabel.text = @"收件人:";
    sjrLabel.font = [UIFont systemFontOfSize:16];
    sjrLabel.backgroundColor = [UIColor clearColor];
    [sjrBGimage addSubview:sjrLabel];
    [sjrLabel release];//1986
    
    
    
    mLinkMan = [UIButton buttonWithType:UIButtonTypeCustom];
    mLinkMan.frame = CGRectMake(80, 10, 120, 25);
    [mLinkMan setTitleColor:[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2] forState:UIControlStateNormal];
    mLinkMan.backgroundColor = [UIColor clearColor];
    [sjrBGimage addSubview:mLinkMan];
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(270+55, 0, 50, 40);
    
    UIImageView * addiamge = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
    addiamge.backgroundColor =  [UIColor clearColor];
    addiamge.image = UIImageGetImageFromName(@"wb5.png");
    [addBtn addSubview:addiamge];
    [addiamge release];
    
    //    [addBtn setImage:UIImageGetImageFromName(@"wb5.png") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(actionAddLinkMan:) forControlEvents:UIControlEventTouchUpInside];
    [sjrBGimage addSubview:addBtn];
    
    //    [self.view bringSubviewToFront:linLabel];
    //    [self.view bringSubviewToFront:mLinkMan];
    //    [self.view bringSubviewToFront:addBtn];
    
    //内容
    //    infoText = [[UITextView alloc] initWithFrame:CGRectMake(0, 40, 320, 200)];
    //    [infoText becomeFirstResponder];
    //    infoText.backgroundColor = [UIColor clearColor];
    //    [self.mainView addSubview:infoText];
    //    infoText.delegate = self;
    //    [infoText release];
    //
    mBackground = [[EditText alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height-44, 390, 44)];
    [mBackground setDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];

   
    [mBackground.editText setDelegate:self];
    [mBackground.sendBtn addTarget:self action:@selector(actionSendMail:) forControlEvents:(UIControlEventTouchUpInside)];
    [mBackground.mDeleteText addTarget:self action:@selector(actionDeleteText:) forControlEvents:(UIControlEventTouchUpInside)];
    mBackground.editText.internalTextView.backgroundColor = [UIColor clearColor];

//    [self.mainView addSubview:mBackground];

    [self.mainView insertSubview:mBackground atIndex:1000];
    
    faceSystem = [[Face alloc] initWithFrame: CGRectMake(0, self.mainView.frame.size.height+44, 390, 216)];

    
    [faceSystem setDelegate:self];
    [self.mainView addSubview:faceSystem];
    
    [faceSystem.addLinkM addTarget:self action:@selector(actionTopicOrLinkMan:) forControlEvents:(UIControlEventTouchUpInside)];
    [faceSystem.addTopic addTarget:self action:@selector(actionTopicOrLinkMan:) forControlEvents:(UIControlEventTouchUpInside)];
//    mBackground.frame = ;
//    faceSystem.frame = 
    
    [mBackground.editText.internalTextView becomeFirstResponder];
}
//- (void)actionBack{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
   
#ifdef isCaiPiaoForIPad
    [self loadingIpad];
    
#else
    [self loadingIphone];
#endif
    //self.mainView.backgroundColor = [UIColor whiteColor];
   
}

// 发送私信
- (void)actionSendMail:(id)sender {
    if (mHimId) {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NetURL CBsendMail:[[Info getInstance] userId] taUserId:mHimId content:[mBackground.editText text] imageUrl:@""]];
        [request setDelegate:self];
        [request setTimeOutSeconds:60.0];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request startAsynchronous];
        [[ProgressBar getProgressBar] show:@"正在发送私信..." view:self.mainView];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"收件人不符合要求"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
- (void)keyBoardWillDisappear:(id)sender
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
   
#ifdef isCaiPiaoForIPad
    [mBackground setCenter:CGPointMake(390/2, self.view.frame.size.height  - 216 - mBackground.bounds.size.height/2)];
#else
     mBackground.center = CGPointMake(160, self.mainView.frame.size.height-216/2-mBackground.frame.size.height/2 - 60);//[UIScreen mainScreen].bounds.size.height-30 - 170 - mBackground.frame.size.height/2);
#endif
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyBoardWillShow:(id)sender
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    CGRect keyboardFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keyboardFrame];
    
#ifdef isCaiPiaoForIPad
    CGFloat keyboardHeight = CGRectGetWidth(keyboardFrame);
    [mBackground setCenter:CGPointMake(390/2, self.mainView.frame.size.height - keyboardHeight - mBackground.bounds.size.height/2)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
#else
    CGFloat keyboardHeight = CGRectGetHeight(keyboardFrame);
    //mBackground.frame = CGRectMake(160, 416 - keyboardHeight, 320, mBackground.frame.size.height);
#ifdef isHaoLeCai
    mBackground.center = CGPointMake(160, [UIScreen mainScreen].bounds.size.height - keyboardHeight - mBackground.frame.size.height +25);
#else
    mBackground.center = CGPointMake(160, [UIScreen mainScreen].bounds.size.height - keyboardHeight - mBackground.frame.size.height +25);
    
#endif
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
#endif
   

}
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
   
    if ([result isEqualToString:RESULT_SUCC]) {
        [[ProgressBar getProgressBar] setTitle:@"发送私信成功!"];
    } else if ([result isEqualToString:RESULT_FAIL]) {
        [[ProgressBar getProgressBar] setTitle:@"你在对方的黑名单中！"];
    } else {
        // maybe is JSON format now...　-_-!
        NSDictionary *resultDict = [result JSONValue];
        if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [[ProgressBar getProgressBar] setTitle:@"发送私信成功!"];
        } else {
            [[ProgressBar getProgressBar] setTitle:@"你在对方的黑名单中！"];
        }
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(dismissDialog:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) requestFailed:(ASIHTTPRequest *)request {
    [[ProgressBar getProgressBar] dismiss];
}

- (void) dismissDialog : (id) sender {
    [[ProgressBar getProgressBar] dismiss];
#ifdef isCaiPiaoForIPad
    [self.navigationController popViewControllerAnimated:YES];
#else
    [self dismissViewControllerAnimated: YES completion: nil];
//    [self.navigationController popViewControllerAnimated:YES];
#endif
}

// 添加联系人
- (IBAction) actionAddLinkMan:(UIButton *)sender {
    
    FolloweesViewController *followeesController = [[FolloweesViewController alloc] init];
    followeesController.contentType = kLinkManEachOther;
    followeesController.shixin = YES;
	UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:followeesController];
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] >= 6) {
#ifdef isCaiPiaoForIPad
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
        
#else
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        
#endif
//        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    }

	if (navController) {
        followeesController.mController = self;
#ifdef isCaiPiaoForIPad
        [self.navigationController pushViewController:followeesController animated:YES];
#else
        [self presentViewController:navController animated: YES completion:nil];
#endif
		
	}
	[navController release];
	[followeesController release];
}

// 插入话题和@联系人
- (IBAction)actionTopicOrLinkMan:(UIButton *)sender {
    FolloweesViewController *followeesController = [[FolloweesViewController alloc] init];
    if (sender.tag == 0) {
        followeesController.contentType = kAddTopicController;
    } else if (sender.tag == 1) {
        followeesController.contentType = kLinkManController;
    }
	UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:followeesController];
	if (navController) {
        followeesController.mController = self;
		[self presentViewController:navController animated: YES completion:nil];
	}
	[navController release];
	[followeesController release];
}

// 选中插入话题或@联系人回调函数
- (void) friendsViewDidSelectFriend : (NSString*) name {
    if ([name hasPrefix:@"@"] || [name hasPrefix:@"#"]) {
        NSMutableString *textBuffer = [[NSMutableString alloc] init];
        [textBuffer appendString:mBackground.editText.internalTextView.text];
        [textBuffer appendString:name];
        
        [mBackground.editText.internalTextView setText:textBuffer];
        NSString *count = [[mBackground.mDeleteText titleLabel] text];
        [mBackground.mDeleteText setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
        [self changeTextCount:textBuffer];
        [textBuffer release];
        
        [mBackground.editText textViewDidChange:mBackground.editText.internalTextView];
        
        if (mBackground.sendBtn.enabled == NO) {
            mBackground.sendBtn.enabled = YES;
        }
    } else {
        NSArray *strArray = [name componentsSeparatedByString:@":"];
        if ([strArray count] >= 2) {
            NSString *nick_name = [strArray objectAtIndex:0];
            [self setMHimId: [strArray objectAtIndex:1]];
            if (nick_name) {
                self.nickName=nick_name;
                mLinkMan.hidden = NO;
                [mLinkMan setTitle:nick_name forState:(UIControlStateNormal)];
                int w = [nick_name sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]].width + 55;
                CGRect rect = mLinkMan.frame;
                [mLinkMan setFrame:CGRectMake(rect.origin.x, rect.origin.y, w, rect.size.height)];
            }
        }
        
    }
}

// 点击表情
- (void) clickFace:(NSString *)faceName {    
    NSMutableString *finalText = [[NSMutableString alloc] init];
    [finalText appendString:[mBackground.editText.internalTextView text]];
    [finalText appendString:faceName];
    [mBackground.editText.internalTextView setText:finalText];
    [finalText release];
    
    [mBackground.editText textViewDidChange:mBackground.editText.internalTextView];
    [self changeTextCount:[mBackground.editText.internalTextView text]];
    
    if (mBackground.sendBtn.enabled == NO) {
        mBackground.sendBtn.enabled = YES;
    }
}

- (void) changeTextCount : (NSString *) text {    
    int textCount = 300 - (int)[text length];
    if (textCount < 0) {
        [mBackground.mDeleteText setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    } else {
        [mBackground.mDeleteText setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    }
    [mBackground.mDeleteText setTitle:[NSString stringWithFormat:@"%d", textCount] forState:(UIControlStateNormal)];
    if ([[mBackground.editText.internalTextView text] length] == 0) {
        mBackground.sendBtn.enabled = false;
        mBackground.mDeleteText.hidden = YES;
    }
}

// 清除文字
- (void) actionDeleteText:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"清除文字"
                                  otherButtonTitles:nil,nil];
    actionSheet.tag = 0;
    [actionSheet showInView:self.mainView];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
    }
    [actionSheet release];
}

- (void)growingTextView:(GrowingTextView *)textView willChangeHeight:(float)height {
	float diff = (textView.frame.size.height - height);
    
    // 背景
    CGRect bgRect = mBackground.frame;
    bgRect.origin.y += diff;
    bgRect.size.height -= diff;
    mBackground.frame = bgRect;
    
    // 表情按钮
    CGRect faceRect = mBackground.showFaceBtn.frame;
    faceRect.origin.y -= diff;
    mBackground.showFaceBtn.frame = faceRect;
    
    // 发送按钮
    CGRect sendRect = mBackground.sendBtn.frame;
    sendRect.origin.y -= diff;
    mBackground.sendBtn.frame = sendRect;
    
    if (height >= 79) {
        mBackground.mDeleteText.hidden = NO;
    } else {
        mBackground.mDeleteText.hidden = YES;
    }
}

// 开始编辑文字
- (void) growingTextViewDidBeginEditing:(GrowingTextView *)growingTextView {
    [mBackground.showFaceBtn setSelected:NO];
    [faceSystem dismissFaceSystem];// 关闭表情
}

- (void) growingTextViewDidChange:(GrowingTextView *)textView {
    if ([textView.text length] == 0) {
        mBackground.sendBtn.enabled = false;
    } else {
        mBackground.sendBtn.enabled = true;
    }
    [self changeTextCount:[textView text]];
}

// 点击关闭表情,键盘弹出
- (void) keyBoardShow {
    [faceSystem dismissFaceSystem];
}

// 点击弹出表情,键盘消失
- (void) keyBoardDismiss {//352
    
#ifdef isCaiPiaoForIPad
    [faceSystem showFaceSystem:CGPointMake(195, self.view.frame.size.height  - faceSystem.bounds.size.height/2)];
#else
    [faceSystem showFaceSystem:CGPointMake(160, self.mainView.frame.size.height-216/2)];
#endif
}

- (IBAction) actionCancel : (id) sender {
    if ([[infoText text] length] > 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"放弃",nil];
        actionSheet.tag = 1;
        [actionSheet showInView:self.mainView];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
        }
        [actionSheet release];
    } else {
#ifdef isCaiPiaoForIPad
        [self.navigationController popViewControllerAnimated:YES];
#else
        [self dismissViewControllerAnimated: YES completion: nil];
//         [self.navigationController popViewControllerAnimated:YES];
#endif
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 0) {
        if (buttonIndex == actionSheet.destructiveButtonIndex) {
            [mBackground resumeDefaultAndKeyBoardIsShow:5];
        }
    } else if (actionSheet.tag == 1) {
        if (buttonIndex == actionSheet.firstOtherButtonIndex) {
            [self dismissViewControllerAnimated: YES completion: nil];
        }
    }
}

- (void)dealloc {
    //[mLinkMan release];
    [mBackground release];
    [faceSystem release];
    [mHimId release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	mLinkMan=nil;
	mBackground=nil;
	faceSystem=nil;
	self.mHimId=nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    