//
//  GouCaiChaiCell.m
//  caibo
//
//  Created by yaofuyu on 13-8-15.
//
//

#import "GouCaiChaiCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation GouCaiChaiCell

@synthesize Index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//        backImageView= [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 54)];
//        backImageView.userInteractionEnabled = YES;
//        backImageView.image = UIImageGetImageFromName(@"XQCELlBG960.png");
//        [self.contentView addSubview:backImageView];
//        [backImageView release];
        
//        upImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, -42, 300, 52)];
//        [self.contentView addSubview:upImageV];
//        [self.contentView.layer setMasksToBounds:YES];
//        upImageV.image = UIImageGetImageFromName(@"XQTZTableBG.png");
//        [upImageV release];
        
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 3, 180, 20)];
        infoLabel.font = [UIFont systemFontOfSize:12];
        infoLabel.textAlignment = NSTextAlignmentLeft;
        infoLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.text = @"拆分详情";
        infoLabel.hidden = YES;
        [self.contentView addSubview:infoLabel];
        [infoLabel release];
        
        
        
        lineImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 1)];
        lineImageV.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [self.contentView addSubview:lineImageV];
        [lineImageV release];
        
        backUpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 320, 48)];
        backUpImageView.image = nil;
        [self.contentView addSubview:backUpImageView];
        backUpImageView.userInteractionEnabled =YES;
        [backUpImageView release];
                
        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.textColor = [UIColor redColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:12];
        numLabel.text = @"1";
        [backUpImageView addSubview:numLabel];
        [numLabel release];
        
        Zhulabel = [[UILabel alloc] init];
        Zhulabel.backgroundColor = [UIColor clearColor];
        Zhulabel.font = [UIFont systemFontOfSize:12];
        Zhulabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
        [backUpImageView addSubview:Zhulabel];
        [Zhulabel release];
        
        moneyLabel = [[UILabel alloc] init];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.font = [UIFont systemFontOfSize:12];
        moneyLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
        [backUpImageView addSubview:moneyLabel];
        [moneyLabel release];
        
        jiangJiLable = [[ColorView alloc] initWithFrame:CGRectMake(25, 33, 255, 14)];
        jiangJiLable.font = [UIFont systemFontOfSize:12];
        jiangJiLable.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
        jiangJiLable.backgroundColor = [UIColor clearColor];
        [backUpImageView addSubview:jiangJiLable];
        [jiangJiLable release];
        
        line2 = [[UIImageView alloc] initWithFrame:CGRectMake(11, 28, 260, 1)];
        line2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [backUpImageView addSubview:line2];
        [line2 release];
        
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


- (void)setMyinfo:(NSString *)_info {
    numLabel.text = [NSString stringWithFormat:@"%ld",(long)Index + 1];
    NSArray *infoArray = [_info componentsSeparatedByString:@"||"];
    NSArray *array = nil;
    UIColor *textColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];;
    numLabel.textColor = textColor;
    if (infoArray.count < 7) {
        return;
    }
    if ([[infoArray objectAtIndex:5] intValue] == 1) {
        textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
        numLabel.textColor = textColor;
        jiangJiLable.text = @"未中奖";
    }
    else if ([[infoArray objectAtIndex:5] intValue] == 2) {
        numLabel.textColor = [UIColor redColor];
        jiangJiLable.text = [NSString stringWithFormat:@"奖金 <%@> 元",[infoArray objectAtIndex:6]];
    }
    else {
        jiangJiLable.text = @"等待开奖";
    }
    if ([infoArray count] > 2) {
        array = [[infoArray objectAtIndex:1] componentsSeparatedByString:@"x"];
    }
    else {
        array = nil;
    }
    if (Index == 0) {
        infoLabel.hidden = NO;
        lineImageV.hidden = YES;
        upImageV.hidden = NO;
        backImageView.frame= CGRectMake(10, 30, 300, 30 + 20 *  [array count]);
        backUpImageView.frame = CGRectMake(0, 26, 320, 24 + 20 * [array count]);

    }
    else {
        infoLabel.hidden = YES;
        lineImageV.hidden = NO;
        upImageV.hidden = YES;
        backImageView.frame= CGRectMake(10, 0, 300, 30 + 20 *  [array count]);
        backUpImageView.frame = CGRectMake(0, 6, 320, 24 + 20 * [array count]);
    }
    
    
    jiangJiLable.frame = CGRectMake(230 - [[infoArray objectAtIndex:6] sizeWithFont:jiangJiLable.font].width, 11 + 20 *  [array count], 110, 14);
    Zhulabel.text = [NSString stringWithFormat:@"%@注",[infoArray objectAtIndex:3]];
    Zhulabel.frame = CGRectMake(32, 11 + 20 *  [array count], 44, 14);
    moneyLabel.text = [NSString stringWithFormat:@"投注%@元",[infoArray objectAtIndex:4]];
    moneyLabel.frame = CGRectMake(74, 11 + 20 *  [array count], 90, 14);
    line2.frame =CGRectMake(27, 6 + 20 * [array count], 300, 1);
    moneyLabel.textColor = textColor;
    Zhulabel.textColor = textColor;
    
    numLabel.frame = CGRectMake(0, 2, 25, 18);
    UIView *v = [backUpImageView viewWithTag:101];
    if (!v) {
        for (int i = 0; i < [array count]; i++) {
            NSArray *arry2 = [[array objectAtIndex:i] componentsSeparatedByString:@" "];
            NSString *num = @"";
            NSString *zhu = @"";
            NSString *rang = @"";
            NSString *ke = @"";
            NSString *tou = @"";
            if ([arry2 count] >= 2) {
                NSArray *array3 =[[arry2 objectAtIndex:1] componentsSeparatedByString:@"("];
                ke = [array3 objectAtIndex:0];
                if ([array3 count] >= 2) {
                    tou = [[array3 objectAtIndex:1] stringByReplacingOccurrencesOfString:@")" withString:@""];
                }
                NSArray *array4 = [[arry2 objectAtIndex:0] componentsSeparatedByString:@"-"];
                num = [array4 objectAtIndex:0];
                zhu = [array4 objectAtIndex:1];
                if ([array3 count] >= 3) {
                    rang = [array3 objectAtIndex:2];
                }
                
            }
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.backgroundColor = [UIColor clearColor];
            label1.frame = CGRectMake(35, 3 + 20 * i, 22, 14);
            label1.text = num;
            label1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            [backUpImageView addSubview:label1];
            label1.tag = 100*i+1;
            label1.font = [UIFont systemFontOfSize:12];
            [label1 release];
            
            ColorView *label2 = [[ColorView alloc] init];
            label2.backgroundColor = [UIColor clearColor];
            label2.frame = CGRectMake(57, 3 + 20 * i, 70, 14);
            
            label2.tag = 100*i+2;
            label2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
            [backUpImageView addSubview:label2];
            if ([rang intValue]) {
                label2.text = [NSString stringWithFormat:@"%@<%@>",zhu,rang];
            }
            else {
                label2.text = [NSString stringWithFormat:@"%@",zhu];
            }
            label2.font = [UIFont systemFontOfSize:12];
            [label2 release];
            
            UILabel *label3 = [[UILabel alloc] init];
            label3.backgroundColor = [UIColor clearColor];
            label3.frame = CGRectMake(127, 3 + 20 * i, 16, 14);
            label3.text = @"VS";
            label3.textAlignment = NSTextAlignmentCenter;
            label3.tag = 100*i+3;
            label3.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
            [backUpImageView addSubview:label3];
            label3.font = [UIFont systemFontOfSize:12];
            [label3 release];
            
            ColorView *label4 = [[ColorView alloc] init];
            label4.backgroundColor = [UIColor clearColor];
            label4.frame = CGRectMake(146, 3 + 20 * i, 70, 14);
            label4.tag = 100*i+4;
            label4.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
            label4.text = ke;
            [backUpImageView addSubview:label4];
            label4.font = [UIFont systemFontOfSize:12];
            [label4 release];
            
            UILabel *label5 = [[UILabel alloc] init];
            label5.backgroundColor = [UIColor clearColor];
            label5.frame = CGRectMake(240, 3 + 20 *  i, 60, 14);
            label5.text = tou;
            if ([label5.text rangeOfString:@"平"].location == NSNotFound) {
                if ([label5.text rangeOfString:@"主"].location != NSNotFound || [label5.text rangeOfString:@"客"].location != NSNotFound) {
                    label5.text = [NSString stringWithFormat:@"(%@)",label5.text];
                }
                else {
                    label5.text = [NSString stringWithFormat:@"(主%@)",label5.text];
                }
                
            }
            else {
                label5.text = [NSString stringWithFormat:@"(%@)",label5.text];
            }
            label5.tag = 100*i+5;
            label5.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1.0];
            [backUpImageView addSubview:label5];
            label5.font = [UIFont systemFontOfSize:12];
            [label5 release];
            
        }
        
        
    }
    else {
        for (int i = 0; i < [array count]; i++) {
            NSArray *arry2 = [[array objectAtIndex:i] componentsSeparatedByString:@" "];
            NSString *num = @"";
            NSString *zhu = @"";
            NSString *rang = @"";
            NSString *ke = @"";
            NSString *tou = @"";
            if ([arry2 count] >= 2) {
                NSArray *array3 =[[arry2 objectAtIndex:1] componentsSeparatedByString:@"("];
                ke = [array3 objectAtIndex:0];
                if ([array3 count] >= 2) {
                    tou = [[array3 objectAtIndex:1] stringByReplacingOccurrencesOfString:@")" withString:@""];
                }
                NSArray *array4 = [[arry2 objectAtIndex:0] componentsSeparatedByString:@"-"];
                num = [array4 objectAtIndex:0];
                zhu = [array4 objectAtIndex:1];
                if ([array3 count] >= 3) {
                    rang = [array3 objectAtIndex:2];
                }
                
            }
            UILabel *label1 = (UILabel *)[backUpImageView viewWithTag:100*i + 1];
            label1.text = num;
            
            ColorView *label2 = (ColorView *)[backUpImageView viewWithTag:100*i + 2];
            if ([rang intValue]) {
                label2.text = [NSString stringWithFormat:@"%@<%@>",zhu,rang];
            }
            else {
                label2.text = [NSString stringWithFormat:@"%@",zhu];
            }
            
            UILabel *label3 = (UILabel *)[backUpImageView viewWithTag:100*i + 3];
            label3.text = @"VS";
            
            ColorView *label4 = (ColorView *)[backUpImageView viewWithTag:100*i + 4];
            label4.text = ke;
            
            UILabel *label5 = (UILabel *)[backUpImageView viewWithTag:100*i + 5];
            label5.text = tou;
            if ([label5.text rangeOfString:@"平"].location == NSNotFound) {
                if ([label5.text rangeOfString:@"主"].location != NSNotFound || [label5.text rangeOfString:@"客"].location != NSNotFound) {
                    label5.text = [NSString stringWithFormat:@"(%@)",label5.text];
                }
                else {
                    label5.text = [NSString stringWithFormat:@"(主%@)",label5.text];
                }
                
            }
            else {
                label5.text = [NSString stringWithFormat:@"(%@)",label5.text];
            }
            
        }
        for (int i = (int)[array count]; i < [array count] + 3; i++) {
            UILabel *label1 = (UILabel *)[backUpImageView viewWithTag:100*i + 1];
            label1.text = nil;
            
            ColorView *label2 = (ColorView *)[backUpImageView viewWithTag:100*i + 2];
            label2.text = nil;
            UILabel *label3 = (UILabel *)[backUpImageView viewWithTag:100*i + 3];
            label3.text = nil;
            
            ColorView *label4 = (ColorView *)[backUpImageView viewWithTag:100*i + 4];
            label4.text = nil;
            
            UILabel *label5 = (UILabel *)[backUpImageView viewWithTag:100*i + 5];
            label5.text = nil;
        }
    }
    
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