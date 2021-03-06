//
//  SwitchCell.m
//  iphone_control
//
//  Created by houchenguang on 12-12-5.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

@synthesize titleLabel;
@synthesize bgimage;
@synthesize line;
@synthesize line2;
@synthesize switchyn;
@synthesize delegate;
@synthesize _section;
@synthesize _row;

- (void)dealloc{
    
    [bgimage release];
    [line release];
    [titleLabel release];
    [switchyn release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
#ifdef isCaiPiaoForIPad
    
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 475, 44)];
        bgimage.backgroundColor = [UIColor whiteColor];
        bgimage.userInteractionEnabled = YES;
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 200, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        [bgimage addSubview:titleLabel];
        
        switchyn = [[CP_SWButton alloc] initWithFrame:CGRectMake(370, 8, 77, 27)];
        switchyn.onImageName = @"heji2-640_10.png";
        switchyn.offImageName = @"heji2-640_11.png";
        [switchyn addTarget:self action:@selector(pressSwitchYN:) forControlEvents:UIControlEventValueChanged];
        [bgimage addSubview:switchyn];
        
        //        CP_SWButton *sw = [CP_SWButton buttonWithType:UIButtonTypeCustom];
        //        sw.frame = CGRectMake(50, 150, 70, 30);
        //        [self.view addSubview:sw];
        
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(2, 42, 472, 2)];
        line.backgroundColor = [UIColor clearColor];
        line.backgroundColor = [UIColor grayColor];
        [bgimage addSubview:line];
        
        
        
        
        [self.contentView addSubview:bgimage];
        
    }
    return self;
    
#else
    
    if (self) {
        
        
        
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        bgimage.backgroundColor = [UIColor whiteColor];
        bgimage.userInteractionEnabled = YES;
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 200, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        [bgimage addSubview:titleLabel];
        
        switchyn = [[CP_SWButton alloc] init];
        switchyn.frame = CGRectMake(235, 8, 70, 31);
        switchyn.onImageName = @"heji2-640_10.png";
        switchyn.offImageName = @"heji2-640_11.png";
        [bgimage addSubview:switchyn];
//        switchyn.offImageName = @"switchOff_1.png";
        [switchyn addTarget:self action:@selector(pressSwitchYN:) forControlEvents:UIControlEventValueChanged];

        
      
        
        
        
        
        
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 0.5)];
        line.backgroundColor = [UIColor clearColor];
        line.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [bgimage addSubview:line];
        
        line2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
        line2.backgroundColor = [UIColor clearColor];
        line2.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [bgimage addSubview:line2];
        
        
        [self.contentView addSubview:bgimage];
        
    }
    return self;
    
#endif


}

- (void)pressSwitchYN:(CP_SWButton *)sender{
//    switchyn.on = sender.on;
//    if (sender.on == YES) {
//        [self switchReturnYesOrNo:@"1" section:_section row:_row];
//    }else{
//        [self switchReturnYesOrNo:@"0" section:_section row:_row];
//    }
    
    if (sender.on) {
        //sender.on = NO;
        //sender.selected = NO;
        [self switchReturnYesOrNo:@"1" section:_section row:_row];
    }else{
        //sender.on= YES;
        //sender.selected = YES;
        [self switchReturnYesOrNo:@"0" section:_section row:_row];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)switchReturnYesOrNo:(NSString *)yesorno section:(NSInteger)section row:(NSInteger)row{
    if ([delegate respondsToSelector:@selector(switchReturnYesOrNo:section:row:)]) {
        [delegate switchReturnYesOrNo:yesorno section:section row:row];
    }

}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    