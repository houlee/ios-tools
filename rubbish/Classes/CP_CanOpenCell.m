//
//  CP_CanOpenCell.m
//  iphone_control
//
//  Created by yaofuyu on 12-12-4.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import "CP_CanOpenCell.h"

@implementation CP_CanOpenCell
@synthesize cp_canopencelldelegate;
@synthesize isShow;
@synthesize butonScrollView;
@synthesize nameLable;
@synthesize backImageView;
@synthesize otherImageView;
@synthesize btnTitleColor;
@synthesize btnFontSize;

@synthesize xzhi,ypianyi;

@synthesize normalHight;
@synthesize selectHight;
@synthesize xialabianImge;
@synthesize shouQiButton;
@synthesize cellType, allTitleArray;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        cellType = type;
        ypianyi = 0;
        btnFontSize = 13;
        self.btnTitleColor = [UIColor blackColor];
        normalHight = 56;
        selectHight = 110;
        
        butonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5.5, 0, 309, normalHight)];
    
        butonScrollView.bounces = NO;
        [self.contentView addSubview:butonScrollView];
        
        
        
        
        
        
        otherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, normalHight)];
        otherImageView.hidden = YES;
        [butonScrollView addSubview:otherImageView];
        [otherImageView release];
        
        
        
        
        backImageView= [[UIImageView alloc] initWithFrame:CGRectMake(300, 0, 300, normalHight)];
//        backImageView.backgroundColor = [UIColor orangeColor];
        backImageView.hidden = YES;
        [butonScrollView addSubview:backImageView];
        [backImageView release];
        
        
        xialabianImge = [[UIImageView alloc] initWithFrame:CGRectMake(9, 48, 300, 5)];
        [self.contentView addSubview:xialabianImge];
        xialabianImge.hidden = YES;
        xialabianImge.backgroundColor = [UIColor clearColor];
        [xialabianImge release];
//
        nameLable = [[UILabel alloc] init];
        nameLable.hidden = YES;
        nameLable.frame = CGRectMake(40, 15, 100, 25);
        nameLable.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:nameLable];
        [nameLable release];
        
        
        
    }
    return self;

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        ypianyi = 0;
        btnFontSize = 13;
        self.btnTitleColor = [UIColor blackColor];
        normalHight = 56;
        selectHight = 110;
        otherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, normalHight)];
        otherImageView.hidden = YES;
        [self.contentView addSubview:otherImageView];
        [otherImageView release];
        
        butonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, normalHight)];
        [self.contentView addSubview:butonScrollView];
        butonScrollView.hidden = YES;
        NSLog(@"11111%f",self.frame.size.width);
        
        
        
        backImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, normalHight)];
        [self.contentView addSubview:backImageView];
        [backImageView release];
        
        
        xialabianImge = [[UIImageView alloc] initWithFrame:CGRectMake(9, 48, 300, 5)];
        [self.contentView addSubview:xialabianImge];
        xialabianImge.backgroundColor = [UIColor clearColor];
        [xialabianImge release];
        
        nameLable = [[UILabel alloc] init];
        nameLable.frame = CGRectMake(40, 15, 100, 25);
        nameLable.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:nameLable];
        [nameLable release];
        
        
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [allTitleArray release];
    [butonScrollView release];
    self.btnTitleColor = nil;
    [super dealloc];
}

#pragma mark - Action

- (void)hidenScoll {
    butonScrollView.hidden = YES;
    otherImageView.hidden = YES;
}

- (void)hidenButonScollWithAnime:(BOOL)anime {
    if (anime) {
        butonScrollView.hidden = NO;

//        butonScrollView.frame = CGRectMake(xzhi, normalHight - 1, 300, selectHight - normalHight);
//        otherImageView.frame = butonScrollView.frame;
        otherImageView.hidden = NO;
//        xialabianImge.frame = CGRectMake(xzhi, selectHight-2, 300, 5);
        
        butonScrollView.frame = CGRectMake(xzhi, normalHight - 1, 300, selectHight - normalHight);
        otherImageView.frame = butonScrollView.frame;
        xialabianImge.frame = CGRectMake(xzhi, selectHight-2 + ypianyi, 300, xialabianImge.frame.size.height);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.25];

        butonScrollView.frame = CGRectMake(xzhi, 0, 300, normalHight);
        otherImageView.frame = butonScrollView.frame;
        xialabianImge.frame = CGRectMake(xzhi, normalHight-2 +ypianyi, 300, xialabianImge.frame.size.height);
        
        [UIView commitAnimations];
        [self performSelector:@selector(hidenScoll) withObject:nil afterDelay:0.23];
    }
    else {

        butonScrollView.frame = CGRectMake(xzhi, 0, 300, normalHight);
        xialabianImge.frame = CGRectMake(xzhi, normalHight-2+ypianyi, 300, xialabianImge.frame.size.height);
       
        butonScrollView.hidden = YES;
        otherImageView.frame = butonScrollView.frame;
        otherImageView.hidden = YES;
    }
}

- (void)showButonScollWithFrame:(CGRect)frame WithAnime:(BOOL)anime {
    if (anime) {

        butonScrollView.hidden = NO;
        otherImageView.hidden = NO;

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.25];
        butonScrollView.frame = frame;
        otherImageView.frame = butonScrollView.frame;
        xialabianImge.frame = CGRectMake(xzhi, selectHight-4+ypianyi, 300, xialabianImge.frame.size.height);
        [UIView commitAnimations];
    }
    else {
        butonScrollView.frame = frame;
        otherImageView.frame = butonScrollView.frame;
        xialabianImge.frame = CGRectMake(xzhi, selectHight-4+ypianyi, 300, xialabianImge.frame.size.height);
        xialabianImge.hidden = NO;
        butonScrollView.hidden = NO;
        otherImageView.hidden = NO;
    }
}

- (BOOL)getIsShow {
    isShow = butonScrollView.hidden;
    return isShow;
}

- (void)showButonScollWithAnime:(BOOL)anime {

    [self showButonScollWithFrame:CGRectMake(xzhi, normalHight - 1, 309, selectHight - normalHight) WithAnime:anime];

}

- (void)btnClicle:(UIButton *)sender {
    if (cp_canopencelldelegate && [cp_canopencelldelegate respondsToSelector:@selector(CP_CanOpenSelect:WithSelectButonIndex:)]) {
        [cp_canopencelldelegate CP_CanOpenSelect:self WithSelectButonIndex:sender.tag];
    }
}

- (void)setButonImageArray:(NSArray *)imageArray TitileArray:(NSArray *)titleArray {
    for (UIView *v in butonScrollView.subviews) {
        if (v.tag != 1101 && v.tag != 1102) {
            [v removeFromSuperview];
        }
        
    }
    self.allTitleArray = [NSArray arrayWithArray:titleArray];
    if ([cellType isEqualToString:@"1"] || [cellType isEqualToString:@"3"] || [cellType isEqualToString:@"4"]||[cellType isEqualToString:@"6"]||[cellType isEqualToString:@"7"]) {
       
        
        for (int i = 0; i < [titleArray count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            if ([cellType isEqualToString:@"3"]) {
                btn.frame = CGRectMake(309+i*70, 20, 70, 97);
            }else if ([cellType isEqualToString:@"4"]){
            
                btn.frame = CGRectMake(309+i*70, 20, 70, 64);
            
            }else if([cellType isEqualToString:@"6"]){
//                btn.frame = CGRectMake(300+i*70, 20, 70, 60);
                if ([titleArray count] > 0) {
//                    if ([[titleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//                        if (i == 0) {
//                            btn.frame = CGRectMake(309, 20, 35, 51);
//                        }else{
//                            btn.frame = CGRectMake(309+35+ (i-1)*70, 20, 70, 51);
//                        }
//                    }else {
                        btn.frame = CGRectMake(309+i * 70, 20, 70, 51);
                        
//                    }
                }else{
                    btn.frame = CGRectMake(309+i * 70, 20, 0, 0);
                }
                
            }else if([cellType isEqualToString:@"7"]){
            
                btn.frame = CGRectMake(309+i * 70, 20, 70, 51);
            }else{
//                if ([[titleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//                    if (i == 0) {
//                        btn.frame = CGRectMake(309, 20, 35, 51);
//                    }else{
//                        btn.frame = CGRectMake(309+35+ (i-1)*70, 20, 70, 51);
//                    }
//                }else {
                    btn.frame = CGRectMake(309+i * 70, 20, 70, 51);
                NSLog(@"btn.frame = %f", btn.frame.origin.x);
//                }
            }
            
            
            UILabel *lable = [[UILabel alloc] initWithFrame:btn.bounds];
            lable.font = [UIFont systemFontOfSize:btnFontSize];
            lable.textColor = [UIColor whiteColor];
            if (i == 0) {
                lable.backgroundColor = [UIColor colorWithRed:117/255.0 green:121/255.0 blue:130/255.0 alpha:1];
            }else if (i == 1){
                lable.backgroundColor = [UIColor colorWithRed:75/255.0 green:80/255.0 blue:91/255.0 alpha:1];
            }else if (i == 2){
                lable.backgroundColor = [UIColor colorWithRed:43/255.0 green:51/255.0 blue:63/255.0 alpha:1];
            }
            
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = [titleArray objectAtIndex:i];
            [btn addSubview:lable];
            [lable release];
            
            UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(19, 11, 22, 22)];
            [btn addSubview:btnImage];
            btnImage.tag = 10;
            btnImage.hidden = YES;
//            btnImage.image = UIImageGetImageFromName([imageArray objectAtIndex:i]);
            [btnImage release];
            [btn addTarget:self action:@selector(btnClicle:) forControlEvents:UIControlEventTouchUpInside];
            
            
//            btn.backgroundColor = [UIColor redColor];
//            butonScrollView.backgroundColor = [UIColor greenColor];
            [butonScrollView addSubview:btn];

            
            
            
        }
        
        
        
    }else{
        for (int i = 0; i < [imageArray count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            btn.frame = CGRectMake(i * 60, 0, 60, selectHight - normalHight);
            
            
            btn.tag = i;
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 60, 20)];
            lable.font = [UIFont systemFontOfSize:btnFontSize];
            lable.textColor = btnTitleColor;
            lable.backgroundColor = [UIColor clearColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = [titleArray objectAtIndex:i];
            [btn addSubview:lable];
            [lable release];
            
            UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(19, 11, 22, 22)];
            [btn addSubview:btnImage];
            btnImage.tag = 10;
            btnImage.image = UIImageGetImageFromName([imageArray objectAtIndex:i]);
            [btnImage release];
            [btn addTarget:self action:@selector(btnClicle:) forControlEvents:UIControlEventTouchUpInside];
            [butonScrollView addSubview:btn];
        }
    }
    
    if ([cellType isEqualToString:@"1"]) {
//        if ([[titleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//            butonScrollView.contentSize = CGSizeMake(309+35+ ([titleArray count]-1)*70, 61);
//        }else{
            butonScrollView.contentSize = CGSizeMake(309+ [titleArray count]*70, 61);
//        }
       NSLog(@"asdfasdfasfdsa  = %f", butonScrollView.contentSize.width);
    }else if ([cellType isEqualToString:@"3"]) {
        
            butonScrollView.contentSize = CGSizeMake(309+ [titleArray count]*70, 117);
    }else if ([cellType isEqualToString:@"4"]){
        butonScrollView.contentSize = CGSizeMake(309+ [titleArray count]*70, 64);

    
    }else if([cellType isEqualToString:@"7"]){
    
        butonScrollView.contentSize = CGSizeMake(309+ [titleArray count]*70, 61);
    
    }else if ([cellType isEqualToString:@"6"]) {
        if ([titleArray count] > 0) {
//            if ([[titleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//                butonScrollView.contentSize = CGSizeMake(309+35+ ([titleArray count]-1)*70, 61);
//            }else{
                butonScrollView.contentSize = CGSizeMake(309+ [titleArray count]*70, 61);
//            }
        }else{
            butonScrollView.contentSize = CGSizeMake(309, 61);
        }
        
    }else{
        butonScrollView.contentSize = CGSizeMake(60 *[imageArray count], 55);
    }
    
    
}

- (void)setButonImageArray:(NSArray *)imageArray TitileArray:(NSArray *)titleArray newType:(NSInteger)type{
    for (UIView *v in butonScrollView.subviews) {
        if (v.tag != 1101 && v.tag != 1102) {
            [v removeFromSuperview];
        }
        
    }
    self.allTitleArray = [NSArray arrayWithArray:titleArray];
    if ([cellType isEqualToString:@"1"]) {
        
        
        for (int i = 0; i < [titleArray count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
//            if ([[titleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//                if (i == 0) {
//                    btn.frame = CGRectMake(309, 20, 35, 64.5);
//                }else{
//                    btn.frame = CGRectMake(309+35+ (i-1)*70, 20, 70, 64.5);
//                }
//            }else{
                btn.frame = CGRectMake(309+i * 70, 20, 70, 64.5);
                
//            }
            
           
            
            UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(19, 11, 22, 22)];
            [btn addSubview:btnImage];
            btnImage.tag = 10;
//            btnImage.hidden = YES;
//            btnImage.image = UIImageGetImageFromName([imageArray objectAtIndex:i]);
            [btnImage release];
            [btn addTarget:self action:@selector(btnClicle:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            UILabel *lable = [[UILabel alloc] initWithFrame:btn.bounds];
            lable.font = [UIFont systemFontOfSize:btnFontSize];
            lable.textColor = [UIColor whiteColor];
            if (i == 0) {
                lable.backgroundColor = [UIColor colorWithRed:117/255.0 green:121/255.0 blue:130/255.0 alpha:1];
            }else if (i == 1){
                lable.backgroundColor = [UIColor colorWithRed:75/255.0 green:80/255.0 blue:91/255.0 alpha:1];
            }else if (i == 2){
                lable.backgroundColor = [UIColor colorWithRed:43/255.0 green:51/255.0 blue:63/255.0 alpha:1];
            }
            
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = [titleArray objectAtIndex:i];
            [btn addSubview:lable];
            [lable release];
            [butonScrollView addSubview:btn];
            
            
            
            
        }
        
    }else{
        for (int i = 0; i < [imageArray count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if ([cellType isEqualToString:@"1"] ) {
                btn.frame = CGRectMake(309+i * 60, 5, 60, selectHight - normalHight);
            }else{
                btn.frame = CGRectMake(i * 60, 0, 60, selectHight - normalHight);
            }
            
            btn.tag = i;
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 60, 20)];
            lable.font = [UIFont systemFontOfSize:btnFontSize];
            lable.textColor = btnTitleColor;
            lable.backgroundColor = [UIColor clearColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = [titleArray objectAtIndex:i];
            [btn addSubview:lable];
            [lable release];
            
            UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(19, 11, 22, 22)];
            [btn addSubview:btnImage];
            btnImage.tag = 10;
            btnImage.image = UIImageGetImageFromName([imageArray objectAtIndex:i]);
            [btnImage release];
            [btn addTarget:self action:@selector(btnClicle:) forControlEvents:UIControlEventTouchUpInside];
            [butonScrollView addSubview:btn];
        }
    
    }
   
    if (type == 1 || type == 2) {
        shouQiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (type == 1) {
            shouQiButton.frame = CGRectMake(0, 0, 50, 56);
        }else if(type == 2){
            shouQiButton.frame = CGRectMake(250, 0, 50, 56);
        }
        
        [shouQiButton addTarget:self action:@selector(btnClicle:) forControlEvents:UIControlEventTouchUpInside];
        [butonScrollView addSubview:shouQiButton];
        shouQiButton.tag = 101;
        
        UIImageView * shouqiImage =[[UIImageView alloc] initWithFrame:CGRectMake((50-22)/2, 10, 22, 22)];
        shouqiImage.backgroundColor = [UIColor clearColor];
        shouqiImage.image = UIImageGetImageFromName(@"shouqibuttonimage.png");
        [shouQiButton addSubview:shouqiImage];
        [shouqiImage release];
    }
    
    if ([cellType isEqualToString:@"1"]) {
//        if ([[titleArray objectAtIndex:0] isEqualToString:@"胆"]) {
//            butonScrollView.contentSize = CGSizeMake(309+35+ ([titleArray count]-1)*70, 85);
//           
//        }else{
            butonScrollView.contentSize = CGSizeMake(309+ [titleArray count]*70, 85);
//        }
 NSLog(@"asdfasdfasfdsa  = %f", butonScrollView.contentSize.width);
    }else{
        butonScrollView.contentSize = CGSizeMake(60 *[imageArray count], 55);
    }
    
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    