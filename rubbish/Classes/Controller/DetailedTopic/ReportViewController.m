//
//  ReportViewController.m
//  caibo
//
//  Created by jacob on 11-7-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReportViewController.h"
#import "ASIHTTPRequest.h"
#import "Info.h"
#import "NetURL.h"
#import "ProgressBar.h"
#import "YtTopic.h"
#import "JSON.h"

#import "caiboAppDelegate.h"

@implementation ReportViewController

@synthesize textView;
@synthesize request;
@synthesize sataus;

-(id)initWithYtTopic:(YtTopic*)ytTopic{
	if ((self = [super init])) {
		[self setSataus: ytTopic];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setTitle: @"举报原因"];
	
	// 添加 左边取消按钮
	UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *image = UIImageGetImageFromName(@"btn_square_bg.png");
	leftbutton.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
	[leftbutton setBackgroundImage:image forState:UIControlStateNormal];
	[leftbutton setTitle:@"取 消" forState:UIControlStateNormal];
	leftbutton.titleLabel.font = [UIFont systemFontOfSize:14];
	[leftbutton addTarget:self action:@selector(actionCancelOut) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *cancebutton = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
	self.navigationItem.leftBarButtonItem = cancebutton;
	[cancebutton release];
	
	// 添加 右边 发送 写微博 按钮
	UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
	rigthbutton.bounds = CGRectMake(0, 0,image.size.width, image.size.height);
	[rigthbutton setBackgroundImage:image forState:UIControlStateNormal];
	[rigthbutton setTitle:@"发 送" forState:UIControlStateNormal];
	rigthbutton.titleLabel.font = [UIFont systemFontOfSize:14];
	[rigthbutton addTarget:self action:@selector(actionSend) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *sendbutton = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
	self.navigationItem.rightBarButtonItem = sendbutton;
	self.navigationItem.rightBarButtonItem.enabled=NO;
	[sendbutton release];
    
   //[textView setText:OpinionTEXT];
    [textView becomeFirstResponder];
}

// 取消 推出 
-(void)actionCancelOut{
	if ([textView.text length]>0) {
		UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"放弃",nil];
		[sheet showInView:self.view.superview];
		[sheet release];
	} else {
		[self dismissViewControllerAnimated: YES completion: nil];
	}
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{	
	if (buttonIndex !=actionSheet.cancelButtonIndex) {
		[self dismissViewControllerAnimated: YES completion: nil];
	}
}

// 发送 举报请求
- (void)actionSend
{
	NSMutableString *str = [[NSMutableString alloc] initWithCapacity:40];
	[str appendFormat:@"%@%@",OpinionTEXT,[[Info getInstance] cbVersion]];
	[str appendFormat:@"%@",textView.text];
	textView.text = str;
	[str release];
	
	[[ProgressBar getProgressBar] show:@"正在发送举报消息" view:self.view];
	[ProgressBar getProgressBar].mDelegate = self;
	
	[request clearDelegatesAndCancel];
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBreport:[[Info getInstance] userId] content:textView.text topicId:sataus.topicid]]];
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(sendReportSucess:)];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
}


-(void)sendReportSucess:(ASIHTTPRequest*)mrequest
{
    NSString *result = [mrequest responseString];
    NSLog(@"result = %@", result);
    if ([result isEqualToString:@"succ"]) 
    {
        [[ProgressBar getProgressBar] setTitle:@"举报信息发送成功!"];
        [self performSelector:@selector(sendSuccdismissProgerssBar) withObject:nil afterDelay:1.0];
    } 
    else if ([result isEqualToString:@"fail"]) 
    {
        [[ProgressBar getProgressBar] setTitle:@"举报信息发送失败!"];
        [self performSelector:@selector(dismissProgerssBar) withObject:nil afterDelay:1.0];
    } 
    else 
    {
        NSDictionary *resultDict = [result JSONValue];
        if ([[resultDict objectForKey:@"result"] isEqualToString:@"succ"]) 
        {
            [[ProgressBar getProgressBar] setTitle:@"举报信息发送成功!"];
            [self performSelector:@selector(sendSuccdismissProgerssBar) withObject:nil afterDelay:1.0];
        } 
        else 
        {
            [[ProgressBar getProgressBar] setTitle:@"举报信息发送失败!"];
            [self performSelector:@selector(dismissProgerssBar) withObject:nil afterDelay:1.0];
        }
    }
}

#pragma mark ProgressBarDelegate
- (void)prograssBarBtnDeleate:(NSInteger) type {
    [request clearDelegatesAndCancel];
    [[ProgressBar getProgressBar] dismiss];
}

-(void)dismissProgerssBar {
	[[ProgressBar getProgressBar] dismiss];
}

// 发送成功之后 调用 
-(void)sendSuccdismissProgerssBar{
	[[ProgressBar getProgressBar] dismiss];
	[self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark UITextViewDelegate 
- (void)textViewDidChange:(UITextView *)mtextView{
  if ([mtextView.text length]>0) {
	  self.navigationItem.rightBarButtonItem.enabled =YES;  
  } else {
	  self.navigationItem.rightBarButtonItem.enabled =NO;
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.request =nil;
	self.sataus =nil;
	self.textView =nil;
	
	
	
}

- (void)dealloc {
	[request clearDelegatesAndCancel];
	[request release];
    
    [sataus release];
	[textView release];
    
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    