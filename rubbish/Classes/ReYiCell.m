//
//  ReYiCell.m
//  caibo
//
//  Created by  on 12-5-25.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "ReYiCell.h"
#import "MyWebViewController.h"
#import "caiboAppDelegate.h"
#import "PreJiaoDianTabBarController.h"
#import "ChatView.h"
#import "NSStringExtra.h"
#import "ShuangSeQiuInfoViewController.h"
#import "NetURL.h"
#import "DetailedViewController.h"

@implementation ReYiCell
@synthesize tubiaoimage;
@synthesize namelabel;
@synthesize datelabel;
@synthesize hautiLabel;
@synthesize cstr;
@synthesize xian;
@synthesize returnview;
@synthesize request;

- (NSString *)huatistring{
    return huatistring;
}
- (void)setHuatistring:(NSString *)_huatistring{
    if (huatistring != _huatistring) {
        [huatistring release];
        huatistring = [_huatistring retain];
    }
    
    
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ];
//    if (self) {
//        // Initialization code
//        [self.contentView addSubview:[self returnTabelViewCell]];
//    }
//    return self;
//}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier str:(NSString *)str huati:(NSString *)ht name:(NSString *)names{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        cstr = str;
        huatistring = ht;
        namestr = names;
        [self.contentView addSubview:[self returnTabelViewCell]];
        NSLog(@"str = %@", str);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (UIView *)returnTabelViewCell{
    returnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 294, self.frame.size.height)] ;
    returnview.backgroundColor = [UIColor clearColor];
    namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.backgroundColor = [UIColor clearColor];
    namelabel.font = [UIFont systemFontOfSize:14];
    
    tubiaoimage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 20, 20)];
    tubiaoimage.backgroundColor = [UIColor clearColor];
    
    datelabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 8, 60, 20)];
    datelabel.textAlignment = NSTextAlignmentLeft;
    datelabel.backgroundColor = [UIColor clearColor];
    datelabel.font = [UIFont systemFontOfSize:11];
    datelabel.textColor = [UIColor grayColor];
    
   // [returnview addSubview:namelabel];
   // [returnview addSubview:tubiaoimage];
   // [returnview addSubview:datelabel];
    
    
    
//    ColorLabel * mLabel = [[[ColorLabel alloc] initWithTextReyi:cstr tihuanhuati:huatistring name:namestr] autorelease];
//    mLabel.reyibool = YES;
//    NSLog(@"cstr = %@", cstr);
//    mLabel.colorLabeldelegate = self;
//    [mLabel setMaxWidth:274];
//    [returnview  addSubview:mLabel];
    
    ChatView * chat = [[ChatView alloc] initWithFrame:CGRectMake(10, 0, 274, self.frame.size.height-2)];
    chat.text = [cstr flattenPartHTML:cstr];
    chat.backgroundColor = [UIColor clearColor];
    [returnview addSubview:chat];
    
    NSLog(@"cstr = %@", cstr);
    
    NSArray * comarr = [cstr componentsSeparatedByString:@">#"];
    
    NSString * string = @"";
    if ([comarr count] > 1) {
        string = [NSString stringWithFormat:@"#%@", [comarr objectAtIndex:1]];
    }
    NSArray * comarr2 = [string componentsSeparatedByString:@"</a>"];
    
    NSString * str = @"";
    if ([comarr2 count] >= 2) {
        str = [NSString stringWithFormat:@"%@%@", [comarr2 objectAtIndex:0], [comarr2 objectAtIndex:1]];
    }
    
    
    
    UIFont * font = [UIFont fontWithName:@"Arial" size:14];
    CGSize  size = CGSizeMake(260, 70);
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    hautiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, labelSize.width, labelSize.height)];
    hautiLabel.backgroundColor = [UIColor clearColor];
    hautiLabel.font = font;
    hautiLabel.text = str;
    hautiLabel.numberOfLines = 0;
    
    //hautiLabel.textAlignment = NSTextAlignmentCenter;
    
//    hautiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 280, 70)];
//    hautiLabel.backgroundColor = [UIColor clearColor];
//    hautiLabel.textColor = [UIColor grayColor];
//    hautiLabel.text = str;
   // [returnview addSubview:hautiLabel];
    

    [chat release];

    xian = [[UIImageView alloc] initWithFrame:CGRectMake(chat.frame.origin.x, chat.frame.size.height, chat.frame.size.width, 2)];
    xian.backgroundColor  = [UIColor grayColor];
    [returnview addSubview:xian];
    
    return returnview;
}


- (void)clikeOrderIdURL:(NSURLRequest *)request1 {
    if ([[NSString stringWithFormat:@"%@",[request1 URL]] hasPrefix:@"http://caipiao365.com"]) {
        NSString *topic = [[NSString stringWithFormat:@"%@",[request1 URL]] stringByReplacingOccurrencesOfString:@"http://caipiao365.com/" withString:@""];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSArray *array = [topic componentsSeparatedByString:@"&"];
        for (int i = 0; i < [array count]; i ++) {
            NSString *st = [array objectAtIndex:i];
            NSArray *array2 = [st componentsSeparatedByString:@"="];
            if ([array2 count] >= 2) {
                [dic setValue:[array2 objectAtIndex:1] forKey:[array2 objectAtIndex:0]];
            }
        }
        if ([dic objectForKey:@"wbxq"]) {
            [request clearDelegatesAndCancel];
            [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:[dic objectForKey:@"wbxq"]]]];
            [request setDefaultResponseEncoding:NSUTF8StringEncoding];
            [request setDelegate:self];
            [request setTimeOutSeconds:20.0];
            [request startAsynchronous];
            return;
        }
        else if ([[dic objectForKey:@"faxq"] length]) {
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.orderId = [dic objectForKey:@"faxq"];
            UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
            [NV setNavigationBarHidden:NO];
            [info.navigationController setNavigationBarHidden:NO];
            if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
                PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
                NSLog(@"%@",VC);
                
                [VC.selectedViewController.navigationController pushViewController:info animated:YES];
            }
            else {
                [NV pushViewController:info animated:YES];
            }
            
            [info release];
            return;
        }
        
    }
    MyWebViewController *my = [[MyWebViewController alloc] init];
	[my LoadRequst:request1];
	[my setHidesBottomBarWhenPushed:YES];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:my animated:YES];
        if (VC.selectedIndex == 0) {
            [my.navigationController setNavigationBarHidden:NO];
        }
    }
    else {
        [NV pushViewController:my animated:YES];
    }
	[my release];
}

- (void)requestFinished:(ASIHTTPRequest *)request1 {
    NSString *result = [request1 responseString];
    YtTopic *mStatus2 = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus2 arrayList] objectAtIndex:0]];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:detailed animated:YES];
    }
    else {
        [NV pushViewController:detailed animated:YES];
    }
    [detailed setHidesBottomBarWhenPushed:YES];
    [detailed release];
    
    [mStatus2 release];
}

- (void)dealloc{
    [xian release];
    [hautiLabel release];
    [cstr release];
    [datelabel release];
    [namelabel release];
    [tubiaoimage release];
    [request clearDelegatesAndCancel];
    self.request = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    