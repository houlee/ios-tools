//
//  MyProfileWCTableViewCell.m
//  caibo
//
//  Created by GongHe on 14-5-29.
//
//

#import "MyProfileWCTableViewCell.h"

#define ORIGIN_X(view) (view.frame.origin.x + view.frame.size.width)
#define ORIGIN_Y(view) (view.frame.origin.y + view.frame.size.height)

@implementation MyProfileWCTableViewCell

@synthesize cupImageView;
@synthesize cupNameLabel;
@synthesize flagNumberColorView;
@synthesize flagContentColorView;
@synthesize listButton;
@synthesize howButton;

@synthesize caiJinLabel;
@synthesize countdownColorView;
@synthesize signUpButton;
@synthesize questionMarkButton;
@synthesize faceImageView;
@synthesize faceImageView1;

- (void)dealloc
{
    [cupImageView release];
    [cupNameLabel release];
    [flagNumberColorView release];
    [flagContentColorView release];
    [listButton release];
    [howButton release];
    
    [caiJinLabel release];
    [countdownColorView release];
    [signUpButton release];
    [questionMarkButton release];
    [faceImageView release];
    [faceImageView1 release];

    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(int)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView * lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
        lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:lineView];
        
        float lineHeight = 0;
        
        if (!type) {
//            lineHeight = 102;
            
            faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 12, 16, 16)];
            faceImageView.image = UIImageGetImageFromName(@"WC_Face.png");
            [self.contentView addSubview:faceImageView];
            faceImageView.hidden = YES;
            
            cupImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 15, 54, 54)];
            [self.contentView addSubview:cupImageView];
            
            cupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(27.5, ORIGIN_Y(cupImageView) + 5, 54, 20)];
            cupNameLabel.backgroundColor = [UIColor clearColor];
            cupNameLabel.font = [UIFont boldSystemFontOfSize:12];
            cupNameLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:cupNameLabel];
            
            faceImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(cupImageView) + 12, 12, 16, 16)];
            faceImageView1.image = UIImageGetImageFromName(@"WC_Face1.png");
            [self.contentView addSubview:faceImageView1];
            faceImageView1.hidden = YES;
            
            flagNumberColorView = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(cupImageView) + 12, 11, 225, 20)];
            flagNumberColorView.textColor = [UIColor blackColor];
            flagNumberColorView.changeColor = [UIColor colorWithRed:40/255.0 green:153/255.0 blue:192/255.0 alpha:1];
            flagNumberColorView.font = [UIFont systemFontOfSize:15];
            flagNumberColorView.colorfont = flagNumberColorView.font;
            flagNumberColorView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:flagNumberColorView];
            
            flagContentColorView = [[ColorView alloc] initWithFrame:CGRectMake(flagNumberColorView.frame.origin.x, ORIGIN_Y(flagNumberColorView) + 18, 320 - flagNumberColorView.frame.origin.x - 11, 40)];
            flagContentColorView.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
            flagContentColorView.changeColor = [UIColor colorWithRed:45/255.0 green:115/255.0 blue:47/255.0 alpha:1];
            flagContentColorView.font = [UIFont systemFontOfSize:12];
            flagContentColorView.colorfont = flagContentColorView.font;
            flagContentColorView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:flagContentColorView];
            
            listButton = [[UIButton alloc] init];
            [listButton setTitle:@"获奖名单" forState:UIControlStateNormal];
            [listButton setTitleColor:[UIColor colorWithRed:45/255.0 green:115/255.0 blue:47/255.0 alpha:1] forState:UIControlStateNormal];
            listButton.titleLabel.font = [UIFont systemFontOfSize:12];
            listButton.titleLabel.lineBreakMode = 0;
            
            CGSize listButtonSize = [[NSString stringWithFormat:@"%@",listButton.titleLabel.text] sizeWithFont:listButton.titleLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:0];
            listButton.frame = CGRectMake(320 - listButtonSize.width - 11, 0, listButtonSize.width, 40);
            [self.contentView addSubview:listButton];
            
            howButton = [[UIButton alloc] init];
            [howButton setTitle:@"如何收集国旗?" forState:UIControlStateNormal];
            [howButton setTitleColor:[UIColor colorWithRed:243/255.0 green:202/255.0 blue:144/255.0 alpha:1] forState:UIControlStateNormal];
            howButton.titleLabel.font = [UIFont systemFontOfSize:12];
            howButton.titleLabel.lineBreakMode = 0;
            
            CGSize howButtonSize = [[NSString stringWithFormat:@"%@",howButton.titleLabel.text] sizeWithFont:howButton.titleLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:0];
            howButton.frame = CGRectMake(320 - howButtonSize.width - 11, cupNameLabel.frame.origin.y - 7, howButtonSize.width, 35);
            [self.contentView addSubview:howButton];
        }
        else if (type == 1) {
//            lineHeight = 60;
            
            caiJinLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 11, 110, 15)];
            caiJinLabel.backgroundColor = [UIColor clearColor];
            caiJinLabel.font = [UIFont systemFontOfSize:12];
            caiJinLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
            [self.contentView addSubview:caiJinLabel];
            
            questionMarkButton = [[UIButton alloc] initWithFrame:CGRectMake(ORIGIN_X(caiJinLabel) - 8, 0, 36, 36)];
            questionMarkButton.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:questionMarkButton];
            
            UIImageView * questionMarkImageView = [[[UIImageView alloc] initWithFrame:CGRectMake((questionMarkButton.frame.size.width - 14)/2, (questionMarkButton.frame.size.height - 14)/2, 14, 14)] autorelease];
            questionMarkImageView.image = UIImageGetImageFromName(@"faq-wenhao.png");
            [questionMarkButton addSubview:questionMarkImageView];
            
            countdownColorView = [[ColorView alloc] initWithFrame:CGRectMake(11, ORIGIN_Y(caiJinLabel) + 6, 200, 20)];
            countdownColorView.textColor = [UIColor blackColor];
            countdownColorView.changeColor = [UIColor colorWithRed:243/255.0 green:202/255.0 blue:144/255.0 alpha:1] ;
            countdownColorView.font = [UIFont systemFontOfSize:14];
            countdownColorView.colorfont = [UIFont systemFontOfSize:15];
            countdownColorView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:countdownColorView];
            
            signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(320 - 11 - 101.5, 11, 101.5, 38)];
            signUpButton.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
            [signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            signUpButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [signUpButton setTitle:@"我要报名" forState:UIControlStateNormal];
            signUpButton.layer.cornerRadius = 5;
            signUpButton.enabled = NO;
            [self.contentView addSubview:signUpButton];
        }
        else if (type == 2) {
            lineHeight = 516;
            
            NSString * path = [[NSBundle mainBundle] pathForResource:@"teamInfo_Name" ofType:@"plist"];
            NSDictionary * teamInfoDic =[NSDictionary dictionaryWithContentsOfFile:path];
            
            NSArray * teamArray = @[
  @[@"阿尔及利亚",@"比利时",@"厄瓜多尔",@"韩国",@"喀麦隆",@"墨西哥",@"瑞士",@"伊朗"],
  @[@"阿根廷",@"波黑",@"法国",@"荷兰",@"科特迪瓦",@"尼日利亚",@"乌拉圭",@"意大利"],
  @[@"澳大利亚",@"德国",@"哥伦比亚",@"洪都拉斯",@"克罗地亚",@"葡萄牙",@"西班牙",@"英格兰"],
  @[@"巴西",@"俄罗斯",@"哥斯达黎加",@"加纳",@"美国",@"日本",@"希腊",@"智利"]];
            
            for (int i = 0; i < 4; i++) {
                for (int j = 0; j < 8; j++) {
                    UIImageView * flagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17 + (47 + 32) * i, 12 + (26.5 + 36) * j, 47, 26.5)];
                    flagImageView.image = UIImageGetImageFromName(@"NoFlag.png");
                    flagImageView.tag = [[[teamInfoDic objectForKey:[[teamArray objectAtIndex:i] objectAtIndex:j]] valueForKey:@"id"] integerValue];
                    [self.contentView addSubview:flagImageView];
                    flagImageView.layer.borderWidth = 0.5;
                    flagImageView.layer.borderColor = [UIColor grayColor].CGColor;
                    [flagImageView release];
                    
                    UILabel * flagNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + 79 * i, ORIGIN_Y(flagImageView) + 10, 66, 16)];
                    flagNameLabel.backgroundColor = [UIColor clearColor];
                    flagNameLabel.textAlignment = 1;
                    flagNameLabel.textColor = [UIColor blackColor];
                    flagNameLabel.text = [[teamArray objectAtIndex:i] objectAtIndex:j];
                    flagNameLabel.font = [UIFont systemFontOfSize:12];
                    [self.contentView addSubview:flagNameLabel];
                    [flagNameLabel release];
                    
                    UIView * lineView1 = [[[UIView alloc] initWithFrame:CGRectMake(0, lineHeight - 0.5, 320, 0.5)] autorelease];
                    lineView1.backgroundColor = [UIColor lightGrayColor];
                    [self.contentView addSubview:lineView1];
                }
            }
        }
    }
    return self;
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