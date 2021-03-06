//
//  CommentCell.m
//  caibo
//
//  Created by jeff.pluto on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CommentCell.h"
#import "caiboAppDelegate.h"
#import "KFMessageBoxView.h"
#import "ClassicViewController.h"
#import "KFMessageViewController.h"
@implementation CommentCell
@synthesize isAutoReport;
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        cellView = [[[CommentView alloc] initWithFrame:CGRectZero] autorelease];
        [self.contentView addSubview:cellView];
        
//         xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, cellView.frame.size.height, 300, 2)];
        xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, cellView.frame.size.height, 300, 1)];
#ifdef isCaiPiaoForIPad
        xian.frame = CGRectMake(10, cellView.frame.size.height-5, 370, 2);
#endif
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = [UIImage imageNamed:@"SZTG960.png"] ;
        [self.contentView addSubview:xian];
        [xian release];
        
        
        grayView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 296, 30)];
        grayView.hidden = YES;
        grayView.userInteractionEnabled = YES;
        grayView.backgroundColor = [UIColor clearColor];
        grayView.image = UIImageGetImageFromName(@"autoReport_background.png");
        [self.contentView addSubview:grayView];
        
        
        NSArray *titleArray = [NSArray arrayWithObjects:@"近期问题",@"经典问题",@"在线客服", nil];
        for(int i = 0 ;i<3;i++)
        {
            UIButton *jinqiBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
            [jinqiBtn setFrame:CGRectMake(0.5 + 74*i, 0, 73.5, 29)];
            if(i==3){
                [jinqiBtn setFrame:CGRectMake(0.5 + 74*i, 0, 73, 29)];
                
            }
            [jinqiBtn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [jinqiBtn setBackgroundColor:[UIColor clearColor]];
            
            if(i==0){
                
                [jinqiBtn setBackgroundImage:[UIImageGetImageFromName(@"autoReport_btn_left.png") stretchableImageWithLeftCapWidth:7 topCapHeight:14] forState:UIControlStateHighlighted];
                
            }
            else if(i==3){
                
                [jinqiBtn setBackgroundImage:[UIImageGetImageFromName(@"autoReport_btn_right.png") stretchableImageWithLeftCapWidth:7 topCapHeight:14] forState:UIControlStateHighlighted];
                
            }
            else{
                [jinqiBtn setBackgroundImage:UIImageGetImageFromName(@"autoReport_btn_middle.png") forState:UIControlStateHighlighted];
                
            }
            [jinqiBtn setTitleColor:[UIColor colorWithRed:25/255.0 green:113/255.0 blue:209/255.0 alpha:1] forState:UIControlStateNormal];
            [jinqiBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateHighlighted];
            
            jinqiBtn.tag = 111+i;
            [jinqiBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
            [jinqiBtn addTarget:self action:@selector(pressJinQiQuestion:) forControlEvents:UIControlEventTouchUpInside];
            [grayView addSubview:jinqiBtn];
        }
        

    }
    return self;
}

- (void) setComment:(TopicComment *)comment {
    NSLog(@"louceng cell = %@", comment.louceng);
    cellView.mComment = comment;
    [cellView setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect r = self.bounds;
    r.size.height -= 1;
    cellView.frame = r;
    
    if(isAutoReport)
    {
//        xian.frame = CGRectMake(10, cellView.frame.size.height-5, 300, 2);
        xian.frame = CGRectMake(10, cellView.frame.size.height-4, 320, 1);
        grayView.frame = CGRectMake(12, cellView.frame.size.height - 13-29, 294, 30);
        grayView.hidden = NO;
    }
    else
    {
//        xian.frame = CGRectMake(10, cellView.frame.size.height-5, 300, 2);
        xian.frame = CGRectMake(10, cellView.frame.size.height-4, 320, 1);
        grayView.hidden = YES;
    }
#ifdef isCaiPiaoForIPad
    xian.frame = CGRectMake(10, cellView.frame.size.height-5, 370, 2);
#endif
    
    
}
-(void)pressJinQiQuestion:(UIButton *)sender
{
    if(sender.tag == 111)
    {
        NSLog(@"近期问题");
        UINavigationController * nav = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        ClassicViewController *classic = [[ClassicViewController alloc] init];
        classic.questionType = @"0";
        [nav pushViewController:classic animated:YES];
        [classic release];
    }
    else if(sender.tag == 112)
    {
        NSLog(@"经典问题");
        UINavigationController * nav = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        ClassicViewController *classic = [[ClassicViewController alloc] init];
        classic.questionType = @"1";
        [nav pushViewController:classic animated:YES];
        [classic release];
    }
    else if(sender.tag == 113)
    {
        NSLog(@"在线客服");

        caiboAppDelegate * appDelegate = [caiboAppDelegate getAppDelegate];
        
        KFMessageViewController *kfmBox=[KFMessageViewController alloc];
        
        kfmBox.showBool = YES;
        
        [kfmBox tsInfo];//调用提示信息
        
        [kfmBox returnSiXinCount];
        
        [(UINavigationController *)appDelegate.window.rootViewController pushViewController:kfmBox animated:YES];
        [kfmBox release];
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
            NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
            [dic setValue:@"0" forKey:@"kfsx"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
            caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
            caiboappdelegate.keFuButton.markbool = NO;
            caiboappdelegate.keFuButton.newkfbool = NO;
            
        }
    }
    else
    {
        NSLog(@"客服电话");
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//
//        
//        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//        [actionSheet showInView:window];
////        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
////            actionSheet.frame = CGRectMake(0, window.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
////        }
//        [actionSheet release];
    }
}
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
//    }
}


- (void)dealloc {
    [grayView release];
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    