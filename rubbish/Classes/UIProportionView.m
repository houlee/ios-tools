//
//  UIProportionView.m
//  caibo
//
//  Created by houchenguang on 14-8-10.
//
//

#import "UIProportionView.h"

@implementation UIProportionView

- (void)dealloc{
    [dataDictionary release];
    [super dealloc];
}

- (NSDictionary *)dataDictionary{
    return dataDictionary;
}

- (void)setDataDictionary:(NSDictionary *)_dataDictionary{
    if (![_dataDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if (dataDictionary != _dataDictionary) {
        [dataDictionary release];
        dataDictionary = [_dataDictionary retain];
    }
    if (_dataDictionary == nil || [_dataDictionary count] == 0) {
        return;
    }
    NSDictionary * tzbl = [dataDictionary objectForKey:@"tzbl"];
    NSDictionary * jczq = [tzbl objectForKey:@"jczq"];
    NSDictionary * bd = [tzbl objectForKey:@"bd"];
    
    for (int i = 0; i < 8; i++) {
        
        NSArray * dataArray = nil;
        UILabel * oneLabel = nil;
        UILabel * twoLabel = nil;
        
        if (i == 0) {
            dataArray = [jczq objectForKey:@"S20110"];//竞彩足球 胜平负
        }else if (i == 1){
            dataArray = [jczq objectForKey:@"S20103"];//竞彩足球 总进球
        }else if (i == 2){
            dataArray = [jczq objectForKey:@"S20104"];//竞彩足球 半全场
        }else if (i == 3){
            dataArray = [jczq objectForKey:@"S20105"];//竞彩足球 比分
        }else if (i == 4){
            dataArray = [bd objectForKey:@"S40001"];//北单 胜平负
        }else if (i == 5){
            dataArray = [bd objectForKey:@"S40003"];//北单 总进球
        }else if (i == 6){
            dataArray = [bd objectForKey:@"S40002"];//北单 上下单双
        }else if (i == 7){
             dataArray = [bd objectForKey:@"S40005"];//北单 胜平负
        }
        
        for (int j = 0; j < [dataArray count]; j++) {
            
            NSDictionary * datadict = [dataArray objectAtIndex:j];
            if (i == 0) {
                if (j == 0) {
                    oneLabel = (UILabel *)[self viewWithTag:1];
                    twoLabel = (UILabel *)[self viewWithTag:2];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 1){
                    oneLabel = (UILabel *)[self viewWithTag:9];
                    twoLabel = (UILabel *)[self viewWithTag:10];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 2){
                    oneLabel = (UILabel *)[self viewWithTag:17];
                    twoLabel = (UILabel *)[self viewWithTag:18];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }
            }
            else if (i == 1){
                if (j == 0) {
                    oneLabel = (UILabel *)[self viewWithTag:3];
                    twoLabel = (UILabel *)[self viewWithTag:4];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 1){
                    oneLabel = (UILabel *)[self viewWithTag:11];
                    twoLabel = (UILabel *)[self viewWithTag:12];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                  twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 2){
                    oneLabel = (UILabel *)[self viewWithTag:19];
                    twoLabel = (UILabel *)[self viewWithTag:20];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }
            }else if (i == 2){
                if (j == 0) {
                    oneLabel = (UILabel *)[self viewWithTag:5];
                    twoLabel = (UILabel *)[self viewWithTag:6];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                   twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 1){
                    oneLabel = (UILabel *)[self viewWithTag:13];
                    twoLabel = (UILabel *)[self viewWithTag:14];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                   twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 2){
                    oneLabel = (UILabel *)[self viewWithTag:21];
                    twoLabel = (UILabel *)[self viewWithTag:22];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }
            }else if (i == 3){
                if (j == 0) {
                    oneLabel = (UILabel *)[self viewWithTag:7];
                    twoLabel = (UILabel *)[self viewWithTag:8];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 1){
                    oneLabel = (UILabel *)[self viewWithTag:15];
                    twoLabel = (UILabel *)[self viewWithTag:16];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                   twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 2){
                    oneLabel = (UILabel *)[self viewWithTag:23];
                    twoLabel = (UILabel *)[self viewWithTag:24];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                   twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }
            }else if (i == 4){
                if (j == 0) {
                    oneLabel = (UILabel *)[self viewWithTag:25];
                    twoLabel = (UILabel *)[self viewWithTag:26];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 1){
                    oneLabel = (UILabel *)[self viewWithTag:33];
                    twoLabel = (UILabel *)[self viewWithTag:34];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                   twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 2){
                    oneLabel = (UILabel *)[self viewWithTag:41];
                    twoLabel = (UILabel *)[self viewWithTag:42];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                   twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }
            }else if (i == 5){
                if (j == 0) {
                    oneLabel = (UILabel *)[self viewWithTag:27];
                    twoLabel = (UILabel *)[self viewWithTag:28];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 1){
                    oneLabel = (UILabel *)[self viewWithTag:35];
                    twoLabel = (UILabel *)[self viewWithTag:36];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                    
                }else if (j == 2){
                    oneLabel = (UILabel *)[self viewWithTag:43];
                    twoLabel = (UILabel *)[self viewWithTag:44];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }
            }else if (i == 6){
                if (j == 0) {
                    oneLabel = (UILabel *)[self viewWithTag:29];
                    twoLabel = (UILabel *)[self viewWithTag:30];
                    oneLabel.text = [NSString stringWithFormat:@"%@:", [datadict objectForKey:@"key"]];
                     twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 1){
                    oneLabel = (UILabel *)[self viewWithTag:37];
                    twoLabel = (UILabel *)[self viewWithTag:38];
                    oneLabel.text = [NSString stringWithFormat:@"%@:", [datadict objectForKey:@"key"]];
                     twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 2){
                    oneLabel = (UILabel *)[self viewWithTag:45];
                    twoLabel = (UILabel *)[self viewWithTag:46];
                     oneLabel.text = [NSString stringWithFormat:@"%@:", [datadict objectForKey:@"key"]];
                     twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }
            }else if (i == 7){
                if (j == 0) {
                    oneLabel = (UILabel *)[self viewWithTag:31];
                    twoLabel = (UILabel *)[self viewWithTag:32];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                     twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 1){
                    oneLabel = (UILabel *)[self viewWithTag:39];
                    twoLabel = (UILabel *)[self viewWithTag:40];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                     twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }else if (j == 2){
                    oneLabel = (UILabel *)[self viewWithTag:47];
                    twoLabel = (UILabel *)[self viewWithTag:48];
                    oneLabel.text = [NSString stringWithFormat:@"%@: ", [datadict objectForKey:@"key"]];
                    twoLabel.text = [NSString stringWithFormat:@"%d%%", [[datadict objectForKey:@"value"] intValue]];
                }
            }
            
            
            
            
        }
        
        
    }
    NSLog(@"aaaaaaaaaaaaaaaaaa");
    
    
    
}


- (id)init
{
    self = [super init];
    if (self) {
        
        
        self.frame = CGRectMake(0, 0, 320, 253);
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
//        236  118
        
        for (int i = 0; i < 2; i++) {
            
            UILabel * teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i*118, 46.5, 117)];
            teamLabel.backgroundColor = [UIColor clearColor];
            teamLabel.textAlignment = NSTextAlignmentCenter;
            teamLabel.font = [UIFont systemFontOfSize:15];
            teamLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            if (i == 0) {
                teamLabel.text = @"竞彩";
            }else{
                teamLabel.text = @"单场";
            }
            [self addSubview:teamLabel];
            [teamLabel release];
            
            UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 117, 320, 1)];
            if (i == 0) {
                lineImageView.frame = CGRectMake(0, 117, 320, 1);
            }else{
                lineImageView.frame = CGRectMake(0, 235, 320, 1);
            }
            lineImageView.backgroundColor =  [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
            [self addSubview:lineImageView];
            [lineImageView release];
            
        }
    
        UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(46.5, 0, 0.5, 236)];
        lineImageView.backgroundColor =  [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [self addSubview:lineImageView];
        [lineImageView release];
        
        float width =  273.0f/4.0f;
        float hight = 236.0f/8.0f;
        NSInteger tagcount = 1;
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 4; j++) {
                
                if (i == 0 || i == 4) {
                    
                    UILabel * teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(47+(j*width), hight * i, width, hight)];
                    teamLabel.backgroundColor = [UIColor clearColor];
                    teamLabel.textAlignment = NSTextAlignmentCenter;
                    teamLabel.font = [UIFont systemFontOfSize:12];
                    teamLabel.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
                    [self addSubview:teamLabel];
                    [teamLabel release];
                    if (i == 4 ) {
                        teamLabel.frame = CGRectMake(47+(j*width), 118 , width, hight);
                    }
                    
                    if (j == 0 ) {
                        teamLabel.text = @"胜平负";
                    }else if (j == 1){
                        teamLabel.text = @"总进球";
                    }else if (j == 2){
                        teamLabel.text = @"半全场";
                    }else if (j == 3){
                        teamLabel.text = @"比分";
                    }
                    
                }else{
                
                    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(47+(j*width), hight * i, width/2.0f , hight)];
                    titleLabel.backgroundColor = [UIColor clearColor];
                    titleLabel.textAlignment = NSTextAlignmentRight;
                    titleLabel.font = [UIFont systemFontOfSize:10];
                    titleLabel.tag = tagcount;
                    titleLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                    [self addSubview:titleLabel];
                     tagcount += 1;
                    if ((i == 7 && j == 2) || (i == 6 && j == 2) || (i == 5 && j == 2)) {
                        titleLabel.frame =CGRectMake(47+(j*width), hight * i, width/2.0f , hight);
                    }else{
                        
                        titleLabel.frame =CGRectMake(47+(j*width), hight * i, width/2.0f - 5 , hight);
                    }
                    
//                    if (i == 1 && j == 0){
//                        titleLabel.text = @"负: ";
//                    }else if (i == 1 && j == 1){
//                        titleLabel.text = @"3: ";
//                    }else if (i == 1 && j == 2){
//                        titleLabel.text = @"平平: ";
//                    }else if (i == 1 && j == 3){
//                        titleLabel.text = @"0-0: ";
//                    }
//                    
//                    else if (i == 2 && j == 0){
//                        titleLabel.text = @"胜: ";
//                    }else if (i == 2 && j == 1){
//                        titleLabel.text = @"4: ";
//                    }else if (i == 2 && j == 2){
//                        titleLabel.text = @"平负: ";
//                    }else if (i == 2 && j == 3){
//                        titleLabel.text = @"1-0: ";
//                    }
//                   
//                    else if (i == 3 && j == 0){
//                        titleLabel.text = @"平: ";
//                    }else if (i == 3 && j == 1){
//                        titleLabel.text = @"0: ";
//                    }else if (i == 3 && j == 2){
//                        titleLabel.text = @"平胜: ";
//                    }else if (i == 3 && j == 3){
//                        titleLabel.text = @"0-1: ";
//                    }
//                   
//                    else if (i == 5 && j == 0){
//                        titleLabel.text = @"负: ";
//                    }else if (i == 5 && j == 1){
//                        titleLabel.text = @"3: ";
//                    }else if (i == 5 && j == 2){
//                        titleLabel.text = @"上+双:";
//                    }else if (i == 5 && j == 3){
//                        titleLabel.text = @"0-0: ";
//                    }
//                    else if (i == 6 && j == 0){
//                        titleLabel.text = @"胜: ";
//                    }else if (i == 6 && j == 1){
//                        titleLabel.text = @"4: ";
//                    }else if (i == 6 && j == 2){
//                        titleLabel.text = @"上+单:";
//                    }else if (i == 6 && j == 3){
//                        titleLabel.text = @"1-0: ";
//                    }
//                    
//                    else if (i == 7 && j == 0){
//                        titleLabel.text = @"平: ";
//                    }else if (i == 7 && j == 1){
//                        titleLabel.text = @"0: ";
//                    }else if (i == 7 && j == 2){
//                        titleLabel.text = @"下+双:";
//                    }else if (i == 7 && j == 3){
//                        titleLabel.text = @"0-1: ";
//                    }


                    UILabel * caiLabel = [[UILabel alloc] initWithFrame:CGRectMake(47+(j*width) + (width/2.0f)+2, hight * i, width/2.0f-2, hight)];
                    caiLabel.backgroundColor = [UIColor clearColor];
                    caiLabel.textAlignment = NSTextAlignmentLeft;
                    caiLabel.font = [UIFont systemFontOfSize:10];
                    caiLabel.tag = tagcount;
                    caiLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                    [self addSubview:caiLabel];
//                    caiLabel.text = @"234%";
                    tagcount += 1;
//                    if (i >= 4) {
//                        caiLabel.frame = CGRectMake(47+(j*width) + (width/2.0f-1), hight * i, width/2.0f-1, hight);
//                    }
                }
                
                
                
                
            }
        }
        
        
        
        for (int i = 0; i < 6; i++) {
            
            UIImageView * lineTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(47, hight * i, 320-47, 0.5)];
            lineTwoImageView.backgroundColor =  [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
            [self addSubview:lineTwoImageView];
            [lineTwoImageView release];
            
            if (i < 3) {
                lineTwoImageView.frame = CGRectMake(47, hight * (i+1), 320-47, 0.5);
            }else{
                lineTwoImageView.frame = CGRectMake(47, 118+hight * (i - 2), 320-47, 0.5);
            }
        }
        
        for (int i = 0; i < 3; i++) {
            
            UIImageView * lineTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(47+(width *(i+1)), 0, 0.5, 236)];
            lineTwoImageView.backgroundColor =  [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
            [self addSubview:lineTwoImageView];
            [lineTwoImageView release];
        }
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    