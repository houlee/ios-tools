//
//  DuanXinViewController.m
//  caibo
//
//  Created by zhang on 9/14/12.
//
//

#import "DuanXinViewController.h"
#import "Info.h"
#import "CBNavigationBar.h"
#import "NetURL.h"
#import "JSON.h"
#import "YaoQingViewController.h"
#import "NSStringExtra.h"
#import "MobClick.h"

@interface DuanXinViewController ()

@end

@implementation DuanXinViewController
@synthesize yaorequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    titleLabel.hidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (![sjrField isFirstResponder]) {
        [sjrField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.3];
    }
    // [self keyboardWillShow:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [sjrField resignFirstResponder];
    [inputField resignFirstResponder];
//    titleLabel.hidden = YES;
    
    // titleLabel.hidden = YES;
    
    //判断版本号
    //    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    //    NSString * diyistr = [devicestr substringToIndex:1];
    //    if ([diyistr isEqualToString: @"5"]) {
    //        [self.navigationController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    //    }else{
    //        [self.navigationController.navigationBar drawRect:CGRectMake(0, 0,self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    //    }
    
}

- (void)dealloc {
    [yaorequest clearDelegatesAndCancel];
    [yaorequest release];
    [super dealloc];
}

- (void)scrollself {
    [sjrField scrollRectToVisible:CGRectMake(0, 0, 100 , 35) animated:NO];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == sjrField) {
//        sjrField.contentOffset = CGPointMake(0, 0);
        [self performSelector:@selector(scrollself) withObject:nil afterDelay:0.1];
//        [sjrField performSelector:@selector(scrollRectToVisible:animated:) withObject:(0, 0, 100 , 35) afterDelay:0.1];
        
        NSLog(@"111%@",textView.text);
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.tag == 5) {
        NSLog(@"aaaaaaaaaaaa");
        NSString * str = textView.text;
        NSLog(@"str = %@", str);
//        UIFont * font = [UIFont fontWithName:@"Arial" size:13];
        CGSize  size = CGSizeMake(210, 100);        
    
        CGSize labelSize = [str sizeWithFont:textView.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        if (labelSize.height <= 35) {
            bbx.frame = CGRectMake(0, self.mainView.bounds.size.height-keysize.height-50, 320, 50);
            inputField.frame = CGRectMake(10, 0, 210, 20);
            inputImage.frame = CGRectMake(35, 12, 222, 27);
        }
        else {
            bbx.frame = CGRectMake(0, self.mainView.bounds.size.height-keysize.height-50 - labelSize.height, 320,  labelSize.height + 48);
            inputField.frame = CGRectMake(10, 0, 210, labelSize.height + 8);
            inputImage.frame = CGRectMake(35, 12, 222, labelSize.height + 20);
        }


    }else
 if (textView.tag == 6){
            
      NSLog(@"bbbbbbbbbb");
      NSString * str = textView.text;
      NSLog(@"str = %@", str);
     //        UIFont * font = [UIFont fontWithName:@"Arial" size:13];
      CGSize  size = CGSizeMake(210, 100);
            
      CGSize labelSize = [str sizeWithFont:textView.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
      if (labelSize.height <= 35) {
          sjrImage.frame = CGRectMake(0, 0, 320, 45);
          sjrField.frame = CGRectMake(73, 7, 180, 35);
                
          }else {
          sjrImage.frame = CGRectMake(0, 0, 320, 45 + labelSize.height);
          sjrField.frame = CGRectMake(73, 7, 180, 35 + labelSize.height);
                
            }
            
        }

    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.title = @"短信邀请";
    
    self.mainView.backgroundColor = [UIColor colorWithRed:192/225.0 green:192/225.0 blue:192/225.0 alpha:1];
//    [self.CP_navigation setHidesBackButton:YES];
    
    //更换导航栏
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    imageV.image = UIImageGetImageFromName(@"sbiso1.png");
//    imageV.tag = 101;
//    [self.navigationController.navigationBar addSubview:imageV];
//    [imageV release];
    
//    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 5, 80, 35)];
//    titleLabel.text = @"短信邀请";
//    titleLabel.font = [UIFont systemFontOfSize:20];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    [self.CP_navigation.titleView addSubview:titleLabel];
//    self.CP_navigation.titleView = titleLabel;
    self.CP_navigation.title =  @"短信邀请";
    

    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    
   
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBounds:CGRectMake(0, 0, 70, 40)];
   
//    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
//    imagevi.backgroundColor = [UIColor clearColor];
//    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
//    [btn addSubview:imagevi];
//    [imagevi release];
    
    UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
    lilable.textColor = [UIColor whiteColor];
    lilable.backgroundColor = [UIColor clearColor];
    lilable.textAlignment = NSTextAlignmentCenter;
    lilable.font = [UIFont boldSystemFontOfSize:14];
    lilable.shadowColor = [UIColor blackColor];//阴影
    lilable.shadowOffset = CGSizeMake(0, 1.0);
    lilable.text = @"取消";
    [btn addSubview:lilable];
    [lilable release];
    [btn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];
    
    
    //收件人
    sjrImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44.5)];
    sjrImage.image = UIImageGetImageFromName(@"BBiso.png");
    sjrImage.userInteractionEnabled = YES;
    
    UILabel *sjrLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    sjrLabel.text = @"收件人:";
    sjrLabel.textAlignment = NSTextAlignmentCenter;
    sjrLabel.backgroundColor = [UIColor clearColor];
    sjrLabel.font = [UIFont systemFontOfSize:18];
    
    sjrField = [[UITextView alloc] initWithFrame:CGRectMake(73, 7, 180, 35)];
    sjrField.backgroundColor = [UIColor clearColor];
    sjrField.tag =6;
    sjrField.contentInset = UIEdgeInsetsZero;
    sjrField.text = @"";
    sjrField.font = [UIFont systemFontOfSize:15];
    sjrField.delegate = self;
    
    
//    sjrField = [[UITextField alloc] initWithFrame:CGRectMake(80, 15, 160, 30)];
//    sjrField.backgroundColor = [UIColor clearColor];
//    sjrField.text = @"";
//    [sjrField becomeFirstResponder];
//    //[sjrfield resignFirstResponder];
    
    
    
    
    //添加联系人按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(280, 5, 29, 33);
    [addButton setImage:UIImageGetImageFromName(@"Biso.png") forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //监听键盘切换
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:)
    name:UIKeyboardWillShowNotification object:nil];//显示
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:)
  //  name:UIKeyboardWillHideNotification object:nil];//隐藏
    
    
    
    
    bbx = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 320, 42)];
    bbx.image = UIImageGetImageFromName(@"BBXiso.png");
    bbx.userInteractionEnabled = YES;
    
    
    //短信内容输入框
    inputImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 12, 222, 27)];
    inputImage.image = UIImageGetImageFromName(@"DZiso.png");
    inputImage.userInteractionEnabled = YES;
    
    inputField = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, 210, 25)];
    inputField.backgroundColor = [UIColor clearColor];
    inputField.textAlignment = NSTextAlignmentLeft;
    inputField.tag =5;
    inputField.font = [UIFont systemFontOfSize:15];
    inputField.text = @"投注站手机买彩票真方便，下载地址http://www.cp365.cn/down.jsp";
    inputField.returnKeyType = UIReturnKeyDefault;
    inputField.keyboardType = UIKeyboardTypeDefault;
    inputField.scrollEnabled = YES;
    inputField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    inputField.delegate = self;
    
    
    //发送按钮
    UIButton *fsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fsButton.frame = CGRectMake(265, 12, 53, 27);
    [fsButton setImage:UIImageGetImageFromName(@"FSiso.png") forState:UIControlStateNormal];
    [fsButton addTarget:self action:@selector(sendSMS) forControlEvents:UIControlEventTouchUpInside];
    
    
    //拍照按钮
    UIButton *pzButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pzButton.frame = CGRectMake(2, 12, 26, 26);
    pzButton.backgroundColor = [UIColor clearColor];
    [pzButton setImage:UIImageGetImageFromName(@"XJiso.png") forState:UIControlStateNormal];
    
    
    
    [self.mainView addSubview:sjrImage];
    [sjrImage addSubview:sjrLabel];
    [sjrImage addSubview:sjrField];
    [sjrImage addSubview:addButton];
    
    [self.mainView addSubview:bbx];
    [bbx addSubview:inputImage];
    [bbx addSubview:fsButton];
    [bbx addSubview:pzButton];
    [inputImage addSubview:inputField];
    
    
    [inputImage release];
    [inputField release];
    [bbx release];
    [sjrField release];
    [sjrLabel release];
    [sjrImage release];
//    [titleLabel release];

}


- (void)doBack{
    for (UIView *v in self.navigationController.navigationBar.subviews)
    {
        if (v.tag >100) {
            [v removeFromSuperview];
        }
    }
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[YaoQingViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] -3] animated:YES];
    }
    
}


//键盘监听
- (void)keyboardNotification:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:UIKeyboardWillShowNotification])
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut
        animations:^{
                             
        
            //获取键盘值
            NSValue * kvalue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
            keysize = [kvalue CGRectValue].size;
            
            //短信内容输入框
            bbx.frame = CGRectMake(0, self.mainView.bounds.size.height-keysize.height-50, 320, 50);
            inputImage.frame = CGRectMake(35, 12, 222, 27);
            inputField.frame = CGRectMake(10, 0, 210, 25);
            
            //收件人
//            sjrImage.frame = CGRectMake(0, 0, 320, 45);
//            sjrField.frame = CGRectMake(73, 7, 180, 35);
           
            
                             
     } completion:NULL];
    }
    
}

//键盘显示
- (void) keyboardWillShow:(id)sender
{
	//[self.mMessage setSelectedRange:NSMakeRange(0, 0)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    //   CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
    
//    CGRect frame = self.view.frame;
//    frame.origin.y -=216;
//    frame.size.height +=216;
//      self.view.frame = frame;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.view.frame = frame;
//    [UIView commitAnimations];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

//短信电话号码格式判断
//- (void)allnuberoriphone:(NSString *)nub{
//    if(![nub isAllNumber] || ![nub isPhoneNumber]){
//        
//        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"手机号格式不合法." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [aler show];
//        [aler release];
//        //          twobol = NO;
//        return;
//    }
//
//}

//发送
- (void)sendSMS{
    [MobClick event:@"event_wodecaipiao_yaoqinghaoyou_duanxin_fasong"];
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
	NSLog(@"can send SMS [%d]", canSendSMS);
	if (canSendSMS) {
        [inputField resignFirstResponder];
        [sjrField resignFirstResponder];
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.navigationBar.tintColor = [UIColor blueColor];
    picker.body = inputField.text;//短信内容
     
    //收件人
    sjr = [[NSMutableArray alloc] initWithCapacity:0];
    NSRange doustr = [sjrField.text rangeOfString:@","];
    if (doustr.location != NSNotFound) {
      NSArray * sjrarr = [sjrField.text componentsSeparatedByString:@","];
        
//        for (NSString * str in sjrarr) {
//            [self allnuberoriphone:str];
//
//        }
        
      [sjr addObjectsFromArray:sjrarr];
        }else{
            //[self allnuberoriphone:sjrField.text];
            [sjr addObject:sjrField.text];
        }
        NSLog(@"aaassssddddd = %d", (int)[sjr count]);
        picker.recipients = [NSArray arrayWithArray:sjr];
        [sjr release];
        

        
    if ([MFMessageComposeViewController canSendText]) {
        
        [self presentViewController:picker animated: YES completion:nil];
    }
    [picker release];
    }
}

//短信发送成功，失败，取消调用该方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Result: SMS sent");
          
            //收件人上传服务器
            [yaorequest clearDelegatesAndCancel];
            self.yaorequest = [ASIHTTPRequest requestWithURL:[NetURL CBInviteFriend:[[Info getInstance] userId] type:@"0" success:@"1" typeId:sjrField.text]];
            [yaorequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [yaorequest setDelegate:self];
            [yaorequest setDidFinishSelector:@selector(yaoQingHaoYouRequest:)];
            [yaorequest setTimeOutSeconds:20.0];
            [yaorequest startAsynchronous];
            break;
        case MessageComposeResultFailed:
            NSLog(@"Result: SMS filed");
            break;
        default:
            NSLog(@"Result: SMS not sent");
            break;
    }
    [self dismissViewControllerAnimated: YES completion: nil];
}


- (void)yaoQingHaoYouRequest:(ASIHTTPRequest *)mrequest{
    NSString * requeststr = [mrequest responseString];
    NSLog(@"request = %@", requeststr);
    NSDictionary * dict = [requeststr JSONValue];
    NSString * code = [dict objectForKey:@"code"];
    //
    if ([code intValue] == 1) {
        
    }else{
        
    }
    
    
}

//获取通讯录联系人
- (void)showPicker:(id)sender
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate= self;
    [self presentViewController:picker animated: YES completion:nil];
    [picker release];
    
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
   
    [self dismissViewControllerAnimated: YES completion: nil];
        
}

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    //获取联系人姓名
    name = (NSString*)ABRecordCopyCompositeName(person);
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] initWithCapacity:0];
    int i;
    for (i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
        NSString *aPhone = [(NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i) autorelease];
        NSString *aLabel = [(NSString*)ABMultiValueCopyLabelAtIndex(phoneMulti, i) autorelease];
        NSLog(@"PhoneLabel:%@ Phone#:%@",aLabel,aPhone);
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"])
        {
            [phones addObject:aPhone];
        }
    }
    //phoneNo.text=@"";
    if([phones count]>0)
    {
     //   phoneNo.text = mobileNo;
        NSLog(@"%@",[phones objectAtIndex:0]);
    }
    CFRelease(phoneMulti);
    [phones release];
    //获取联系人邮箱
    ABMutableMultiValueRef emailMulti = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSMutableArray *emails = [[NSMutableArray alloc] initWithCapacity:0];
    for (i = 0;i < ABMultiValueGetCount(emailMulti); i++)
    {
        NSString *emailAdress = [(NSString*)ABMultiValueCopyValueAtIndex(emailMulti, i) autorelease];
        [emails addObject:emailAdress];
    }
//    email.text=@"";
    if([emails count]>0)
    {
        
        NSString *emailFirst=[emails objectAtIndex:0];
        email = emailFirst;
        //NSLog(emailFirst);
    }
    CFRelease(emailMulti);
    [emails release];
    //[peoplePicker dismissViewControllerAnimated: YES completion: nil];
    return YES;
}


- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person  property:(ABPropertyID)property  
 identifier:(ABMultiValueIdentifier)identifier
{
    
    NSString* compositeName = (NSString *)ABRecordCopyCompositeName(person);
    contactsAdd = compositeName;
    nameTextField.text =compositeName;
    [compositeName release];
    ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
    
    //添加多个电话号码
    NSString *phone = (NSString *)ABMultiValueCopyValueAtIndex(phoneProperty,identifier);
    contactsAdd = (NSString*)phone;
    if ([sjrField.text length] == 0) {
        sjrField.text = [NSString stringWithFormat:@"%@%@,", sjrField.text, phone];
    }else{
        sjrField.text = [NSString stringWithFormat:@"%@,%@,", sjrField.text, phone];
    }
    
    sjrField.text = [sjrField.text substringToIndex:[sjrField.text length] - 1];

    [self dismissViewControllerAnimated: YES completion: nil];
    CFRelease(phoneProperty);
    return NO;
} 

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    