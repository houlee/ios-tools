//
//  CPTuiJianCell.m
//  CPgaopin
//
//  Created by yaofuyu on 13-11-27.
//
//

#import "CPTuiJianCell.h"

@implementation CPTuiJianCell
@synthesize tuijianCellDelegate;
@synthesize btn1,btn2,btn3;

#define ORIGIN_X(view) (view.frame.origin.x + view.frame.size.width)
#define ORIGIN_Y(view) (view.frame.origin.y + view.frame.size.height)

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        // Initialization code
//        backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 35)];
//        backImageView.image = [UIImageGetImageFromName(@"dikuang13.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
//        [self.contentView addSubview:backImageView];
//        [backImageView release];
        
        UIImageView *zuoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 65, 40)];
        zuoImageView.image = UIImageGetImageFromName(@"YuSheTitleRed.png");
        [self.contentView addSubview:zuoImageView];
        [zuoImageView release];
        
        
        nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(10, zuoImageView.bounds.origin.y, zuoImageView.bounds.size.width - 13, zuoImageView.bounds.size.height);
        [zuoImageView addSubview:nameLabel];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textAlignment = 0;
        nameLabel.lineBreakMode = 0;
        nameLabel.numberOfLines = 0;
        [nameLabel release];
        
        btn1  = [[GCBallView alloc] initWithFrame:CGRectMake(ORIGIN_X(zuoImageView) + 9, 3, 73, 40) Num:@"1" ColorType:GCBallViewYuShe];
//        [btn1 loadButonImage:@"TXWZBG960.png" LabelName:@"1"];
//        btn1.buttonName.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
//        btn1.buttonName.frame = CGRectMake(0, 3, 73, 18);
//        btn1.buttonName.shadowColor = [UIColor clearColor];
//        btn1.buttonName.font= [UIFont boldSystemFontOfSize:15];
//        btn1.highTextColor = [UIColor whiteColor];
//        btn1.hightImage = [UIImageGetImageFromName(@"dikuang5.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        btn1.tag = 1;
        [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 73, 10)];
//        label1.backgroundColor = [UIColor orangeColor];
//        label1.font = [UIFont boldSystemFontOfSize:8];
//        label1.textColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
//        [btn1 addSubview:label1];
//        label1.textAlignment = NSTextAlignmentCenter;
//        btn1.otherLabel = label1;
//        [label1 release];
        [self.contentView addSubview:btn1];
        
        btn2  = [[GCBallView alloc] initWithFrame:CGRectMake(ORIGIN_X(btn1) + 7, 3, 73, 40) Num:@"1" ColorType:GCBallViewYuShe];

//        btn2  = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//        btn2.frame = CGRectMake(ORIGIN_X(btn1) + 7, 3, 73, 40);
//        [btn2 loadButonImage:@"TXWZBG960.png" LabelName:@"1"];
//        btn2.buttonName.textColor = btn1.buttonName.textColor;
////        btn2.buttonName.shadowColor = [UIColor clearColor];
//        btn2.buttonName.frame = btn1.buttonName.frame;
//        btn2.buttonName.font= btn2.buttonName.font;
//        btn2.highTextColor = [UIColor whiteColor];
        btn2.tag = 2;
        [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        btn2.hightImage = [UIImageGetImageFromName(@"dikuang5.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
//        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 73, 10)];
//        label2.backgroundColor = [UIColor clearColor];
//        label2.font = [UIFont boldSystemFontOfSize:8];
//        label2.textColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
//        [btn2 addSubview:label2];
//        label2.textAlignment = NSTextAlignmentCenter;
//        btn2.otherLabel = label2;
//        [label2 release];
        [self.contentView addSubview:btn2];
        
        btn3  = [[GCBallView alloc] initWithFrame:CGRectMake(ORIGIN_X(btn2) + 7, 3, 73, 40) Num:@"1" ColorType:GCBallViewYuShe];

//        btn3  = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//        btn3.frame = CGRectMake(ORIGIN_X(btn2) + 7, 3, 73, 40);
//        [btn3 loadButonImage:@"TXWZBG960.png" LabelName:@"1"];
//        btn3.buttonName.textColor = btn1.buttonName.textColor;
        btn3.tag = 3;
        [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        btn3.buttonName.frame = btn1.buttonName.frame;
//        btn3.buttonName.font = btn1.buttonName.font;
////        btn3.buttonName.shadowColor = [UIColor clearColor];
////        btn3.highTextColor = [UIColor whiteColor];
//        btn3.hightImage = [UIImageGetImageFromName(@"dikuang5.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
//        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 73, 10)];
//        label3.backgroundColor = [UIColor clearColor];
//        label3.font = [UIFont boldSystemFontOfSize:8];
//        label3.textColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
//        label3.textAlignment = NSTextAlignmentCenter;
//        [btn3 addSubview:label3];
//        btn3.otherLabel = label3;
//        [label3 release];
        [self.contentView addSubview:btn3];
        
    }
    return self;
}

- (void)btnClick:(GCBallView *)sender {
    if (tuijianCellDelegate && [tuijianCellDelegate respondsToSelector:@selector(BtnClick:WithCell:)]) {
        [tuijianCellDelegate BtnClick:sender WithCell:self];
    }
}

- (void)LoadName:(NSString *)name {
    nameLabel.text = name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)changeHeZhiDuan:(NSString *)num {
    NSArray *array = [NSArray arrayWithObjects:@"3-4",@"5-7",@"8-10",@"11-13",@"14-16",@"17-18", nil];
    if ([num intValue] < [array count]) {
        return [array objectAtIndex:[num intValue]];
    }
    return @"-";
}

- (void)LoadData:(NSString *)data {
    NSArray *dataArray = [data componentsSeparatedByString:@","];
    btn1.hidden = YES;
    btn2.hidden = YES;
    btn3.hidden = YES;
    for (int i = 0; i < [dataArray count]; i ++) {
        NSString *st = [dataArray objectAtIndex:i];
        NSArray *array = [st componentsSeparatedByString:@"#"];
        if ([array count] >= 2) {
            if (i == 0) {
                
                if ([nameLabel.text isEqualToString:@"号码和值段"]) {
                    btn1.numLabel.text = [self changeHeZhiDuan:[array objectAtIndex:0]];
                }
                else {
                    btn1.numLabel.text = [array objectAtIndex:0];
                }
                btn1.ylLable.text = [NSString stringWithFormat:@"遗漏%@",[array objectAtIndex:1]];
                btn1.hidden = NO;
            }
            else if (i == 1) {
                if ([nameLabel.text isEqualToString:@"号码和值段"]) {
                    btn2.numLabel.text = [self changeHeZhiDuan:[array objectAtIndex:0]];
                }
                else {
                    btn2.numLabel.text = [array objectAtIndex:0];
                }
                btn2.ylLable.text = [NSString stringWithFormat:@"遗漏%@",[array objectAtIndex:1]];
                btn2.hidden = NO;
            }
            else if (i == 2) {
                if ([nameLabel.text isEqualToString:@"号码和值段"]) {
                    btn3.numLabel.text = [self changeHeZhiDuan:[array objectAtIndex:0]];
                }
                else {
                    btn3.numLabel.text = [array objectAtIndex:0];
                }
                btn3.ylLable.text = [NSString stringWithFormat:@"遗漏%@",[array objectAtIndex:1]];
                btn3.hidden = NO;
            }
        }
    }
    
}

- (void)dealloc {
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    