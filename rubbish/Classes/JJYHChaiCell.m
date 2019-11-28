//
//  JJYHChaiCell.m
//  caibo
//
//  Created by yaofuyu on 13-7-11.
//
//

#import "JJYHChaiCell.h"
#import "CP_PTButton.h"
#import "JiangJinYouhuaViewController.h"
#import "ColorView.h"

@implementation JJYHChaiCell
@synthesize myinfo;
@synthesize Index;
@synthesize jJYHChaiCellDelegate;
@synthesize isGenggai, zuihouBool;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        backImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 96)];
        backImageView.userInteractionEnabled = YES;
//        backImageView.image = UIImageGetImageFromName(@"XQCELlBG960.png");
        [self.contentView addSubview:backImageView];
        [backImageView release];
        
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 6, 180, 20)];
        infoLabel.font = [UIFont systemFontOfSize:11];
        infoLabel.textAlignment = NSTextAlignmentLeft;
        infoLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.text = @"方案详细手动调节";
        infoLabel.hidden = YES;
        [backImageView addSubview:infoLabel];
        [infoLabel release];
        
        lineImageV = [[UIImageView alloc] initWithFrame:CGRectMake(120, 15, 165, 2)];
        lineImageV.backgroundColor = [UIColor clearColor];
//        lineImageV.image = UIImageGetImageFromName(@"SZTG960.png");
        [backImageView addSubview:lineImageV];
        lineImageV.hidden = YES;
        [lineImageV release];
        
        backUpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 0, 281, 48)];
        backdownImageView.backgroundColor = [UIColor clearColor];
//        backUpImageView.image = [UIImageGetImageFromName(@"JJYH4.png") stretchableImageWithLeftCapWidth:0 topCapHeight:20];
        [backImageView addSubview:backUpImageView];
        backUpImageView.userInteractionEnabled =YES;
        [backUpImageView release];
        
        numImageV = [[UIImageView alloc] initWithFrame:CGRectMake(6, 10, 17, 18)];
        numImageV.backgroundColor = [UIColor clearColor];
        numImageV.image = UIImageGetImageFromName(@"JJYH6.png");
        [backUpImageView addSubview:numImageV];
        [numImageV release];
        
        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:10];
        numLabel.text = @"1";
        [numImageV addSubview:numLabel];
        [numLabel release];
        
        jiangJiLable = [[ColorView alloc] initWithFrame:CGRectMake(25, 33, 255, 10)];
        jiangJiLable.font = [UIFont systemFontOfSize:9];
        jiangJiLable.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
        jiangJiLable.backgroundColor = [UIColor clearColor];
        [backUpImageView addSubview:jiangJiLable];
        [jiangJiLable release];
        
        line2 = [[UIImageView alloc] initWithFrame:CGRectMake(11, 28, 300, 0.5)];
        line2.backgroundColor = [UIColor colorWithRed:180/255.0 green:174/255.0 blue:158/255.0 alpha:1];
//        line2.image = UIImageGetImageFromName(@"yucexuxian.png");
        [backUpImageView addSubview:line2];
        [line2 release];
        
        
        backdownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 28, 281, 42)];
//        backdownImageView.image = UIImageGetImageFromName(@"JJYH5.png");
        backdownImageView.backgroundColor = [UIColor clearColor];
        [backImageView addSubview:backdownImageView];
        backdownImageView.userInteractionEnabled = YES;
        [backdownImageView release];
        
        ZhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ZhuBtn.frame = CGRectMake(25, 6, 133, 30);
        [backdownImageView addSubview:ZhuBtn];
        
        [ZhuBtn addTarget:self action:@selector(zhuSelect) forControlEvents:UIControlEventTouchUpInside];
        [ZhuBtn setBackgroundImage:[UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10]  forState:UIControlStateNormal];
//        [ZhuBtn setBackgroundImage:[UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateHighlighted];
        
        
        
        ZhuText = [[UITextField alloc] init];
        ZhuText.delegate = self;
        ZhuText.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        ZhuText.font = [UIFont systemFontOfSize:12];
        ZhuText.keyboardType = UIKeyboardTypeNumberPad;
        ZhuText.frame = CGRectMake(0, 6, 103, 18);
        ZhuText.textAlignment = NSTextAlignmentCenter;
        ZhuText.backgroundColor = [UIColor clearColor];
        [ZhuBtn addSubview:ZhuText];
        [ZhuText release];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(103, 0, 30, 30)];
        label2.text = @"份";
        label2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
        label2.backgroundColor = [UIColor clearColor];
        label2.textAlignment = NSTextAlignmentCenter;
        [ZhuBtn addSubview:label2];
        label2.font = [UIFont systemFontOfSize:11];
        [label2 release];
        
        CP_PTButton *addbutton1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        addbutton1.frame =  CGRectMake(170, 7, 45, 28);
        [addbutton1 loadButonImage:@"zhuihaojia_normal.png" LabelName:@""];
        addbutton1.buttonName.frame = CGRectMake(0, -3, 45, 28);
        addbutton1.buttonName.font = [UIFont systemFontOfSize:28];
        [addbutton1 addTarget:self action:@selector(pressaddbuttonone:) forControlEvents:UIControlEventTouchUpInside];
        
        CP_PTButton *jianbutton1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        jianbutton1.frame = CGRectMake(216, 7, 45, 28);
        [jianbutton1 loadButonImage:@"zhuihaojian_normal.png" LabelName:@""];
        jianbutton1.buttonName.frame = CGRectMake(0, -3, 45, 28);
        jianbutton1.buttonName.font = [UIFont systemFontOfSize:28];
        [jianbutton1 addTarget:self action:@selector(pressjianbuttonone:) forControlEvents:UIControlEventTouchUpInside];
        [backdownImageView addSubview:addbutton1];
        [backdownImageView addSubview:jianbutton1];
        
        [addbutton1 setHightImage:[UIImageGetImageFromName(@"ZHBANBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [jianbutton1 setHightImage:[UIImageGetImageFromName(@"ZHBANBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        
        xiaImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 0, 0)];
        xiaImageV.backgroundColor = [UIColor colorWithRed:180/255.0 green:174/255.0 blue:158/255.0 alpha:1];
        [backdownImageView addSubview:xiaImageV];
        [xiaImageV release];
        
//        lilunJiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        lilunJiangBtn.frame = CGRectMake(44, 6, 145, 30);
//        [backdownImageView addSubview:lilunJiangBtn];
//        [lilunJiangBtn addTarget:self action:@selector(lilunSelect) forControlEvents:UIControlEventTouchUpInside];
//        [lilunJiangBtn setBackgroundImage:[UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateNormal];
//        [lilunJiangBtn setBackgroundImage:[UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateHighlighted];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:lilunJiangBtn.bounds];
//        label.text = @" 理论奖金                           元";
//        label.backgroundColor = [UIColor clearColor];
//        [lilunJiangBtn addSubview:label];
//        label.font = [UIFont systemFontOfSize:11];
//        [label release];
//        
//        lilunText = [[UITextField alloc] init];
//        lilunText.delegate = self;
//        lilunText.textColor = [UIColor redColor];
//        lilunText.font = [UIFont systemFontOfSize:12];
//        lilunText.keyboardType = UIKeyboardTypeNumberPad;
//        lilunText.frame = CGRectMake(50, 7, 80, 20);
//        lilunText.textAlignment = NSTextAlignmentCenter;
//        lilunText.backgroundColor = [UIColor clearColor];
//        [lilunJiangBtn addSubview:lilunText];
//        [lilunText release];
//        [backdownImageView addSubview:lilunJiangBtn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard) name:@"hideKeyBoard" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [myinfo release];
    [super dealloc];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.jJYHChaiCellDelegate && [self.jJYHChaiCellDelegate isKindOfClass:[JiangJinYouhuaViewController class]]) {
        JiangJinYouhuaViewController *control = (JiangJinYouhuaViewController *)self.jJYHChaiCellDelegate;
        CGPoint point = [self convertPoint:CGPointMake(0, 0) toView:[control mainView]];
        if (point.y > 68) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:0.3];
            control.myTableView.frame = CGRectMake(control.myTableView.frame.origin.x, -180, control.myTableView.frame.size.width, control.myTableView.frame.size.height);
            [UIView commitAnimations];
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!isGenggai) {
        isGenggai = YES;
        textField.text = string;
        return NO;
    }
    if ([string length]) {
        NSString * jianp = [NSString stringWithFormat:@"%@%@", textField.text , string];
        if ([jianp intValue] >= 29999) {
            textField.text = @"29999";
            return NO;
        }
        
    }
    return YES;
}


- (void)hideKeyBoard {
    if ([lilunText isFirstResponder]) {
        NSInteger a = [lilunText.text floatValue]/[self.myinfo.danJiang floatValue];
        if (a + 0.5 < [lilunText.text floatValue]/[self.myinfo.danJiang floatValue]) {
            a = a + 1;
        }
    myinfo.betNum = [NSString stringWithFormat:@"%ld",(long)a];
    myinfo.zongJiang = [NSString stringWithFormat:@"%.2f",a * [myinfo.danJiang floatValue]];
    }
    if ([ZhuText isFirstResponder]) {
        myinfo.betNum = [NSString stringWithFormat:@"%ld",(long)[ZhuText.text integerValue]];
        myinfo.zongJiang = [NSString stringWithFormat:@"%.2f",[ZhuText.text integerValue] * [myinfo.danJiang floatValue]];
    }
    [lilunText resignFirstResponder];
    [ZhuText resignFirstResponder];
    [self update]; 
}

- (void)setMyinfo:(GC_YHChaiInfo *)_myinfo {
    if (myinfo != _myinfo) {
        [_myinfo retain];
        [myinfo release];
        myinfo = _myinfo;
    }
    
    isGenggai = NO;
    
    numLabel.text = [NSString stringWithFormat:@"%d",(int)Index + 1];
    if ([numLabel.text intValue] >= 10) {
        numLabel.font = [UIFont systemFontOfSize:10];
    }
    else {
        numLabel.font = [UIFont systemFontOfSize:13];
    }
    jiangJiLable.text = [NSString stringWithFormat:@"单注奖金 <%@> 元  理论奖金 <%@> 元",self.myinfo.danJiang,self.myinfo.zongJiang];
    ZhuText.text = [NSString stringWithFormat:@"%@",self.myinfo.betNum];
    lilunText.text = [NSString stringWithFormat:@"%@",self.myinfo.zongJiang];

    NSArray *array = [self.myinfo.betInfo componentsSeparatedByString:@"x"];
    if (Index == 0) {
        infoLabel.hidden = NO;
        lineImageV.hidden = NO;
        backImageView.frame= CGRectMake(10, 0, 300, 111 + 11 * [array count]);
        backUpImageView.frame = CGRectMake(10, 0 + 38, 281, 26 + 11 * [array count]);
        backdownImageView.frame = CGRectMake(10,38 + backUpImageView.frame.size.height, 281, 42);
        
        if (zuihouBool) {
            xiaImageV.frame = CGRectMake(0,0, 0, 0);
        }else{
            xiaImageV.frame = CGRectMake(5, backdownImageView.frame.size.height - 0.5, 320 - 5, 0.5);
        }
        
    }
    else {
        infoLabel.hidden = YES;
        lineImageV.hidden = YES;
        backImageView.frame= CGRectMake(10, 0, 300, 73 + 11 * [array count]);
        backUpImageView.frame = CGRectMake(10, 0, 281, 26 + 11 * [array count]);
        backdownImageView.frame = CGRectMake(10, backUpImageView.frame.size.height, 281, 42);
        
        if (zuihouBool) {
            xiaImageV.frame = CGRectMake(0,0, 0, 0);
        }else{
            xiaImageV.frame = CGRectMake(5, backdownImageView.frame.size.height - 0.5, 320 - 5, 0.5);
        }
    }

    jiangJiLable.frame = CGRectMake(25, 11 + 11 * [array count], 240, 10);
    line2.frame =CGRectMake(11, 6 + 11 * [array count], 300, 0.5);
    numImageV.frame = CGRectMake(6,-4 + 5.5 * [array count], 18, 18);
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
                if ([array4 count] == 2) {
                    num = [array4 objectAtIndex:0];
                    zhu  =[[[array4 objectAtIndex:1] componentsSeparatedByString:@"+"] objectAtIndex:0];
                    if ([[[array4 objectAtIndex:1] componentsSeparatedByString:@"+"] count] >= 2) {
                        rang = [NSString stringWithFormat:@"+%@",[[[array4 objectAtIndex:1] componentsSeparatedByString:@"+"] objectAtIndex:1]];
                    }
                }
                else if ([array4 count] >= 3) {
                    num = [array4 objectAtIndex:0];
                    zhu  =[array4 objectAtIndex:1];
                    rang = [NSString stringWithFormat:@"-%@",[array4 objectAtIndex:2]];
                }
            }
            
                UILabel *label1 = [[UILabel alloc] init];
                label1.backgroundColor = [UIColor clearColor];
                label1.frame = CGRectMake(35, 3 + 11 * i, 22, 10);
                label1.text = num;
                [backUpImageView addSubview:label1];
                label1.tag = 100*i+1;
                label1.font = [UIFont boldSystemFontOfSize:9];
                [label1 release];
                
                ColorView *label2 = [[ColorView alloc] init];
                label2.backgroundColor = [UIColor clearColor];
                label2.frame = CGRectMake(57, 3 + 11 * i, 60, 10);

                label2.tag = 100*i+2;
                label2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
                [backUpImageView addSubview:label2];
            if ([rang intValue]) {
                label2.text = [NSString stringWithFormat:@"%@<%@>",zhu,rang];
            }
            else {
                label2.text = [NSString stringWithFormat:@"%@",zhu];
            }
            
                label2.font = [UIFont boldSystemFontOfSize:9];
                [label2 release];
                
                UILabel *label3 = [[UILabel alloc] init];
                label3.backgroundColor = [UIColor clearColor];
                label3.frame = CGRectMake(117, 3 + 11 * i, 16, 10);
                label3.text = @"vs";
                label3.textAlignment = NSTextAlignmentCenter;
                label3.tag = 100*i+3;
                label3.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
                [backUpImageView addSubview:label3];
                label3.font = [UIFont boldSystemFontOfSize:9];
                [label3 release];
                
                ColorView *label4 = [[ColorView alloc] init];
                label4.backgroundColor = [UIColor clearColor];
                label4.frame = CGRectMake(136, 3 + 11 * i, 60, 10);
                label4.tag = 100*i+4;
                label4.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
                label4.text = ke;
                [backUpImageView addSubview:label4];
                label4.font = [UIFont boldSystemFontOfSize:9];
                [label4 release];
                
                UILabel *label5 = [[UILabel alloc] init];
                label5.backgroundColor = [UIColor clearColor];
                label5.frame = CGRectMake(197, 3 + 11 * i, 60, 10);
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
                label5.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:1 alpha:1];
                [backUpImageView addSubview:label5];
                label5.font = [UIFont boldSystemFontOfSize:9];
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
                if ([array4 count] == 2) {
                    num = [array4 objectAtIndex:0];
                    zhu  =[[[array4 objectAtIndex:1] componentsSeparatedByString:@"+"] objectAtIndex:0];
                    if ([[[array4 objectAtIndex:1] componentsSeparatedByString:@"+"] count] >= 2) {
                        rang = [NSString stringWithFormat:@"+%@",[[[array4 objectAtIndex:1] componentsSeparatedByString:@"+"] objectAtIndex:1]];
                    }
                }
                else if ([array4 count] >= 3) {
                    num = [array4 objectAtIndex:0];
                    zhu  =[array4 objectAtIndex:1];
                    rang = [NSString stringWithFormat:@"-%@",[array4 objectAtIndex:2]];
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
                label3.text = @"vs";
                
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

- (void)qing:(CP_PTButton *)sender {
    myinfo.betNum = @"0";
    myinfo.zongJiang = @"0.00";
    [self update];
}

- (void)zhuSelect {
    [ZhuText becomeFirstResponder];
}

- (void)lilunSelect {
    [lilunText becomeFirstResponder];
}

- (void)update {
    ZhuText.text = [NSString stringWithFormat:@"%@",self.myinfo.betNum];
    jiangJiLable.text = [NSString stringWithFormat:@"单注奖金 <%@> 元  理论奖金 <%@> 元",self.myinfo.danJiang,self.myinfo.zongJiang];
    if (jJYHChaiCellDelegate &&[jJYHChaiCellDelegate respondsToSelector:@selector(delegateUpdate:)]) {
        [jJYHChaiCellDelegate delegateUpdate:self];
    }
}

- (void)pressaddbuttonone:(CP_PTButton *)sender {
    myinfo.betNum = [NSString stringWithFormat:@"%ld",(long)[myinfo.betNum integerValue] + 1];
    if ([myinfo.betNum intValue] > 29999) {
        myinfo.betNum = @"29999";
    }
    myinfo.zongJiang = [NSString stringWithFormat:@"%.2f",[myinfo.betNum integerValue] * [myinfo.danJiang floatValue]];
    [self update];

}

- (void)pressjianbuttonone:(CP_PTButton *)sender {
    myinfo.betNum = [NSString stringWithFormat:@"%ld",(long)[myinfo.betNum integerValue] - 1];
    if ([myinfo.betNum integerValue] <= 0) {
        myinfo.betNum = @"0";
    }
    myinfo.zongJiang = [NSString stringWithFormat:@"%.2f",[myinfo.betNum integerValue] * [myinfo.danJiang floatValue]];
    [self update];
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