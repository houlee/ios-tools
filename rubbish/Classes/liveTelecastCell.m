//
//  liveTelecastCell.m
//  caibo
//
//  Created by houchenguang on 13-6-26.
//
//

#import "liveTelecastCell.h"

@implementation liveTelecastCell
@synthesize indexPath;
@synthesize delegate;
@synthesize typeCell;

- (void)setLiveData:(liveTelecastData *)_liveData{

    if (liveData != _liveData) {
        
        [liveData release];
        liveData = [_liveData retain];
        
    }
    ///////////////////////////////////////数据介入
    
    homeTeam.text = liveData.home;
    leagueMatches.text = liveData.leagueName;
    guestTeam.text = liveData.away;
    matchNum.text = liveData.xh;
    vsLabel.text = liveData.caiguo;
    
    
//    if ([liveData.start isEqualToString:@"0"]) {
//         
//        vsLabel.text = @"VS";
//        guestUpLabel.text = @"";
//    }else{
        vsLabel.text = [NSString stringWithFormat:@"%@:%@", liveData.scoreHost,liveData.awayHost];
        guestUpLabel.text = liveData.bcbf;
//    }
    
    
    homeUpLabel.text = liveData.ASIA_cp_p;
    vsUpLabel.text = liveData.status;
   
    
    concedePoints.text = [NSString stringWithFormat:@"(%@)", liveData.rangqiu];
    if ([concedePoints.text isEqualToString:@"()"]||[concedePoints.text isEqualToString:@"(0)"]) {
        concedePoints.text = @"";
    }
    
    if ([liveData.section_id length]) {
         pptvImge.image = UIImageGetImageFromName(@"pptvliveiamge.png");
    }
    else {
        pptvImge.image = nil;
    }
    
    NSArray * datestArr = [liveData.matchTime componentsSeparatedByString:@" "];
    if ([datestArr count] > 1) {
        NSString * timeString = [datestArr objectAtIndex:1];
        NSArray * timeArray = [timeString componentsSeparatedByString:@":"];
        if ([timeArray count] > 1) {
            endTime.text = [NSString stringWithFormat:@"%@:%@", [timeArray objectAtIndex:0], [timeArray objectAtIndex:1]];
        }else{
            endTime.text = @"";
        }
    }
    
   
    
    
    
    //hostcard：1_0_1 第一位表示红牌是1，第二位表示 黄牌是0,最后一位 0表示没顺序，1表示的是先出红牌。2表示显出皇牌。
   // awaycard 客队红黄牌数
    
    //主队的红黄牌
    
    NSArray * homeArray = [liveData.hostcard componentsSeparatedByString:@"_"];
    NSString * redString = @"";
    NSString * yellowString = @"";
    NSString * shunxu = @"";
    
    if ([homeArray count] > 2) {
        redString = [homeArray objectAtIndex:0];
        yellowString = [homeArray objectAtIndex:1];
        shunxu = [homeArray objectAtIndex:2];
    }
        
        if ([redString intValue] > 0 && [yellowString intValue] > 0) {
            
            if ([shunxu intValue] == 1) {
                homeYellow.image = UIImageGetImageFromName(@"hongpaiimage.png");
                homeRed.image = UIImageGetImageFromName(@"huangpaiimage.png");
                homeRed.hidden = NO;
                homeYellow.hidden = NO;
                
                homeOneLabel.text = yellowString;
                homeTwoLabel.text = redString;

            }else if([shunxu intValue] == 2){
            
                homeYellow.image = UIImageGetImageFromName(@"huangpaiimage.png");
                homeRed.image = UIImageGetImageFromName(@"hongpaiimage.png");
                homeRed.hidden = NO;
                homeYellow.hidden = NO;
                
                homeOneLabel.text = redString;
                homeTwoLabel.text = yellowString;

            }
            
            
        }else if([redString intValue] >0 && [yellowString intValue] == 0){
            
            
            homeYellow.image = UIImageGetImageFromName(@"hongpaiimage.png");
            homeRed.hidden = YES;
            homeYellow.hidden = NO;
            
            homeOneLabel.text = @"0";
            homeTwoLabel.text = redString;

        
        }else if([redString intValue] == 0 && [yellowString intValue] > 0){
            
            homeYellow.image = UIImageGetImageFromName(@"huangpaiimage.png");
            homeRed.hidden = YES;
            homeYellow.hidden = NO;
            
            homeOneLabel.text = @"0";
            homeTwoLabel.text = yellowString;

        }else{
        
            homeYellow.hidden = YES;
            homeRed.hidden = YES;
            homeOneLabel.text = @"0";
            homeTwoLabel.text = @"0";
            
        }
    
    
    
    NSArray * guestArray = [liveData.awaycard componentsSeparatedByString:@"_"];
    NSString * guestredString = @"";
    NSString * guestyellowString = @"";
    NSString * guestshunxu = @"";
    if ([guestArray count] > 2) {
        guestredString = [guestArray objectAtIndex:0];
        guestyellowString = [guestArray objectAtIndex:1];
        guestshunxu = [guestArray objectAtIndex:2];
    }
    
    if ([guestredString intValue] > 0 && [guestyellowString intValue] > 0) {
        
        if ([guestshunxu intValue] == 1) {
            guestYellow.image = UIImageGetImageFromName(@"huangpaiimage.png");
            guestRed.image = UIImageGetImageFromName(@"hongpaiimage.png");
            guestRed.hidden = NO;
            guestYellow.hidden = NO;
            
            guestOneLabel.text = guestredString;
            guestTwoLabel.text = guestyellowString;
            
        }else if([guestshunxu intValue] == 2){
            
            guestYellow.image = UIImageGetImageFromName(@"hongpaiimage.png");
            guestRed.image = UIImageGetImageFromName(@"huangpaiimage.png");
            guestRed.hidden = NO;
            guestYellow.hidden = NO;
            
            guestOneLabel.text = guestyellowString;
            guestTwoLabel.text = guestredString;
        }
        
        
    }else if([guestredString intValue] >0 && [guestyellowString intValue] == 0){
        
        
        guestRed.image = UIImageGetImageFromName(@"hongpaiimage.png");
        guestYellow.hidden = YES;
        guestRed.hidden = NO;
        
        guestOneLabel.text = guestredString;
        guestTwoLabel.text = @"0";
        
    }else if([guestredString intValue] == 0 && [guestyellowString intValue] > 0){
        
        guestRed.image = UIImageGetImageFromName(@"huangpaiimage.png");
        guestYellow.hidden = YES;
        guestRed.hidden = NO;
        
        guestOneLabel.text = guestyellowString;
        guestTwoLabel.text = @"0";
    }else{
        
        guestYellow.hidden = YES;
        guestRed.hidden = YES;
        guestOneLabel.text = @"0";
        guestTwoLabel.text = @"0";
    }
    
    
//        if ([redString intValue] > 0) {
//            homeYellow.image = UIImageGetImageFromName(@"huangpaiimage.png");
//            homeRed.image = UIImageGetImageFromName(@"hongpaiimage.png");
//            homeRed.hidden = YES;
//        }
//        
   
    
    
    //客队的红黄牌
    
    
    
    
    if ([liveData.isAttention isEqualToString:@"0"]) {
        xingImge.image = UIImageGetImageFromName(@"guanzhuxing.png");
        
        collectButton.selected = NO;
    }else{
        xingImge.image = UIImageGetImageFromName(@"guanzhuxing_1.png");
        collectButton.selected = YES;
    }

}


- (liveTelecastData *)liveData{

    return liveData;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cellbgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 300, 69)];
        cellbgImage.backgroundColor = [UIColor clearColor];
        cellbgImage.image = UIImageGetImageFromName(@"beidancellbg.png");
        cellbgImage.userInteractionEnabled = YES;
        [self.contentView addSubview:cellbgImage];
        [cellbgImage release];
        
        
//        weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 38, 12)];
//        weekLabel.backgroundColor = [UIColor clearColor];
//        weekLabel.font = [UIFont boldSystemFontOfSize:10];
//        weekLabel.textAlignment = NSTextAlignmentCenter;
//                weekLabel.text = @"周五";
//        [cellbgImage addSubview:weekLabel];
//        [weekLabel release];
        
        matchNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 38, 12)];
        matchNum.backgroundColor = [UIColor clearColor];
        matchNum.font = [UIFont boldSystemFontOfSize:10];
        matchNum.textAlignment = NSTextAlignmentCenter;
//                matchNum.text = @"010";
        [cellbgImage addSubview:matchNum];
        [matchNum release];
        
        leagueMatches = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 38, 12)];
        leagueMatches.backgroundColor = [UIColor clearColor];
        leagueMatches.font = [UIFont boldSystemFontOfSize:10];
        leagueMatches.textAlignment = NSTextAlignmentCenter;
//                leagueMatches.text = @"大师傅地方";
        [cellbgImage addSubview:leagueMatches];
        [leagueMatches release];
        
        endTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, 38, 12)];
        endTime.backgroundColor = [UIColor clearColor];
        endTime.font = [UIFont boldSystemFontOfSize:10];
        endTime.textAlignment = NSTextAlignmentCenter;
//               endTime.text = @"23:34";
        [cellbgImage addSubview:endTime];
        [endTime release];
        
        
        xingImge = [[UIImageView alloc] initWithFrame:CGRectMake(12, 46, 14, 14)];
        xingImge.backgroundColor = [UIColor clearColor];
        xingImge.image = UIImageGetImageFromName(@"guanzhuxing.png");
        [cellbgImage addSubview:xingImge];
        [xingImge release];
        
        homeRed = [[UIImageView alloc] initWithFrame:CGRectMake(49, 15, 8, 11)];
        homeRed.backgroundColor = [UIColor clearColor];
        homeRed.image = UIImageGetImageFromName(@"hongpaiimage.png");
        [cellbgImage addSubview:homeRed];
        [homeRed release];
        
        homeOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 1, 8, 11)];
        homeOneLabel.backgroundColor = [UIColor clearColor];
        homeOneLabel.font = [UIFont systemFontOfSize:9];
        homeOneLabel.textAlignment = NSTextAlignmentCenter;
//        homeOneLabel.text = @"7";
        homeOneLabel.textColor = [UIColor whiteColor];
        [homeRed addSubview:homeOneLabel];
        [homeOneLabel release];
        
        homeYellow = [[UIImageView alloc] initWithFrame:CGRectMake(59, 15, 8, 11)];
        homeYellow.backgroundColor = [UIColor clearColor];
        homeYellow.image = UIImageGetImageFromName(@"huangpaiimage.png");
        [cellbgImage addSubview:homeYellow];
        [homeYellow release];
        
        homeTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 1, 8, 11)];
        homeTwoLabel.backgroundColor = [UIColor clearColor];
        homeTwoLabel.font = [UIFont systemFontOfSize:9];
        homeTwoLabel.textAlignment = NSTextAlignmentCenter;
//        homeTwoLabel.text = @"6";
        homeTwoLabel.textColor = [UIColor whiteColor];
        [homeYellow addSubview:homeTwoLabel];
        [homeTwoLabel release];
        
        homeTeam = [[UILabel alloc] initWithFrame:CGRectMake(68, 10, 62, 20)];
        homeTeam.backgroundColor = [UIColor clearColor];
        homeTeam.font = [UIFont boldSystemFontOfSize:12];
        homeTeam.textAlignment = NSTextAlignmentRight;
//               homeTeam.text = @"撒旦法士大";
        [cellbgImage addSubview:homeTeam];
        [homeTeam release];
        
        concedePoints = [[UILabel alloc] initWithFrame:CGRectMake(68+62+1, 10, 40, 20)];
        concedePoints.backgroundColor = [UIColor clearColor];
        concedePoints.font = [UIFont boldSystemFontOfSize:11];
        concedePoints.textAlignment = NSTextAlignmentLeft;
        //        concedePoints.text = @"(-23)";
        concedePoints.textColor = [UIColor lightGrayColor];
        [cellbgImage addSubview:concedePoints];
        [concedePoints release];
        
        vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 40, 20)];
        vsLabel.backgroundColor = [UIColor clearColor];
        vsLabel.font = [UIFont boldSystemFontOfSize:12];
        vsLabel.textAlignment = NSTextAlignmentCenter;
//        vsLabel.text = @"10:22";
        vsLabel.textColor = [UIColor lightGrayColor];
        [cellbgImage addSubview:vsLabel];
        [vsLabel release];
        
        
        
        
        guestTeam = [[UILabel alloc] initWithFrame:CGRectMake(190, 10, 62, 20)];
        guestTeam.backgroundColor = [UIColor clearColor];
        guestTeam.font = [UIFont boldSystemFontOfSize:12];
        guestTeam.textAlignment = NSTextAlignmentLeft;
//                guestTeam.text = @"阿斯顿发的";
        [cellbgImage addSubview:guestTeam];
        [guestTeam release];
        
        homeUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, 70, 20)];
        homeUpLabel.backgroundColor = [UIColor clearColor];
        homeUpLabel.font = [UIFont boldSystemFontOfSize:10];
        homeUpLabel.textAlignment = NSTextAlignmentRight;
//        homeUpLabel.text = @"的撒发送到";
        homeUpLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        [cellbgImage addSubview:homeUpLabel];
        [homeUpLabel release];
        
        
        guestRed = [[UIImageView alloc] initWithFrame:CGRectMake(253, 15, 8, 11)];
        guestRed.backgroundColor = [UIColor clearColor];
        guestRed.image = UIImageGetImageFromName(@"hongpaiimage.png");
        [cellbgImage addSubview:guestRed];
        [guestRed release];
        
        guestOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 1, 8, 11)];
        guestOneLabel.backgroundColor = [UIColor clearColor];
        guestOneLabel.font = [UIFont systemFontOfSize:9];
        guestOneLabel.textAlignment = NSTextAlignmentCenter;
//        guestOneLabel.text = @"8";
        guestOneLabel.textColor = [UIColor whiteColor];
        [guestRed addSubview:guestOneLabel];
        [guestOneLabel release];
        
        guestYellow = [[UIImageView alloc] initWithFrame:CGRectMake(263, 15, 8, 11)];
        guestYellow.backgroundColor = [UIColor clearColor];
        guestYellow.image = UIImageGetImageFromName(@"huangpaiimage.png");
        [cellbgImage addSubview:guestYellow];
        [guestYellow release];
        
        guestTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 1, 8, 11)];
        guestTwoLabel.backgroundColor = [UIColor clearColor];
        guestTwoLabel.font = [UIFont systemFontOfSize:9];
        guestTwoLabel.textAlignment = NSTextAlignmentCenter;
//        guestTwoLabel.text = @"1";
        guestTwoLabel.textColor = [UIColor whiteColor];
        [guestYellow addSubview:guestTwoLabel];
        [guestTwoLabel release];
        
        guestUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 35, 80, 20)];
        guestUpLabel.backgroundColor = [UIColor clearColor];
        guestUpLabel.font = [UIFont boldSystemFontOfSize:10];
        guestUpLabel.textAlignment = NSTextAlignmentLeft;
//        guestUpLabel.text = @"让球、撒旦飞洒";
        guestUpLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        [cellbgImage addSubview:guestUpLabel];
        [guestUpLabel release];

        vsUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 35, 40, 20)];
        vsUpLabel.backgroundColor = [UIColor clearColor];
        vsUpLabel.font = [UIFont boldSystemFontOfSize:10];
        vsUpLabel.textAlignment = NSTextAlignmentCenter;
//        vsUpLabel.text = @"未开始";
        vsUpLabel.textColor = [UIColor redColor];//colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        [cellbgImage addSubview:vsUpLabel];
        [vsUpLabel release];
        
        
        
        pptvImge = [[UIImageView alloc] initWithFrame:CGRectMake(273, 15, 11, 11)];
        pptvImge.backgroundColor = [UIColor clearColor];
        pptvImge.image = UIImageGetImageFromName(@"pptvliveiamge.png");
        [cellbgImage addSubview:pptvImge];
        [pptvImge release];
        
        
        UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(285, (69-13)/2, 8, 13)];
        
        jiantou.backgroundColor = [UIColor clearColor];
        jiantou.image = UIImageGetImageFromName(@"JTD960.png");
        [cellbgImage addSubview:jiantou];
        [jiantou release];
        
        
        collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        collectButton.frame = CGRectMake(0, 0, 38, 69);
        [collectButton addTarget:self action:@selector(pressCollectButton:) forControlEvents:UIControlEventTouchUpInside];
        [cellbgImage addSubview:collectButton];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)dealloc{
    
    [liveData release];
    
    [super dealloc];

}

- (void)pressCollectButton:(UIButton *)sender{

    NSLog(@"收藏");
    
    if (sender.selected == YES) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    
    [self liveTelecastCellReturn:indexPath uiButton:sender];
}

- (void)liveTelecastCellReturn:(NSIndexPath *)index uiButton:(UIButton *)sender{
    if ([delegate respondsToSelector:@selector(liveTelecastCellReturn: uiButton:)]) {
        [delegate liveTelecastCellReturn:indexPath uiButton:sender];
    }
    
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    