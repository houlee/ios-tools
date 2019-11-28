//
//  cp_LieBiaoView.m
//  iphone_control
//
//  Created by zhang on 11/29/12.
//  Copyright (c) 2012 yaofuyu. All rights reserved.
//

#import "CP_LieBiaoView.h"
#import "CP_PTButton.h"
#import "CP_XZButton.h"
#import <QuartzCore/QuartzCore.h>
#import "caiboAppDelegate.h"
#import "ImageUtils.h"

@implementation CP_LieBiaoView
@synthesize dataArray;
@synthesize delegate;
@synthesize isSelcetType;
@synthesize weixinBool;
@synthesize danXuanBool;
@synthesize arrayType;
- (void)quxiaobutton{
    if([delegate respondsToSelector:@selector(quxiaobutton)]){
        [delegate quxiaobutton];
    }
}

- (id)initWithFrame:(CGRect)frame danXuan:(BOOL)yesOrNo type:(NSMutableArray *)typeArray{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        isSelcetType= NO;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.danXuanBool = yesOrNo;
        self.arrayType = typeArray;
        
    }
    return self;

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        // Initialization code
        dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        isSelcetType= NO;

    }
    return self;
}

- (void)LoadButtonName:(NSArray *)butArray{
    
    self.dataArray = [NSMutableArray arrayWithArray:butArray];
//    [myTableView reloadData];
}

#pragma mark tableview delegate dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell =
    nil;//[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        if (!isSelcetType) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        else {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CP_XZButton *btn1 = [CP_XZButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(10, 0, 240, 35);
            [btn1 loadButtonName:[dataArray objectAtIndex:indexPath.row]];
            [cell.contentView addSubview:btn1];
            btn1.tag = indexPath.row;
            [btn1 addTarget:self action:@selector(btnClike:) forControlEvents:UIControlEventTouchUpInside];
            
            if ([btn1.buttonName.text hasPrefix:@"分享到微信"]&&weixinBool) {
                btn1.enabled = NO;
                btn1.buttonName.textColor = [UIColor grayColor];
            }else{
                btn1.enabled = YES;
            }
            if ([btn1.buttonName.text isEqualToString:@"分享到腾讯微博"]) {
                btn1.enabled = NO;
                btn1.buttonName.textColor = [UIColor grayColor];
            }
            
            if (danXuanBool) {
                NSString * tpyestr = [self.arrayType objectAtIndex:indexPath.row];
                if ([tpyestr isEqualToString:@"1"]) {
                    btn1.selected = YES;
                }else{
                    btn1.selected = NO;
                }
            }
            
           
        }
        
        
    }
    
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 8, 226, 30);
    btn.tag = indexPath.row;
    [btn setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateHighlighted];
    [btn setTitle:[dataArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:btn];
    [btn addTarget:self action:@selector(btnClike:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark action
- (void)pressCancel{
    
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
    
}



- (void)show {

    backImage = [[UIImageView alloc] init];

    
    backImage.frame = CGRectMake(25, 100, 270, dataArray.count*46+118);

    backImage.image = [UIImageGetImageFromName(@"shuZiAlertBG.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
    
    backImage.backgroundColor = [UIColor clearColor];
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];

    [backImage release];

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 270, 17)];
    titleLabel.text = @"选择操作";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor  colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.backgroundColor = [UIColor clearColor];
    [backImage addSubview:titleLabel];
    [titleLabel release];
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(22, titleLabel.frame.origin.y+titleLabel.frame.size.height+29, 226, dataArray.count * 46)];
    
    myScrollView.backgroundColor = [UIColor clearColor];
    [backImage addSubview:myScrollView];
    
    
    for(int i = 0;i<[dataArray count];i++)
    {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,46*i, 226, 30);
        btn.tag = i;
        [btn setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateHighlighted];
        [btn setTitle:[dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        if([btn.titleLabel.text hasPrefix:@"分享到微信"]&&weixinBool){
            btn.enabled = NO;
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        if ([btn.titleLabel.text isEqualToString:@"分享到腾讯微博"]) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor clearColor];
        [myScrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClike:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
//    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(22, titleLabel.frame.origin.y+titleLabel.frame.size.height+21, 226, dataArray.count * 46)];
//    myTableView.backgroundColor = [UIColor orangeColor];
//    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    if ([dataArray count] < 6) {
//         myTableView.scrollEnabled = NO;
//    }else{
//         myTableView.scrollEnabled = YES;
//    }
//    myTableView.dataSource = self;
//    myTableView.delegate = self;
//    [backImage addSubview:myTableView];
    
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame =CGRectMake(0, myScrollView.frame.origin.y+myScrollView.frame.size.height+13, 270, 44);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor clearColor];
//    [cancelButton setBackgroundImage:UIImageGetImageFromName(@"alert_left_highlight.png") forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pressCancelbutton) forControlEvents:UIControlEventTouchUpInside];
    [backImage addSubview:cancelButton];
    
    
//    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    sureButton.frame =CGRectMake(cancelButton.frame.origin.x+cancelButton.frame.size.width+1, cancelButton.frame.origin.y, 134, 44);
//    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
//    sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
//    sureButton.backgroundColor = [UIColor clearColor];
//    [sureButton setBackgroundImage:UIImageGetImageFromName(@"alert_right_highlight.png") forState:UIControlStateHighlighted];
//    [sureButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
//    [sureButton addTarget:self action:@selector(pressSure) forControlEvents:UIControlEventTouchUpInside];
//    [backImage addSubview:sureButton];


    
#ifdef isCaiPiaoForIPad
    
     backImage.frame = CGRectMake((768-300)/2, (1024-314)/2, 300, 314);
    
    
    if ([dataArray count] <6) {
        
        if ([dataArray count] == 4) {
           
            backImage.frame = CGRectMake((768-300)/2, (1024-300)/2, 300, 300);
            
        }
        if ([dataArray count] == 3) {
           
            backImage.frame = CGRectMake((768-300)/2, (1024-250)/2, 300, 250);
           
        }
        if ([dataArray count] == 2) {
            backImage.frame = CGRectMake((768-300)/2, (1024-210)/2, 300, 210);
            
        }
        if ([dataArray count] == 1) {
    
            backImage.frame = CGRectMake((768-300)/2, (1024-140)/2, 300, 140);
           
        }
    }
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [backImage.layer addAnimation:rotationAnimation forKey:@"run"];
    backImage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
    
     [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
#else
     [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
#endif
    
   
}
- (void)showAgain {
    
    backImage = [[UIImageView alloc] init];
    
    
//    backImage.frame = CGRectMake(25, 100, 270, dataArray.count*46+118);
    backImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-(dataArray.count*46+90), 320, dataArray.count*46+90);
    
//    backImage.image = [UIImageGetImageFromName(@"shuZiAlertBG.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
    
    backImage.backgroundColor = [UIColor whiteColor];
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];
    
    [backImage release];
    
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 270, 17)];
//    titleLabel.text = @"选择操作";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor = [UIColor  colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
//    titleLabel.font = [UIFont systemFontOfSize:17];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    [backImage addSubview:titleLabel];
//    [titleLabel release];
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(22, 29, 276, dataArray.count * 46)];
    
    myScrollView.backgroundColor = [UIColor clearColor];
    [backImage addSubview:myScrollView];
    
    
    for(int i = 0;i<[dataArray count];i++)
    {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,46*i, 276, 30);
        btn.tag = i;
        [btn setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateHighlighted];
        [btn setTitle:[dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        if([btn.titleLabel.text hasPrefix:@"分享到微信"]&&weixinBool){
            btn.enabled = NO;
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor clearColor];
        [myScrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClike:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    //    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(22, titleLabel.frame.origin.y+titleLabel.frame.size.height+21, 226, dataArray.count * 46)];
    //    myTableView.backgroundColor = [UIColor orangeColor];
    //    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //    if ([dataArray count] < 6) {
    //         myTableView.scrollEnabled = NO;
    //    }else{
    //         myTableView.scrollEnabled = YES;
    //    }
    //    myTableView.dataSource = self;
    //    myTableView.delegate = self;
    //    [backImage addSubview:myTableView];
    
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelButton.frame =CGRectMake(20, myScrollView.frame.origin.y+myScrollView.frame.size.height+13, 280, 44);
    cancelButton.frame = CGRectMake(22,backImage.frame.size.height-55, 276, 30);
    [cancelButton setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateHighlighted];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor clearColor];
    //    [cancelButton setBackgroundImage:UIImageGetImageFromName(@"alert_left_highlight.png") forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelButton setTitleColor:[UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(pressCancelbutton) forControlEvents:UIControlEventTouchUpInside];
    [backImage addSubview:cancelButton];
    
    
    //    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    sureButton.frame =CGRectMake(cancelButton.frame.origin.x+cancelButton.frame.size.width+1, cancelButton.frame.origin.y, 134, 44);
    //    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    //    sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //    sureButton.backgroundColor = [UIColor clearColor];
    //    [sureButton setBackgroundImage:UIImageGetImageFromName(@"alert_right_highlight.png") forState:UIControlStateHighlighted];
    //    [sureButton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    //    [sureButton addTarget:self action:@selector(pressSure) forControlEvents:UIControlEventTouchUpInside];
    //    [backImage addSubview:sureButton];
    
    
    
#ifdef isCaiPiaoForIPad
    
    backImage.frame = CGRectMake((768-300)/2, (1024-314)/2, 300, 314);
    
    
    if ([dataArray count] <6) {
        
        if ([dataArray count] == 4) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-300)/2, 300, 300);
            
        }
        if ([dataArray count] == 3) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-250)/2, 300, 250);
            
        }
        if ([dataArray count] == 2) {
            backImage.frame = CGRectMake((768-300)/2, (1024-210)/2, 300, 210);
            
        }
        if ([dataArray count] == 1) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-140)/2, 300, 140);
            
        }
    }
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [backImage.layer addAnimation:rotationAnimation forKey:@"run"];
    backImage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
#else
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
#endif
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.userInteractionEnabled = NO;
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
    
}

- (void)showFenxiangWithoutSina {
    backImage = [[UIImageView alloc] init];
    
    
    //    backImage.frame = CGRectMake(25, 100, 270, dataArray.count*46+118);
    backImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-(209), 320, 209);
    //    backImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 320, 209);
    
    //    backImage.image = [UIImageGetImageFromName(@"shuZiAlertBG.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
    
    backImage.backgroundColor = [UIColor whiteColor];
    backImage.alpha=0.9;
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];
    
    [backImage release];
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 22, 320, 100)];
    
    myScrollView.backgroundColor = [UIColor clearColor];
    [backImage addSubview:myScrollView];
    
    NSArray *ary=[NSArray arrayWithObjects:@"微信朋友圈",@"微信好友", nil];
    if(self.weixinBool)
    {
        ary=[NSArray arrayWithObjects:@"微信(未安装)",@"微信(未安装)", nil];
    }
    for(int i = 0;i<[ary count];i++)
    {
        int j=i;
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(22+108*i, 0, 60, 60);
#ifdef CRAZYSPORTS
        btn.frame = CGRectMake(22+108*i+ 5, 10, 50, 50);
#endif
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"weibofenxiang_%d.png",i]] forState:UIControlStateNormal];
        if(self.weixinBool)
        {
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"weibofenxiang_%d.png",j]] forState:UIControlStateNormal];
        }
        //        [btn setTitle:[dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        UILabel *lab=[[UILabel alloc]init];
        lab.frame = CGRectMake(7+108*i, 69, 90, 20);
        lab.backgroundColor=[UIColor clearColor];
        //        lab.text=[ary objectAtIndex:i];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.textColor=[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        lab.font=[UIFont systemFontOfSize:12];
        [myScrollView addSubview:lab];
        [lab release];
        
        if([btn.titleLabel.text hasPrefix:@"分享到微信"]&&weixinBool){
            btn.enabled = NO;
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        lab.text=[ary objectAtIndex:i];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor clearColor];
        [myScrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClike:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    cancelButton.frame =CGRectMake(20, myScrollView.frame.origin.y+myScrollView.frame.size.height+13, 280, 44);
    cancelButton.frame = CGRectMake(22,146, 320-44, 45);
    //    [cancelButton setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
    //    [cancelButton setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateHighlighted];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor colorWithRed:151/255.0 green:153/255.0 blue:158/255.0 alpha:1];
    //    [cancelButton setBackgroundImage:UIImageGetImageFromName(@"alert_left_highlight.png") forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.layer.masksToBounds=YES;
    cancelButton.layer.cornerRadius=4;
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(pressCancelbutton) forControlEvents:UIControlEventTouchUpInside];
    [backImage addSubview:cancelButton];
    
    
#ifdef isCaiPiaoForIPad
    
    backImage.frame = CGRectMake((768-300)/2, (1024-314)/2, 300, 314);
    
    
    if ([dataArray count] <6) {
        
        if ([dataArray count] == 4) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-300)/2, 300, 300);
            
        }
        if ([dataArray count] == 3) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-250)/2, 300, 250);
            
        }
        if ([dataArray count] == 2) {
            backImage.frame = CGRectMake((768-300)/2, (1024-210)/2, 300, 210);
            
        }
        if ([dataArray count] == 1) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-140)/2, 300, 140);
            
        }
    }
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [backImage.layer addAnimation:rotationAnimation forKey:@"run"];
    backImage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
#else
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    //    [self showUp];
#endif
}

- (void)showFenxiang {
    
    backImage = [[UIImageView alloc] init];
    
    
    //    backImage.frame = CGRectMake(25, 100, 270, dataArray.count*46+118);
    backImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-(209), 320, 209);
//    backImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 320, 209);
    
    //    backImage.image = [UIImageGetImageFromName(@"shuZiAlertBG.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
    
    backImage.backgroundColor = [UIColor whiteColor];
    backImage.alpha=0.9;
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];
    
    [backImage release];
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 22, 320, 100)];
    
    myScrollView.backgroundColor = [UIColor clearColor];
    [backImage addSubview:myScrollView];
    
    NSArray *ary=[NSArray arrayWithObjects:@"微信朋友圈",@"微信好友",@"新浪微博", nil];
    if(self.weixinBool)
    {
        ary=[NSArray arrayWithObjects:@"新浪微博",@"微信(未安装)",@"微信(未安装)", nil];
    }
    for(int i = 0;i<[ary count];i++)
    {
        int j=i;
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if(self.weixinBool)
        {
            j=i - 1;

            if(i==0)
                j=2;
            
        }
        btn.frame = CGRectMake(22+108*i, 0, 60, 60);
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"weibofenxiang_%d.png",i]] forState:UIControlStateNormal];
        if(self.weixinBool)
        {
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"weibofenxiang_%d.png",j]] forState:UIControlStateNormal];
        }
//        [btn setTitle:[dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        UILabel *lab=[[UILabel alloc]init];
        lab.frame = CGRectMake(7+108*i, 69, 90, 20);
        lab.backgroundColor=[UIColor clearColor];
//        lab.text=[ary objectAtIndex:i];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.textColor=[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        lab.font=[UIFont systemFontOfSize:12];
        [myScrollView addSubview:lab];
        [lab release];
        
        if([btn.titleLabel.text hasPrefix:@"分享到微信"]&&weixinBool){
            btn.enabled = NO;
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        lab.text=[ary objectAtIndex:i];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor clearColor];
        [myScrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClike:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    cancelButton.frame =CGRectMake(20, myScrollView.frame.origin.y+myScrollView.frame.size.height+13, 280, 44);
    cancelButton.frame = CGRectMake(22,146, 320-44, 45);
//    [cancelButton setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
//    [cancelButton setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateHighlighted];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor colorWithRed:151/255.0 green:153/255.0 blue:158/255.0 alpha:1];
    //    [cancelButton setBackgroundImage:UIImageGetImageFromName(@"alert_left_highlight.png") forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.layer.masksToBounds=YES;
    cancelButton.layer.cornerRadius=4;
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(pressCancelbutton) forControlEvents:UIControlEventTouchUpInside];
    [backImage addSubview:cancelButton];
    
    
#ifdef isCaiPiaoForIPad
    
    backImage.frame = CGRectMake((768-300)/2, (1024-314)/2, 300, 314);
    
    
    if ([dataArray count] <6) {
        
        if ([dataArray count] == 4) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-300)/2, 300, 300);
            
        }
        if ([dataArray count] == 3) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-250)/2, 300, 250);
            
        }
        if ([dataArray count] == 2) {
            backImage.frame = CGRectMake((768-300)/2, (1024-210)/2, 300, 210);
            
        }
        if ([dataArray count] == 1) {
            
            backImage.frame = CGRectMake((768-300)/2, (1024-140)/2, 300, 140);
            
        }
    }
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [backImage.layer addAnimation:rotationAnimation forKey:@"run"];
    backImage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
#else
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
//    [self showUp];
#endif
    
    
}

- (void)shareDetail{
    backImage = [[UIImageView alloc] init];
    backImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-(209), 320, 209);
    backImage.backgroundColor = [UIColor whiteColor];
    backImage.alpha=0.9;
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];
    [backImage release];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 31, 320, 79)];
    myScrollView.backgroundColor = [UIColor clearColor];
    [backImage addSubview:myScrollView];

    NSArray *ary=nil;
   
#ifdef CRAZYSPORTS
    if(self.weixinBool){
        ary=[NSArray arrayWithObjects:@"朋友圈",@"微信好友", nil];
    }else
        ary=[NSArray arrayWithObjects:@"朋友圈",@"微信好友", nil];
#else
    if(self.weixinBool){
        ary=[NSArray arrayWithObjects:@"彩民微博",@"新浪微博",@"朋友圈",@"微信好友", nil];
    }else
        ary=[NSArray arrayWithObjects:@"彩民微博",@"朋友圈",@"微信好友",@"新浪微博", nil];
#endif
    
    for(int i = 0;i<[ary count];i++)
    {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(31+69.5*i, 0, 49.5, 49.5);
        btn.tag = i;
        NSString *imgName=@"";
#ifdef CRAZYSPORTS
        if (i==0) {
            imgName=@"fenxiang_1";
        }else if(i==1){
            imgName=@"fenxiang_2";
        }
#else
        imgName=[NSString stringWithFormat:@"fenxiang_%d.png",i];
#endif
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        if(self.weixinBool){
            NSString *fenxiangStr=@"";
#ifdef CRAZYSPORTS
            if (i==0){
                fenxiangStr=@"WeChatFriendNoInstall";
            }else if (i==1){
                fenxiangStr=@"WeChatNoInstall";
            }
#else
            if (i==0) {
                fenxiangStr=@"fenxiang_0.png";
            }else if (i==1) {
                fenxiangStr=@"fenxiang_3.png";
            }else if (i==2){
                fenxiangStr=@"WeChatFriendNoInstall";
            }else if (i==3){
                fenxiangStr=@"WeChatNoInstall";
            }
#endif
            [btn setImage:[UIImage imageNamed:fenxiangStr] forState:UIControlStateNormal];
        }
        
        UILabel *lab=[[UILabel alloc]init];
        lab.frame = CGRectMake(31+69.5*i, 57, 54.5, 12);
        lab.backgroundColor=[UIColor clearColor];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.textColor=BLACK_EIGHTYSEVER;
        lab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        lab.font=[UIFont systemFontOfSize:12];
        [myScrollView addSubview:lab];
        [lab release];
        
        if(weixinBool){
            if (i==2||i==3) {
                btn.enabled = NO;
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
        
        lab.text=[ary objectAtIndex:i];
        if(self.weixinBool){
            if (i==2||i==3) {
                lab.textColor=[UIColor colorWithHexString:@"#cccccc"];
            }
        }
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor clearColor];
        [myScrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClike:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelButton.frame =CGRectMake(20, myScrollView.frame.origin.y+myScrollView.frame.size.height+13, 280, 44);
    cancelButton.frame = CGRectMake(22,146, 320-44, 45);
//    [cancelButton setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
//    [cancelButton setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateHighlighted];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor colorWithRed:151/255.0 green:153/255.0 blue:158/255.0 alpha:1];
//    [cancelButton setBackgroundImage:UIImageGetImageFromName(@"alert_left_highlight.png") forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.layer.masksToBounds=YES;
    cancelButton.layer.cornerRadius=4;
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(pressCancelbutton) forControlEvents:UIControlEventTouchUpInside];
    [backImage addSubview:cancelButton];
    
#ifdef isCaiPiaoForIPad
    backImage.frame = CGRectMake((768-300)/2, (1024-314)/2, 300, 314);
    if ([dataArray count] <6) {
        if ([dataArray count] == 4) {
            backImage.frame = CGRectMake((768-300)/2, (1024-300)/2, 300, 300);
        }
        if ([dataArray count] == 3) {
            backImage.frame = CGRectMake((768-300)/2, (1024-250)/2, 300, 250);
        }
        if ([dataArray count] == 2) {
            backImage.frame = CGRectMake((768-300)/2, (1024-210)/2, 300, 210);
        }
        if ([dataArray count] == 1) {
            backImage.frame = CGRectMake((768-300)/2, (1024-140)/2, 300, 140);
        }
    }
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [backImage.layer addAnimation:rotationAnimation forKey:@"run"];
    backImage.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
#else
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
//    [self showUp];
#endif
}

- (void)pressCancelbutton{
     [self pressCancel];
    [self quxiaobutton];
}

-(void)showUp
{
    [UIView animateWithDuration:0.5 animations:^{
        backImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-(209), 320, 209);
    }];
}


- (void)btnClike:(UIButton *)sender {
    
    selectedTag = sender.tag;

    
    if (danXuanBool) {
        for (int i = 0; i < [self.arrayType count]; i++) {
            
            [self.arrayType replaceObjectAtIndex:i withObject:@"0"];
            
        }
        
        [self.arrayType replaceObjectAtIndex:selectedTag withObject:@"1"];
    }
    
    
    if (danXuanBool) {
        if (delegate && [delegate respondsToSelector:@selector(CP_liebiao:didDismissWithButtonIndex:type:)]) {
            [delegate CP_liebiao:self didDismissWithButtonIndex:selectedTag type:self.arrayType];
        }
    }else{
        if (delegate && [delegate respondsToSelector:@selector(CP_liebiao:didDismissWithButtonIndex:)]) {
            [delegate CP_liebiao:self didDismissWithButtonIndex:selectedTag];
        }
    }
    
//    [self pressCancel];
    [self pressCancelbutton];
}

-(void)pressSure
{

}

- (void)dealloc{
    [arrayType release];
//    [myTableView release];
    [dataArray release];
    [myScrollView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    