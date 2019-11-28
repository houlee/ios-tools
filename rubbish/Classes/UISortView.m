//
//  UISortView.m
//  caibo
//
//  Created by houchenguang on 14-1-7.
//
//

#import "UISortView.h"

@implementation UISortView
@synthesize delegate;

- (void)pressButtonFunc:(UIButton *)sender{
    
    UIButton * oneButton = (UIButton *)[self viewWithTag:10];
    UIButton * twoButton = (UIButton *)[self viewWithTag:20];
    UIButton * threeButton = (UIButton *)[self viewWithTag:30];
    UIImageView * oneImage = (UIImageView *)[oneButton viewWithTag:oneButton.tag+1];
    UIImageView * twoImage = (UIImageView *)[twoButton viewWithTag:twoButton.tag+1];
    UIImageView * threeImage = (UIImageView *)[threeButton viewWithTag:threeButton.tag+1];
    
    if (sender.tag == 10) {
        if (sender.selected) {
//            sender.selected = NO;
//            oneImage.image = UIImageGetImageFromName(@"changcihaopaixu.png");
        }else{
            twoButton.selected = NO;
            threeButton.selected = NO;
            sender.selected = YES;
            oneImage.image = UIImageGetImageFromName(@"changcihaopaixu_1.png");
            twoImage.image = UIImageGetImageFromName(@"zuipingjunpaixu.png");
            threeImage.image = UIImageGetImageFromName(@"zhukechapaixu.png");
            oneLabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:18/255.0 alpha:1];
            twoLabel.textColor = [UIColor colorWithRed:224/255.0 green:231/255.0 blue:225/255.0 alpha:1];
            threeLabel.textColor = [UIColor colorWithRed:224/255.0 green:231/255.0 blue:225/255.0 alpha:1];
            if (delegate&&[delegate respondsToSelector:@selector(sortViewDidData:select:)]) {
                [delegate sortViewDidData:self select:sender.tag / 10];
            }
        }
    }else if (sender.tag == 20) {
        if (sender.selected) {
//            sender.selected = NO;
//            twoImage.image = UIImageGetImageFromName(@"zuipingjunpaixu.png");
        }else{
            sender.selected = YES;
            oneButton.selected = NO;
            threeButton.selected = NO;
            oneImage.image = UIImageGetImageFromName(@"changcihaopaixu.png");
            twoImage.image = UIImageGetImageFromName(@"zuipingjunpaixu_1.png");
            threeImage.image = UIImageGetImageFromName(@"zhukechapaixu.png");
            oneLabel.textColor = [UIColor colorWithRed:224/255.0 green:231/255.0 blue:225/255.0 alpha:1];
            twoLabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:18/255.0 alpha:1];
            threeLabel.textColor = [UIColor colorWithRed:224/255.0 green:231/255.0 blue:225/255.0 alpha:1];
            if (delegate&&[delegate respondsToSelector:@selector(sortViewDidData:select:)]) {
                [delegate sortViewDidData:self select:sender.tag / 10];
            }
        }
    }else if (sender.tag == 30) {
        if (sender.selected) {
//            sender.selected = NO;
//           threeImage.image = UIImageGetImageFromName(@"zhukechapaixu.png");
        }else{
            sender.selected = YES;
            twoButton.selected = NO;
            oneButton.selected = NO;
            oneImage.image = UIImageGetImageFromName(@"changcihaopaixu.png");
            twoImage.image = UIImageGetImageFromName(@"zuipingjunpaixu.png");
            threeImage.image = UIImageGetImageFromName(@"zhukechapaixu_1.png");
            oneLabel.textColor = [UIColor colorWithRed:224/255.0 green:231/255.0 blue:225/255.0 alpha:1];
            twoLabel.textColor = [UIColor colorWithRed:224/255.0 green:231/255.0 blue:225/255.0 alpha:1];
            threeLabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:18/255.0 alpha:1];
            if (delegate&&[delegate respondsToSelector:@selector(sortViewDidData:select:)]) {
                [delegate sortViewDidData:self select:sender.tag / 10];
            }
        }
    }
   
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        UIImageView * bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(207 - 43), 320, 207)];
        bgImage.backgroundColor = [UIColor clearColor];
        bgImage.userInteractionEnabled = YES;
        bgImage.image = UIImageGetImageFromName(@"paixubeijinga.png");
        [self addSubview:bgImage];
        [bgImage release];
        
        
        UILabel * sortLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 0, 32, frame.size.height)];
        sortLabel.backgroundColor = [UIColor clearColor];
        sortLabel.textAlignment = NSTextAlignmentCenter;
        sortLabel.text = @"排序";
        sortLabel.textColor = [UIColor colorWithRed:61/255.0 green:111/255.0 blue:64/255.0 alpha:1];
        sortLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:sortLabel];
        [sortLabel release];
        
        
        UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        oneButton.frame = CGRectMake(64, 0, 86, frame.size.height);
        oneButton.tag = 10;
        [oneButton addTarget:self action:@selector(pressButtonFunc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:oneButton];
        
        UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        twoButton.frame = CGRectMake(150, 0, 86, frame.size.height);
        twoButton.tag = 20;
        [twoButton addTarget:self action:@selector(pressButtonFunc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:twoButton];
        
        UIButton * threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        threeButton.frame = CGRectMake(236, 0, 86, frame.size.height);
        threeButton.tag = 30;
        [threeButton addTarget:self action:@selector(pressButtonFunc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:threeButton];
        
        
        UIImageView * oneImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-18)/2+2, 18, 16)];
        oneImage.backgroundColor = [UIColor clearColor];
        oneImage.tag = oneButton.tag + 1;
        oneImage.image = UIImageGetImageFromName(@"changcihaopaixu_1.png");
        [oneButton addSubview:oneImage];
        [oneImage release];
        
        UIImageView * twoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-18)/2+2, 18, 16)];
        twoImage.backgroundColor = [UIColor clearColor];
        twoImage.tag = twoButton.tag + 1;
        twoImage.image = UIImageGetImageFromName(@"zuipingjunpaixu.png");
        [twoButton addSubview:twoImage];
        [twoImage release];
        
        UIImageView * threeImage= [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-18)/2+2, 18, 16)];
        threeImage.backgroundColor = [UIColor clearColor];
        threeImage.tag = threeButton.tag + 1;
        threeImage.image = UIImageGetImageFromName(@"zhukechapaixu.png");
        [threeButton addSubview:threeImage];
        [threeImage release];
        
        oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 2, 60, frame.size.height)];
        oneLabel.backgroundColor = [UIColor clearColor];
        oneLabel.textAlignment = NSTextAlignmentLeft;
        oneLabel.text = @"场次号";
        oneLabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:18/255.0 alpha:1];
        oneLabel.font = [UIFont systemFontOfSize:12];
        [oneButton addSubview:oneLabel];
        [oneLabel release];
        
        twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 2, 60, frame.size.height)];
        twoLabel.backgroundColor = [UIColor clearColor];
        twoLabel.textAlignment = NSTextAlignmentLeft;
        twoLabel.text = @"最平均";
        twoLabel.textColor = [UIColor colorWithRed:224/255.0 green:231/255.0 blue:225/255.0 alpha:1];
        twoLabel.font = [UIFont systemFontOfSize:12];
        [twoButton addSubview:twoLabel];
        [twoLabel release];
        
        threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 2, 60, frame.size.height)];
        threeLabel.backgroundColor = [UIColor clearColor];
        threeLabel.textAlignment = NSTextAlignmentLeft;
        threeLabel.text = @"主客差";
        threeLabel.textColor = [UIColor colorWithRed:224/255.0 green:231/255.0 blue:225/255.0 alpha:1];
        threeLabel.font = [UIFont systemFontOfSize:12];
        [threeButton addSubview:threeLabel];
        [threeLabel release];
        
        
        
    }
    return self;
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