//
//  UIIntegralView.m
//  caibo
//
//  Created by houchenguang on 14-8-9.
//
//

#import "UIIntegralView.h"

@implementation UIIntegralView

- (NSDictionary *)dataDictionary{
    return dataDictionary;
}


- (void)setDataDictionary:(NSDictionary *)_dataDictionary{
    
    if (dataDictionary != _dataDictionary) {
        [dataDictionary release];
        dataDictionary = [_dataDictionary retain];
    }
    
    
//    NSDictionary * datas = [dataDictionary objectForKey:@"datas"];
    
    if (!_dataDictionary) {
        return;
    }
    
    NSDictionary * play = [dataDictionary objectForKey:@"play"];
    
    UILabel * homelabel = (UILabel *)[self viewWithTag:1000];
    UILabel * guestlabel = (UILabel *)[self viewWithTag:1001];
    
    UILabel * teamRandLabel = (UILabel *)[self viewWithTag:888];
    
    if ([dataDictionary objectForKey:@"hostNum"]&&[dataDictionary objectForKey:@"guestNum"]) {
         teamRandLabel.text = [NSString stringWithFormat:@"上赛季排名:%@%@    %@%@", [play objectForKey:@"host_name"],[dataDictionary objectForKey:@"hostNum"], [play objectForKey:@"guest_name"],  [dataDictionary objectForKey:@"guestNum"]];
    }else{
        teamRandLabel.text = @"";
    }
    
   
    
    homelabel.text = [play objectForKey:@"host_name"];
    guestlabel.text = [play objectForKey:@"guest_name"];
    
    NSArray * leagueHost = [dataDictionary objectForKey:@"leagueHost"];
    NSArray * leagueGuest = [dataDictionary objectForKey:@"leagueGuest"];
    
    for (int i = 0; i < [leagueHost count]; i++) {
        
        NSDictionary * infoDict = [leagueHost objectAtIndex:i];
        
        UILabel * saiLabel = (UILabel *)[self viewWithTag:i*7+1];
        UILabel * shengLabel = (UILabel *)[self viewWithTag:i*7+2];
        UILabel * pingLabel = (UILabel *)[self viewWithTag:i*7+3];
        UILabel * fuLabel = (UILabel *)[self viewWithTag:i*7+4];
        UILabel * lvLabel = (UILabel *)[self viewWithTag:i*7+5];
        UILabel * paiLabel = (UILabel *)[self viewWithTag:i*7+6];
        UILabel * jiLabel = (UILabel *)[self viewWithTag:i*7+7];
        
        saiLabel.text = [NSString stringWithFormat:@"%d", [[infoDict objectForKey:@"sai"] intValue]];
        shengLabel.text = [infoDict objectForKey:@"win"];
        pingLabel.text = [infoDict objectForKey:@"same"];
        fuLabel.text = [infoDict objectForKey:@"lost"];
        lvLabel.text = [infoDict objectForKey:@"odds"];
        paiLabel.text = [infoDict objectForKey:@"num"];
        jiLabel.text = [infoDict objectForKey:@"score"];
        
    }
    
    for (int i = 0; i < [leagueGuest count]; i++) {
        
        NSDictionary * infoDict = [leagueGuest objectAtIndex:i];
        
        UILabel * saiLabel = (UILabel *)[self viewWithTag:i*7+1+21];
        UILabel * shengLabel = (UILabel *)[self viewWithTag:i*7+2+21];
        UILabel * pingLabel = (UILabel *)[self viewWithTag:i*7+3+21];
        UILabel * fuLabel = (UILabel *)[self viewWithTag:i*7+4+21];
        UILabel * lvLabel = (UILabel *)[self viewWithTag:i*7+5+21];
        UILabel * paiLabel = (UILabel *)[self viewWithTag:i*7+6+21];
        UILabel * jiLabel = (UILabel *)[self viewWithTag:i*7+7+21];
        
        saiLabel.text = [NSString stringWithFormat:@"%d", [[infoDict objectForKey:@"sai"] intValue]];
        shengLabel.text = [infoDict objectForKey:@"win"];
        pingLabel.text = [infoDict objectForKey:@"same"];
        fuLabel.text = [infoDict objectForKey:@"lost"];
        lvLabel.text = [infoDict objectForKey:@"odds"];
        paiLabel.text = [infoDict objectForKey:@"num"];
        jiLabel.text = [infoDict objectForKey:@"score"];
        
    }
    
}

- (void)dealloc{
    [dataDictionary release];
    [super dealloc];
}

- (id)init{

    self = [super init];
    if (self) {
    
        self.frame = CGRectMake(0, 0, 320, 255);
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
        
        UIImageView * headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        headImage.backgroundColor = [UIColor whiteColor];
        [self addSubview:headImage];
        [headImage release];
        
        UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 320, 1.5)];
        lineImage.backgroundColor = [UIColor colorWithRed:162/255.0 green:151/255.0 blue:133/255.0 alpha:1];
        [self addSubview:lineImage];
        [lineImage release];
        
        
        float width = 246.0/7.0;
        for (int i = 0; i < 7; i++) {
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(74 + (i*width), 0, width, 30)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
            [headImage addSubview:titleLabel];
            [titleLabel release];
            
            if (i == 0) {
                titleLabel.text = @"赛";
            }else if (i == 1){
                titleLabel.text = @"胜";
            }else if (i == 2){
                titleLabel.text = @"平";
            }else if (i == 3){
                titleLabel.text = @"负";
            }else if (i == 4){
                titleLabel.text = @"胜率";
            }else if (i == 5){
                titleLabel.text = @"排名";
            }else if (i == 6){
                titleLabel.text = @"积分";
            }
            
        }
//        179
        for (int i = 0; i < 2; i++) {//队名 主客队
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 31.5, 16, 178.0/2.0)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            titleLabel.numberOfLines = 0;
            titleLabel.tag = i+ 1000;
//            titleLabel.text = @"曼联";
            if (i == 1) {
                titleLabel.frame = CGRectMake(7, 90+31.5, 16, 178.0/2.0);
//                titleLabel.text = @"切尔西切而";
            }
            titleLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            [self addSubview:titleLabel];
            [titleLabel release];
            
        }
        UIImageView * lineImageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 31.5+ 178.0/2.0, 320, 1)];
        lineImageTwo.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [self addSubview:lineImageTwo];
        [lineImageTwo release];
        
        UIImageView * lineImageThree = [[UIImageView alloc] initWithFrame:CGRectMake(33, 31.5, 0.5, 180)];
        lineImageThree.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [self addSubview:lineImageThree];
        [lineImageThree release];
        
        UIImageView * lineImagefour = [[UIImageView alloc] initWithFrame:CGRectMake(0, 31.5+ 179, 320, 1)];
        lineImagefour.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [self addSubview:lineImagefour];
        [lineImagefour release];
        
        NSInteger tagCount = 1;
        
        for (int i = 0; i < 6; i++) {//内容
            for (int j = 0; j < 8; j++) {
                
                
                UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                titleLabel.backgroundColor = [UIColor clearColor];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:titleLabel];
                [titleLabel release];
                
                
                if (j == 0) {
                    
                    titleLabel.font = [UIFont systemFontOfSize:12];
                    titleLabel.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
                    titleLabel.frame = CGRectMake(33.5, 31.5+i*30, 74-33.5, 30);
                    if (i == 0) {
                        titleLabel.text = @"总";
                    }else if (i == 1){
                        titleLabel.text = @"主场";
                    }else if (i == 2){
                        titleLabel.text = @"客场";
                    }else if (i == 3){
                        titleLabel.text = @"总";
                    }else if (i == 4){
                        titleLabel.text = @"主场";
                    }else if (i == 5){
                        titleLabel.text = @"客场";
                    }
                    
                }else{
                
                    titleLabel.font = [UIFont systemFontOfSize:13];
                    titleLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                    titleLabel.frame = CGRectMake(74 + ((j - 1)*width), 31.5+i*30, width, 30);
//                    titleLabel.text = @"23sd";
                    titleLabel.tag = tagCount;
                    tagCount +=1;
                }
                
            }
        }
        
        
        for (int i = 0; i < 4; i++) {//画线
            UIImageView * lineImagefive = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            lineImagefive.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
            [self addSubview:lineImagefive];
            [lineImagefive release];
            
            if (i == 0) {
                lineImagefive.frame = CGRectMake(33.5, 31.5+ 30 - 0.5, 320 - 33.5, 0.5);
            }else if (i == 1){
                lineImagefive.frame = CGRectMake(33.5, 31.5+ 30+30 - 0.5, 320 - 33.5, 0.5);
            }else if (i == 2){
                lineImagefive.frame = CGRectMake(33.5, 31.5+ 90+30+30 - 0.5, 320 - 33.5, 0.5);
            }else if (i == 4){
                lineImagefive.frame = CGRectMake(33.5, 31.5+ 90+30+30+30 - 0.5, 320 - 33.5, 0.5);

            }
        }
        
        
    }
    

    
    UILabel * teamRandLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 31.5+180, 320, 28)];//联赛排名
    teamRandLabel.backgroundColor = [UIColor clearColor];
    teamRandLabel.textAlignment = NSTextAlignmentCenter;
    teamRandLabel.font = [UIFont systemFontOfSize:15];
    teamRandLabel.tag = 888;
    teamRandLabel.text = @"";
    [self addSubview:teamRandLabel];
    [teamRandLabel release];
    
    
    UIImageView * lineImagesix = [[UIImageView alloc] initWithFrame:CGRectMake(0, 31.5+180+28, 320, 1)];
    lineImagesix.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [self addSubview:lineImagesix];
    [lineImagesix release];

    
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    