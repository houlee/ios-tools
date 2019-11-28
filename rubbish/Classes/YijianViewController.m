//
//  YijianViewController.m
//  caibo
//
//  Created by  on 12-5-13.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "YijianViewController.h"
#import "Info.h"
#import "NetURL.h"
#import "User.h"
#import "JSON.h"
#import "RegexKitLite.h"
#import "NSStringExtra.h"


@implementation YijianViewController
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"意见反馈";
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
	self.navigationItem.leftBarButtonItem = leftItem;  
	
    
    rightItem = [Info itemInitWithTitle:@"完成" Target:self action:@selector(actionSave:)];
    rightItem.enabled = NO;
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardshow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgimage.image = UIImageGetImageFromName(@"login_bg.png");
    
    
    
    UIImageView * upimage = [[UIImageView alloc] initWithFrame:CGRectMake(13, 15, 293, 177)];
    upimage.image = UIImageGetImageFromName(@"wb_megBg.png");
    
    
    UILabel * telabel = [[UILabel alloc] initWithFrame:CGRectMake(146, 152, 100, 20)];
    telabel.text = @"还可以输入";
    telabel.textAlignment = NSTextAlignmentRight;
    telabel.font = [UIFont systemFontOfSize:10];
    telabel.backgroundColor = [UIColor clearColor];
    [upimage addSubview:telabel];
    [telabel release];
    
    textnum = [[UILabel alloc] initWithFrame:CGRectMake(246, 152, 20, 20)];
    textnum.text = @"200";
    textnum.textAlignment = NSTextAlignmentCenter;
    textnum.font = [UIFont systemFontOfSize:10];
    textnum.backgroundColor = [UIColor clearColor];
    [upimage addSubview:textnum];
    
    
    UILabel * zilabel = [[UILabel alloc] initWithFrame:CGRectMake(266, 152, 20, 20)];
    zilabel.text = @"字";
    zilabel.textAlignment = NSTextAlignmentLeft;
    zilabel.font = [UIFont systemFontOfSize:10];
    zilabel.backgroundColor = [UIColor clearColor];
    [upimage addSubview:zilabel];
    [zilabel release];
    
    baview = [[UIView  alloc] initWithFrame:self.view.bounds];
    baview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    [baview addSubview:bgimage];
    [bgimage release];
    [baview addSubview:upimage];
    [upimage release];
    UIImageView * mailimage = [[UIImageView alloc] initWithFrame:CGRectMake(13, 222, 294, 36)];
    mailimage.image = UIImageGetImageFromName(@"login_input1.png");
    
    UIImageView * mobileimage = [[UIImageView alloc] initWithFrame:CGRectMake(13, 268, 294, 36)];
    mobileimage.image = UIImageGetImageFromName(@"login_input1.png");
    
    UILabel * maillabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 36)];
    maillabel.text = @"您的邮箱(选填):";
    maillabel.textAlignment = NSTextAlignmentRight;
    maillabel.backgroundColor = [UIColor clearColor];
    maillabel.textColor = [UIColor grayColor];
    maillabel.font = [UIFont systemFontOfSize:14];
    
    UILabel * mobilelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 36)];
    mobilelabel.text = @"手机号码(选填):";
    mobilelabel.textAlignment = NSTextAlignmentRight;
    mobilelabel.backgroundColor = [UIColor clearColor];
    mobilelabel.textColor = [UIColor grayColor];
    mobilelabel.font = [UIFont systemFontOfSize:14];
    
    
    //提示“未登录状态下，手机号码为必填”
    if ([[[Info getInstance] userId] intValue] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"未登录状态下，手机号码为必填"];

    }
    	
    
    
    
    [mailimage addSubview:maillabel];
    [mobileimage addSubview:mobilelabel];
    [maillabel release];
    [mobilelabel release];
    
    [baview addSubview:mailimage];
    [baview addSubview:mobileimage];
    [mailimage release];
    [mobileimage release];
    
    bgbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgbutton.frame = self.view.bounds;
    bgbutton.backgroundColor = [UIColor clearColor];
    [bgbutton addTarget:self action:@selector(pressbgbutton:) forControlEvents:UIControlEventTouchUpInside];
    [baview addSubview:bgbutton];
    
    textview = [[UITextView alloc] initWithFrame:CGRectMake(25, 75, 270, 95)];
    textview.backgroundColor = [UIColor clearColor];
    textview.returnKeyType = UIReturnKeyDone;
    textview.delegate = self;
    //textview.returnKeyType = UIReturnKeyDone;
    
    textmail = [[UITextField alloc] initWithFrame:CGRectMake(135, 230, 165, 20)];
    textmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    textmail.delegate = self;
    textmail.tag = 1;
    
    textmobile = [[UITextField alloc] initWithFrame:CGRectMake(135, 276, 165, 20)];
    textmobile.clearButtonMode = UITextFieldViewModeWhileEditing;
    textmobile.delegate = self;
    textmobile.tag = 2;
    
    [baview addSubview:textmail];
    [baview addSubview:textmobile];
    [baview addSubview:textview];
    [self.view addSubview:baview];
    keybool = NO;
    
}
- (void) keyboardWillShow:(id)sender
{
    
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
//    CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
    if ([textview isFirstResponder]) {
        
    }
    if ([textmail isFirstResponder]) {
        
    }
    if ([textmobile isFirstResponder]) {
        
    }
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    
    
}
- (void) keyboardWillDisapper:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
   
    
    hightsi = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
   
    bgbutton.enabled = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    NSLog(@"textview = %@, text = %@", textview.text, text);
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}
/*
- (void)keyboardshow:(NSNotification *)anotification{
    NSDictionary * info = [anotification userInfo];
    NSValue * avalue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardsize = [avalue CGRectValue].size;
    CGRect screenrect = [self.view bounds];
    
    self.view.frame = CGRectMake(0, 0, 320, 480 - keyboardsize.height);

}

 */
- (void)textFieldDidBeginEditing:(UITextField *)textField  
{ //当点触textField内部，开始编辑都会调用这个方法。textField将成为first responder   
    
    
        if (self.view.frame.origin.y == 0) {
            CGRect frame = self.view.frame;  
            frame.origin.y -=100;  
            frame.size.height +=100;
            hightsi += 100;
            //  self.view.frame = frame;  
            [UIView beginAnimations:nil context:nil];  
            [UIView setAnimationDuration:0.3f]; 
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.view.frame = frame;                  
            [UIView commitAnimations];
            bgbutton.enabled = NO;
        }
       
   
 
                     
}  

- (BOOL)textFieldShouldReturn:(UITextField *)textField   
{ 
 
    if (self.view.frame.origin.y != 0) {
        CGRect frame = self.view.frame;      
        frame.origin.y +=hightsi;  //216
        frame.size. height -=hightsi;
        // self.view.frame = frame;  
        hightsi = 0;
        [UIView beginAnimations:nil context:nil];  
        [UIView setAnimationDuration:0.3f];  
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.frame = frame;                  
        [UIView commitAnimations];  
        [textField resignFirstResponder];
        bgbutton.enabled = YES;
    }
       
       
    
        
 
                
    
   
    return YES;
}         

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}

- (void)pressbgbutton:(UIButton *)sender{
    [textview resignFirstResponder];
    if (self.view.frame.origin.y != 0) {
        CGRect frame = self.view.frame;      
        frame.origin.y +=100;  //216      
        frame.size. height -=100;     
        // self.view.frame = frame;  
        
        [UIView beginAnimations:nil context:nil];  
        [UIView setAnimationDuration:0.3f];  
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame = frame;                  
        [UIView commitAnimations];  
        
    }

}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}
// 校验输入的邮箱号
- (BOOL)doCheckMailNum
{
    NSString *mailNum = textmail.text;
    NSString *message;
    
    BOOL isPass = NO;
    if ([mailNum length] == 0) 
        {
        message = @"邮箱名不能为空";
        }
    else
        {
        NSString *regexMailNum = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
        isPass = [mailNum isMatchedByRegex:regexMailNum];
        if (isPass) 
            {
//            if (![mailNum isEqualToString:[[Info getInstance] mailNum]]) 
//                {
//                message = @"与绑定邮箱号不一致";
//                isPass = NO;
//                }
            }
        else
            {
            message = @"邮箱名格式不正确";
            }
        }
    
    if (!isPass) 
        {
        [Info showCancelDialog:(@"提示") :(message) :(self)];
        }
    return isPass;
}

- (void)actionSave:(UIButton *)sender{
//    BOOL onebol;
//    BOOL twobol;
     self.navigationItem.rightBarButtonItem.enabled = NO;
   
    [textview resignFirstResponder];
    NSString * str;
    if ([textmail.text length] != 0) {
        BOOL ispass = [self doCheckMailNum];
    
        if (!ispass) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
            NSLog(@"ispass= %d", ispass);
    //        onebol = NO;
            
            return;
        }
      //  onebol = YES;
    }
    if([textmobile.text length] != 0){
    
   
            if(![textmobile.text isAllNumber] || [textmobile.text length] != 11 || ![textmobile.text isPhoneNumber]){
                str = @"手机号格式不合法.";
                self.navigationItem.rightBarButtonItem.enabled = YES;
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"修改信息失败" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
                [aler release];
      //          twobol = NO;
                 
                return;
            }
       // twobol = YES;
    }
            

    
    
//    if ((onebol && twobol)||([textmail.text length] == 0&&[textmobile.text length]==0)||([textmail.text length]>0 && [textmobile.text length]==0 && onebol)||([textmobile.text length]>0 && [textmail.text length]==0&& twobol)) {
//       
//    }
 
    
    [self performSelector:@selector(requestFasong) withObject:self afterDelay:1];
    
    
    
//    BOOL ispass = [self doCheckMailNum];
//    NSLog(@"ispass= %d", ispass);
//    if(![textmobile.text isAllNumber] || [textmobile.text length] != 11){
//     NSString * str = @"手机号格式不合法.";
//        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"修改信息失败" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [aler show];
//        [aler release];
//        
//    }
    
        
       
    
}

- (void)requestFasong{//测试
    if ([[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] == 0){
        
        self.request = [ASIHTTPRequest requestWithURL:[NetURL CPThreeQAtwouserid:@"0" content:textview.text mobile:textmobile.text mail:textmail.text]];
        
    }
    if ([[[Info getInstance] userId] intValue] == 0) {
		if ([textmobile.text length] == 0) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"未登录状态下，手机号码为必填"];//手机号码未填，提示“未登录状态下，手机号码为必填”
            self.navigationItem.rightBarButtonItem.enabled = YES;
            return;
        }
    }else{
        NSLog(@"request = %@", [NetURL CPThreeQAtwouserid:[[Info getInstance] userId] content:textview.text mobile:textmobile.text mail:textmail.text]);
        self.request = [ASIHTTPRequest requestWithURL:[NetURL CPThreeQAtwouserid:[[Info getInstance] userId] content:textview.text mobile:textmobile.text mail:textmail.text]];
    }
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDidFinishSelector:@selector(reqUserInfoFinished:)];
    [request setDidFailSelector:@selector(reqfail:)];
    [request setDelegate:self];
    [request startAsynchronous];
}
- (void)reqfail:(ASIHTTPRequest *)mrequest{
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)reqUserInfoFinished:(ASIHTTPRequest *)mrequest{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSLog(@"dict = %@", dict);
    NSString * string = [dict objectForKey:@"result"];
    NSString * msg;
    if ([string isEqualToString:@"succ"]) {
        msg = @"发送成功";
    }else{
        msg = @"发送失败";
    }
    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aler show];
    [aler release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

// 监听用户输入；改变字数限制提示
- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text length] != 0) {
        rightItem.enabled = YES;
    }else{
        rightItem.enabled = NO;
    }
    
    [self changeTextCount:[textView text]];
    
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

- (void) changeTextCount : (NSString *) text {
    int textCount = 200 - [self countWord:text];
    textnum.text = [NSString stringWithFormat:@"%d", textCount];
  
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
        
    if ([textView.text length] == 0) {
        rightItem.enabled = NO;
    }
    
    return YES;
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

- (void)dealloc{
    [textnum  release];
    [request clearDelegatesAndCancel];
    [request release];
    [textview release];
    [textmail release];
    [textmobile release];
    //[baview release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    