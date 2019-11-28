//
//  JFBTeamTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-5-26.
//
//

#import "JFBTeamTableViewCell.h"

@implementation JFBTeamTableViewCell
@synthesize jfIndexPath;
@synthesize interalString, cellType;


- (long )retun16TO10:(NSString *)num{
    
    char* str = (char *)[num cStringUsingEncoding:NSASCIIStringEncoding]; //16进制转换为10进制
    long sum = strtol(str,&str,16);
    NSLog(@"a = %ld",  sum);
    return sum;
}

- (NSString *)tolfunc:(NSString *)numstr{
    
    NSString * colorstr = @"";
    
    if ([numstr length] >= 7) {
        NSString * chanStr1 = [numstr substringWithRange:NSMakeRange(1, 2)];
        long one = [self retun16TO10:chanStr1];
        
        NSString * chanStr2 = [numstr substringWithRange:NSMakeRange(3, 2)];
        long two = [self retun16TO10:chanStr2];
        
        NSString * chanStr3 = [numstr substringWithRange:NSMakeRange(5, 2)];
        long three = [self retun16TO10:chanStr3];
        
        colorstr = [NSString stringWithFormat:@"%ld %ld %ld", one, two, three];
        
        
    }else{
        return nil;
    }
    
    
    
    return colorstr;
}

- (void)setDataDictionary:(NSDictionary *)_dataDictionary{
    
    if (dataDictionary != _dataDictionary) {
        [dataDictionary release];
        dataDictionary = [_dataDictionary retain];
    }
    
    UILabel * numLabelOne = (UILabel *)[self.contentView viewWithTag:100];
    UILabel * numLabelTwo = (UILabel *)[self.contentView viewWithTag:101];
    UILabel * nameLabelOne = (UILabel *)[self.contentView viewWithTag:200];
    UILabel * nameLabelTwo = (UILabel *)[self.contentView viewWithTag:201];
    
    NSArray * homeArray = [dataDictionary objectForKey:@"host_league"];
    NSArray * guestArray = [dataDictionary objectForKey:@"guest_league"];
    
    
    NSDictionary * homeDict = nil;
    NSDictionary * guestDict = nil;
    
    if ([homeArray count] > jfIndexPath.row) {
        homeDict = [homeArray objectAtIndex:jfIndexPath.row];
    }
    if ([guestArray count] > jfIndexPath.row) {
        guestDict = [guestArray objectAtIndex:jfIndexPath.row];
    }
    
    

    
    if ([homeDict objectForKey:@"num"]) {
         numLabelOne.text = [homeDict objectForKey:@"num"];
    }else{
        numLabelOne.text = @"";
    }
   
    if ([homeDict objectForKey:@"color"]) {
        if ([[homeDict objectForKey:@"color"]  length] == 0) {
            numLabelOne.backgroundColor = [UIColor clearColor];
            
            


        }else{
            
           NSString * colorstr = [self tolfunc:[homeDict objectForKey:@"color"]];
            NSLog(@"colostr = %@", colorstr);
            
            if (colorstr) {
                NSArray * colorArray = [colorstr componentsSeparatedByString:@" "];
                if ([colorArray count] >= 3) {
                    numLabelOne.backgroundColor = [UIColor colorWithRed:[[colorArray objectAtIndex:0] integerValue]/255.0 green:[[colorArray objectAtIndex:1] integerValue]/255.0 blue:[[colorArray objectAtIndex:2] integerValue]/255.0 alpha:1];
                }else{
                    numLabelOne.backgroundColor = [UIColor clearColor];
                }
            }else{
                numLabelOne.backgroundColor = [UIColor clearColor];
            }
            
        }
    }else{
        numLabelOne.backgroundColor = [UIColor clearColor];
    }
    
    if ([homeDict objectForKey:@"team_name"]) {
         nameLabelOne.text = [NSString stringWithFormat:@"  %@", [homeDict objectForKey:@"team_name"]];
    }else{
         nameLabelOne.text = @"";
    }
   
    if ([guestDict objectForKey:@"num"]) {
         numLabelTwo.text = [guestDict objectForKey:@"num"];
    }else{
         numLabelTwo.text = @"";
    }
    
   

   
    
    if ([guestDict objectForKey:@"color"]) {
        if ([[guestDict objectForKey:@"color"]  length] == 0) {
            numLabelTwo.backgroundColor = [UIColor clearColor];
        }else{
            
            NSString * colorstr = [self tolfunc:[guestDict objectForKey:@"color"]];
            NSLog(@"colostr = %@", colorstr);
            
            if (colorstr) {
                NSArray * colorArray = [colorstr componentsSeparatedByString:@" "];
                if ([colorArray count] >= 3) {
                    numLabelTwo.backgroundColor = [UIColor colorWithRed:[[colorArray objectAtIndex:0] integerValue]/255.0 green:[[colorArray objectAtIndex:1] integerValue]/255.0 blue:[[colorArray objectAtIndex:2] integerValue]/255.0 alpha:1];
                }else{
                    numLabelTwo.backgroundColor = [UIColor clearColor];
                }
            }else{
                numLabelTwo.backgroundColor = [UIColor clearColor];
            }
            
        }
    }else{
        numLabelTwo.backgroundColor = [UIColor clearColor];
    }
    
    if ([guestDict objectForKey:@"team_name"]) {
        nameLabelTwo.text = [NSString stringWithFormat:@"  %@",[guestDict objectForKey:@"team_name"]];
    }else{
        nameLabelTwo.text = @"";
    }
    
//    color
    
    NSArray * idArray = [self.interalString componentsSeparatedByString:@" "];
    if (idArray && [idArray count] >= 2) {
        
        
        
        if ([[homeDict objectForKey:@"team_id"] isEqualToString:[idArray objectAtIndex:0]]) {
            nameLabelOne.backgroundColor = [UIColor colorWithRed:218/255.0 green:253/255.0 blue:180/255.0 alpha:1];
        }else if ([[homeDict objectForKey:@"team_id"] isEqualToString:[idArray objectAtIndex:1]]){
            nameLabelOne.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:253/255.0 alpha:1];
            
        }else{
            nameLabelOne.backgroundColor = [UIColor clearColor];
        }
        
        if ([[guestDict objectForKey:@"team_id"] isEqualToString:[idArray objectAtIndex:0]]) {
            nameLabelTwo.backgroundColor = [UIColor colorWithRed:218/255.0 green:253/255.0 blue:180/255.0 alpha:1];
        }else if ([[guestDict objectForKey:@"team_id"] isEqualToString:[idArray objectAtIndex:1]]){
            nameLabelTwo.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:253/255.0 alpha:1];
            
        }else{
            nameLabelTwo.backgroundColor = [UIColor clearColor];
        }
    }else{
        nameLabelTwo.backgroundColor = [UIColor clearColor];
        nameLabelOne.backgroundColor = [UIColor clearColor];
        
    }
    
    
    
}

- (NSDictionary *)dataDictionary{
    return dataDictionary;
}


- (void)dealloc{
    [jfIndexPath release];
    [dataDictionary release];
    [super dealloc];
}


- (void)tableViewCellShow{
    
    for (int i = 0; i < 2; i++) {
        
        UILabel * numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 41.5, 31.5)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.tag = 100+i;
        numLabel.font = [UIFont systemFontOfSize:14];
//        numLabel.text = @"222";
        numLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:numLabel];
        [numLabel release];
        
        UIImageView * twoLineView = [[UIImageView alloc] initWithFrame:CGRectMake(41.5, 0, 0.5, 31.5)];
        twoLineView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
        [self.contentView addSubview:twoLineView];
        [twoLineView release];
        
        
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 0, 108, 31.5)];
        if (cellType == 1) {
            nameLabel.frame = CGRectMake(42, 0, 118, 31.5);
        }
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:15];
//        nameLabel.text = @"  曼联曼联曼联";
        nameLabel.tag = 200+i;
        nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:nameLabel];
        [nameLabel release];
        
        if (i == 1) {
            UIImageView * oneLineView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 0.5, 31.5)];
            oneLineView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
            [self.contentView addSubview:oneLineView];
            [oneLineView release];
            
            numLabel.frame = CGRectMake(150.5, 0, 41, 31.5);
            twoLineView.frame = CGRectMake(191.5, 0, 0.5, 31.5);
            nameLabel.frame = CGRectMake(192, 0, 108, 31.5);
            if (cellType == 1) {
                nameLabel.frame = CGRectMake(202, 0, 118, 31.5);
                numLabel.frame = CGRectMake(160.5, 0, 41, 31.5);
                twoLineView.frame = CGRectMake(201.5, 0, 0.5, 31.5);
                oneLineView.frame = CGRectMake(160, 0, 0.5, 31.5);
            }
            
        }
        
    }
    
    
    UIImageView * LineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 31.5, 300, 0.5)];
    LineView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [self.contentView addSubview:LineView];
    [LineView release];
    if (cellType == 1) {
        LineView.frame = CGRectMake(0, 31.5, 320, 0.5);
    }
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellType = type;
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self tableViewCellShow];
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