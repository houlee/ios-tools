//
//  ProgressBar.m
//  caibo
//
//  Created by jeff.pluto on 11-6-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ProgressBar.h"
#import "caiboAppDelegate.h"


@implementation ProgressBar

@synthesize mRefreshBar;
@synthesize mDelegate;

static ProgressBar *instance = nil;

+ (ProgressBar *) getProgressBar {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[[self alloc] init] autorelease];
        }
    }
    return instance;
}

- (void) show:(NSString *)text view :(UIView *)view {
    if (instance == nil) {
        return;
    }
    
    [self setTitle:text];
    
    mCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [mCancel setHidden: NO];
    [mCancel setFrame: CGRectMake(10, 10, 45, 26)];
    [mCancel setImage:UIImageGetImageFromName(@"btn_cancelBtn.png") forState:(UIControlStateNormal)];
    
    [mCancel addTarget: self action: @selector(doCancel:) forControlEvents: UIControlEventTouchUpInside];
     
    [self addSubview:mCancel];
    
    
    mRefreshBar = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    mRefreshBar.frame = CGRectMake(260, 10, 24, 24);
    [self addSubview:mRefreshBar];
    [mRefreshBar startAnimating];
    
    mDelegate = Nil;
#ifdef isCaiPiaoForIPad
     [mCancel setFrame: CGRectMake(10, 0, 45, 26)];
    
    UIView *v = [[caiboAppDelegate getAppDelegate].window viewWithTag:10212];
    if (v) {
        [instance showFromRect:CGRectMake(35 + 35, 768-150, 400, 44) inView:view animated:YES];
    }
    else {
        [instance showFromRect:CGRectMake(35, 768-120, 320, 44) inView:view animated:YES];
    }
    
#else
    

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
    }
    else {
            [instance showInView:view];
    }

#endif
    
//    
  
}

- (void) show : (NSString *)text view : (UIView *) view delegate:(BOOL) isDelegate;
{
    [self show:text view:view ];
}

-(IBAction) doCancel:(id) sender
{
 
    if( mDelegate && [mDelegate respondsToSelector:@selector(prograssBarBtnDeleate:)] ){
        
        [mDelegate prograssBarBtnDeleate:1];
    }
   
}

- (void) setTitle:(NSString *)title {
    [super setTitle:title];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [[caiboAppDelegate getAppDelegate] showMessage:title];
        return;
    }
    [mRefreshBar stopAnimating];
    if (mCancel) {
        mCancel.hidden = YES;
    }
}

- (void) dismiss {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [[caiboAppDelegate getAppDelegate] hidenMessage];
    }
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)dealloc {
    instance = nil;
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    