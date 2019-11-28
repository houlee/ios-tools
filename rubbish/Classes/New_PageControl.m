//
//  New_PageControl.m
//  CPgaopin
//
//  Created by GongHe on 14-2-17.
//
//

#import "New_PageControl.h"

@implementation New_PageControl
@synthesize yilouBool ,cjbBool,guideBool;
#define SPACING 12

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.enabled = NO;
    }
    return self;
}

-(void)layoutSubviews{
    [self updateDots];
}

-(void)updateDots
{
    
    for (int i = 0; i < [self.subviews count]; i++)
    {
        
        if (yilouBool) {
            self.backgroundColor = [UIColor colorWithRed:20/255.0 green:19/255.0 blue:10/255.0 alpha:1];

            float yilouHight = (320 - ([self.subviews count] - 1))/[self.subviews count];
            
            UIImageView *dot = [self.subviews objectAtIndex:i];
            CGPoint cen = dot.center;
            UIImageView * imageView = (UIImageView *)[dot viewWithTag:100];
            if (!imageView) {
                UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.5, yilouHight, self.frame.size.height - 1)];
                if (i == 0) {
                    mainImageView.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
                }else{
                    mainImageView.backgroundColor = [UIColor colorWithRed:43/255.0 green:100/255.0 blue:132/255.0 alpha:1];
                }
                mainImageView.tag = 100;
                [dot addSubview:mainImageView];
                [mainImageView release];
            }
            if (i == self.currentPage) {
                    imageView.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
            }
            else{
                    imageView.backgroundColor = [UIColor colorWithRed:43/255.0 green:100/255.0 blue:132/255.0 alpha:1];
                }
            dot.center = cen;
            dot.frame = CGRectMake((yilouHight+1) * i, 0.5, yilouHight, self.frame.size.height - 1);
            UIImageView * imageView2 = (UIImageView *)[dot viewWithTag:100];
            if (imageView2) {
                imageView2.frame = dot.bounds;
            }
            dot.backgroundColor = [UIColor clearColor];
        }else if(cjbBool){
            
            UIImageView *dot = [self.subviews objectAtIndex:i];
            CGPoint cen = dot.center;
            UIImageView * imageView = (UIImageView *)[dot viewWithTag:100];
            if (!imageView) {
                UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 7)];
                if (i == 0) {
                    mainImageView.image = UIImageGetImageFromName(@"cjbdian_1.png");
                }else{
                    mainImageView.image = [UIImage imageNamed:@"cjbdian.png"];
                }
                mainImageView.tag = 100;
                mainImageView.hidden = YES;
                [dot addSubview:mainImageView];
                [mainImageView release];
            }
            UIImageView * imageView1 = (UIImageView *)[dot viewWithTag:100];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                imageView1.hidden = NO;
            }
            if (i == self.currentPage) {
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                    imageView.image = [UIImage imageNamed:@"cjbdian_1.png"];
                }
                else {
                    dot.image = [UIImage imageNamed:@"cjbdian_1.png"];
                }
            }
            else{
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                    imageView.image = [UIImage imageNamed:@"cjbdian.png"];
                }
                else {
                    dot.image = [UIImage imageNamed:@"cjbdian.png"];
                }
            }
            dot.center = cen;
            dot.frame = CGRectMake(25 * i, 0, 7, 7);
            UIImageView * imageView2 = (UIImageView *)[dot viewWithTag:100];
            if (imageView2) {
                imageView2.frame = dot.bounds;
            }
            dot.backgroundColor = [UIColor clearColor];
        
        }
        else if(guideBool)
        {
            UIImageView *dot = [self.subviews objectAtIndex:i];
            CGPoint cen = dot.center;
            UIImageView * imageView = (UIImageView *)[dot viewWithTag:100];
            if (!imageView) {
                UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 7)];
                if (i == 0) {
                    mainImageView.image = UIImageGetImageFromName(@"pageControl_02.png");
                }else{
                    mainImageView.image = [UIImage imageNamed:@"pageControl_01.png"];
                }
                mainImageView.tag = 100;
                mainImageView.hidden = YES;
                [dot addSubview:mainImageView];
                [mainImageView release];
            }
            UIImageView * imageView1 = (UIImageView *)[dot viewWithTag:100];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                imageView1.hidden = NO;
            }
            if (i == self.currentPage) {
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                    imageView.image = [UIImage imageNamed:@"pageControl_02.png"];
                }
                else {
                    dot.image = [UIImage imageNamed:@"pageControl_02.png"];
                }
            }
            else{
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                    imageView.image = [UIImage imageNamed:@"pageControl_01.png"];
                }
                else {
                    dot.image = [UIImage imageNamed:@"pageControl_01.png"];
                }
            }
            dot.center = cen;
            dot.frame = CGRectMake(25 * i, 0, 7, 7);
            UIImageView * imageView2 = (UIImageView *)[dot viewWithTag:100];
            if (imageView2) {
                imageView2.frame = dot.bounds;
            }
            dot.backgroundColor = [UIColor clearColor];
        }
        else{
            UIImageView *dot = [self.subviews objectAtIndex:i];
            CGPoint cen = dot.center;
            UIImageView * imageView = (UIImageView *)[dot viewWithTag:100];
            if (!imageView) {
                UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7.5, 8)];
                if (i == 0) {
                    mainImageView.image = UIImageGetImageFromName(@"CurForecastLunBo.png");
                }else{
                    mainImageView.image = [UIImage imageNamed:@"ForecastLunBo.png"];
                }
                mainImageView.tag = 100;
                mainImageView.hidden = YES;
                [dot addSubview:mainImageView];
                [mainImageView release];
            }
            UIImageView * imageView1 = (UIImageView *)[dot viewWithTag:100];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                imageView1.hidden = NO;
            }
            if (i == self.currentPage) {
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                    imageView.image = [UIImage imageNamed:@"PageDot_1.png"];
                }
                else {
                    dot.image = [UIImage imageNamed:@"PageDot_1.png"];
                }
            }
            else{
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                    imageView.image = [UIImage imageNamed:@"PageDot.png"];
                }
                else {
                    dot.image = [UIImage imageNamed:@"PageDot.png"];
                }
            }
            dot.center = cen;
            dot.frame = CGRectMake(SPACING * i, 0, 7.5, 8);
            UIImageView * imageView2 = (UIImageView *)[dot viewWithTag:100];
            if (imageView2) {
                imageView2.frame = dot.bounds;
            }
            dot.backgroundColor = [UIColor clearColor];
        
        
        }
        
        
      
    }
}

-(void)setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}

- (void)dealloc {
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    