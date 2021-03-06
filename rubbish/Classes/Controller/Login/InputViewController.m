//
//  InputViewController.m
//  caibo
//
//  Created by Kiefer on 11-6-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "InputViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Info.h"
#import "caiboAppDelegate.h"

@implementation InputViewController

@synthesize inputText;
@synthesize lbTextNum;
@synthesize btnClear;
@synthesize delegate;

- (id)initWithText:(NSString *)text
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) 
    {
        [self.view setBackgroundColor:bgColor];
        
        [self.navigationItem setHidesBackButton:(YES)];
        
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        [self.navigationItem setLeftBarButtonItem:leftItem];
        
        
        UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"存 储" Target:self action:@selector(doSave)];
        [self.navigationItem setRightBarButtonItem:rightItem];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 180)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [view.layer setMasksToBounds:YES]; // 设置圆角边框
        [view.layer setCornerRadius:5];
        [view.layer setBorderWidth:1.5];
        [view.layer setBorderColor:[UIColor grayColor].CGColor];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 160)];
        [textView setFont:[UIFont systemFontOfSize:15]];
        [textView setText:text];
        [textView becomeFirstResponder];
        [textView setDelegate:(self)];
        self.inputText = textView;
        [textView release];
        [view addSubview:inputText];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(300-80, 160, 60, 20)];
        [lb setBackgroundColor:[UIColor clearColor]];
        [lb setTextAlignment:(NSTextAlignmentRight)];
        [lb setTextColor:[UIColor grayColor]];
        int num = 70 - (int)[inputText.text length];
        NSString *numStr = [NSString stringWithFormat:@"%d", num];
        [lb setText:numStr];
        self.lbTextNum = lb;
        [lb release];
        [view addSubview:lbTextNum];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(300-80, 160, 80, 20)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setImage:UIImageGetImageFromName(@"kbd_crossBtn.png") forState:(UIControlStateNormal)];
        [btn setImageEdgeInsets:(UIEdgeInsetsMake(0, 80-20, 0, 0))];
        [btn addTarget:self action:@selector(doClear) forControlEvents:(UIControlEventTouchUpInside)];
        if (num == 70)
        {
            [btn setHidden:YES]; 
        }
        self.btnClear = btn;
        [btn release];
        [view addSubview:btnClear];
        
        [self.view addSubview:view];
        [view release];
    }
    return self;
}

- (void)dealloc
{
    [inputText release];
    [lbTextNum release];
    [btnClear release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

// 返回上级界面
- (void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 存储
- (void)doSave
{
    NSString *value = inputText.text;
    if ([value length] == 0) 
    {
        [Info showDialogWithTitle:@"提示" BtnTitle:@"确定" Msg:@"内容不能为空" :self];
    }
    else if([value length] >70)
    {
        [Info showDialogWithTitle:@"提示" BtnTitle:@"确定" Msg:@"您输入的个人简介不能超过70个字" :self];
    }
    else
    {
        [delegate passValue:1 Value:value];
        [self.navigationController popViewControllerAnimated:YES];
//        [[caiboAppDelegate getAppDelegate] switchToHomeView];
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

// 清除
- (void)doClear
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                             delegate:self 
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:@"清除文字"   
                                                    otherButtonTitles:@"取消", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

#pragma mark 重写UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    int num = 70 - (int)[textView.text length];
    if (num < 0) 
    {
        [lbTextNum setTextColor:[UIColor redColor]];
        [btnClear setHidden:NO];
    }
    else if (num == 70)
    {
        [lbTextNum setTextColor:[UIColor grayColor]];
        [btnClear setHidden:YES];
    }
    else
    {
        [lbTextNum setTextColor:[UIColor grayColor]];
        [btnClear setHidden:NO];
    }
    NSString *numStr = [NSString stringWithFormat:@"%d", num];
    [lbTextNum setText:numStr];
}

#pragma mark 重写UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) 
    {
        [inputText setText:@""];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    