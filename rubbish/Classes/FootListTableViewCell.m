//
//  FootListTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-5-23.
//
//

#import "FootListTableViewCell.h"

@implementation FootListTableViewCell
@synthesize listType;
@synthesize delegate;
@synthesize footIndexPath;
@synthesize analyzeDictionary, teamID;
@synthesize macthLabel;
@synthesize keyString;

- (void)dealloc{
    [teamID release];
    [super dealloc];
}

- (void)setListType:(CellListType)_listType{
    
    listType = _listType;
    
    if (listType == homeCellType) {
        
        [macthButton setBackgroundImage:[UIImageGetImageFromName(@"shangfangliansai.png") stretchableImageWithLeftCapWidth:30 topCapHeight:20]  forState:UIControlStateNormal];
        [macthButton setBackgroundImage:[UIImageGetImageFromName(@"shangfangliansai_down.png") stretchableImageWithLeftCapWidth:30 topCapHeight:20]  forState:UIControlStateHighlighted];

        [teamButton setBackgroundImage:[UIImageGetImageFromName(@"shangfangliansai.png") stretchableImageWithLeftCapWidth:30 topCapHeight:20]  forState:UIControlStateNormal];
        [teamButton setBackgroundImage:[UIImageGetImageFromName(@"shangfangliansai_down.png") stretchableImageWithLeftCapWidth:30 topCapHeight:20]  forState:UIControlStateHighlighted];

        macthLabel.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        oneLineImage.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        shulineImage.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        macthJiaImageView.image = UIImageGetImageFromName(@"jiaone.png");
        jiaImageView.image = UIImageGetImageFromName(@"jiaone.png");
    }else if (listType == guestCellType){
    
        [macthButton setBackgroundImage:[UIImageGetImageFromName(@"zhongjianliansai.png") stretchableImageWithLeftCapWidth:30 topCapHeight:20]  forState:UIControlStateNormal];
        [macthButton setBackgroundImage:[UIImageGetImageFromName(@"zhongjianliansai_down.png") stretchableImageWithLeftCapWidth:30 topCapHeight:20]  forState:UIControlStateHighlighted];

        [teamButton setBackgroundImage:[UIImageGetImageFromName(@"zhongjianliansai.png") stretchableImageWithLeftCapWidth:30 topCapHeight:20]  forState:UIControlStateNormal];
        [teamButton setBackgroundImage:[UIImageGetImageFromName(@"zhongjianliansai_down.png") stretchableImageWithLeftCapWidth:30 topCapHeight:20]  forState:UIControlStateHighlighted];

        macthLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];//[UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        oneLineImage.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];//[UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        shulineImage.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];
        macthJiaImageView.image = UIImageGetImageFromName(@"jiatwo.png");
        jiaImageView.image = UIImageGetImageFromName(@"jiatwo.png");
    }else if(listType == historyCellType){
        
        [macthButton setBackgroundImage:[UIImageGetImageFromName(@"dibuliansai.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20]  forState:UIControlStateNormal];
        [macthButton setBackgroundImage:[UIImageGetImageFromName(@"dibuliansai_down.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20]  forState:UIControlStateHighlighted];

        macthLabel.frame = macthButton.bounds;
        [teamButton setBackgroundImage:[UIImageGetImageFromName(@"dibuliansai.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20]  forState:UIControlStateNormal];
        [teamButton setBackgroundImage:[UIImageGetImageFromName(@"dibuliansai_down.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20]  forState:UIControlStateHighlighted];

        macthLabel.textColor = [UIColor colorWithRed:4/255.0 green:75/255.0 blue:175/255.0 alpha:1];
        oneLineImage.backgroundColor = [UIColor colorWithRed:4/255.0 green:75/255.0 blue:175/255.0 alpha:1];
        shulineImage.backgroundColor = [UIColor colorWithRed:4/255.0 green:75/255.0 blue:175/255.0 alpha:1];
        macthJiaImageView.image = UIImageGetImageFromName(@"jiathree.png");
        jiaImageView.image = UIImageGetImageFromName(@"jiathree.png");
    }
    
}

- (CellListType)listType{
    return listType;
}

- (NSMutableDictionary *)analyzeDictionary{

    return analyzeDictionary;
}

- (void)setAnalyzeDictionary:(NSMutableDictionary *)_analyzeDictionary{
    
    if (analyzeDictionary != _analyzeDictionary) {
        [analyzeDictionary release];
        analyzeDictionary = [_analyzeDictionary retain];
    }

    NSDictionary * dict = [analyzeDictionary objectForKey:keyString];
    NSArray * dataArray = nil;
    if (listType == homeCellType) {
        
        dataArray = [dict objectForKey:@"hostRecentPlay"];
        
    }else if (listType == guestCellType){
        
       dataArray = [dict objectForKey:@"guestRecentPlay"];
        
    }else if(listType == historyCellType){
        
        dataArray = [dict objectForKey:@"playvs"];
    
    }
    
    if (dataArray && [dataArray count] > 0) {
        if ([dataArray count] > footIndexPath.row) {
            NSDictionary * dataDict = [dataArray objectAtIndex:footIndexPath.row];
            //右边cell赋值
            macthLabel.text = [dataDict objectForKey:@"league"];
            homeLabel.text = [dataDict objectForKey:@"hname"];
            guestLabel.text = [dataDict objectForKey:@"gname"];
            scoreLabel.text =[dataDict objectForKey:@"score"];
            //左边cell赋值
            shengLabel.text = [dataDict objectForKey:@"win"];
            pingLabel.text = [dataDict objectForKey:@"same"];
            fuLabel.text = [dataDict objectForKey:@"lost"];
            leftScoreLabel.text = [dataDict objectForKey:@"halfscore"];
            
            NSArray * timeArray = [[dataDict objectForKey:@"playtime"] componentsSeparatedByString:@" "];
            if ([timeArray count] >= 2) {
                NSString * timeStr = [timeArray objectAtIndex:0];
                timeStr = [timeStr substringFromIndex:2];
                 timeLabel.text = timeStr;
            }else{
                timeLabel.text = @"";
            }
            
            if ([[dataDict objectForKey:@"cold"] integerValue] == 1) {
                
                coldImage.hidden = NO;
                
                if ([shengLabel.text floatValue] > [fuLabel.text floatValue]) {
                    oneColdImage.hidden = NO;
                    twoColdImage.hidden = YES;
                    threeColdImage.hidden = YES;
                }else if ([shengLabel.text floatValue] < [fuLabel.text floatValue]){
                    oneColdImage.hidden = YES;
                    twoColdImage.hidden = YES;
                    threeColdImage.hidden = NO;
                }
                
            }else{
                coldImage.hidden = YES;
                oneColdImage.hidden = YES;
                twoColdImage.hidden = YES;
                threeColdImage.hidden = YES;
                
            }
            
            
            if ([[dataDict objectForKey:@"odds_type"] integerValue] == 2) {//欧赔蓝色
                shengLabel.textColor = [UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
                pingLabel.textColor = [UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
                fuLabel.textColor = [UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
            }else{//其他黑色
                shengLabel.textColor = [UIColor blackColor];
                pingLabel.textColor = [UIColor blackColor];
                fuLabel.textColor = [UIColor blackColor];
                
            }
            
           
            if ([teamID isEqualToString:[dataDict objectForKey:@"hostid"]]) {
                if ([[dataDict objectForKey:@"result"] isEqualToString:@"胜"]) {
                    homeLabel.textColor = [UIColor colorWithRed:251/255.0 green:0/255.0 blue:30/255.0 alpha:1];//[UIColor colorWithRed:14/255.0 green:97/255.0 blue:194/255.0 alpha:1];
                }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"平"]){
                    homeLabel.textColor = [UIColor colorWithRed:51/255.0 green:168/255.0 blue:32/255.0 alpha:1];
                }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"负"]){
                    homeLabel.textColor = [UIColor colorWithRed:14/255.0 green:97/255.0 blue:194/255.0 alpha:1];//[UIColor colorWithRed:251/255.0 green:0/255.0 blue:30/255.0 alpha:1];
                }
                guestLabel.textColor = [UIColor blackColor];
            }else if ([teamID isEqualToString:[dataDict objectForKey:@"guestid"]]){
                if ([[dataDict objectForKey:@"result"] isEqualToString:@"胜"]) {
                    guestLabel.textColor = [UIColor colorWithRed:251/255.0 green:0/255.0 blue:30/255.0 alpha:1];
                }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"平"]){
                    guestLabel.textColor = [UIColor colorWithRed:51/255.0 green:168/255.0 blue:32/255.0 alpha:1];
                }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"负"]){
                    guestLabel.textColor = [UIColor colorWithRed:14/255.0 green:97/255.0 blue:194/255.0 alpha:1];
                }
                homeLabel.textColor = [UIColor blackColor];
            }else{
            
                homeLabel.textColor = [UIColor blackColor];
                guestLabel.textColor = [UIColor blackColor];
            }
            
            shengLabel.backgroundColor = [UIColor clearColor];//赔率的背景色
            pingLabel.backgroundColor = [UIColor clearColor];
            fuLabel.backgroundColor = [UIColor clearColor];
            
            if (listType == homeCellType ||listType == historyCellType) {
                
                if ([teamID isEqualToString:[dataDict objectForKey:@"hostid"]]) {
                    
                    if ([[dataDict objectForKey:@"result"] isEqualToString:@"胜"]) {
                        shengLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"平"]) {
                        pingLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"负"]) {
                        fuLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }
                    
                }else{
                    if ([[dataDict objectForKey:@"result"] isEqualToString:@"胜"]) {
                        fuLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"平"]) {
                        pingLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"负"]) {
                        shengLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }
                
                
                }
                
            }else if (listType == guestCellType){
                if ([teamID isEqualToString:[dataDict objectForKey:@"guestid"]]) {
                    
                    if ([[dataDict objectForKey:@"result"] isEqualToString:@"胜"]) {
                        fuLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"平"]) {
                        pingLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"负"]) {
                        shengLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }
                    
                }else{
                    if ([[dataDict objectForKey:@"result"] isEqualToString:@"胜"]) {
                        shengLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"平"]) {
                        pingLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }else if ([[dataDict objectForKey:@"result"] isEqualToString:@"负"]) {
                        fuLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:204/255.0 alpha:1];
                    }
                    
                    
                }
            }
            
            
        }
    }
    
    
}



- (void)pressMacthButton:(UIButton *)sender{//点击联赛名触发

    if (delegate && [delegate respondsToSelector:@selector(FootListTableViewCell:macthTouch:teamButtonTouch:indexPath:dict:)]) {
        NSDictionary * dict = [analyzeDictionary objectForKey:keyString];
        NSArray * dataArray = nil;
        if (listType == homeCellType) {
            
            dataArray = [dict objectForKey:@"hostRecentPlay"];
            
        }else if (listType == guestCellType){
            
            dataArray = [dict objectForKey:@"guestRecentPlay"];
            
        }else if(listType == historyCellType){
            
            dataArray = [dict objectForKey:@"playvs"];
            
        }
        NSDictionary * dataDict = nil;
        if (dataArray && [dataArray count] > 0 ) {
            dataDict = [dataArray objectAtIndex:footIndexPath.row];
        }
        
        [delegate FootListTableViewCell:self macthTouch:YES teamButtonTouch:NO indexPath:footIndexPath dict:dataDict];
    }
}

- (void)pressTeamButton:(UIButton *)sender{//点击对阵触发
    
    if (delegate && [delegate respondsToSelector:@selector(FootListTableViewCell:macthTouch:teamButtonTouch:indexPath:dict:)]) {
        [delegate FootListTableViewCell:self macthTouch:NO teamButtonTouch:YES indexPath:footIndexPath dict:nil];
    }
}


- (void)leftCellShowFunc{
    
    
    shulineImage = [[UIImageView alloc] initWithFrame:CGRectMake(311, 0, 0.5, 48)];
    [self.contentView addSubview:shulineImage];
    [shulineImage release];

    oneLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(311, 47.5, 320, 0.5)];
    [self.contentView addSubview:oneLineImage];
    [oneLineImage release];
    
    shengLabel = [[UILabel alloc] initWithFrame:CGRectMake(311+0.5+111+59, 0.5, 50-0.5, 47)];
    shengLabel.backgroundColor = [UIColor clearColor];
    shengLabel.font = [UIFont systemFontOfSize:12];
    shengLabel.textAlignment = NSTextAlignmentCenter;
//    shengLabel.text = @"1.67";
    [self.contentView addSubview:shengLabel];
    [shengLabel release];
    
    oneColdImage = [[UIImageView alloc] initWithFrame:CGRectMake(3,3, 14, 13)];
    oneColdImage.backgroundColor = [UIColor clearColor];
    oneColdImage.image  = UIImageGetImageFromName(@"lengimage.png");
    [shengLabel addSubview:oneColdImage];
    [oneColdImage release];
    
    pingLabel = [[UILabel alloc] initWithFrame:CGRectMake(311+50+111+59, 0.5, 50, 47)];
    pingLabel.backgroundColor = [UIColor clearColor];
    pingLabel.font = [UIFont systemFontOfSize:12];
    pingLabel.textAlignment = NSTextAlignmentCenter;
//    pingLabel.text = @"2.82";
    [self.contentView addSubview:pingLabel];
    [pingLabel release];
    
    twoColdImage = [[UIImageView alloc] initWithFrame:CGRectMake(3,3, 14, 13)];
    twoColdImage.backgroundColor = [UIColor clearColor];
    twoColdImage.image  = UIImageGetImageFromName(@"lengimage.png");
    [pingLabel addSubview:twoColdImage];
    [twoColdImage release];
    
    fuLabel = [[UILabel alloc] initWithFrame:CGRectMake(311+100+111+59, 0.5, 50, 47)];
    fuLabel.backgroundColor = [UIColor clearColor];
    fuLabel.font = [UIFont systemFontOfSize:12];
    fuLabel.textAlignment = NSTextAlignmentCenter;
//    fuLabel.text = @"4.97";
    [self.contentView addSubview:fuLabel];
    [fuLabel release];
    
    threeColdImage = [[UIImageView alloc] initWithFrame:CGRectMake(3,3, 14, 13)];
    threeColdImage.backgroundColor = [UIColor clearColor];
    threeColdImage.image  = UIImageGetImageFromName(@"lengimage.png");
    [fuLabel addSubview:threeColdImage];
    [threeColdImage release];
    
    leftScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(311+111, 0.5, 59, 47)];
    leftScoreLabel.backgroundColor = [UIColor clearColor];
    leftScoreLabel.font = [UIFont systemFontOfSize:12];
    leftScoreLabel.textAlignment = NSTextAlignmentCenter;
//    leftScoreLabel.text = @"2-2";
    [self.contentView addSubview:leftScoreLabel];
    [leftScoreLabel release];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(311+0.5, 0.5, 320 - 209, 47)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentCenter;
//    timeLabel.text = @"14-01-02";
    [self.contentView addSubview:timeLabel];
    [timeLabel release];
    
}

- (void)rightCellShowFunc{

    macthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    macthButton.frame = CGRectMake(10, 3, 51, 42);
    [macthButton addTarget:self action:@selector(pressMacthButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:macthButton];
    
    macthLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 47, macthButton.frame.size.height)];
    macthLabel.backgroundColor = [UIColor clearColor];
    macthLabel.font = [UIFont systemFontOfSize:14];
    macthLabel.textAlignment = NSTextAlignmentCenter;
//    macthLabel.text = @"英超";
    [macthButton addSubview:macthLabel];
    [macthLabel release];
    
    macthJiaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(51 - 11, 42 - 11, 7, 7)];
    macthJiaImageView.backgroundColor = [UIColor clearColor];
    [macthButton addSubview:macthJiaImageView];
    [macthJiaImageView  release];
    
    
    teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
    teamButton.frame = CGRectMake(macthButton.frame.origin.x + macthButton.frame.size.width + 5, 3, 238, 42);
    [teamButton addTarget:self action:@selector(pressTeamButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:teamButton];
    
    
    homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 88, teamButton.frame.size.height)];
    homeLabel.backgroundColor = [UIColor clearColor];
    homeLabel.textColor = [UIColor blackColor];
    homeLabel.font = [UIFont systemFontOfSize:12];
    homeLabel.textAlignment = NSTextAlignmentCenter;
//    homeLabel.text = @"曼联";
    [teamButton addSubview:homeLabel];
    [homeLabel release];
    
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, 0, 44, teamButton.frame.size.height)];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor blackColor];
    scoreLabel.font = [UIFont systemFontOfSize:12];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
//    scoreLabel.text = @"1-2";
    [teamButton addSubview:scoreLabel];
    [scoreLabel release];
    
    guestLabel = [[UILabel alloc] initWithFrame:CGRectMake(teamButton.frame.size.width - 98, 0, 88, teamButton.frame.size.height)];
    guestLabel.backgroundColor = [UIColor clearColor];
    guestLabel.textColor = [UIColor blackColor];
    guestLabel.font = [UIFont systemFontOfSize:12];
    guestLabel.textAlignment = NSTextAlignmentCenter;
//    guestLabel.text = @"切尔西";
    [teamButton addSubview:guestLabel];
    [guestLabel release];
    
    coldImage = [[UIImageView alloc] initWithFrame:CGRectMake(teamButton.frame.size.width - 2 - 13, 2, 14, 13)];
    coldImage.backgroundColor = [UIColor clearColor];
    coldImage.image  = UIImageGetImageFromName(@"lengimage.png");
    [teamButton addSubview:coldImage];
    [coldImage release];
    
    jiaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(238 - 11, 42 - 11, 7, 7)];
    jiaImageView.backgroundColor = [UIColor clearColor];
    [teamButton addSubview:jiaImageView];
    [jiaImageView  release];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self leftCellShowFunc];  // 左边cell
        [self rightCellShowFunc];//右边cell
        
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
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