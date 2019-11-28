//
//  MyActionsheet.m
//  MyActionSheet
//
//  Created by cp365dev on 14-5-21.
//  Copyright (c) 2014年 cp365dev. All rights reserved.
//

#import "CP_Actionsheet.h"
#import "CP_PTButton.h"
@implementation CP_Actionsheet
@synthesize delegate, showType;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithType:(ActionsheetType)type Title:(NSString *)title delegate:(id)delegates cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if(self)
    {
        self.delegate = delegates;
        
        grayView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        grayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self addSubview:grayView];
        [grayView release];
        
        UIButton *grayViewBtn  =[[UIButton alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        grayViewBtn.backgroundColor = [UIColor clearColor];
        [grayViewBtn addTarget:self action:@selector(pressGrayView) forControlEvents:UIControlEventTouchUpInside];
        [grayView addSubview:grayViewBtn];
        [grayViewBtn release];
        
        
       
        
    
        
//        [UIView beginAnimations:@"nddd" context:NULL];
//        [UIView setAnimationDuration:.5];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    
//        [UIView commitAnimations];
        
       
        
        if (type == writeMicroblogActionsheetType){
        
            int allHight = 22;
            
            if (title && ![title isEqualToString:@""]){
            
                allHight = 55;
            
            }
            
            
            UIView *sheetView = [[UIView alloc] init];
            sheetView.backgroundColor = [UIColor whiteColor];
            [grayView addSubview:sheetView];
            [sheetView release];
            
            
            if (otherButtonTitles){
                id eachObject;
                int tag = 1;
                va_list argList;
                va_start(argList,otherButtonTitles);
                eachObject=va_arg(argList,id);
                
                CP_PTButton *ptbutton =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                ptbutton.frame = CGRectMake((320 - 278)/2, allHight, 278, 46);
                ptbutton.backgroundColor = [UIColor clearColor];
                ptbutton.tag = tag;
                [ptbutton loadButonImage:nil LabelName:otherButtonTitles];
                ptbutton.buttonName.textColor = [UIColor blackColor];
                [ptbutton setBackgroundImage:[UIImageGetImageFromName(@"saveimagezc.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateNormal];
                [ptbutton setBackgroundImage:[UIImageGetImageFromName(@"saveimagexz.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateHighlighted];
                [ptbutton addTarget:self action:@selector(pressPtbutton:) forControlEvents:UIControlEventTouchUpInside];
                [sheetView addSubview:ptbutton];
                allHight += 46+9;
                while (eachObject) {
                    tag +=1;
                    CP_PTButton *ptbutton2 =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                    ptbutton2.frame = CGRectMake((320 - 278)/2, allHight, 278, 46);
                    ptbutton2.backgroundColor = [UIColor clearColor];
                    [ptbutton2 loadButonImage:nil LabelName:eachObject];
                    ptbutton2.tag = tag;
                    ptbutton2.buttonName.textColor = [UIColor blackColor];
                    [ptbutton2 addTarget:self action:@selector(pressPtbutton:) forControlEvents:UIControlEventTouchUpInside];
                    [ptbutton2 setBackgroundImage:[UIImageGetImageFromName(@"saveimagezc.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateNormal];
                    [ptbutton2 setBackgroundImage:[UIImageGetImageFromName(@"saveimagexz.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateHighlighted];
                    [sheetView addSubview:ptbutton2];
                    eachObject=va_arg(argList,id);
                    [ptbutton2 release];
                    allHight += 46+9;
                }
            }
           
            if(cancelButtonTitle){
            
                allHight += 15;
                
                CP_PTButton *ptbutton3 =[[CP_PTButton alloc] initWithFrame:CGRectZero];
                ptbutton3.frame = CGRectMake((320 - 278)/2, allHight, 278, 46);
                ptbutton3.backgroundColor = [UIColor clearColor];
                [ptbutton3 loadButonImage:nil LabelName:cancelButtonTitle];
                ptbutton3.buttonName.textColor = [UIColor whiteColor];
                [ptbutton3 addTarget:self action:@selector(pressPtbutton:) forControlEvents:UIControlEventTouchUpInside];
                [ptbutton3 setBackgroundImage:[UIImageGetImageFromName(@"saveimagezc_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateNormal];
                ptbutton3.tag = 0;
                [sheetView addSubview:ptbutton3];
                [ptbutton3 release];
                allHight+=46 + 18;
            }else{
                allHight += 9;
            }
            
            
            sheetView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, 320, allHight);
            
            [UIView beginAnimations:@"nddd" context:NULL];
            [UIView setAnimationDuration:.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            sheetView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - allHight, 320, allHight);
            [UIView commitAnimations];

        }else{
            
            UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(10, [[UIScreen mainScreen] bounds].size.height-96-44-20, 300, 86)];
            sheetView.backgroundColor = [UIColor whiteColor];
            sheetView.layer.masksToBounds = YES;
            sheetView.layer.borderColor = [[UIColor grayColor] CGColor];
            sheetView.layer.cornerRadius = 5.0;
            
            [grayView addSubview:sheetView];
            [sheetView release];
            if(![destructiveButtonTitle isEqualToString:@""])
            {
                UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn1 setFrame:CGRectMake(0, 10, 300, 25)];
                btn1.tag = 101;
                [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn1.titleLabel.backgroundColor = [UIColor clearColor];
                [btn1 setTitle:destructiveButtonTitle forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
                [sheetView addSubview:btn1];
            }
            if(![destructiveButtonTitle isEqualToString:@""])
            {
                UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, 300, 1)];
                [xian setImage:[UIImage imageNamed:@"wf_xian2.png"]];
                [sheetView addSubview:xian];
                [xian release];
            }
            
            if(otherButtonTitles)
            {
                if(![destructiveButtonTitle isEqualToString:@""])
                {
                    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn2 setFrame:CGRectMake(0, 48, 300, 25)];
                    btn2.tag = 102;
                    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    btn2.titleLabel.backgroundColor = [UIColor clearColor];
                    [btn2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
                    [btn2 setTitle:otherButtonTitles forState:UIControlStateNormal];
                    [sheetView addSubview:btn2];
                }
                else
                {
                    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn2 setFrame:CGRectMake(0, 30, 300, 25)];
                    btn2.tag = 102;
                    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    btn2.titleLabel.backgroundColor = [UIColor clearColor];
                    [btn2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
                    [btn2 setTitle:otherButtonTitles forState:UIControlStateNormal];
                    [sheetView addSubview:btn2];
                }
                
                
            }
        
        }
       
        
        
        
    }
    return self;
}

- (void)pressPtbutton:(UIButton *)sender{

    [self dismissWithClickedButtonIndex:0 animated:YES];
    
    if(delegate && [delegate respondsToSelector:@selector(CP_Actionsheet:clickedButtonAtIndex:)])
    {
        [delegate CP_Actionsheet:self clickedButtonAtIndex:sender.tag];
    }
    
}
-(void)pressGrayView
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if(animated)
    {
        [UIView beginAnimations:@"nddd" context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 0;
        [UIView commitAnimations];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    }
}
-(void)removeFromSuperview
{
    [super removeFromSuperview];
    [grayView removeFromSuperview];
    grayView = nil;
}
-(void)btnPress:(UIButton *)sender
{
    NSLog(@"btnPress");
    
    [self dismissWithClickedButtonIndex:0 animated:YES];
    
    if(delegate && [delegate respondsToSelector:@selector(CP_Actionsheet:clickedButtonAtIndex:)])
    {
        [delegate CP_Actionsheet:self clickedButtonAtIndex:sender.tag-101];
    }
}



-(void)dealloc
{
    [super dealloc];
//    self.delegate = nil;
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