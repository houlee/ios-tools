//
//  JiangJinJiSuanView.m
//  caibo
//
//  Created by yaofuyu on 14-3-12.
//
//

#import "JiangJinJiSuanView.h"
#import "caiboAppDelegate.h"

@implementation JiangJinJiSuanView
@synthesize dataDic;
@synthesize lottoryID;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return self;
}

- (void)show {
    self.frame = [UIScreen mainScreen].bounds;
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 35, 290, 427)];
    [self addSubview:backImageView];
    backImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    backImageView.userInteractionEnabled = YES;
    backImageView.image = [UIImageGetImageFromName(@"jiangjinBack.png") stretchableImageWithLeftCapWidth:0 topCapHeight:35];
    [backImageView release];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(85, 3, 120, 30)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"我的奖金";
    [backImageView addSubview:titleLable];
    [titleLable release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backImageView addSubview:btn];
    btn.frame = CGRectMake(15, 373, 260, 40);
    [btn setImage:UIImageGetImageFromName(@"jiangjin.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"jiangjinzhong.png") forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *btnLable = [[UILabel alloc] initWithFrame:btn.bounds];
    btnLable.backgroundColor = [UIColor clearColor];
    btnLable.textColor = [UIColor whiteColor];
    btnLable.font = [UIFont systemFontOfSize:16];
    btnLable.textAlignment = NSTextAlignmentCenter;
    btnLable.text = @"取消";
    [btn addSubview:btnLable];
    [btnLable release];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 165, 20)];
    [backImageView addSubview:moneyLabel];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.text = [self.dataDic objectForKey:@"totalaward"];
    moneyLabel.frame = CGRectMake(-25 + [moneyLabel.text sizeWithFont:moneyLabel.font].width /2, 50, 165, 20);
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.layer.masksToBounds = NO;
    moneyLabel.textColor = [UIColor redColor];
    [moneyLabel release];
    
    UILabel *moneyLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(168, 0, 165, 20)];
    [moneyLabel addSubview:moneyLabel2];
    moneyLabel2.backgroundColor = [UIColor clearColor];
    moneyLabel2.text = @"元";
    moneyLabel2.textAlignment = NSTextAlignmentLeft;
    moneyLabel2.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
    [moneyLabel2 release];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 83, 290, 275)];
    [backImageView addSubview:myTableView];
    myTableView.dataSource= self;
    myTableView.delegate = self;
    
    // ***加线
    UIView *lineView = [[[UIView alloc] init] autorelease];
    lineView.frame = CGRectMake(0,83 + 274.5, backImageView.frame.size.width, 0.5);
    lineView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    [backImageView addSubview:lineView];
    
    
    [myTableView release];
    
    [[caiboAppDelegate getAppDelegate].window addSubview:self];
}

- (void)removeSelf {
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
}

- (void)dealloc {
    self.dataDic = nil;
    self.lottoryID = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView =[[[UIView alloc] init] autorelease];
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(6, 0, 278, 40)];
    [backView addSubview:backView2];
    [backView2 release];
    backView2.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 72, 40)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"奖项";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    [backView2 addSubview:label1];
    [label1 release];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(72, 0, 106, 40)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"中奖注数（注）";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textAlignment = NSTextAlignmentCenter;
    
    label2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    [backView2 addSubview:label2];
    [label2 release];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(178, 0, 100, 40)];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = @"中奖奖金（元）";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:13];
    label3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    [backView2 addSubview:label3];
    [label3 release];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 278, 1)];
    line1.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [backView2 addSubview:line1];
    [line1 release];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(72, 10, 1, 20)];
    line2.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [backView2 addSubview:line2];
    [line2 release];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(178, 10, 1, 20)];
    line3.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [backView2 addSubview:line3];
    [line3 release];
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 278, 1)];
    line4.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [backView2 addSubview:line4];
    [line4 release];
    
    return backView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.lottoryID isEqualToString:@"001"]) {
        return 6;
    }
    else if ([self.lottoryID isEqualToString:@"113"]) {
        return 6;
    }
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0 + 6, 0, 72, 40)];
        label1.backgroundColor = [UIColor clearColor];
        label1.tag = 101;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:16];
        label1.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label1];
        [label1 release];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(72 + 6, 0, 106, 40)];
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont systemFontOfSize:16];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.tag = 102;
        label2.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label2];
        [label2 release];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(178 + 6, 0, 100, 40)];
        label3.backgroundColor = [UIColor clearColor];
        label3.tag = 103;
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:16];
        label3.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label3];
        [label3 release];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(72 + 6, 0, 1, 43)];
        line2.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [cell.contentView addSubview:line2];
        [line2 release];
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(178 + 6, 0, 1, 43)];
        line3.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [cell.contentView addSubview:line3];
        [line3 release];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    
    UILabel *lable1 = (UILabel *)[cell.contentView viewWithTag:101];
    UILabel *lable2 = (UILabel *)[cell.contentView viewWithTag:102];
    UILabel *lable3 = (UILabel *)[cell.contentView viewWithTag:103];
    switch (indexPath.row) {
        case 0:
        {
            lable1.text = @"一等奖";
            lable2.text = [self.dataDic objectForKey:@"1_num"];
            lable3.text = [self.dataDic objectForKey:@"1_award"];
        }
            break;
        case 1:
        {
            lable1.text = @"二等奖";
            lable2.text = [self.dataDic objectForKey:@"2_num"];
            lable3.text = [self.dataDic objectForKey:@"2_award"];
        }
            break;
        case 2:
        {
            lable1.text = @"三等奖";
            lable2.text = [self.dataDic objectForKey:@"3_num"];
            lable3.text = [self.dataDic objectForKey:@"3_award"];
        }
            break;
        case 3:
        {
            lable1.text = @"四等奖";
            lable2.text = [self.dataDic objectForKey:@"4_num"];
            lable3.text = [self.dataDic objectForKey:@"4_award"];
        }
            break;
        case 4:
        {
            lable1.text = @"五等奖";
            lable2.text = [self.dataDic objectForKey:@"5_num"];
            lable3.text = [self.dataDic objectForKey:@"5_award"];
        }
            break;
        case 5:
        {
            lable1.text = @"六等奖";
            lable2.text = [self.dataDic objectForKey:@"6_num"];
            lable3.text = [self.dataDic objectForKey:@"6_award"];
        }
            break;
//        case 6:
//        {
//            lable1.text = @"七等奖";
//            lable2.text = [self.dataDic objectForKey:@"7_num"];
//            lable3.text = [self.dataDic objectForKey:@"7_award"];
//        }
//            break;
//        case 7:
//        {
//            lable1.text = @"八等奖";
//            lable2.text = [self.dataDic objectForKey:@"8_num"];
//            lable3.text = [self.dataDic objectForKey:@"8_award"];
//        }
//            
//            break;
            
        default:
            break;
    }
    return cell;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    