//
//  YH_PageControl.m
//  CIPG_ShowDemo
//
//  Created by yao on 11-3-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YH_PageControl.h"

@implementation YH_PageControl
@synthesize dotWidth;
@synthesize spacing;
@synthesize dotNormalImage;
@synthesize dotSelectImage;
@synthesize dotHeight;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.enabled = NO;
        
        dotWidth = 8;
        dotHeight = 2;
        spacing = 6;
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
        UIImageView *dot = [self.subviews objectAtIndex:i];
		CGPoint cen = dot.center;
            UIImageView * imageView = (UIImageView *)[dot viewWithTag:100];
            if (!imageView) {
                UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dotWidth, dotHeight)];
                if (i == 0) {
                    if (dotSelectImage && dotSelectImage.length) {
                        mainImageView.image = UIImageGetImageFromName(dotSelectImage);
                    }else{
                        mainImageView.image = UIImageGetImageFromName(@"LunBo_selected.png");
                    }

                }else{
                    if (dotNormalImage && dotNormalImage.length) {
                        mainImageView.image = [UIImage imageNamed:dotNormalImage];

                    }else{
                        mainImageView.image = [UIImage imageNamed:@"LunBo_normal.png"];
                    }

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
                if ([imageView isKindOfClass:[UIImageView class]]) {
                    if (dotSelectImage && dotSelectImage.length) {
                        imageView.image = UIImageGetImageFromName(dotSelectImage);
                    }else{
                        imageView.image = UIImageGetImageFromName(@"LunBo_selected.png");
                    }
                }
            }
            else {
                if ([dot isKindOfClass:[UIImageView class]]) {
                    if (dotSelectImage && dotSelectImage.length) {
                        dot.image = UIImageGetImageFromName(dotSelectImage);
                    }else{
                        dot.image = UIImageGetImageFromName(@"LunBo_selected.png");
                    }
                }
                
     
            }
		}
        else{
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                if ([imageView isKindOfClass:[UIImageView class]]) {
                    if (dotNormalImage && dotNormalImage.length) {
                        imageView.image = [UIImage imageNamed:dotNormalImage];
                    }else{
                        imageView.image = [UIImage imageNamed:@"LunBo_normal.png"];
                    }
                }
 
            }
            else {
                if ([dot isKindOfClass:[UIImageView class]]) {
                    if (dotNormalImage && dotNormalImage.length) {
                        dot.image = [UIImage imageNamed:dotNormalImage];
                    }else{
                        dot.image = [UIImage imageNamed:@"LunBo_normal.png"];
                    }
                }

            }
		}
		dot.center = cen;
        dot.frame = CGRectMake((spacing + dotWidth) * i, 0, dotWidth, dotHeight);
        UIImageView * imageView2 = (UIImageView *)[dot viewWithTag:100];
        if (imageView2) {
            imageView2.frame = dot.bounds;
        }
        dot.backgroundColor = [UIColor clearColor];
    }
}

-(void)setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}

- (void)dealloc {
    [dotSelectImage release];
    [dotNormalImage release];
    
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    