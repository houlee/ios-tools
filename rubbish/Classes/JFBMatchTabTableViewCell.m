//
//  JFBMatchTabTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-5-26.
//
//

#import "JFBMatchTabTableViewCell.h"

@implementation JFBMatchTabTableViewCell
@synthesize jfIndexPath, interalString, cellType;
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

    UILabel * nameLabelOne = (UILabel *)[self.contentView viewWithTag:200];
   
    NSArray * homeArray = [dataDictionary objectForKey:@"league"];

//    if ([homeArray count] <= jfIndexPath.row ) {
//         numLabelOne.backgroundColor = [UIColor clearColor];
//        nameLabelOne.backgroundColor = [UIColor clearColor];
//        numLabelOne.text = @"";
//        nameLabelOne.text = @"";
//        for (int i = 0; i < 5; i++) {
//            UILabel * titleMatchLabel = (UILabel *)[self.contentView viewWithTag:10+i];
//            
//            if (i == 0) {
//                titleMatchLabel.text = @"";
//            }else if (i == 1){
//                titleMatchLabel.text = @"";
//            }else if (i == 2){
//                titleMatchLabel.text = @"";
//            }else if (i == 3){
//                titleMatchLabel.text = @"";
//            }else if (i == 4){
//                titleMatchLabel.text = @"";
//            }
//        }
//        return;
//    }
    
    NSDictionary * homeDict = [homeArray objectAtIndex:jfIndexPath.row];

    NSLog(@"num = %@ team_name = %@",[homeDict objectForKey:@"num"] , [homeDict objectForKey:@"team_name"]);
    numLabelOne.text = [homeDict objectForKey:@"num"];
    nameLabelOne.text = [NSString stringWithFormat:@"  %@",[homeDict objectForKey:@"team_name"]];
    
    
    NSLog(@"interalString = %@", self.interalString);
    
    NSArray * idArray = [self.interalString componentsSeparatedByString:@" "];
    NSLog(@"idArray = %@ , %@, homedict = %@",[idArray objectAtIndex:0], [idArray objectAtIndex:1], [homeDict objectForKey:@"team_id"]);
    if (idArray && [idArray count] >= 2) {
        
        if ([[homeDict objectForKey:@"team_id"] isEqualToString:[idArray objectAtIndex:0]]) {
             nameLabelOne.backgroundColor = [UIColor colorWithRed:218/255.0 green:253/255.0 blue:180/255.0 alpha:1];
        }else if ([[homeDict objectForKey:@"team_id"] isEqualToString:[idArray objectAtIndex:1]]){
             nameLabelOne.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:253/255.0 alpha:1];
            
        }else{
            nameLabelOne.backgroundColor = [UIColor clearColor];
        }
    }else{
        
        nameLabelOne.backgroundColor = [UIColor clearColor];
                   
    }

    for (int i = 0; i < 5; i++) {
        UILabel * titleMatchLabel = (UILabel *)[self.contentView viewWithTag:10+i];
        
        if (i == 0) {
            titleMatchLabel.text = [homeDict objectForKey:@"round"];
        }else if (i == 1){
            titleMatchLabel.text = [homeDict objectForKey:@"win"];
        }else if (i == 2){
            titleMatchLabel.text = [homeDict objectForKey:@"same"];
        }else if (i == 3){
            titleMatchLabel.text = [homeDict objectForKey:@"lost"];
        }else if (i == 4){
            titleMatchLabel.text = [homeDict objectForKey:@"score"];
        }
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

    UILabel * numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 41.5, 31.5)];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont systemFontOfSize:14];
//    numLabel.text = @"222";
    numLabel.tag  = 100;
    numLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:numLabel];
    [numLabel release];
    
    UIImageView * twoLineView = [[UIImageView alloc] initWithFrame:CGRectMake(41.5, 0, 0.5, 31.5)];
    twoLineView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [self.contentView addSubview:twoLineView];
    [twoLineView release];
    
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 0, 105, 31.5)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15];
//    nameLabel.text = @"  曼联曼联曼联";
    nameLabel.tag = 200;
    nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:nameLabel];
    [nameLabel release];
    
    
    for (int i = 0; i < 5; i++) {
        UILabel * titleMatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(167+ (i*25), 0, 25, 31.5)];
        titleMatchLabel.backgroundColor = [UIColor clearColor];
        titleMatchLabel.textAlignment = NSTextAlignmentCenter;
        titleMatchLabel.font = [UIFont systemFontOfSize:11];
        titleMatchLabel.tag = 10+i;
//        titleMatchLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
        [self.contentView addSubview:titleMatchLabel];
        [titleMatchLabel release];
        if (i == 0) {
            titleMatchLabel.textColor = [UIColor blackColor];
        }else if (i == 1){
            titleMatchLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];

        }else if (i == 2){
            titleMatchLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];

        }else if (i == 3){
            titleMatchLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];

        }else if (i == 4){
             titleMatchLabel.textColor = [UIColor blackColor];
        }
        
        if (cellType == 1) {
            titleMatchLabel.font = [UIFont systemFontOfSize:14];
            titleMatchLabel.frame = CGRectMake(167+ (i*25), 0, 25, 31.5);
            titleMatchLabel.frame = CGRectMake(167+ (i*29), 0, 29, 31.5);
        }
    }
    
    
    
    UIImageView * LineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 31.5, 300, 0.5)];
    LineView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [self.contentView addSubview:LineView];
    [LineView release];
    if (cellType == 1) {
        LineView.frame = CGRectMake(0, 31.5, 320, 0.5);
        nameLabel.frame = CGRectMake(42, 0, 115, 31.5);
    }
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        cellType = type;
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