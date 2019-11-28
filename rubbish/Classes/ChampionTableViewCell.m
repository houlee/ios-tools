//
//  ChampionTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-5-29.
//
//

#import "ChampionTableViewCell.h"

@implementation ChampionTableViewCell
@synthesize cellType, cellIndexPath, delegate;

- (void)dealloc{
    [cellIndexPath release];
    [super dealloc];
}

- (void)setChampionData:(ChampionData *)_championData{

    if (championData != _championData) {
        [championData release];
        championData = [_championData retain];
    }
    
    NSArray * teamInfoArray = [championData.teamInfo componentsSeparatedByString:@","];
    NSArray * teamNumArray = [championData.teamNum componentsSeparatedByString:@","];
    NSArray * oddsArray = [championData.odds componentsSeparatedByString:@" "];
    
    if ([oddsArray count] > cellIndexPath.row) {//赔率
        oddsLabel.text = [oddsArray objectAtIndex:cellIndexPath.row];
    }else{
        oddsLabel.text = @"";
    }
    
    if ([championData.typeArray count] > cellIndexPath.row) {
        if ([[championData.typeArray objectAtIndex:cellIndexPath.row] isEqualToString:@"1"]) {
            matchButton.selected = YES;
           
            
        }else{
            matchButton.selected = NO;
            
        }
    }else{
        matchButton.selected = NO;
        oddsLabel.textColor = [UIColor blackColor];
    }
    
    if ([teamNumArray count] > cellIndexPath.row) {
        numLabel.text = [teamNumArray objectAtIndex:cellIndexPath.row];//场号
        
        if ([championData.endNum rangeOfString:[NSString stringWithFormat:@"%@,", [teamNumArray objectAtIndex:cellIndexPath.row]]].location != NSNotFound) {//截止 还是开售
            
            endTypeLabel.text = @"停售";
            oddsLabel.textColor = [UIColor lightGrayColor];
            teamLabel.textColor = [UIColor lightGrayColor];
            keduiLabel.textColor = [UIColor lightGrayColor];
            endTypeLabel.textColor = [UIColor lightGrayColor];
            changhaoImage.image = UIImageGetImageFromName(@"gyjchanghao_1.png");
            matchButton.enabled = NO;
        }else{
            endTypeLabel.text = @"开售";
            changhaoImage.image = UIImageGetImageFromName(@"gyjchanghao.png");
            matchButton.enabled = YES;
            if (matchButton.selected) {
                oddsLabel.textColor = [UIColor colorWithRed:232/255.0 green:255/255.0 blue:13/255.0 alpha:1];
                teamLabel.textColor = [UIColor colorWithRed:232/255.0 green:255/255.0 blue:13/255.0 alpha:1];
                keduiLabel.textColor = [UIColor colorWithRed:232/255.0 green:255/255.0 blue:13/255.0 alpha:1];
                endTypeLabel.textColor = [UIColor colorWithRed:232/255.0 green:255/255.0 blue:13/255.0 alpha:1];
            }else{
                oddsLabel.textColor = [UIColor blackColor];
                teamLabel.textColor = [UIColor blackColor];
                keduiLabel.textColor = [UIColor blackColor];
                endTypeLabel.textColor = [UIColor colorWithRed:12/255.0 green:62/255.0 blue:31/255.0 alpha:1];
            }
            
        }
    }else{
        numLabel.text = @"";
        endTypeLabel.text = @"";
    }
    
    
    
    
    if (cellType == championCellTypeShow) {//冠军
        
        matchButton.frame = CGRectMake(10, 5, 300, 58);
        homeImageView.frame = CGRectMake(62, 18, 47, 26);
        keduiImageView.frame = CGRectMake(0, 0, 0, 0);
        teamLabel.frame = CGRectMake(119, 21, 103, 16);
        keduiLabel.frame = CGRectMake(0,0, 0, 0);
        oddsLabel.frame = CGRectMake(300 - 18 - 60, 21, 60, 16);
        oddsLabel.textAlignment = NSTextAlignmentRight;
        teamLabel.textAlignment = NSTextAlignmentLeft;
        keduiLabel.text = @"";
        keduiImageView.image = nil;
        
        
        if ([teamInfoArray count] > cellIndexPath.row) {//队名
            
            teamLabel.text = [teamInfoArray objectAtIndex:cellIndexPath.row];
            
            NSString * path = [[NSBundle mainBundle] pathForResource:@"teamInfo_Name" ofType:@"plist"];
            NSDictionary * teamInfoDic =[NSDictionary dictionaryWithContentsOfFile:path];
            
            
            if ([teamInfoDic objectForKey:teamLabel.text]) {
                NSDictionary * bannerDic = [teamInfoDic objectForKey:teamLabel.text];
                homeImageView.image = UIImageGetImageFromName([bannerDic objectForKey:@"teamFlag"]);
                
            }else{
                homeImageView.image = nil;
            }
        
        }else{
            homeImageView.image = nil;
            teamLabel.text = @"";
            
        }
        
    }else if (cellType == championSecondPlaceCellShow){//冠亚军
        
        matchButton.frame = CGRectMake(10, 5, 300, 68);
        homeImageView.frame = CGRectMake(74, 10, 47, 26);
        keduiImageView.frame = CGRectMake(227, 10, 47, 26);
        teamLabel.frame = CGRectMake(74 - 28, 42, 103, 15);
        keduiLabel.frame = CGRectMake(227 - 28,42, 103, 15);
        oddsLabel.frame = CGRectMake(97+47, 15, 60, 16);
        oddsLabel.textAlignment = NSTextAlignmentCenter;
        teamLabel.textAlignment = NSTextAlignmentCenter;
        
        if ([teamInfoArray count] > cellIndexPath.row) {//队名
        
            NSArray *teamArray = [[teamInfoArray objectAtIndex:cellIndexPath.row] componentsSeparatedByString:@"—"];//—
            if ([teamArray count] >= 2) {

                teamLabel.text =  [teamArray objectAtIndex:0];
                keduiLabel.text = [teamArray objectAtIndex:1];
                
                NSString * path = [[NSBundle mainBundle] pathForResource:@"teamInfo_Name" ofType:@"plist"];
                NSDictionary * teamInfoDic =[NSDictionary dictionaryWithContentsOfFile:path];
                
               
                if ([teamInfoDic objectForKey:teamLabel.text]) {
                    NSDictionary * bannerDic = [teamInfoDic objectForKey:teamLabel.text];
                    homeImageView.image = UIImageGetImageFromName([bannerDic objectForKey:@"teamFlag"]);
                    
                }else{
                    homeImageView.image = nil;
                }
                if ([teamInfoDic objectForKey:keduiLabel.text]) {
                    NSDictionary * bannerDic = [teamInfoDic objectForKey:keduiLabel.text];
                    keduiImageView.image = UIImageGetImageFromName([bannerDic objectForKey:@"teamFlag"]);
                    
                }else{
                    keduiImageView.image = nil;
                }



            }else{
                teamLabel.text = @"";
                homeImageView.image = nil;
                keduiImageView.image = nil;
                keduiLabel.text = @"";
            }
        }else{
            teamLabel.text = @"";
            homeImageView.image = nil;
            keduiImageView.image = nil;
            keduiLabel.text = @"";
        }
        
    }
    
    
    
    
    
}

- (ChampionData *)championData{
    return championData;
}

- (void)tableViewCell{

    

    matchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    matchButton.frame = CGRectMake(10, 4, 300, 68);
    //    button1.tag = 3;
    [matchButton setBackgroundImage:[UIImageGetImageFromName(@"gyjimagebg.png") stretchableImageWithLeftCapWidth:16 topCapHeight:16] forState:UIControlStateNormal];
    [matchButton setBackgroundImage:[UIImageGetImageFromName(@"gyjimagebg_1.png") stretchableImageWithLeftCapWidth:16 topCapHeight:16] forState:UIControlStateSelected];
    [matchButton setBackgroundImage:[UIImageGetImageFromName(@"gyjimagebg.png") stretchableImageWithLeftCapWidth:16 topCapHeight:16] forState:UIControlStateDisabled];
    
    [matchButton addTarget:self action:@selector(pressMatchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:matchButton];
    
    
    
    changhaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 40, 37/2)];
    changhaoImage.backgroundColor = [UIColor clearColor];
    changhaoImage.image = UIImageGetImageFromName(@"gyjchanghao.png");
    [matchButton addSubview:changhaoImage];
    [changhaoImage release];
    
    numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 16, 37/2)];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.textAlignment = NSTextAlignmentLeft;
    numLabel.font = [UIFont systemFontOfSize:9];
//    numLabel.text = @"233";
    numLabel.textColor  = [UIColor whiteColor];
    [changhaoImage addSubview:numLabel];
    [numLabel release];
    
    endTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 37/2+5, 25, 14)];
    endTypeLabel.textAlignment = NSTextAlignmentLeft;
    endTypeLabel.textColor = [UIColor colorWithRed:12/255.0 green:62/255.0 blue:31/255.0 alpha:1];
    endTypeLabel.font = [UIFont systemFontOfSize:9];
    endTypeLabel.backgroundColor = [UIColor clearColor];
//    endTypeLabel.text = @"开售";
    [matchButton addSubview:endTypeLabel];
    [endTypeLabel release];
    
    
    homeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(74, 10, 47, 26)];
    homeImageView.backgroundColor = [UIColor clearColor];
    [matchButton addSubview:homeImageView];
    [homeImageView release];
    
    keduiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(227, 10, 47, 26)];
    keduiImageView.backgroundColor = [UIColor clearColor];
    [matchButton addSubview:keduiImageView];
    [keduiImageView release];
    
    
    teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(74 - 28, 42, 103, 15)];
    teamLabel.textAlignment = NSTextAlignmentCenter;
    teamLabel.font = [UIFont boldSystemFontOfSize:14];
    teamLabel.backgroundColor = [UIColor clearColor];
    teamLabel.textColor = [UIColor blackColor];
//    teamLabel.text = @"巴西单负式    _    巴拉圭都是";
    [matchButton addSubview:teamLabel];
    [teamLabel release];
    

    
    //客队
    keduiLabel = [[UILabel alloc] initWithFrame:CGRectMake(227 - 28,42, 103, 15)];
    keduiLabel.textAlignment = NSTextAlignmentCenter;
    keduiLabel.font = [UIFont boldSystemFontOfSize:14];
    keduiLabel.backgroundColor = [UIColor clearColor];
    keduiLabel.textColor = [UIColor blackColor];
    //    keduiLabel.text = @"地方撒的的";
    [matchButton addSubview:keduiLabel];
    [keduiLabel release];
    
   
    
    oddsLabel = [[UILabel alloc] initWithFrame:CGRectMake(97+47, 15, 60, 16)];
    oddsLabel.textAlignment = NSTextAlignmentCenter;
    oddsLabel.font = [UIFont systemFontOfSize:13];
    oddsLabel.backgroundColor = [UIColor clearColor];
    oddsLabel.textColor = [UIColor blackColor];
//    oddsLabel.text = @"45.345";
    [matchButton addSubview:oddsLabel];
    [oddsLabel release];

}

- (void)pressMatchButton:(UIButton *)sender{

    if (sender.selected == NO) {
        sender.selected = YES;
        [championData.typeArray replaceObjectAtIndex:cellIndexPath.row withObject:@"1"];
        oddsLabel.textColor = [UIColor whiteColor];
    }else{
        sender.selected = NO;
        [championData.typeArray replaceObjectAtIndex:cellIndexPath.row withObject:@"0"];
        oddsLabel.textColor = [UIColor blackColor];
    }
    if (matchButton.selected) {
        oddsLabel.textColor = [UIColor colorWithRed:232/255.0 green:255/255.0 blue:13/255.0 alpha:1];
        teamLabel.textColor = [UIColor colorWithRed:232/255.0 green:255/255.0 blue:13/255.0 alpha:1];
        keduiLabel.textColor = [UIColor colorWithRed:232/255.0 green:255/255.0 blue:13/255.0 alpha:1];
        endTypeLabel.textColor = [UIColor colorWithRed:232/255.0 green:255/255.0 blue:13/255.0 alpha:1];
    }else{
        oddsLabel.textColor = [UIColor blackColor];
        teamLabel.textColor = [UIColor blackColor];
        keduiLabel.textColor = [UIColor blackColor];
        endTypeLabel.textColor = [UIColor colorWithRed:12/255.0 green:62/255.0 blue:31/255.0 alpha:1];
    }
    
    
    if (delegate && [delegate respondsToSelector:@selector(championTableViewCell:withData:indexPath:selectBool:)]) {
        [delegate championTableViewCell:self withData:championData indexPath:cellIndexPath selectBool:sender.selected];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self tableViewCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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