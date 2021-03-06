//
//  CP_HiddenAlertView.m
//  caibo
//
//  Created by cp365dev on 14-5-23.
//
//

#import "CP_HiddenAlertView.h"
#import "ImageUtils.h"
#import "caiboAppDelegate.h"

@implementation CP_HiddenAlertView
@synthesize mEndMessage,mImageName,mMessage,mTitle;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    }
    return self;
}
-(id)initWithTitle:(NSString *)title delegate:(id)delegates andTitleImage:(NSString *)imageName andMessage:(NSString *)message andEndMessage:(NSString *)endMessage
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if(self)
    {
        self.delegate = delegates;
        self.mTitle = title;
        self.mMessage = message;
        self.mEndMessage = endMessage;
        self.mImageName = imageName;
    }
    return self;
}
-(void)showAndHiddenAfter:(NSTimeInterval)time isBack:(BOOL)isback
{
    isCanBack = isback;
    alreadyPress = NO;
    
    grayView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    grayView.backgroundColor = [UIColor colorWithRed:0 green:0  blue:0  alpha:0.7];
//    grayView.alpha = 0.5;
    [self addSubview:grayView];
    [grayView release];
    
    UIButton *grayViewBtn  =[[UIButton alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    grayViewBtn.backgroundColor = [UIColor clearColor];
    [grayViewBtn addTarget:self action:@selector(pressGrayView) forControlEvents:UIControlEventTouchUpInside];
    [grayView addSubview:grayViewBtn];
    [grayViewBtn release];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, ([[UIScreen mainScreen] bounds].size.height-150)/2, 300, 150)];
    bgView.layer.masksToBounds =YES;
    bgView.layer.cornerRadius = 5.0;
    bgView.layer.borderColor = [[UIColor blackColor] CGColor];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //        self.alpha = 1;
    [UIView commitAnimations];
    [grayView addSubview:bgView];
    [bgView release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 15, 15, 15)];
    [imageView setImage:UIImageGetImageFromName(self.mImageName)];
    [bgView addSubview:imageView];
    [imageView release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, 10, 90, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = self.mTitle;
    [bgView addSubview:titleLabel];
    [titleLabel release];
    
    UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, titleLabel.frame.origin.y+titleLabel.frame.size.height+10, 300, 1)];
    [xian setImage:UIImageGetImageFromName(@"wf_xian2.png")];
    [bgView addSubview:xian];
    [xian release];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, xian.frame.origin.y+xian.frame.size.height+10, 300, 40)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = [UIFont systemFontOfSize:16];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor grayColor];
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.numberOfLines = 0;
    messageLabel.text = self.mMessage;
    [bgView addSubview:messageLabel];
    [messageLabel release];
    
    UILabel *mEndMessagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, messageLabel.frame.origin.y+messageLabel.frame.size.height+15, 300, 17)];
    mEndMessagLabel.backgroundColor = [UIColor clearColor];
    mEndMessagLabel.font = [UIFont systemFontOfSize:16];
    mEndMessagLabel.textColor = [UIColor grayColor];
    mEndMessagLabel.textAlignment = NSTextAlignmentCenter;
    mEndMessagLabel.text = self.mEndMessage;
    [bgView addSubview:mEndMessagLabel];
    [mEndMessagLabel release];
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];

    
    [self performSelector:@selector(removeAlertFromSuperview) withObject:nil afterDelay:time];
    
}
-(void)removeAlertFromSuperview
{
    if(!alreadyPress)
    {
        [UIView beginAnimations:@"nddd" context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 0;
        [UIView commitAnimations];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    }

}
-(void)pressGrayView
{
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeFromSuperview) object:nil];
    alreadyPress = YES;
    
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
    
    if(delegate && [delegate respondsToSelector:@selector(disMissCP_HiddenAlertAndIsAutoBack:)])
    {
        [delegate disMissCP_HiddenAlertAndIsAutoBack:isCanBack];
    }
    
    if([grayView isDescendantOfView:self])
    {
        [grayView removeFromSuperview];

    }
    grayView = nil;
    self.mTitle = nil;
    self.mMessage = nil;
    self.mImageName = nil;
    self.mEndMessage = nil;
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