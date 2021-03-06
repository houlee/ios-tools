//
//  CP_APPAlertFlashAdView.m
//  caibo
//
//  Created by cp365dev on 14-5-27.
//
//

#import "CP_APPAlertFlashAdView.h"

@implementation CP_APPAlertFlashAdView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame andFlashAdImage:(UIImage *)image

{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        grayView = [[UIView alloc] initWithFrame:frame];
        grayView.backgroundColor = [UIColor colorWithRed:0 green:0  blue:0  alpha:0.6];
        [self addSubview:grayView];
        [grayView release];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        UIImageView *popalertbg = [[UIImageView alloc] initWithFrame:CGRectMake(21.5, (window.frame.size.height-357)/2.0, 277, 357)];
        [popalertbg setImage:[UIImageGetImageFromName(@"tanchuangbg.png") stretchableImageWithLeftCapWidth:21 topCapHeight:19]];
        [popalertbg setUserInteractionEnabled:YES];
        [grayView addSubview:popalertbg];
        [popalertbg release];
        
        UIButton *popAlertImageBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        //    [popAlertImageBtn setImage :UIImageGetImageFromName(@"tangchuang.png") forState:UIControlStateNormal];
        [popAlertImageBtn setImage:image forState:UIControlStateNormal];
        [popAlertImageBtn setFrame:CGRectMake(0, 0, 277, 357)];
        [popAlertImageBtn addTarget:self action:@selector(PressFlashAd:) forControlEvents:UIControlEventTouchUpInside];
        [popalertbg addSubview:popAlertImageBtn];
        
        
        
        UIButton *popalertClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [popalertClose setFrame:CGRectMake(227, 0, 50, 50)];
        [popalertClose addTarget:self action:@selector(PressFlashAdClose:) forControlEvents:UIControlEventTouchUpInside];
        [popAlertImageBtn addSubview:popalertClose];
        
        UIImageView *closeImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 18, 18)];
        [closeImage setImage:UIImageGetImageFromName(@"tangchuangclose.png")];
        [popalertClose addSubview:closeImage];
        [closeImage release];
    }

    
    return self;

}
//点击广告
-(void)PressFlashAd:(UIButton *)sender
{
    NSLog(@"应用内弹窗——点击广告");
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0];
    
    if(delegate && [delegate respondsToSelector:@selector(clickAppAlertFlashAdViewDelegate)])
    {
        [delegate clickAppAlertFlashAdViewDelegate];
    }
    
}
//点击关闭广告
-(void)PressFlashAdClose:(UIButton *)sender
{
    NSLog(@"应用内弹窗——点击关闭广告");
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    

}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
    [grayView removeFromSuperview];
    grayView = nil;
    
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"alertFalshAd"];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    