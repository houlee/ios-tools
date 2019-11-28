//
//  GouCaiShuZiCell.m
//  caibo
//
//  Created by yao on 12-5-24.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GouCaiShuZiCell.h"
#import "NSStringExtra.h"
#import "GCBallView.h"
#import "SharedMethod.h"
#import "SharedDefine.h"

@implementation GouCaiShuZiCell

@synthesize myredArray;
@synthesize myblueArray;
@synthesize mylotteryId,wanfa,zhongjiang;
@synthesize backImage1;
@synthesize backImage;
@synthesize isHeZhi;
@synthesize isFirst;
@synthesize luckyBall;
@synthesize isDanshi;
@synthesize isHorseCell;
@synthesize isHorseDuoWanFa;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.XQTZTableBG
        self.backgroundColor = [UIColor clearColor];
        isHeZhi = NO;
        isFirst = NO;
        isDanshi = NO;
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
        backLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        backLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:backLine];
        [backLine release];
        backLine.hidden = YES;
    }
    return self;
}

- (BOOL)isRight:(NSString *)num {
    if (zhongjiang && [zhongjiang length] > 2) {
        if ([zhongjiang isMatchWithRegexString:@"^[\\u4E00-\\u9FA5]+$"]){
            return NO;
        }
        
    }
    return NO;
}

- (NSArray *)changePukeArray:(NSString *)jiang {
    NSArray *numArray = [jiang componentsSeparatedByString:@","];
    if ([numArray count] == 3) {
        NSArray *array1 = [[numArray objectAtIndex:0] componentsSeparatedByString:@":"];
        NSArray *array2 = [[numArray objectAtIndex:1] componentsSeparatedByString:@":"];
        NSArray *array3 = [[numArray objectAtIndex:2] componentsSeparatedByString:@":"];
        int a,b,c,a1,b1,c1;
        a = (int)[[array1 objectAtIndex:0] integerValue];
        b = (int)[[array2 objectAtIndex:0] integerValue];
        c = (int)[[array3 objectAtIndex:0] integerValue];
        a1 =(int) [[array1 objectAtIndex:1] integerValue];
        b1 = (int)[[array2 objectAtIndex:1] integerValue];
        c1 = (int)[[array3 objectAtIndex:1] integerValue];
        NSString *leixing = @"";
        int smal = 100,mid = 0,big = 0;
        if (smal > a) {
            smal = a;
        }
        if (smal > b) {
            smal = b;
        }
        if (smal > c) {
            smal = c;
        }
        if (big < a) {
            big = a;
        }
        if (big < b) {
            big = b;
        }
        if (big < c) {
            big = c;
        }
        mid = a + b + c - smal - big;
        if (a == b && b == c) {
            leixing = @"豹子";
        }
        else if (a == b || b == c || a == c) {
            leixing = @"对子";
        }
        else if (a1 == b1 && b1 == c1) {
            leixing = @"同花";
            if (smal + 1 == mid && mid + 1 ==big) {
                leixing = @"同花顺";
            }
        }
        else if (smal + 1 == mid && mid + 1 ==big) {
            leixing = @"顺子";
        }
        return [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",a],[NSString stringWithFormat:@"%d",b],[NSString stringWithFormat:@"%d",c],[NSString stringWithFormat:@"%d",a1],[NSString stringWithFormat:@"%d",b1],[NSString stringWithFormat:@"%d",c1],leixing ,nil];
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)changeColor:(GCBallView *)numLable jiang:(NSString *)num {
    if ([numLable.numLabel.text isEqualToString:@"大"]) {
        if ([num intValue] >= 5) {
            numLable.selected =YES;
        }
    }
    else if ([numLable.numLabel.text isEqualToString:@"小"]) {
        if ([num intValue] < 5) {
            numLable.selected =YES;
        }
    }
    else if ([numLable.numLabel.text isEqualToString:@"单"]) {
        if ([num intValue] % 2 == 1) {
            numLable.selected =YES;
        }
    }
    else if ([numLable.numLabel.text isEqualToString:@"双"]) {
        if ([num intValue] % 2 == 0) {
            numLable.selected =YES;
        }
    }
    
}


- (NSString *)changeDaxiaoDanshuang:(NSString *)num {
    if ([num isEqualToString:@"9"]) {
        return @"大";
    }
    if ([num isEqualToString:@"0"]) {
        return @"小";
    }
    if ([num isEqualToString:@"1"]) {
        return @"单";
    }
    if ([num isEqualToString:@"2"]) {
        return @"双";
    }
    return nil;
    
}

- (void )getPukeViewBy:(NSArray *)numArray setImageArray:(NSArray *)picArray{//
    if ([numArray count] < 3) {
        return;
    }
    NSArray *name = [NSArray arrayWithObjects:@"",@"⑴",@"⑵",@"⑶",@"⑷",@"⑸",@"⑹",@"⑺",@"⑻",@"⑼",@"⒂",@"⑾",@"⑿",@"⒀", nil];
    NSArray *array1 = [[numArray objectAtIndex:0] componentsSeparatedByString:@":"];
    NSArray *array2 = [[numArray objectAtIndex:1] componentsSeparatedByString:@":"];
    NSArray *array3 = [[numArray objectAtIndex:2] componentsSeparatedByString:@":"];
    int a,b,c,a1,b1,c1;
    a = (int)[[array1 objectAtIndex:0] integerValue];
    b = (int)[[array2 objectAtIndex:0] integerValue];
    c = (int)[[array3 objectAtIndex:0] integerValue];
    a1 = (int)[[array1 objectAtIndex:1] integerValue];
    b1 = (int)[[array2 objectAtIndex:1] integerValue];
    c1 = (int)[[array3 objectAtIndex:1] integerValue];
    NSString *leixing = @"";
    int smal = 100,mid = 0,big = 0;
    if (smal > a) {
        smal = a;
    }
    if (smal > b) {
        smal = b;
    }
    if (smal > c) {
        smal = c;
    }
    if (big < a) {
        big = a;
    }
    if (big < b) {
        big = b;
    }
    if (big < c) {
        big = c;
    }
    mid = a + b + c - smal - big;
    if (a == b && b == c) {
        leixing = @"豹子";
    }
    else if (a == b || b == c || a == c) {
        leixing = @"对子";
    }
    else if (a1 == b1 && b1 == c1) {
        leixing = @"同花";
        if (smal + 1 == mid && mid + 1 ==big) {
            leixing = @"同花顺";
        }
    }
    else if (smal + 1 == mid && mid + 1 ==big) {
        leixing = @"顺子";
    }
    NSString *pic1 = [NSString stringWithFormat:@"puke_%d.png",a1];
    NSString *pic2 = [NSString stringWithFormat:@"puke_%d.png",b1];
    NSString *pic3 = [NSString stringWithFormat:@"puke_%d.png",c1];
    if ([picArray count] >= 3) {
        UIImageView *imag1 = [picArray objectAtIndex:0];
        UIImageView *imag2 = [picArray objectAtIndex:1];
        UIImageView *imag3 = [picArray objectAtIndex:2];
        UILabel *lab1 = (UILabel *)[imag1 viewWithTag:101];
        UILabel *lab2 = (UILabel *)[imag2 viewWithTag:101];
        UILabel *lab3 = (UILabel *)[imag3 viewWithTag:101];
        lab1.text = [name objectAtIndex:a];
        lab2.text = [name objectAtIndex:b];
        lab3.text = [name objectAtIndex:c];
        imag1.image = UIImageGetImageFromName(pic1);
        imag2.image = UIImageGetImageFromName(pic2);
        imag3.image = UIImageGetImageFromName(pic3);

    }
    if ([picArray count] >= 4) {
        UILabel *label = [picArray objectAtIndex:4];
        label.text = leixing;
    }
    
    
}


- (void)LoadRedArray:(NSArray *)redArray BlueArray:(NSArray *)blueArray FenGeArrag:(NSArray *)fengeArray WithBall:(BOOL)isBall{
    if (isBall) {
        for (UIView *v in self.contentView.subviews) {
            v.hidden = YES;
        }
        if ([self.mylotteryId isEqualToString:@"122"]) {
            UIImageView *image1 = (UIImageView *)[self.contentView viewWithTag:133];
            if (!image1) {
                image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 30, 40)];
                [self.contentView addSubview:image1];
                image1.tag = 133;
                [image1 release];
                UILabel *lab1 = [[UILabel alloc] init];
                lab1.frame = CGRectMake(2, 2, 12, 12);
                lab1.font = [UIFont fontWithName:@"TRENDS" size:10];
                lab1.backgroundColor = [UIColor clearColor];
                lab1.tag = 101;
                lab1.autoresizingMask = 111111;
                [image1 addSubview:lab1];
                [lab1 release];
            }
            
            UIImageView *image2 = (UIImageView *)[self.contentView viewWithTag:134];
            if (!image2) {
                image2 = [[UIImageView alloc] initWithFrame:CGRectMake(45, 2, 30, 40)];
                [self.contentView addSubview:image2];
                image2.tag = 134;
                [image2 release];
                UILabel *lab1 = [[UILabel alloc] init];
                lab1.frame = CGRectMake(2, 2, 12, 12);
                lab1.font = [UIFont fontWithName:@"TRENDS" size:10];
                lab1.backgroundColor = [UIColor clearColor];
                lab1.tag = 101;
                lab1.autoresizingMask = 111111;
                [image2 addSubview:lab1];
                [lab1 release];
            }
            UIImageView *image3 = (UIImageView *)[self.contentView viewWithTag:135];
            if (!image3) {
                image3 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 2, 30, 40)];
                [self.contentView addSubview:image3];
                image3.tag = 135;
                [image3 release];
                UILabel *lab1 = [[UILabel alloc] init];
                lab1.frame = CGRectMake(2, 2, 12, 12);
                lab1.font = [UIFont fontWithName:@"TRENDS" size:10];
                lab1.backgroundColor = [UIColor clearColor];
                lab1.tag = 101;
                lab1.autoresizingMask = 111111;
                [image3 addSubview:lab1];
                [lab1 release];
            }
            [self getPukeViewBy:redArray setImageArray:[NSArray arrayWithObjects:image1, image2,image3,nil]];
            backImage.frame = CGRectMake(10, 0, 300, 65);
            backImage1.frame = CGRectMake(15, 5, 290, 0);
            return;
        }
        else if ([self.mylotteryId isEqualToString:@"012"] || [self.mylotteryId isEqualToString:@"013"] || [self.mylotteryId isEqualToString:@"019"] || [self.mylotteryId isEqualToString:LOTTERY_ID_JILIN] || [self.mylotteryId isEqualToString:LOTTERY_ID_ANHUI]) {//内蒙古和江苏快三
            for (int i = 0; i < 3; i ++ ) {
                UIImageView *image1 = (UIImageView *)[self.contentView viewWithTag:100 +i];
                if (!image1) {
                    image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 30, 40)];
                    [self.contentView addSubview:image1];
                    image1.tag = 100 +i;
                    image1.backgroundColor = [UIColor clearColor];
                    [image1 release];
                }
                image1.frame = CGRectMake(15 + 31 * i, 4, 26, 26);
                if (i < [redArray count]) {
                    NSString *name = [NSString stringWithFormat:@"xqshaizi0%d.png",(int)[[redArray objectAtIndex:i] integerValue]];
                    image1.image = UIImageGetImageFromName(name);
                }
                else {
                    image1.image = nil;
                }
            }
            return;
            
        }
        for (int i =0; i < [redArray count]; i++) {
            UIImageView *im = (UIImageView *)[self.contentView viewWithTag:i+100];
            int a = i/8,b = i%8;
            if (!im) {
                im = [[UIImageView alloc] init];
                im.frame = CGRectMake(7+38*b, 9+36*a, 33, 33);
                im.tag = i+100;
                UILabel *numLabel = [[UILabel alloc] initWithFrame:im.bounds];
                numLabel.backgroundColor =[UIColor clearColor];
                numLabel.userInteractionEnabled = NO;
                [im addSubview:numLabel];
                numLabel.tag = 44;
                numLabel.font = [UIFont systemFontOfSize:16];
                numLabel.textAlignment = NSTextAlignmentCenter;
                numLabel.textColor = [UIColor whiteColor];
                [numLabel release];
                [self.contentView addSubview:im];
                [im release];
            }
            im = (UIImageView *)[self.contentView viewWithTag:i+100];
            UILabel *numLabel = (UILabel *)[im viewWithTag:44];
            numLabel.text = [redArray objectAtIndex:i];
            im.frame = CGRectMake(7+38*b, 9+36*a, 33, 33);
            im.image = UIImageGetImageFromName(@"faxqhongqiu.png");
            if ([self.mylotteryId isEqualToString:@"011"] && [numLabel.text integerValue] < 19) {
                im.image = UIImageGetImageFromName(@"faxqlanqiu.png");
            }
            im.hidden = NO;
        }
        for (int i = (int)[redArray count]; i<[redArray count]+[blueArray count]; i ++) {
            UIImageView *im = (UIImageView *)[self.contentView viewWithTag:i+100];
            int a = (i + 1)/8,b = (i + 1)%8;
            if ([self.luckyBall length] > 0 ) {
                a = (i)/8,b = (i)%8;
            }
            if (!im) {
                im = [[UIImageView alloc] init];
                im.tag = i+100;
                im.frame = CGRectMake(7+38*b, 9+36*a, 33, 33);
                UILabel *numLabel = [[UILabel alloc] initWithFrame:im.bounds];
                numLabel.backgroundColor =[UIColor clearColor];
                numLabel.font = [UIFont systemFontOfSize:16];
                numLabel.userInteractionEnabled = NO;
                [im addSubview:numLabel];
                numLabel.textColor = [UIColor whiteColor];
                numLabel.tag = 44;
                numLabel.textAlignment = NSTextAlignmentCenter;
                [numLabel release];
                [self.contentView addSubview:im];
                [im release];
            }
            im = (UIImageView *)[self.contentView viewWithTag:i+100];
            UILabel *numLabel = (UILabel *)[im viewWithTag:44];
            numLabel.text = [blueArray objectAtIndex:i-[redArray count]];
            im.frame = CGRectMake(7+38*b, 9+36*a, 33, 33);
            im.image = UIImageGetImageFromName(@"faxqlanqiu.png");
            im.hidden = NO;
            
            if (i == [redArray count]+[blueArray count] - 1 && [self.luckyBall length] > 0 ) {
                UIImageView *luck = (UIImageView *)[self.contentView viewWithTag:i + 1+100];
                if (!luck) {
                    luck = [[UIImageView alloc] init];
                    luck.tag = i + 1+100;
                    luck.frame = CGRectMake(7+38*b, 9+36*a, 33, 33);
                    UILabel *numLabel = [[UILabel alloc] initWithFrame:im.bounds];
                    numLabel.backgroundColor =[UIColor clearColor];
                    numLabel.font = [UIFont systemFontOfSize:16];
                    numLabel.userInteractionEnabled = NO;
                    [luck addSubview:numLabel];
                    numLabel.textColor = [UIColor whiteColor];
                    numLabel.tag = 44;
                    numLabel.textAlignment = NSTextAlignmentCenter;
                    [numLabel release];
                    [self.contentView addSubview:luck];
                    [luck release];
                }
                UILabel *numLabel = (UILabel *)[luck viewWithTag:44];
                numLabel.text = self.luckyBall;
                luck.frame = CGRectMake(7+38*(b + 1), 9+36*a, 33, 33);
                luck.image = UIImageGetImageFromName(@"luckyblue.png");
                luck.hidden = NO;
                
            }
        }
        for (int i = 0; i < [fengeArray count]; i++) {
            UIView *line = [[UIView alloc] init];
            int a = [[fengeArray objectAtIndex:i] intValue]/9,b = [[fengeArray objectAtIndex:i] intValue]%9;
            line.backgroundColor = [UIColor blackColor];
            line.frame = CGRectMake(17+31*b, 15+20*a, 1, 10);
            [self.contentView addSubview:line];
            [line release];
        }
        if ([blueArray count]) {
            backImage.frame = CGRectMake(10, 0, 300, ([redArray count]+ [blueArray count] )/9 *20 +36);
            backImage1.frame = CGRectMake(15, 5, 290, ([redArray count]+ [blueArray count] )/9 *20 +30);
        }
        else {
            backImage.frame = CGRectMake(10, 0, 300, ([redArray count]-1)/9 *20 +36);
            backImage1.frame = CGRectMake(15, 5, 290, ([redArray count]-1)/9 *20 +30);
        }
    }
    else {
        [self LoadRedArray:redArray BlueArray:blueArray FenGeArrag:fengeArray];
    }
}

- (void)LoadRedArray:(NSArray *)redArray BlueArray:(NSArray *)blueArray FenGeArrag:(NSArray *)fengeArray {
    [self changeNum:zhongjiang];
    for (UIView *v in self.contentView.subviews) {
        v.hidden = YES;
    }
    if (!isFirst) {
        backLine.hidden = NO;
    }
    if (isDanshi) {
        backLine.hidden = NO;
        backLine.backgroundColor = [SharedMethod getColorByHexString:@"bbbab6"];
    }
    for (int i = 0; i < [fengeArray count]; i++) {
        
        int count = [[fengeArray objectAtIndex:i] intValue];
        
        if (count == [redArray count]) {
            
        }
        else {
            if (count >= [redArray count]) {
                count = count + 1;
            }
            int a = 0;
            int b = 0;

            UIView *line = [self.contentView viewWithTag:1000 + i];
            if (!line) {
                line = [[UIView alloc] init];
                [self.contentView addSubview:line];
                line.tag = 1000 + i;
                
                [line release];
            }
            line.backgroundColor = [UIColor redColor];
            if ([self.mylotteryId isEqualToString:@"012"] ||[self.mylotteryId isEqualToString:@"013"] || [self.mylotteryId isEqualToString:@"019"] || [self.mylotteryId isEqualToString:LOTTERY_ID_JILIN] || [self.mylotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
                a = count / 3, b= count %3;
                line.frame = CGRectMake(15+ 105 *b, 9+36*a, 1, 30);
                if ([self.wanfa isEqualToString:@"05"] || [self.wanfa isEqualToString:@"08"]) {
                    a = count/8,b = count%8;
                    line.frame = CGRectMake(15+36*b + 18, 9+36*a, 1, 33);
                }
                else if ([self.wanfa isEqualToString:@"06"]) {
                    if (b == 0) {
                        line.frame = CGRectMake(15+ 105 * 3 - 20, 7+36*a - 36, 1, 30);
                    }
                    else {
                        line.frame = CGRectMake(15+ 105 *b - 20, 7+36*a, 1, 30);
                    }
                    
                }
            }
            else {
                count = count + i;
                int a = count/8,b = count%8;
//                if (b == 0) {
//                    a = a -1; b = 8;
//                }
                if ([self.mylotteryId isEqualToString:@"113"] && count > [redArray count]) {
                    line.backgroundColor = [UIColor blueColor];
                }
                line.frame = CGRectMake(15+38*b + 19, 9+36*a, 1, 30);
            }
            line.hidden = NO;
            
        }
        
    }
    NSInteger shuziwei = 0;
    NSArray *pukeArray = nil;
    if ([self.mylotteryId isEqualToString:@"122"]) {
        pukeArray = [self changePukeArray:self.zhongjiang];
    }
    for (int i =0; i < [redArray count]; i++) {
        GCBallView *ballView = (GCBallView *)[self.contentView viewWithTag:i + 100];
        int fengewei = 0;
        int a = i/8,b = i%8;
        if (isHorseDuoWanFa) {
            a = i/6,b = i%6;
        }
        for (int t = 0; t < [fengeArray count]; t++) {
            if (i >= [[fengeArray objectAtIndex:t] integerValue] && i != 0) {
                fengewei ++;
            }
        }
        if (fengewei > 0) {
            a = (i + fengewei)/8,b= (i +fengewei)%8;
        }
        if (!ballView) {
            
            if ([self.mylotteryId isEqualToString:@"122"] ||[self.mylotteryId isEqualToString:@"012"] ||[self.mylotteryId isEqualToString:@"013"] || [self.mylotteryId isEqualToString:@"019"] || [self.mylotteryId isEqualToString:LOTTERY_ID_JILIN] || [self.mylotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
                
            }
            else {
                ballView = [[GCBallView alloc] initWithFrame:CGRectMake(15+38*b, 9+36*a, 33, 33) Num:@" " ColorType:GCBallViewColorRed];
                ballView.backgroundColor =[UIColor clearColor];
                ballView.userInteractionEnabled = NO;
                ballView.selected = NO;
                ballView.tag = 100 +i;
                [self.contentView addSubview:ballView];
                [ballView release];
            }
            
            
        }
        
        if ([self.mylotteryId isEqualToString:@"122"] ||[self.mylotteryId isEqualToString:@"012"] ||[self.mylotteryId isEqualToString:@"013"] || [self.mylotteryId isEqualToString:@"019"] || [self.mylotteryId isEqualToString:LOTTERY_ID_JILIN] || [self.mylotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
            ballView = nil;
        }
        ballView = (GCBallView *)[self.contentView viewWithTag:i + 100];
        ballView.hidden = NO;
        [ballView changeTo:GCBallViewColorRed];
        if (isDanshi) {
            [ballView setBackgroundImage:nil forState:UIControlStateNormal];
            [ballView setBackgroundImage:nil forState:UIControlStateSelected];
            self.zhongjiang = nil;
        }
        if ([ballView isKindOfClass:[GCBallView class]]) {
            ballView.numLabel.text = [redArray objectAtIndex:i];
            ballView.frame =CGRectMake(15+38*b, 9+36*a, 33, 33);
            if (isHorseDuoWanFa) {
                ballView.frame = CGRectMake(69+38*b, 9+36*a, 33, 33);
                backLine.frame = CGRectMake(69, 0, 320 - 69, 0.5);
                
                UILabel * label = (UILabel *)[self viewWithTag:666];
                if (!label) {
                    UIImageView * titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 16, 54, 22)];
                    titleImage.backgroundColor=[UIColor clearColor];
                    titleImage.image = [UIImage imageNamed:BETSVIEW_TITLE_IMAGENAME_RED];
                    titleImage.tag = 555;
                    titleImage.hidden = YES;
                    [self.contentView addSubview:titleImage];
                    
                    UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(14, 0, titleImage.frame.size.width - 14, titleImage.frame.size.height)] autorelease];
                    titleLabel.backgroundColor = [UIColor clearColor];
                    titleLabel.font = BETSVIEW_TITLE_FONT;
                    titleLabel.textColor = BETSVIEW_TITLE_COLOR;
                    titleLabel.tag = 666;
                    [titleImage addSubview:titleLabel];
                }
            }
        }
        if ([self.mylotteryId isEqualToString:@"110"] || [self.mylotteryId isEqualToString:@"109"]) {//七星彩,排列五
            ballView.selected = NO;
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@","];
                if (shuziwei < [array count]) {
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    if (shuziwei < [array count]) {
                        if ([[array objectAtIndex:shuziwei] isEqualToString:ballView.numLabel.text]) {
                            ballView.selected = YES;
                        }
                    }
                }
            }
        }
        else if ([self.mylotteryId isEqualToString:@"108"]) {//排三
            ballView.selected = NO;
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@","];
                if (isHeZhi) {
                    NSInteger he = 0;
                    for (NSString *num in array) {
                        he = he +[num intValue];
                    }
                    if ([ballView.numLabel.text intValue] == he) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa isEqualToString:@"01"]) {
                    if (shuziwei < [array count]) {
                        if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                            shuziwei ++;
                        }
                        if (shuziwei < [array count]) {
                            if ([[array objectAtIndex:shuziwei] isEqualToString:ballView.numLabel.text]) {
                                ballView.selected = YES;
                            }
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"02"] || [self.wanfa isEqualToString:@"03"] ||[self.wanfa isEqualToString:@"04"]) {
                    if ([array containsObject:ballView.numLabel.text]) {
                        ballView.selected = YES;
                    }
                }
            }
        }
        else if ([self.mylotteryId isEqualToString:@"003"]) {//七乐彩
            ballView.selected = NO;
            if (isDanshi) {
                ballView.numLabel.textColor = [SharedMethod getColorByHexString:@"ff3b30"];
            }
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@"+"];
                NSString *blue = nil;
                if ([array count] >= 2) {
                    blue = [array objectAtIndex:1];
                    array = [[array objectAtIndex:0] componentsSeparatedByString:@","];
                    
                }
                if ([array containsObject:ballView.numLabel.text]) {
                    [ballView changeTo:GCBallViewColorRed];
                    ballView.selected = YES;
                }
                else if (blue &&[blue isEqualToString:ballView.numLabel.text]) {
                    [ballView changeTo:GCBallViewColorBlue];
                    ballView.selected = YES;
                }
                
            }
        }
        else if ([self.mylotteryId isEqualToString:@"002"]) {// 3d
            ballView.selected = NO;
            if (isDanshi) {
                ballView.numLabel.textColor = [SharedMethod getColorByHexString:@"ff3b30"];
            }
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@","];
                if (isHeZhi) {
                    NSInteger he = 0;
                    for (NSString *num in array) {
                        he = he + [num intValue];
                    }
                    if ([ballView.numLabel.text intValue] == he) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa isEqualToString:@"01"]) {
                    if ([fengeArray count] == 0) {
                        if (i < [array count] &&[[array objectAtIndex:i] isEqualToString:ballView.numLabel.text] ) {
                            ballView.selected = YES;
                        }
                    }
                    else if (shuziwei < [array count]) {
                        if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                            shuziwei ++;
                        }
                        if (shuziwei < [array count]) {
                            if ([[array objectAtIndex:shuziwei] isEqualToString:ballView.numLabel.text]) {
                                ballView.selected = YES;
                            }
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"02"]) {
                    if ([array containsObject:ballView.numLabel.text]) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa isEqualToString:@"03"]) {
                    if ([array containsObject:ballView.numLabel.text]) {
                        ballView.selected = YES;
                    }
                }
            }
        }
        else if ([self.mylotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [self.mylotteryId isEqualToString:@"119"] || [self.mylotteryId isEqualToString:@"121"] || [self.mylotteryId isEqualToString:@"123"] || [self.mylotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) {//11选5 121是广东11选5
            ballView.selected = NO;
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@","];
                if ([self.wanfa intValue] >= 2 &&[self.wanfa intValue] <= 8) {
                    if ([array containsObject:ballView.numLabel.text]) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa intValue] == 9 || [self.wanfa intValue] == 10 || ([self.wanfa intValue] == 11 && [self.mylotteryId isEqualToString:LOTTERY_ID_JIANGXI_11]) || (([self.mylotteryId isEqualToString:LOTTERY_ID_SHANDONG_11] || [self.mylotteryId isEqualToString:LOTTERY_ID_GUANGDONG_11]|| [self.mylotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) &&[self.wanfa intValue] == 1)){
                    
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    if (shuziwei < [array count]) {
                        if ([[array objectAtIndex:shuziwei] isEqualToString:ballView.numLabel.text]) {
                            ballView.selected = YES;
                        }
                    }
                    
                }
                else if (([self.wanfa intValue] == 12 && [self.mylotteryId isEqualToString:LOTTERY_ID_JIANGXI_11]) || ([self.wanfa intValue] == 11 && ([self.mylotteryId isEqualToString:LOTTERY_ID_SHANDONG_11] || [self.mylotteryId isEqualToString:LOTTERY_ID_GUANGDONG_11]|| [self.mylotteryId isEqualToString:LOTTERY_ID_SHANXI_11]))) {
                    
                    if ([array count] >= 3) {
                        NSArray *array2 = [NSArray arrayWithObjects:[array objectAtIndex:0],[array objectAtIndex:1], nil];
                        if ([array2 containsObject:ballView.numLabel.text]) {
                            ballView.selected = YES;
                        }
                    }
                }
                else if (([self.wanfa intValue] == 13 && [self.mylotteryId isEqualToString:LOTTERY_ID_JIANGXI_11]) || ([self.wanfa intValue] == 12 && ([self.mylotteryId isEqualToString:LOTTERY_ID_SHANDONG_11] || [self.mylotteryId isEqualToString:LOTTERY_ID_GUANGDONG_11 ]|| [self.mylotteryId isEqualToString:LOTTERY_ID_SHANXI_11]))) {
                    if ([array count] >= 3) {
                        NSArray *array2 = [NSArray arrayWithObjects:[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2], nil];
                        if ([array2 containsObject:ballView.numLabel.text]) {
                            ballView.selected = YES;
                        }
                    }
                }
            }
            
        }
        else if ([self.mylotteryId isEqualToString:@"006"]) {//时时彩
            ballView.selected = NO;
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@","];
                if ([self.wanfa intValue] >= 1 && [self.wanfa intValue] <= 5){//一星复式-五星复式
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    NSInteger wan = [self.wanfa intValue];//几位的玩法
                    if (shuziwei < wan && wan -shuziwei <= [array count]) {
                        if ([[array objectAtIndex:shuziwei + [array count] - wan] isEqualToString:[NSString stringWithFormat:@"0%@",ballView.numLabel.text]]) {
                            ballView.selected = YES;
                        }
                    }
                
                }
                else if ([self.wanfa isEqualToString:@"06"]) {//二星组选
                    if ([array count] >= 5) {
                        NSArray *array2 = [NSArray arrayWithObjects:[array objectAtIndex:3],[array objectAtIndex:4], nil];
                        if ([array2 containsObject:[NSString stringWithFormat:@"0%@",ballView.numLabel.text]]) {
                            ballView.selected = YES;
                        }
                    }
                }
                else if ([self.wanfa intValue] >= 20 && [self.wanfa intValue] <= 22) {//任选一到任选三
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    if (shuziwei < [array count]) {
                        if ([[array objectAtIndex:shuziwei] isEqualToString:[NSString stringWithFormat:@"0%@",ballView.numLabel.text]]) {
                            ballView.selected = YES;
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"14"]) {
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    if (shuziwei < [array count]) {
                        if ([[array objectAtIndex:shuziwei] isEqualToString:[NSString stringWithFormat:@"0%@",ballView.numLabel.text]]) {
                            ballView.selected = YES;
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"23"]) {
                    ballView.numLabel.text = [self changeDaxiaoDanshuang:ballView.numLabel.text];
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    NSInteger wan = 2;
                    if (shuziwei < wan && wan -shuziwei <= [array count]) {
                        [self changeColor:ballView jiang:[array objectAtIndex:shuziwei + [array count] - wan]];
                    }

                }
            }
            else {
                if ([self.wanfa isEqualToString:@"23"]) {
                    ballView.numLabel.text = [self changeDaxiaoDanshuang:ballView.numLabel.text];
                }
            }
            
        }
        else if ([self.mylotteryId isEqualToString:@"014"]) {//重庆时时彩
            ballView.selected = NO;
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@","];
                if ([self.wanfa intValue] >= 1 && [self.wanfa intValue] <= 5){//一星复式-五星复式
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    NSInteger wan = [self.wanfa intValue];//几位的玩法
                    if (shuziwei < wan && wan -shuziwei <= [array count]) {
                        if ([[array objectAtIndex:shuziwei + [array count] - wan] isEqualToString:ballView.numLabel.text]) {
                            ballView.selected = YES;
                        }
                    }
                    
                }
                else if ([self.wanfa isEqualToString:@"06"]) {//二星组选
                    if ([array count] >= 5) {
                        NSArray *array2 = [NSArray arrayWithObjects:[array objectAtIndex:3],[array objectAtIndex:4], nil];
                        if ([array2 containsObject:[NSString stringWithFormat:@"%@",ballView.numLabel.text]]) {
                            ballView.selected = YES;
                        }
                    }
                }
                else if ([self.wanfa intValue] >= 20 && [self.wanfa intValue] <= 22) {//任选一到任选三
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    if (shuziwei < [array count]) {
                        if ([[array objectAtIndex:shuziwei] isEqualToString:ballView.numLabel.text]) {
                            ballView.numLabel.textColor = [UIColor redColor];
                            ballView.selected = YES;
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"14"]) {
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    if (shuziwei < [array count]) {
                        if ([[array objectAtIndex:shuziwei] isEqualToString:ballView.numLabel.text]) {
                            ballView.numLabel.textColor = [UIColor redColor];
                            ballView.selected = YES;
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"23"]) {
                    ballView.numLabel.text = [self changeDaxiaoDanshuang:ballView.numLabel.text];
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    NSInteger wan = 2;
                    if (shuziwei < wan && wan -shuziwei <= [array count]) {
                        [self changeColor:ballView jiang:[array objectAtIndex:shuziwei + [array count] - wan]];
                    }
                    
                }
            }
            else {
                if ([self.wanfa isEqualToString:@"23"]) {
                    ballView.numLabel.text = [self changeDaxiaoDanshuang:ballView.numLabel.text];
                    
                }
            }
            
        }
        else if ([self.mylotteryId isEqualToString:@"011"]) {//快乐十分
            ballView.selected = NO;
            if ([self.wanfa isEqualToString:@"11"]) {//猜大数
                if (!ballView.numLabel3) {
                    UILabel *lable = [[UILabel alloc] init];
                    ballView.numLabel3 = lable;
                    [lable release];
                    ballView.numLabel3.text = [SharedMethod changeFontWithString:@"个"];
                    ballView.numLabel3.backgroundColor =[UIColor clearColor];
                    ballView.numLabel3.userInteractionEnabled = NO;
                    ballView.numLabel3.font = [UIFont fontWithName:@"TRENDS" size:13];
                    ballView.numLabel3.textColor = ballView.numLabel3.textColor;
                    ballView.numLabel3.textAlignment = 0;
                    ballView.numLabel3.frame = CGRectMake(17, 0, 15, 25);
                    [ballView addSubview:ballView.numLabel3];
                }
                ballView.numLabel.textColor = ballView.numLabel3.textColor = [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
                ballView.frame = CGRectMake(15, 5, 35, 25);
                ballView.numLabel.frame = CGRectMake(2, 0, 20, 25);
                ballView.numLabel.font = [UIFont systemFontOfSize:16];
                [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDabai.png") forState:UIControlStateNormal];
                [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDahong.png") forState:UIControlStateSelected];
                ballView.numLabel.text = [NSString stringWithFormat:@"%d",(int)[ballView.numLabel.text integerValue]];

            }
            else if ([self.wanfa isEqualToString:@"12"]) {//猜单数
                if (!ballView.numLabel3) {
                    UILabel *lable = [[UILabel alloc] init];
                    ballView.numLabel3 = lable;
                    [lable release];
                    ballView.numLabel3.text = [SharedMethod changeFontWithString:@"个"];
                    ballView.numLabel3.backgroundColor =[UIColor clearColor];
                    ballView.numLabel3.userInteractionEnabled = NO;
                    ballView.numLabel3.font = [UIFont fontWithName:@"TRENDS" size:13];
                    ballView.numLabel3.textColor = ballView.numLabel3.textColor;
                    ballView.numLabel3.textAlignment = 0;
                    ballView.numLabel3.frame = CGRectMake(17, 0, 15, 25);
                    [ballView addSubview:ballView.numLabel3];
                }
                ballView.numLabel.textColor = ballView.numLabel3.textColor = [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
                ballView.frame = CGRectMake(15, 5, 35, 25);
                ballView.numLabel.frame = CGRectMake(2, 0, 20, 25);
                ballView.numLabel.font = [UIFont systemFontOfSize:16];
                [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDabai.png") forState:UIControlStateNormal];
                [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDahong.png") forState:UIControlStateSelected];
                ballView.numLabel.text = [NSString stringWithFormat:@"%d",(int)[ballView.numLabel.text integerValue]];
            }
            else if ([self.wanfa isEqualToString:@"13"]) {//猜全数
                ballView.numLabel.text = [SharedMethod changeFontWithString:@"全数"];
                ballView.frame = CGRectMake(15, 5, 35, 25);
                ballView.numLabel.frame = ballView.bounds;
                ballView.numLabel.textColor = [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
                ballView.numLabel.font = [UIFont fontWithName:@"TRENDS" size:13];
                [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDabai.png") forState:UIControlStateNormal];
                [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDahong.png") forState:UIControlStateSelected];
            }
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@","];
                if ([self.wanfa intValue] >= 7 && [self.wanfa intValue] <= 10) {//任二到任五
                    if ([array containsObject:ballView.numLabel.text]) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa isEqualToString:@"03"] || [self.wanfa isEqualToString:@"04"]) {//选2连组和连直
                    if ([array containsObject:ballView.numLabel.text]) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa isEqualToString:@"05"] || [self.wanfa isEqualToString:@"06"]) {////选3前组和前直
                    if ([array containsObject:ballView.numLabel.text]) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa isEqualToString:@"01"]) {//数投
                    if ([[array objectAtIndex:0] isEqualToString:ballView.numLabel.text]) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa isEqualToString:@"02"]) {//红投
                    if ([[array objectAtIndex:0] intValue] >= 19) {
                        ballView.selected = YES;
                    }
                    
                }
                else if ([self.wanfa isEqualToString:@"11"]) {//猜大数
                    int big = 0;
                    [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDabai.png") forState:UIControlStateNormal];
                    [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDahong.png") forState:UIControlStateSelected];
                    for (int j = 0; j < [array count]; j ++) {
                        if ([[array objectAtIndex:j] intValue] >= 11) {
                            big ++;
                        }
                    
                    }
                    if (big == [ballView.numLabel.text intValue]) {
                        ballView.selected = YES;
                        ballView.numLabel3.textColor = [UIColor whiteColor];
                    }
                    else {
                        ballView.numLabel.textColor = [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
                        ballView.numLabel3.textColor = ballView.numLabel.textColor;
                    }
                }
                else if ([self.wanfa isEqualToString:@"12"]) {//猜单数
                    int dan = 0;
                    [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDabai.png") forState:UIControlStateNormal];
                    [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDahong.png") forState:UIControlStateSelected];
                    for (int j = 0; j < [array count]; j ++) {
                        if ([[array objectAtIndex:j] intValue] % 2) {
                            dan ++;
                        }
                        
                    }
                    if (dan == [ballView.numLabel.text intValue]) {
                        ballView.selected = YES;
                        ballView.numLabel3.textColor = [UIColor whiteColor];
                    }
                    else {
                        ballView.numLabel.textColor = [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
                        ballView.numLabel3.textColor = ballView.numLabel.textColor;
                    }
                    
                }
                else if ([self.wanfa isEqualToString:@"13"]) {//猜全数

                    [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDabai.png") forState:UIControlStateNormal];
                    [ballView setBackgroundImage:UIImageGetImageFromName(@"KuaileDahong.png") forState:UIControlStateSelected];
                    BOOL isQuan = NO;
                    for (int j = 0; j < [array count]; j ++) {
                        if ([[array objectAtIndex:j] intValue] >= 19) {
                            isQuan = NO;
                            break;
                        }
                        isQuan = YES;
                    }
                    ballView.selected = isQuan;
                    if (!isQuan) {
                        ballView.numLabel.textColor = [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
                    }
                    ballView.numLabel3.textColor = ballView.numLabel.textColor;
                    
                }
                
            }
        }
        else if ([self.mylotteryId isEqualToString:@"012"] ||[self.mylotteryId isEqualToString:@"013"] || [self.mylotteryId isEqualToString:@"019"] || [self.mylotteryId isEqualToString:LOTTERY_ID_JILIN] || [self.mylotteryId isEqualToString:LOTTERY_ID_ANHUI]) {//内蒙古和江苏快三
            if (isHeZhi ||[self.wanfa isEqualToString:@"01"]) {//和值
                GCBallView *ballView = (GCBallView *)[self.contentView viewWithTag:i + 100];
                int a = i/8,b = i%8;
                if (!ballView) {
                    ballView = [[GCBallView alloc] initWithFrame:CGRectMake(15+38*b, 9+36*a, 33, 33) Num:@" " ColorType:GCBallViewColorRed];
                    ballView.backgroundColor =[UIColor clearColor];
                    ballView.userInteractionEnabled = NO;
                    ballView.selected = NO;
                    ballView.tag = 100 +i;
                    [self.contentView addSubview:ballView];
                    [ballView release];
                }
                [ballView changeTo:GCBallViewColorRed];
                ballView.hidden = NO;
                ballView.selected = NO;
                ballView.numLabel.text = [NSString stringWithFormat:@"%d",(int)[[redArray objectAtIndex:i] integerValue]];
                
            }
            else if ([self.wanfa isEqualToString:@"02"]) {//三同号单选
                int a = i/8,b = i%8;
                UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                if (!shaiziImageV) {
                    shaiziImageV = [[UIImageView alloc] initWithFrame:CGRectMake(36 * b + 15, 8 + 36 *a , 26, 26)];
                    [self.contentView addSubview:shaiziImageV];
                    [shaiziImageV release];
                    shaiziImageV.tag = 200 +i;
                }
                shaiziImageV.hidden = NO;
                NSString *imageName = [NSString stringWithFormat:@"xqshaizi%@.png",[redArray objectAtIndex:i]];
                shaiziImageV.image = UIImageGetImageFromName(imageName);
            }
            else if ([self.wanfa isEqualToString:@"04"]) {//三同号通选
                if (i == 0) {
                    UILabel *numLabel = (UILabel *)[self.contentView viewWithTag:i + 200];
                    int a = i/8,b = i%8;
                    if (!numLabel) {
                        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+30*b, 9+36*a, 100, 26)];
                        numLabel.backgroundColor =[UIColor clearColor];
                        numLabel.userInteractionEnabled = NO;
                        numLabel.tag = 200 +i;
                        numLabel.textAlignment = NSTextAlignmentLeft;
                        [self.contentView addSubview:numLabel];
                        [numLabel release];
                        
                    }
                    numLabel.hidden = NO;
                    numLabel.textColor = [UIColor colorWithRed:111/255.0 green:111/255.0 blue:111/255.0 alpha:1];
                    numLabel.text = @"三同号通选";
                }
            }
            else if ([self.wanfa isEqualToString:@"03"]) {//三连号通选
                if (i == 0) {
                    UILabel *numLabel = (UILabel *)[self.contentView viewWithTag:i + 200];
                    int a = i/8,b = i%8;
                    if (!numLabel) {
                        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+30*b, 9+36*a, 100, 26)];
                        numLabel.backgroundColor =[UIColor clearColor];
                        numLabel.userInteractionEnabled = NO;
                        numLabel.tag = 200 +i;
                        numLabel.textAlignment = NSTextAlignmentLeft;
                        [self.contentView addSubview:numLabel];
                        [numLabel release];
                        
                    }
                    numLabel.hidden = NO;
                    numLabel.textColor = [UIColor colorWithRed:111/255.0 green:111/255.0 blue:111/255.0 alpha:1];
                    numLabel.text = @"三连号通选";
                }
            }
            else if ([self.wanfa isEqualToString:@"05"]) {//三不同号
                a = i / 8,b = i %8;
                if (fengewei > 0) {
                    a = (i +fengewei)/8,b= (i + fengewei)%8;
                }
                UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                if (!shaiziImageV) {
                    shaiziImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15+36*b, 12 +36*a, 26, 26)];
                    [self.contentView addSubview:shaiziImageV];
                    [shaiziImageV release];
                    shaiziImageV.tag = 200 +i;
                }
                shaiziImageV.hidden = NO;
                NSString *imageName = [NSString stringWithFormat:@"xqshaizi%@.png",[redArray objectAtIndex:i]];
                shaiziImageV.image = UIImageGetImageFromName(imageName);
            }
            else if ([self.wanfa isEqualToString:@"08"]) {//二不同号
                a = i / 8,b = i %8;

                if (fengewei > 0) {
                    a = (i + fengewei)/8,b= (i + fengewei)%8;
                }
                UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                if (!shaiziImageV) {
                    shaiziImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15+36*b, 12+36*a, 26, 26)];
                    [self.contentView addSubview:shaiziImageV];
                    [shaiziImageV release];
                    shaiziImageV.tag = 200 +i;
                }
                shaiziImageV.hidden = NO;
                NSString *imageName = [NSString stringWithFormat:@"xqshaizi%@.png",[redArray objectAtIndex:i]];
                shaiziImageV.image = UIImageGetImageFromName(imageName);
            }
            else if ([self.wanfa isEqualToString:@"07"]) {//二同号复选
                a = i / 3,b = i %3;
                UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                if (!shaiziImageV) {
                    shaiziImageV = [[UIImageView alloc] initWithFrame:CGRectMake(90 * b + 15, 8 + 36 *a , 26, 26)];
                    [self.contentView addSubview:shaiziImageV];
                    [shaiziImageV release];
                    shaiziImageV.tag = 200 +i;
                    UIImageView *shaizi2 = [[UIImageView alloc] initWithFrame:CGRectMake(28, 0, 26, 26)];
                    [shaiziImageV addSubview:shaizi2];
                    shaizi2.tag = 301;
                    [shaizi2 release];
                }
                shaiziImageV.hidden = NO;
                UIImageView *shaizi2 = (UIImageView *)[shaiziImageV viewWithTag:301];
                NSString *imageName = [NSString stringWithFormat:@"xqshaizi%d.png",[[redArray objectAtIndex:i] intValue] % 10];
                shaiziImageV.image = UIImageGetImageFromName(imageName);
                shaizi2.image = shaiziImageV.image;
            }
            else if ([self.wanfa isEqualToString:@"06"]) {//二同号单选
                a = i / 3,b = i %3;
                UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                if (!shaiziImageV) {
                    shaiziImageV = [[UIImageView alloc] initWithFrame:CGRectMake(105 * b + 15, 8 + 36 *a , 26, 26)];
                    [self.contentView addSubview:shaiziImageV];
                    [shaiziImageV release];
                    shaiziImageV.tag = 200 +i;
                    UIImageView *shaizi2 = [[UIImageView alloc] initWithFrame:CGRectMake(28, 0, 26, 26)];
                    [shaiziImageV addSubview:shaizi2];
                    shaizi2.tag = 301;
                    [shaizi2 release];
                }
                shaiziImageV.hidden = NO;
                shaiziImageV.frame = CGRectMake(100 * b + 15, 8 + 36 *a , 26, 26);
                UIImageView *shaizi2 = (UIImageView *)[shaiziImageV viewWithTag:301];
                NSString *imageName = [NSString stringWithFormat:@"xqshaizi%d.png",[[redArray objectAtIndex:i] intValue] % 10];
                shaiziImageV.image = UIImageGetImageFromName(imageName);
                shaizi2.image = shaiziImageV.image;
                shaizi2.hidden = NO;
                if (i < [[fengeArray objectAtIndex:0] intValue]) {
                    
                }
                else {
                    a = ([[fengeArray objectAtIndex:0] intValue] * 2 + i) / 8, b = ([[fengeArray objectAtIndex:0] intValue] * 2 + i) % 8;
                    if ([[fengeArray objectAtIndex:0] intValue] >= 3) {
                        b = b -1;
                    }
                    shaiziImageV.frame = CGRectMake(15+35*b, 9+36*a, 26, 26);
                    shaizi2.hidden = YES;
                }
            }
            if (self.zhongjiang) {
                NSArray *array = [self.zhongjiang componentsSeparatedByString:@","];
                if (isHeZhi || [self.wanfa isEqualToString:@"01"]) {//和值
                    NSInteger he = 0;
                    GCBallView *ballView = (GCBallView *)[self.contentView viewWithTag:i + 100];
                    for (NSString *num in array) {
                        he = he + [num intValue];
                    }
                    if ([ballView.numLabel.text intValue] == he) {
                        ballView.selected = YES;
                    }
                }
                else if ([self.wanfa isEqualToString:@"02"]) {//三同号单选
                    if ([array count] == 3 && [[array objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"0%@",[redArray objectAtIndex:i]]] && [[array objectAtIndex:1] isEqualToString:[NSString stringWithFormat:@"0%@",[redArray objectAtIndex:i]]] &&[[array objectAtIndex:2] isEqualToString:[NSString stringWithFormat:@"0%@",[redArray objectAtIndex:i]]]) {
                        UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                        NSString *imageName = [NSString stringWithFormat:@"xqshaizi0%@.png",[redArray objectAtIndex:i]];
                        shaiziImageV.image = UIImageGetImageFromName(imageName);
                    }
                }
                else if ([self.wanfa isEqualToString:@"04"]) {//三同号通选
                    UILabel *numLabel = (UILabel *)[self.contentView viewWithTag:200];
                    NSString *jiang = [self.zhongjiang stringByReplacingOccurrencesOfString:@",0" withString:@""];
                    if ([jiang intValue] == [numLabel.text intValue]) {
                        numLabel.textColor = [UIColor redColor];
                    }
                    else if ([numLabel.text isEqualToString:@"三同号通选"]) {
                        NSArray *jiangArray = [self.zhongjiang componentsSeparatedByString:@","];
                        if ([jiangArray count] >= 3) {
                            if ([[jiangArray objectAtIndex:0] isEqualToString:[jiangArray objectAtIndex:1]] && [[jiangArray objectAtIndex:0] isEqualToString:[jiangArray objectAtIndex:2]]) {
                                numLabel.textColor = [UIColor redColor];
                            }
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"03"]) {//三连号通选
                    UILabel *numLabel = (UILabel *)[self.contentView viewWithTag:200];
                    NSMutableArray *randBalls = [NSMutableArray array];
                    for (NSString *rs in array) {
                        if ([array count]) {
                            if ([randBalls count] == 0 ||[rs intValue] > [[randBalls lastObject] intValue]) {
                                [randBalls addObject:rs];
                            }
                            else {
                                int a=0;
                                for (int i = 0; i < [randBalls count] -1; i++) {
                                    if ([rs intValue]>[[randBalls objectAtIndex:i] intValue] &&[rs intValue]<[[randBalls objectAtIndex:i + 1] intValue]) {
                                        a= i+1 ;
                                        i = (int)[randBalls count];
                                    }
                                }
                                [randBalls insertObject:rs atIndex:a];
                            }
                        }
                    }
                    if ([numLabel.text isEqualToString:[[randBalls componentsJoinedByString:@""] stringByReplacingOccurrencesOfString:@"0" withString:@""]]) {
                        numLabel.textColor = [UIColor redColor];
                    }
                    else if ([numLabel.text isEqualToString:@"三连号通选"]) {
                        if ([randBalls count] >=3 && [[randBalls objectAtIndex:0] intValue] + 1 == [[randBalls objectAtIndex:1] intValue] &&
                            [[randBalls objectAtIndex:1] intValue] +1 == [[randBalls objectAtIndex:2] intValue]) {
                            numLabel.textColor = [UIColor redColor];
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"05"]) {//三不同号
                    if ([array containsObject:[NSString stringWithFormat:@"0%@",[redArray objectAtIndex:i]]]) {
                        UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                        NSString *imageName = [NSString stringWithFormat:@"xqshaizi0%d.png",[[redArray objectAtIndex:i] intValue] % 10];
                        shaiziImageV.image = UIImageGetImageFromName(imageName);
                    }
                }
                else if ([self.wanfa isEqualToString:@"08"]) {//二不同号
                    if ([array containsObject:[NSString stringWithFormat:@"0%@",[redArray objectAtIndex:i]]]) {
                        UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                        NSString *imageName = [NSString stringWithFormat:@"xqshaizi0%d.png",[[redArray objectAtIndex:i] intValue] % 10];
                        shaiziImageV.image = UIImageGetImageFromName(imageName);
                    }
                }
                else if ([self.wanfa isEqualToString:@"07"]) {//二同号复选
                    NSInteger tong = 0;
                    for (NSString *st in array) {
                        if ([[redArray objectAtIndex:i] integerValue] % 10 == [st integerValue]) {
                            tong = tong + 1;
                        }
                    }
                    if (tong >= 2) {
                        UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                        NSString *imageName = [NSString stringWithFormat:@"xqshaizi0%d.png",[[redArray objectAtIndex:i] intValue] % 10];
                        shaiziImageV.image = UIImageGetImageFromName(imageName);
                        UIImageView *shaizi2 = (UIImageView *)[shaiziImageV viewWithTag:301];
                        shaizi2.image = shaiziImageV.image;
                    }
                }
                else if ([self.wanfa isEqualToString:@"06"]) {//二同号单选
                    if (shuziwei < [fengeArray count] &&i + 1 > [[fengeArray objectAtIndex:shuziwei] integerValue]) {
                        shuziwei ++;
                    }
                    if (shuziwei == 0) {
                        NSInteger tong = 0;
                        for (NSString *st in array) {
                            if ([[redArray objectAtIndex:i] integerValue] % 10 == [st integerValue]) {
                                tong = tong + 1;
                            }
                        }
                        if (tong == 2) {
//                            numLabel.textColor = [UIColor redColor];
                            UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                            NSString *imageName = [NSString stringWithFormat:@"xqshaizi0%d.png",[[redArray objectAtIndex:i] intValue] % 10];
                            shaiziImageV.image = UIImageGetImageFromName(imageName);
                            UIImageView *shaizi2 = (UIImageView *)[shaiziImageV viewWithTag:301];
                            shaizi2.image = shaiziImageV.image;
                        }
                    }
                    else {
                        NSInteger tong = 0;
                        for (NSString *st in array) {
                            if ([[redArray objectAtIndex:i] intValue] % 10 == [st integerValue]) {
                                tong = tong + 1;
                            }
                        }
                        if (tong == 1) {
                            UIImageView *shaiziImageV = (UIImageView *)[self.contentView viewWithTag:i + 200];
                            NSString *imageName = [NSString stringWithFormat:@"xqshaizi0%d.png",[[redArray objectAtIndex:i] intValue] % 10];
                            shaiziImageV.image = UIImageGetImageFromName(imageName);
//                            numLabel.textColor = [UIColor redColor];
                        }
                    }
                }
            }
            
        }
        else if ([self.mylotteryId isEqualToString:@"122"]) {//快乐扑克
            UILabel *numLabel = (UILabel *)[self.contentView viewWithTag:i + 200];
            int a = i/8,b = i%8;
            if (!numLabel) {
                numLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+30*b, 9+36*a, 25, 33)];
                numLabel.backgroundColor =[UIColor clearColor];
                numLabel.userInteractionEnabled = NO;
                numLabel.tag = 200 +i;
                numLabel.textAlignment = NSTextAlignmentCenter;
                [self.contentView addSubview:numLabel];
                [numLabel release];
                
            }
            numLabel.hidden = NO;
            numLabel.textColor = [UIColor colorWithRed:111/255.0 green:111/255.0 blue:111/255.0 alpha:1];
            numLabel.text =[redArray objectAtIndex:i];
            numLabel.text = [self changePuke:numLabel.text];
            numLabel.frame = CGRectMake(15+30*b, 9+36*a, 25, 33);
            if ([self.wanfa intValue] <= 2) {
                UIImageView *image = (UIImageView *)[self.contentView viewWithTag: 32222];
                if (!image) {
                    image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 25, 33)];
                    [self.contentView addSubview:image];
                    image.backgroundColor = [UIColor clearColor];
                    image.tag =32222;
                    [image release];
                }
                
                image.hidden = NO;
                if ([numLabel.text isEqualToString:@"包选"]) {
                    image.hidden = YES;
                    if ([self.wanfa intValue] == 2) {
                        numLabel.text = @"同花顺包选";
                    }
                    else if ([self.wanfa intValue] == 1) {
                        numLabel.text = @"同花包选";
                    }
                    numLabel.frame = CGRectMake(22+35*b, 9+20*a, 100, 30);
                }
                else if ([numLabel.text isEqualToString:@"黑桃"]) {
                    image.image = UIImageGetImageFromName(@"pukexq_5.png");
                    numLabel.frame = CGRectMake(22+25, 9, 35, 30);
                }
                else if ([numLabel.text isEqualToString:@"红桃"]) {
                    image.image = UIImageGetImageFromName(@"pukexq_6.png");
                    numLabel.frame = CGRectMake(22+ 25, 9, 35, 30);
                }
                else if ([numLabel.text isEqualToString:@"梅花"]) {
                    image.image = UIImageGetImageFromName(@"pukexq_7.png");
                    numLabel.frame = CGRectMake(22+25, 9, 35, 30);
                }
                else if ([numLabel.text isEqualToString:@"方块"]) {
                    image.image = UIImageGetImageFromName(@"pukexq_8.png");
                    numLabel.frame = CGRectMake(22+ 25, 9, 35, 30);
                }
                else {
                    image.hidden = YES;
                    numLabel.frame = CGRectMake(22+35*b, 9+20*a, 35, 30);
                }
            }
            else if ([self.wanfa intValue] >= 6 && [self.wanfa intValue] <= 11) {
                UIImageView *imageV = (UIImageView *)[self.contentView viewWithTag: 300+i];
                if (!imageV) {
                    imageV = [[UIImageView alloc] init];
                    imageV.backgroundColor = [UIColor clearColor];
                    imageV.tag = 300 + i;
                    imageV.frame = numLabel.frame;
                    [self.contentView insertSubview:imageV belowSubview:numLabel];
                    [imageV release];
                }
                imageV.image = UIImageGetImageFromName(@"pukexq_0.png");
            }
            else if ([self.wanfa intValue] == 3 || [self.wanfa intValue] == 4) {
                a = i / 2,b = i %2;
                numLabel.frame = CGRectMake(127 * b + 15, 5 + 36 *a , 25, 33);
                UIImageView *imageV = (UIImageView *)[self.contentView viewWithTag: 1000+i];
                if (!imageV) {
                    imageV = [[UIImageView alloc] init];
                    imageV.backgroundColor = [UIColor clearColor];
                    imageV.tag = 1000+i;
                    imageV.frame = numLabel.frame;
                    [self.contentView insertSubview:imageV belowSubview:numLabel];
                    [imageV release];
                }
                imageV.hidden = NO;
                if ([imageV isKindOfClass:[UIImageView class]]) {
                    imageV.image = UIImageGetImageFromName(@"pukexq_0.png");
                }
                
                for (UIView *v2 in imageV.subviews){
                    v2.hidden = YES;
                }
                if ([numLabel.text isEqualToString:@"包选"]) {
                    if ([self.wanfa intValue] == 3) {
                        numLabel.text = @"顺子包选";
                    }else {
                        numLabel.text = @"豹子包选";
                    }
                    
                    imageV.hidden = YES;
                    numLabel.frame = CGRectMake(15, 9, 80, 30);
                }
                else {
                    if ([numLabel.text length] >= 3) {
                        NSString *yi = [numLabel.text substringWithRange:NSMakeRange(0, 1)];
                        NSString *er = [numLabel.text substringWithRange:NSMakeRange(1, 1)];
                        NSString *san = [numLabel.text substringWithRange:NSMakeRange(2, 1)];
                        if ([yi isEqualToString:@"*"]) {
                            yi = @"10";
                        }
                        else if ([er isEqualToString:@"*"]) {
                            er = @"10";
                        }
                        if ([san isEqualToString:@"*"]) {
                            san = @"10";
                        }
                        if ([numLabel.text length] == 6) {
                            yi = [numLabel.text substringWithRange:NSMakeRange(0, 2)];
                            er = [numLabel.text substringWithRange:NSMakeRange(2, 2)];
                            san = [numLabel.text substringWithRange:NSMakeRange(4, 2)];
                            
                        }
                        numLabel.text = yi;
                        UIImageView *image2 = (UIImageView *)[imageV viewWithTag:301];
                        if (!image2) {
                            image2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, imageV.bounds.size.width, imageV.bounds.size.height)];
                            [imageV addSubview:image2];
                            image2.tag = 301;
                            image2.image = UIImageGetImageFromName(@"pukexq_0.png");
                            [image2 release];
                        }
                        image2.hidden = NO;
                        UILabel *label2 = (UILabel *)[imageV viewWithTag:302];
                        if (!label2) {
                            label2 = [[UILabel alloc] initWithFrame:image2.frame];
                            [imageV addSubview:label2];
                            label2.tag = 302;
                            label2.backgroundColor = [UIColor clearColor];
                            label2.textAlignment = NSTextAlignmentCenter;
                            label2.font = numLabel.font;
                            [label2 release];
                        }
                        label2.textColor = numLabel.textColor;
                        label2.hidden = NO;
                        label2.text = er;
                        
                        UIImageView *image3 = (UIImageView *)[imageV viewWithTag:401];
                        if (!image3) {
                            image3 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 0, imageV.bounds.size.width, imageV.bounds.size.height)];
                            [imageV addSubview:image3];
                            image3.tag = 401;
                            image3.image = UIImageGetImageFromName(@"pukexq_0.png");
                            [image3 release];
                        }
                        image3.hidden = NO;
                        UILabel *label3 = (UILabel *)[imageV viewWithTag:402];
                        if (!label3) {
                            label3 = [[UILabel alloc] initWithFrame:image3.frame];
                            [imageV addSubview:label3];
                            
                            label3.hidden = 402;
                            label3.backgroundColor = [UIColor clearColor];
                            label3.textAlignment = NSTextAlignmentCenter;
                            label3.font = numLabel.font;
                            [label3 release];
                            
                        }
                        label3.textColor = numLabel.textColor;
                        label3.hidden = NO;
                        label3.text = san;
                        
                    }
                }
            }
            else if ([self.wanfa intValue] == 5) {//对子
                a = i / 3,b = i %3;
                numLabel.frame = CGRectMake(104 * b + 15, 5 + 36 *a , 25, 33);
                UIImageView *imageV = (UIImageView *)[self.contentView viewWithTag: 1000+i];
                if (!imageV) {
                    imageV = [[UIImageView alloc] init];
                    imageV.backgroundColor = [UIColor clearColor];
                    imageV.tag = 1000 + i;
                    imageV.frame = numLabel.frame;
                    [self.contentView insertSubview:imageV belowSubview:numLabel];
                    [imageV release];
                }
                imageV.hidden = NO;
                imageV.image = UIImageGetImageFromName(@"pukexq_0.png");
                for (UIView *v2 in imageV.subviews){
                    v2.hidden = YES;
                }
                if ([numLabel.text isEqualToString:@"包选"]) {
                    numLabel.text = @"对子包选";
                    imageV.hidden = YES;
                    numLabel.frame = CGRectMake(15, 9, 80, 30);
                }
                else {
                    if ([numLabel.text length] >= 2) {
                        NSString *yi = [numLabel.text substringWithRange:NSMakeRange(0, 1)];
                        NSString *er = [numLabel.text substringWithRange:NSMakeRange(1, 1)];
                        if ([numLabel.text length] == 4) {
                            yi = [numLabel.text substringWithRange:NSMakeRange(0, 2)];
                            er = [numLabel.text substringWithRange:NSMakeRange(2, 2)];
                        }
                        numLabel.text = yi;
                        
                        UIImageView *image2 = (UIImageView *)[imageV viewWithTag:301];
                        if (!image2) {
                            image2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, imageV.bounds.size.width, imageV.bounds.size.height)];
                            [imageV addSubview:image2];
                            image2.tag = 301;
                            image2.image = UIImageGetImageFromName(@"pukexq_0.png");
                            [image2 release];
                        }
                        image2.hidden = NO;
                        UILabel *label2 = (UILabel *)[imageV viewWithTag:302];
                        if (!label2) {
                            label2 = [[UILabel alloc] initWithFrame:image2.frame];
                            [imageV addSubview:label2];
                            label2.tag = 302;
                            label2.backgroundColor = [UIColor clearColor];
                            label2.textAlignment = NSTextAlignmentCenter;
                            label2.font = numLabel.font;
                            [label2 release];
                        }
                        label2.textColor = numLabel.textColor;
                        label2.hidden = NO;
                        label2.text = er;
                        
                    }
                }
            }
            if (self.zhongjiang && [pukeArray count] >= 7) {
                if ([self.wanfa isEqualToString:@"04"]) {//豹子变红
                    if ([[pukeArray objectAtIndex:6] isEqualToString:@"豹子"]) {
                        if ([numLabel.text isEqualToString:@"豹子包选"]) {
                            numLabel.textColor = [UIColor redColor];
                        }
                        else if ([[pukeArray objectAtIndex:0] intValue] ==[[redArray objectAtIndex:i] intValue]) {
                            numLabel.textColor =[UIColor redColor];
                            UIImageView *ImageV = (UIImageView *)[self.contentView viewWithTag:1000 + i];
                            UILabel *label1 = (UILabel *)[ImageV viewWithTag:302];
                            UILabel *label2 = (UILabel *)[ImageV viewWithTag:402];
                            label1.textColor = numLabel.textColor;
                            label2.textColor = numLabel.textColor;
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"01"]) {//同花
                    if ([[pukeArray objectAtIndex:6] isEqualToString:@"同花"] || [[pukeArray objectAtIndex:6] isEqualToString:@"同花顺"]) {
                        UIImageView *image = (UIImageView *)[self.contentView viewWithTag: 32222];
                        if ([numLabel.text isEqualToString:@"同花包选"]) {
                            numLabel.textColor = [UIColor redColor];
                        }
                        else if ([[redArray objectAtIndex:i] intValue] == [[pukeArray objectAtIndex:4] intValue]) {
                            numLabel.textColor = [UIColor redColor];
                            NSString *pic = [NSString stringWithFormat:@"pukexq_%d.png",[[pukeArray objectAtIndex:4] intValue]];
                            image.image = UIImageGetImageFromName(pic);
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"02"]) {//同花顺
                    if ([[pukeArray objectAtIndex:6] isEqualToString:@"同花顺"]) {
                        UIImageView *image = (UIImageView *)[self.contentView viewWithTag: 32222];
                        if ([numLabel.text isEqualToString:@"同花顺包选"]) {
                            numLabel.textColor = [UIColor redColor];
                        }
                        else if ([[redArray objectAtIndex:i] intValue] == [[pukeArray objectAtIndex:4] intValue]) {
                            numLabel.textColor = [UIColor redColor];
                            NSString *pic = [NSString stringWithFormat:@"pukexq_%d.png",[[pukeArray objectAtIndex:4] intValue]];
                            image.image = UIImageGetImageFromName(pic);
                            UIImageView *ImageV = (UIImageView *)[self.contentView viewWithTag:300 + i];
                            UILabel *label1 = (UILabel *)[ImageV viewWithTag:302];
                            UILabel *label2 = (UILabel *)[ImageV viewWithTag:402];
                            label1.textColor = numLabel.textColor;
                            label2.textColor = numLabel.textColor;
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"03"]) {//顺子
                    if ([[pukeArray objectAtIndex:6] isEqualToString:@"顺子"]) {
                        if ([numLabel.text isEqualToString:@"顺子包选"]) {
                            numLabel.textColor = [UIColor redColor];
                        }
                        else {//顺子的最小值如果和返回值相等就是中奖
                            NSInteger small = 100;
                            if (small > [[pukeArray objectAtIndex:0] intValue]) {
                                small = [[pukeArray objectAtIndex:0] intValue];
                            }
                            if (small > [[pukeArray objectAtIndex:1] intValue]) {
                                small = [[pukeArray objectAtIndex:1] intValue];
                            }
                            if (small > [[pukeArray objectAtIndex:2] intValue]) {
                                small = [[pukeArray objectAtIndex:2] intValue];
                            }
                            if (small == [[redArray objectAtIndex:i] intValue]) {
                                numLabel.textColor = [UIColor redColor];
                                UIImageView *ImageV = (UIImageView *)[self.contentView viewWithTag:1000 + i];
                                UILabel *label1 = (UILabel *)[ImageV viewWithTag:302];
                                UILabel *label2 = (UILabel *)[ImageV viewWithTag:402];
                                label1.textColor = numLabel.textColor;
                                label2.textColor = numLabel.textColor;
                            }
                        }
                    }
                }
                else if ([self.wanfa isEqualToString:@"05"]) {//对子
                    if ([[pukeArray objectAtIndex:6] isEqualToString:@"对子"]) {
                        if ([numLabel.text isEqualToString:@"包选"] || [numLabel.text isEqualToString:@"对子包选"]) {
                            numLabel.textColor = [UIColor redColor];
                        }
                        else {
                            NSInteger small = [[pukeArray objectAtIndex:0] intValue];
                            NSInteger big = [[pukeArray objectAtIndex:0] intValue];
                            NSInteger mid = 0;
                            if (small > [[pukeArray objectAtIndex:1] intValue]) {
                                small = [[pukeArray objectAtIndex:1] intValue];
                            }
                            if (small > [[pukeArray objectAtIndex:2] intValue]) {
                                small = [[pukeArray objectAtIndex:2] intValue];
                            }
                            if (big < [[pukeArray objectAtIndex:1] intValue]) {
                                big = [[pukeArray objectAtIndex:1] intValue];
                            }
                            if (big < [[pukeArray objectAtIndex:2] intValue]) {
                                big = [[pukeArray objectAtIndex:2] intValue];
                            }
                            mid = [[pukeArray objectAtIndex:0] intValue] + [[pukeArray objectAtIndex:1] intValue] + [[pukeArray objectAtIndex:2] intValue] - small - big;
                            //除了最大最小值以外，剩下的数必然是对子或者豹子，
                            if (mid == [[redArray objectAtIndex:i] intValue]) {
                                numLabel.textColor = [UIColor redColor];
                                UIImageView *ImageV = (UIImageView *)[self.contentView viewWithTag:1000 + i];
                                UILabel *label1 = (UILabel *)[ImageV viewWithTag:302];

                                label1.textColor = numLabel.textColor;
                            }
                        }
                    }
                }
                else {//任选
                    if ([[redArray objectAtIndex:i] intValue] == [[pukeArray objectAtIndex:0] intValue] || [[redArray objectAtIndex:i] intValue] == [[pukeArray objectAtIndex:1] intValue] ||[[redArray objectAtIndex:i] intValue] == [[pukeArray objectAtIndex:2] intValue]) {
                        numLabel.textColor = [UIColor redColor];
                    }
                }
                
            }
                
        }
        
        else if ([self.myredArray containsObject:ballView.numLabel.text]) {
            ballView.selected = YES;
        }
        else {
            ballView.selected = NO;
            ballView.numLabel.textColor = [UIColor colorWithRed:1.0 green:59/255.0 blue:47/255.0 alpha:1.0];
        }
    }
    for (int i = (int)[redArray count]; i<(int)[redArray count]+(int)[blueArray count]; i ++) {
        GCBallView *ballView = (GCBallView *)[self.contentView viewWithTag:i + 100];
        int fengewei = 0;
        int a = (i + 1) /8,b = (i + 1) %8;
        for (int t = 0; t < [fengeArray count]; t++) {
            if (i >= [[fengeArray objectAtIndex:t] integerValue] && i != 0) {
                fengewei ++;
            }
        }
        if (fengewei > 0) {
            a = (i + 1 + fengewei)/8,b= (i + 1 + fengewei)%8;
        }
        
        if (!ballView) {
            ballView = [[GCBallView alloc] initWithFrame:CGRectMake(15+38*b, 9+36*a, 33, 33) Num:@" " ColorType:GCBallViewColorBlue];
            ballView.backgroundColor =[UIColor clearColor];
            ballView.userInteractionEnabled = NO;
            ballView.selected = NO;
            ballView.tag = 100 +i;
            [self.contentView addSubview:ballView];
            [ballView release];
        }
        ballView.frame = CGRectMake(15+38*b, 9+36*a, 33, 33);
        [ballView changeTo:GCBallViewColorBlue];
        ballView = (GCBallView *)[self.contentView viewWithTag:i + 100];
        ballView.numLabel.text = [blueArray objectAtIndex:i-[redArray count]];
        if (isDanshi) {
            if ([self.mylotteryId isEqualToString:@"001"] || [self.mylotteryId isEqualToString:@"113"]) {
                if (i == [redArray count]) {
                    UILabel *lable = [[UILabel alloc] init];
                    lable.text = @"+";
                    lable.textAlignment = NSTextAlignmentCenter;
                    lable.frame = CGRectMake(- 35, 0, 33, 33);
                    [ballView addSubview:lable];
                    lable.textColor = [UIColor lightGrayColor];
                    [lable release];
                }
            }
            ballView.numLabel.textColor = [SharedMethod getColorByHexString:@"13a3ff"];
            [ballView setBackgroundImage:nil forState:UIControlStateNormal];
            [ballView setBackgroundImage:nil forState:UIControlStateSelected];
        }
        ballView.hidden = NO;
        if ([self.myblueArray containsObject:ballView.numLabel.text]) {
            ballView.selected = YES;
        }
        else {
            ballView.selected = NO;
            ballView.numLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:1 alpha:1.0];
        }
    }
    if ([self.mylotteryId isEqualToString:@"122"] && [redArray count]) {
        //([xiaarr count] - 1)/6 *20 +35;
        backImage.frame = CGRectMake(10, 0, 300, ([redArray count] - 1)/6 *20 +35);
        backImage1.frame = CGRectMake(15, 5, 290, ([redArray count] - 1)/6 *20 +30);
        
    }
    else if ([redArray count]) {
        if ([blueArray count]) {
            backImage.frame = CGRectMake(10, 0, 300, ([redArray count]+ [blueArray count] )/10 *20 +35);
            backImage1.frame = CGRectMake(15, 5, 290, ([redArray count]+ [blueArray count] )/10 *20 +30);
        }
        else {
            backImage.frame = CGRectMake(10, 0, 300, ([redArray count]+ [blueArray count] - 1)/10 *20 +35);
            backImage1.frame = CGRectMake(15, 5, 290, ([redArray count]+ [blueArray count] -1)/10 *20 +30);
        }
        
    }
}

- (BOOL)compareWithString:(NSString *)str
{
	if ([mylotteryId isEqualToString:@"001"]){//双色球
		return (![str isEqualToString:@","] && ![str isEqualToString:@"@"]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"113"]){//大乐透
		return (![str isEqualToString:@"_"] && ![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"002"]){//3d
		return (![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"110"]){//七星彩
		return (![str isEqualToString:@"*"]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"003"]){//七乐彩
		return (![str isEqualToString:@"_"]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"111"]){//22选5
		return (![str isEqualToString:@"*"]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"108"]){//排列3
		return (![str isEqualToString:@"*"]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"109"]){//排列5
		return (![str isEqualToString:@"*"]) ? YES: NO;
	}
    else if ([mylotteryId isEqualToString:@"010"]){//两步彩
		return (![str isEqualToString:@"|"] && ![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"006"]){//时时彩
		return (![str isEqualToString:@"^"] && ![str isEqualToString:@","] && ![str isEqualToString:@"_"]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [mylotteryId isEqualToString:@"119"] || [mylotteryId isEqualToString:@"123"] || [mylotteryId isEqualToString:LOTTERY_ID_SHANXI_11]){//11选5
		return (![str isEqualToString:@"|"] && ![str isEqualToString:@","]) ? YES: NO;
	}
    else if ([mylotteryId isEqualToString:@"121"]){//广东11选5
		return (![str isEqualToString:@"|"] && ![str isEqualToString:@","]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"016"]){//快乐8
		return (![str isEqualToString:@"|"]) ? YES: NO;
	}
	else if ([mylotteryId isEqualToString:@"017"]){//PK拾
		return (![str isEqualToString:@"|"] && ![str isEqualToString:@","]) ? YES: NO;
	}
	return NO;
}

- (void)LoadNum:(NSString *)lottoryNum LottoryID:(NSString *)lottoryid WithBall:(BOOL)withBall{
	self.mylotteryId = lottoryid;
    if ([lottoryNum isEqualToString:@"未截期，暂不公开！"]) {
        lottoryNum = @"等待开奖";
    }
	[self changeNum:lottoryNum];
	if (self.myredArray) {
		[self LoadRedArray:self.myredArray BlueArray:self.myblueArray FenGeArrag:nil WithBall:withBall];
        backImage.frame = CGRectMake(10, 0, 300,  40);
        backImage1.frame =  CGRectMake(0,0 , 0, 0);
	}
	else {
		[self LoadRedArray:nil BlueArray:nil FenGeArrag:nil WithBall:YES];
        backImage1.frame = CGRectMake(0,0 , 0, 0);
        UILabel *label = (UILabel *)[self.contentView viewWithTag:31111];
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 20)];
            label.backgroundColor = [UIColor clearColor];
            label.tag = 31111;
            label.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:label];
            [label release];
            label.textAlignment = NSTextAlignmentCenter;
        }
		if ([lottoryNum rangeOfString:@".txt"].location != NSNotFound) {
			label.text = @"单式上传";
            label.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
		}
        else if ([lottoryNum isEqualToString:@"未截期，暂不公开"]) {
            label.text = nil;
        }
		else {
			label.text = [NSString stringWithFormat:@"%@         ",lottoryNum];
            label.textColor = [UIColor colorWithRed:34/255.0 green:185/255.0 blue:255/255.0 alpha:1.0];
            UIImageView *time = (UIImageView *)[label viewWithTag:11234];
            if (!time) {
                time = [[UIImageView alloc] init];
                time.image = UIImageGetImageFromName(@"faxqbiao.png");
                [label addSubview:time];
                time.tag = 11234;
                [time release];
            }
            time.frame = CGRectMake([label.text sizeWithFont:label.font].width /2 + 160 - 17, 1, 17, 17);
		}
//		self.textLabel.font = [UIFont systemFontOfSize:16];
//        self.textLabel.textColor = [UIColor colorWithRed:254/255.0 green:186/255.0 blue:39/255.0 alpha:1.0];
//        self.textLabel.frame = CGRectMake(0, 0, self.bounds.size.width - 12, self.bounds.size.height);
//		self.textLabel.textAlignment = NSTextAlignmentLeft;
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 32);
        backImage.frame = CGRectMake(10, 0, 300,  36);
	}

}

//提取号码
- (NSMutableArray *)reArrayWithNumber:(NSString *)strNumber lenOfNumber:(NSInteger)len
{
	NSMutableArray *arrayBall = [[[NSMutableArray alloc] init] autorelease];
	NSRange rang;
	rang.location = 0;
	while (rang.location < ([strNumber length]-(len-1))) {
		rang.length = 1;
		NSString *rStr = [strNumber substringWithRange:rang];
		if ([self compareWithString:rStr]) {
			rang.length = len;
			NSString *s = [strNumber substringWithRange:rang];
			[arrayBall addObject:s];
			rang.location += len;
		}
		else {
			rang.location += 1;
		}
	}
	return arrayBall;
}

- (NSString *)changePuke:(NSString *)puke {
    if ([puke hasPrefix:@"距离开奖"]||[puke isEqualToString:@"等待开奖"]||[puke rangeOfString:@".txt"].location != NSNotFound || [puke length] == 0) {
        self.zhongjiang = nil;
		return @"";
	}
    NSArray *array = [puke componentsSeparatedByString:@","];
    NSMutableArray *ballArray = [NSMutableArray array];
    for (NSString *strBall in array) {
        NSInteger num = [strBall intValue];
        if ([self.wanfa isEqualToString:@"01"]|| [self.wanfa isEqualToString:@"02"]) {
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"黑桃"];
            }
            else if ([strBall isEqualToString:@"02"]) {
                [ballArray addObject:@"红桃"];
            }
            else if ([strBall isEqualToString:@"03"]) {
                [ballArray addObject:@"梅花"];
            }
            else if ([strBall isEqualToString:@"04"]) {
                [ballArray addObject:@"方块"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if ([self.wanfa intValue] >= 6 && [self.wanfa intValue] <= 11) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d",(int)num]];
            }
            else if (num == 1) {
                [ballArray addObject:@"A"];
            }
            else if (num == 11) {
                [ballArray addObject:@"J"];
            }
            else if (num == 12) {
                [ballArray addObject:@"Q"];
            }
            else if (num == 13) {
                [ballArray addObject:@"K"];
            }
        }
        else if ([self.wanfa intValue] == 05) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d",(int)num,(int)num]];
            }
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"AA"];
            }
            else if ([strBall isEqualToString:@"11"]) {
                [ballArray addObject:@"JJ"];
            }
            else if ([strBall isEqualToString:@"12"]) {
                [ballArray addObject:@"QQ"];
            }
            else if ([strBall isEqualToString:@"13"]) {
                [ballArray addObject:@"KK"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if ([self.wanfa intValue] == 4) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d%d",(int)num,(int)num,(int)num]];
            }
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"AAA"];
            }
            else if ([strBall isEqualToString:@"11"]) {
                [ballArray addObject:@"JJJ"];
            }
            else if ([strBall isEqualToString:@"12"]) {
                [ballArray addObject:@"QQQ"];
            }
            else if ([strBall isEqualToString:@"13"]) {
                [ballArray addObject:@"KKK"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if ([self.wanfa intValue] == 3) {
            if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
            else if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"A23"];
            }
//            10用*表示
            else if (num >= 1 && num <= 7) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d%d",(int)num,(int)num + 1,(int)num + 2]];
            }
            else if (num == 8) {
                [ballArray addObject:@"89*"];
            }
            else if (num == 9) {
                [ballArray addObject:@"9*J"];
            }
            else if (num == 10) {
                [ballArray addObject:@"*JQ"];
            }
            else if (num == 11) {
                [ballArray addObject:@"JQK"];
            }
            else if (num == 12) {
                [ballArray addObject:@"QKA"];
            }
        }
    }
    return [ballArray componentsJoinedByString:@" "];
}

- (void)changeNum:(NSString *) strBall{
	if ([strBall hasPrefix:@"距离开奖"]||[strBall isEqualToString:@"等待开奖"]||[strBall rangeOfString:@".txt"].location != NSNotFound || [strBall length] == 0) {
        self.zhongjiang = nil;
		return;
	}
	NSArray *secArray = [strBall componentsSeparatedByString:@";"];
	
	for (int j = 0; j < [secArray count]; j++) {
		NSString *ball = strBall;
		
		if (1||[mylotteryId isEqualToString:@"001"]) {//双色球
			NSArray *numberArray = [ball componentsSeparatedByString:@"+"];
			NSString *redNumber = [numberArray objectAtIndex:0];
			redNumber = [redNumber stringByReplacingOccurrencesOfString:@"\"" withString:@""];
			redNumber = [redNumber stringByReplacingOccurrencesOfString:@"\"" withString:@""];
			
			NSMutableArray *arrayRed = [NSMutableArray arrayWithArray:[redNumber componentsSeparatedByString:@","]];//[self reArrayWithNumber:redNumber lenOfNumber:2];
			self.myredArray = arrayRed;
			if ([numberArray count]>1) {
				NSString *blueNumber = [numberArray objectAtIndex:1];
				NSArray *arrayBlue = [blueNumber componentsSeparatedByString:@","];
				self.myblueArray= arrayBlue;//存 蓝球
			}
			return;
		}
		else if ([mylotteryId isEqualToString:@"113"]) {//大乐透
			NSArray *numberArray = [ball componentsSeparatedByString:@"+"];
			NSString *redNumber = [numberArray objectAtIndex:0];
			NSString *blueNumber = [numberArray objectAtIndex:1];
			
			NSMutableArray *arrayRed = [self reArrayWithNumber:redNumber lenOfNumber:2];
			self.myredArray = arrayRed;
			
			NSMutableArray *arrayBlue = [self reArrayWithNumber:blueNumber lenOfNumber:2];
			self.myblueArray= arrayBlue;
		}
		else if ([mylotteryId isEqualToString:@"002"]) {//3d
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
			self.myredArray = arrayRed;
			
		}
		else if ([mylotteryId isEqualToString:@"110"]) {//七星彩
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
			self.myredArray = arrayRed;
			
		}
		else if ([mylotteryId isEqualToString:@"003"]) {//七乐彩
			NSArray *numberArray = [ball componentsSeparatedByString:@"+"];
			NSString *redNumber = [numberArray objectAtIndex:0];
			redNumber = [redNumber stringByReplacingOccurrencesOfString:@"\"" withString:@""];
			redNumber = [redNumber stringByReplacingOccurrencesOfString:@"\"" withString:@""];
			NSString *blueNumber = [numberArray objectAtIndex:1];
			
			NSMutableArray *arrayRed = [self reArrayWithNumber:redNumber lenOfNumber:2];
			self.myredArray = arrayRed;
			
			NSMutableArray *arrayBlue = [self reArrayWithNumber:blueNumber lenOfNumber:2];
			self.myblueArray= arrayBlue;
			//NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
//			self.myredArray = arrayRed;
			
		}
		else if ([mylotteryId isEqualToString:@"111"]) {//22选5
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
			self.myredArray = arrayRed;
			
		}
		else if ([mylotteryId isEqualToString:@"108"]) {//排列3
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
			self.myredArray = arrayRed;
			
		}
		else if ([mylotteryId isEqualToString:@"109"]) {//排列5
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
			self.myredArray = arrayRed;
			
		}
		else if ([mylotteryId isEqualToString:@"010"]) {//两步彩
			NSArray *numberArray = [ball componentsSeparatedByString:@"+"];
			NSString *redNumber = [numberArray objectAtIndex:0];
			NSMutableArray *arrayRed = [self reArrayWithNumber:redNumber lenOfNumber:1];
			self.myredArray = arrayRed;//存 红球
			
			
			if ([numberArray count] > 1) {
				NSString *blueNumber = [numberArray objectAtIndex:1];
				NSArray *arrayBlue = [blueNumber componentsSeparatedByString:@"|"];
				self.myblueArray= arrayBlue;//存 蓝球
			}
		}
		else if ([mylotteryId isEqualToString:@"006"]) {//时时彩
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:1];
			self.myredArray = arrayRed;
			
		}
		else if ([mylotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [mylotteryId isEqualToString:@"119"] || [mylotteryId isEqualToString:@"123"] || [mylotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) {//11选5
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
			self.myredArray = arrayRed;
			
		}
        else if ([mylotteryId isEqualToString:@"121"]) {//广东11选5
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
			self.myredArray = arrayRed;
			
		}
		else if ([mylotteryId isEqualToString:@"016"]) {//快乐8
			NSMutableArray *arrayRed = [self reArrayWithNumber:ball lenOfNumber:2];
			self.myredArray = arrayRed;
			
			//飞盘号
			NSMutableArray *arrayBlue = [[NSMutableArray alloc] init];
			NSString *feipan = strBall;
			NSArray *fArray = [feipan componentsSeparatedByString:@"+"];
			if ([fArray count] < 2) {
				[arrayBlue addObject:@"0"];
			}
			else {
				NSString *fp = [fArray objectAtIndex:1];
				[arrayBlue addObject:fp];
			}
			self.myblueArray= arrayBlue;
		}
		else if ([mylotteryId isEqualToString:@"017"]) {//PK拾
			NSArray *arrayRed = [ball componentsSeparatedByString:@"|"];
			self.myredArray = arrayRed;
		}
        else if ([mylotteryId isEqualToString: @"122"]) {//快乐扑克
            self.myredArray = [ball componentsSeparatedByString:@","];
        }
	}
}

- (void)dealloc {
	self.myredArray = nil;
	self.myblueArray = nil;
	self.mylotteryId = nil;
    self.wanfa = nil;
    self.luckyBall = nil;
    self.zhongjiang = nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    