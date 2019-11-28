//
//  BifenLanQiuCell.m
//  caibo
//
//  Created by yaofuyu on 13-10-24.
//
//

#import "BifenLanQiuCell.h"

@implementation BifenLanQiuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        cellbgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 300, 60)];
        cellbgImage.backgroundColor = [UIColor clearColor];
        cellbgImage.image = UIImageGetImageFromName(@"bifenPutong.png");
        cellbgImage.userInteractionEnabled = YES;
        [self.contentView addSubview:cellbgImage];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [cellbgImage release];
        
        UIImageView *zuo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 57)];
        zuo.image = UIImageGetImageFromName(@"bifenZuo.png");
        [cellbgImage addSubview:zuo];
        zuo.backgroundColor = [UIColor clearColor];
        [zuo release];
        
        bifenBack = [[UIImageView alloc] initWithFrame:CGRectMake(135, 9, 70, 20)];
        bifenBack.image = [UIImageGetImageFromName(@"bifenback.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0];
        [cellbgImage addSubview:bifenBack];
        bifenBack.hidden = YES;
        bifenBack.backgroundColor = [UIColor clearColor];
        [bifenBack release];
        
        matchNoLabel = [[UILabel alloc] init];
        matchNoLabel.backgroundColor = [UIColor clearColor];
        matchNoLabel.frame = CGRectMake(0, 7, 53, 10);
        matchNoLabel.textAlignment = NSTextAlignmentCenter;
        matchNoLabel.font = [UIFont systemFontOfSize:9];
        matchNoLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
        [cellbgImage addSubview:matchNoLabel];
        [matchNoLabel release];
        
        liansainameLabel = [[UILabel alloc] init];
        liansainameLabel.backgroundColor = [UIColor clearColor];
        liansainameLabel.frame = CGRectMake(0, 18, 53, 10);
        liansainameLabel.textAlignment = NSTextAlignmentCenter;
        liansainameLabel.font = [UIFont systemFontOfSize:9];
        liansainameLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
        [cellbgImage addSubview:liansainameLabel];
        [liansainameLabel release];
        
        matchStartTimeLabel = [[UILabel alloc] init];
        matchStartTimeLabel.backgroundColor = [UIColor clearColor];
        matchStartTimeLabel.frame = CGRectMake(0, 29, 53, 22);
        matchStartTimeLabel.numberOfLines = 0;
        matchStartTimeLabel.textAlignment = NSTextAlignmentCenter;
        matchStartTimeLabel.font = [UIFont systemFontOfSize:9];
        matchStartTimeLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
        [cellbgImage addSubview:matchStartTimeLabel];
        [matchStartTimeLabel release];
        
        
        guestNameLabel = [[UILabel alloc] init];
        guestNameLabel.backgroundColor = [UIColor clearColor];
        guestNameLabel.frame = CGRectMake(56, 13, 73, 14);
        guestNameLabel.textAlignment = NSTextAlignmentRight;
        guestNameLabel.font = [UIFont boldSystemFontOfSize:12];
        guestNameLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
        [cellbgImage addSubview:guestNameLabel];
        [guestNameLabel release];
        
        hostNameLabel = [[UILabel alloc] init];
        hostNameLabel.backgroundColor = [UIColor clearColor];
        hostNameLabel.frame = CGRectMake(208, 13, 73, 14);
        hostNameLabel.textAlignment = NSTextAlignmentLeft;
        hostNameLabel.font = [UIFont boldSystemFontOfSize:12];
        hostNameLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
        [cellbgImage addSubview:hostNameLabel];
        [hostNameLabel release];
        
        ScoreLabel = [[UILabel alloc] init];
        ScoreLabel.backgroundColor = [UIColor clearColor];
        ScoreLabel.frame = CGRectMake(135, 10, 70, 17);
        ScoreLabel.textAlignment = NSTextAlignmentCenter;
        ScoreLabel.font = [UIFont boldSystemFontOfSize:17];
        ScoreLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
        [cellbgImage addSubview:ScoreLabel];
        [ScoreLabel release];
        
        statusLabel = [[UILabel alloc] init];
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.frame = CGRectMake(110, 35, 120, 14);
        statusLabel.textAlignment = NSTextAlignmentCenter;
        statusLabel.font = [UIFont boldSystemFontOfSize:10];
        statusLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
        [cellbgImage addSubview:statusLabel];
        [statusLabel release];
        
        bcbfLabel = [[UILabel alloc] init];
        bcbfLabel.backgroundColor = [UIColor clearColor];
        bcbfLabel.frame = CGRectMake(208, 35, 73, 14);
        bcbfLabel.textAlignment = NSTextAlignmentLeft;
        bcbfLabel.font = [UIFont systemFontOfSize:10];
        bcbfLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1.0];
        [cellbgImage addSubview:bcbfLabel];
        [bcbfLabel release];
        
        UIImageView *jantou = [[UIImageView alloc] initWithFrame:CGRectMake(280, 26, 8.5, 13)];
        jantou.image = UIImageGetImageFromName(@"yinlianjiantou.png");
        [cellbgImage addSubview:jantou];
        jantou.backgroundColor = [UIColor clearColor];
        [jantou release];
        
    }
    return self;
}

- (void)LoadData:(BiFenZhiBoLanQiuData *)data {
    matchNoLabel.text = data.matchNo;
    liansainameLabel.text = data.liansainame;
    matchStartTimeLabel.text = [data.matchStartTime stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    hostNameLabel.text = data.hostName;
    guestNameLabel.text = data.guestName;
        ScoreLabel.text = [NSString stringWithFormat:@"%@:%@",data.Guestscore,data.Hostscore];
    if (data.isColorNeedChange) {
        if (data.isScoreHostChange) {
            hostNameLabel.textColor = [UIColor redColor];
        }
        if (data.isAwayHostChange) {
            guestNameLabel.textColor = [UIColor redColor];
        }
        cellbgImage.image = UIImageGetImageFromName(@"bifenShan.png");
    }
    else {
        cellbgImage.image = UIImageGetImageFromName(@"bifenPutong.png");
        hostNameLabel.textColor = [UIColor blackColor];
        guestNameLabel.textColor = [UIColor blackColor];
    }
    if ([data.state isEqualToString:@"2"]) {
        bifenBack.hidden = NO;
        statusLabel.textColor = [UIColor colorWithRed:125/255.0 green:0 blue:0 alpha:1.0];
        ScoreLabel.textColor = [UIColor colorWithRed:125/255.0 green:0 blue:0 alpha:1.0];
    }
    else if ([data.state isEqualToString:@"1"]) {
        bifenBack.hidden = NO;
        statusLabel.textColor = [UIColor redColor];
         ScoreLabel.textColor = [UIColor redColor];
        if ([data.status rangeOfString:@"结束"].location != NSNotFound || [data.status rangeOfString:@"中场"].location != NSNotFound) {
            statusLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1.0];
            ScoreLabel.textColor = [UIColor colorWithRed:1.0 green:156.0/255.0 blue:0 alpha:1.0];;
        }
       
    }
    else {
        bifenBack.hidden = YES;
        ScoreLabel.text = @"VS";
        ScoreLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1.0];
        statusLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1.0];
    }
    statusLabel.text = data.status;
    if ([data.bcbf length]) {
        bcbfLabel.text = [NSString stringWithFormat:@"半场 %@",data.bcbf];
    }
    else {
        bcbfLabel.text = nil;
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dealloc {
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    