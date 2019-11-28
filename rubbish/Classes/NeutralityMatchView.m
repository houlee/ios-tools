//
//  NeutralityMatchView.m
//  caibo
//
//  Created by houchenguang on 14-6-6.
//
//

#import "NeutralityMatchView.h"
#import "caiboAppDelegate.h"

@implementation NeutralityMatchView
@synthesize delegate;
@synthesize betData;
- (void)dealloc{
    
    [betData release];
    [super dealloc];
}

- (id)initWithBetData:(GC_BetData *)_betData number:(NSString *)number
{
    self = [super init];
    if (self) {
        self.betData = _betData;
        // Initialization code
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        self.frame = app.window.bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 344)];//441
        bgImageView.backgroundColor = [UIColor clearColor];
        bgImageView.image = [UIImageGetImageFromName(@"jifenbangbg.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        bgImageView.userInteractionEnabled = YES;
        [self addSubview:bgImageView];
        [bgImageView release];
        
        bgImageView.center = app.window.center;
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 43)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textColor = [UIColor colorWithRed:153/255.0 green:152/255.0 blue:152/255.0 alpha:1];
        titleLabel.text = @"提醒";
        [bgImageView addSubview:titleLabel];
        [titleLabel release];
        
        UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 300, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
        [bgImageView addSubview:lineView];
        [lineView release];
        
        UIView * bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, 300, 229)] ;
        bgview.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [bgImageView addSubview:bgview];
        [bgview release];
        
         NSArray * teamarray = [self.betData.team componentsSeparatedByString:@","];
        
        UILabel * homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 34 - 6, 107, 20)];
        homeLabel.backgroundColor = [UIColor clearColor];
        homeLabel.textAlignment = NSTextAlignmentCenter;
        homeLabel.font = [UIFont systemFontOfSize:15];
        homeLabel.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        if ([teamarray count]>= 2) {
             homeLabel.text = [teamarray objectAtIndex:1];
        }else{
            homeLabel.text = @"";
        }
       
        [bgview addSubview:homeLabel];
        [homeLabel release];
        
        UIImageView * hengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 56 - 6, 107, 6)];
        hengImageView.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        [bgview addSubview:hengImageView];
        [hengImageView release];
        
        UILabel * matchLabel = [[UILabel alloc] initWithFrame:CGRectMake(107, 29 - 6, 86, 20)];
        matchLabel.backgroundColor = [UIColor clearColor];
        matchLabel.textAlignment = NSTextAlignmentCenter;
        matchLabel.font = [UIFont systemFontOfSize:15];
        matchLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
        matchLabel.text = self.betData.event;
        [bgview addSubview:matchLabel];
        [matchLabel release];
        
        
        
        UILabel * guestLabel = [[UILabel alloc] initWithFrame:CGRectMake(193, 34 - 6, 107, 20)];
        guestLabel.backgroundColor = [UIColor clearColor];
        guestLabel.textAlignment = NSTextAlignmentCenter;
        guestLabel.font = [UIFont systemFontOfSize:15];
        guestLabel.textColor = [UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        if ([teamarray count]>= 2) {
            guestLabel.text = [teamarray objectAtIndex:0];
        }else{
            guestLabel.text = @"";
        }
        [bgview addSubview:guestLabel];
        [guestLabel release];
        
        
        UIImageView * twoHengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(193, 56 - 6, 107, 6)];
        twoHengImageView.backgroundColor = [UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        [bgview addSubview:twoHengImageView];
        [twoHengImageView release];
        
        if ([self.betData.zlcString rangeOfString:@"True"].location != NSNotFound) {
            UILabel * zlcLabel = [[UILabel alloc] initWithFrame:CGRectMake(107, 62 - 6, 86, 20)];
            zlcLabel.backgroundColor = [UIColor clearColor];
            zlcLabel.textAlignment = NSTextAlignmentCenter;
            zlcLabel.font = [UIFont systemFontOfSize:15];
            zlcLabel.textColor = [UIColor colorWithRed:232/255.0 green:37/255.0 blue:14/255.0 alpha:1];
            zlcLabel.text = @"中立场";
            [bgview addSubview:zlcLabel];
            [zlcLabel release];
        }
       
        
        UIImageView * zhongliImage = [[UIImageView alloc] initWithFrame:CGRectMake((300 - 146)/2, 77 - 6, 146, 84)];
        zhongliImage.backgroundColor = [UIColor clearColor];
        zhongliImage.image = UIImageGetImageFromName(@"zlctkimage.png");
        [bgview addSubview:zhongliImage];
        [zhongliImage release];
        
        
        
        UILabel * juLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 167 - 6, 300, 14)];
        juLabel.backgroundColor = [UIColor clearColor];
        juLabel.textAlignment = NSTextAlignmentCenter;
        juLabel.text = @"请注意主客场与投注的不同";
        juLabel.textColor = [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1];
        juLabel.font = [UIFont systemFontOfSize:12];
        [bgview addSubview:juLabel];
        [juLabel release];
        
        
        UIView * matchView = [[UIView alloc] initWithFrame:CGRectMake(0, 229-43 - 6, 300, 43)];
        matchView.backgroundColor = [UIColor whiteColor];
        [bgview addSubview:matchView];
        [matchView release];
        
        UIImageView * matchHengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 0.5)];
        matchHengImageView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
        [matchView addSubview:matchHengImageView];
        [matchHengImageView release];
        
        UIImageView * matchshuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(64, 0, 0.5, 42)];
        matchshuImageView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
        [matchView addSubview:matchshuImageView];
        [matchshuImageView release];
        
        UIImageView * twoMatchHengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42.5, 300, 0.5)];
        twoMatchHengImageView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
        [matchView addSubview:twoMatchHengImageView];
        [twoMatchHengImageView release];

        
        UILabel * numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5.5, 64, 20)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:10];
        numLabel.textColor = [UIColor colorWithRed:144/255.0 green:143/255.0 blue:143/255.0 alpha:1];
        numLabel.text = [NSString stringWithFormat:@"%@ %@", number, self.betData.event];
        [matchView addSubview:numLabel];
        [numLabel release];
        
        UILabel * endLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 19.5, 64, 20)];
        endLabel.backgroundColor = [UIColor clearColor];
        endLabel.textAlignment = NSTextAlignmentCenter;
        endLabel.font = [UIFont systemFontOfSize:8];
        endLabel.textColor = [UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1];
        endLabel.text = [NSString stringWithFormat:@"%@截止", self.betData.time ];
        [matchView addSubview:endLabel];
        [endLabel release];
        
        
        UILabel * oneTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(64.5, 0, 108, 43)];
        oneTeamLabel.backgroundColor = [UIColor clearColor];
        oneTeamLabel.textAlignment = NSTextAlignmentCenter;
        oneTeamLabel.font = [UIFont systemFontOfSize:15];
        oneTeamLabel.textColor = [UIColor blackColor];
        if ([teamarray count]>= 2) {
            oneTeamLabel.text = [teamarray objectAtIndex:0];
        }else{
            oneTeamLabel.text = @"";
        }
        [matchView addSubview:oneTeamLabel];
        [oneTeamLabel release];
        
        UILabel * twoTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(300 - 108, 0, 108, 43)];
        twoTeamLabel.backgroundColor = [UIColor clearColor];
        twoTeamLabel.textAlignment = NSTextAlignmentCenter;
        twoTeamLabel.font = [UIFont systemFontOfSize:15];
        twoTeamLabel.textColor = [UIColor blackColor];
        if ([teamarray count]>= 2) {
            twoTeamLabel.text = [teamarray objectAtIndex:1];
        }else{
            twoTeamLabel.text = @"";
        }
        [matchView addSubview:twoTeamLabel];
        [twoTeamLabel release];

        
        
        UIImageView * vsImage = [[UIImageView alloc] initWithFrame:CGRectMake((300 - 64.5 - 18)/2.0+ 64.5, (43 - 15)/2.0, 18, 15)];
        vsImage.backgroundColor = [UIColor clearColor];
        vsImage.image = UIImageGetImageFromName(@"vsimage.png");
        [matchView addSubview:vsImage];
        [vsImage release];
        
        
        UIImageView * twoLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 272.5, 300, 0.5)];
        twoLineView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
        [bgImageView addSubview:twoLineView];
        [twoLineView release];

        
        UIButton * sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame = CGRectMake((300 - 246)/2, 288, 246, 38);
        [sendButton setBackgroundImage:UIImageGetImageFromName(@"jfbsendbutton.png") forState:UIControlStateNormal];
        [sendButton setBackgroundImage:UIImageGetImageFromName(@"jfbsendbutton_1.png") forState:UIControlStateHighlighted];
        [sendButton setTitle:@"确定" forState:UIControlStateNormal];
        [sendButton setTintColor:[UIColor whiteColor]];
        [sendButton addTarget:self action:@selector(pressSendButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:sendButton];
    }
    return self;
}

- (void)show{
    
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    [app.window addSubview:self];
}

- (void)pressSendButton:(UIButton *)sender{
    
    if (delegate && [delegate respondsToSelector:@selector(neutralityMatchViewDelegate:withBetData:)]) {
        [delegate neutralityMatchViewDelegate:self withBetData:self.betData];
    }
    
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
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