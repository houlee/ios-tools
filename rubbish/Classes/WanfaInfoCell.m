//
//  WanfaInfoCell.m
//  TableTest
//
//  Created by cp365dev on 14-5-6.
//  Copyright (c) 2014年 cp365dev. All rights reserved.
//

#import "WanfaInfoCell.h"

@implementation WanfaInfoCell
@synthesize lieshu;
@synthesize hangofCell;
@synthesize jiangjiArray;
@synthesize jiangjinArray;
@synthesize zjtiaojianArray;
@synthesize zjshuomingArray;
@synthesize isQiLeCai;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self.backgroundColor = [UIColor  clearColor];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}
//cell第一列label

-(void)addCell1:(NSString *)jiangji andCellNUm:(int)num andWedith:(int)wed lineHeight:(float)height
{
    if(hangofCell != 1 && hangofCell != 0)
    {
        num = hangofCell;
    }
    UIImageView *xianImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 174)] autorelease];
    [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage];
    
    label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, wed, 36+22*(num-1))] autorelease];
    label1.font = [UIFont systemFontOfSize:14.0];
    label1.numberOfLines = 0;
    label1.backgroundColor = [UIColor clearColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = jiangji;
    [self.contentView addSubview:label1];
    
    UIImageView *xianImage1 = [[[UIImageView alloc] initWithFrame:CGRectMake(wed-1, 0, 1, height)] autorelease];
    [xianImage1 setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage1];
}

-(void)addCell1:(NSString *)jiangji andCellNUm:(int)num andWedith:(int)wed
{
    [self addCell1:jiangji andCellNUm:num andWedith:wed lineHeight:36+22*(hangofCell-1)];
}

//cell第二列label

-(void)addCell2:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed textAlignment:(NSTextAlignment)textAlignment{
    
    if(hangofCell != 1 && hangofCell != 0)
    {
        num = hangofCell;
    }
    label2 = [[[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width, 0, wed, 36+22*(num-1))] autorelease];
    if (textAlignment == NSTextAlignmentLeft) {
        label2.frame = CGRectMake(label1.frame.origin.x+label1.frame.size.width + 5, 0, wed - 5, 36+22*(num-1));
    }
    label2.text  = jiangji;
    label2.font = [UIFont systemFontOfSize:14.0];
    label2.numberOfLines = 0;
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = textAlignment;
    [self.contentView addSubview:label2];
    
    UIImageView *xianImage = [[[UIImageView alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width-1, 0, 1, 36+22*(num-1))] autorelease];
    [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage];
    
}

-(void)addCell2:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed{
    [self addCell2:jiangji andCellNum:num andWedith:wed textAlignment:NSTextAlignmentCenter];
        
}
-(void)addCell2Another:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed andX:(int)y
{
    if(hangofCell != 1 && hangofCell != 0)
    {
        num = hangofCell;
    }
    label2 = [[[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width, y, wed, 36+22*(num-1))] autorelease];
    label2.text  = jiangji;
    label2.font = [UIFont systemFontOfSize:14.0];
    label2.numberOfLines = 0;
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label2];
    
    UIImageView *xianImage = [[[UIImageView alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width-1, y, 1, 36+22*(num-1))] autorelease];
    [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage];

}
-(void)addCell3Another:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed andX:(int)y
{
    if(hangofCell != 1 && hangofCell != 0)
    {
        num = hangofCell;
    }
    label3 = [[[UILabel alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width, y, wed, 36+22*(num-1))] autorelease];
    label3.text=jiangji;
    label3.numberOfLines = 0;
    label3.backgroundColor = [UIColor clearColor];
    label3.font = [UIFont systemFontOfSize:14.0];
    label3.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label3];
    
    UIImageView *xianImage = [[[UIImageView alloc] initWithFrame:CGRectMake(label3.frame.origin.x+label3.frame.size.width-1, y, 1, 36+22*(num-1))] autorelease];
    [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage];
}
//cell第二列球

-(void)addCell2WithRedBordNum:(int)redNum andBlueBordNum:(int)blueNum andCellNum:(int)num andWedith:(int)wed
{
    
    int x = (wed - 7*(redNum + blueNum) - 2*(redNum+blueNum-1))/2;
    UIImageView *red = nil;
    UIImageView *blue = nil;
    for(int i = 0;i<redNum;i++)
    {
        red = [[[UIImageView alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+1+x+i*9, ((36+22*(num-1)-7*num)/(num+1)) * num + 7* (num-1), 7, 7)] autorelease];
        [red setImage:[UIImage imageNamed:@"wf_redBord.jpg"]];
        [self.contentView addSubview:red];
    }
    
    for(int i = 0;i<blueNum;i++)
    {

        if(redNum == 0)
        {
            blue= [[[UIImageView alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+1+x+i*9, ((36+22*(num-1)-7*num)/(num+1)) * num + 7* (num-1), 7, 7)] autorelease];
            [blue setImage:[UIImage imageNamed:@"wf_blueBord.jpg"]];
            [self.contentView addSubview:blue];
        }
        else{
            
            blue= [[[UIImageView alloc] initWithFrame:CGRectMake(red.frame.origin.x+9+i*9, ((36+22*(num-1)-7*num)/(num+1)) * num + 7* (num-1), 7, 7)] autorelease];
            [blue setImage:[UIImage imageNamed:@"wf_blueBord.jpg"]];
            [self.contentView addSubview:blue];
        }
    }
    
    
    label2 = [[[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+1, 0, wed, 36+22*(num-1))] autorelease];
    label2.backgroundColor = [UIColor clearColor];
    
    UIImageView *xianImage = [[[UIImageView alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width, 0, 1, 36+22*(num-1))] autorelease];
    if(isQiLeCai)
    {
        xianImage.frame = CGRectMake(xianImage.frame.origin.x, 0, 1, 36+22*num);
    }
    [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage];
}


//第三列(带球滴)
-(void)addCell3WithBord:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed
{
    label3 = [[[UILabel alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width, ((36+22*(num-1)-14*num)/(num+1)) * num + 11.5* (num-1), wed, 14)] autorelease];
    label3.text=jiangji;
    label3.numberOfLines = 0;
    label3.backgroundColor = [UIColor clearColor];
    label3.font = [UIFont systemFontOfSize:14.0];
    label3.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label3];
    
    UIImageView *xianImage = [[[UIImageView alloc] initWithFrame:CGRectMake(label3.frame.origin.x+label3.frame.size.width-1, 0, 1, 36+22*(num-1))] autorelease];
    [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage];
}
//cell第三列label
-(void)addCell3:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed{

    if(hangofCell != 1 && hangofCell != 0)
    {
        num = hangofCell;
    }
    label3 = [[[UILabel alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width, 0, wed, 36+22*(num-1))] autorelease];
    label3.text=jiangji;
    label3.numberOfLines = 0;
    label3.backgroundColor = [UIColor clearColor];
    label3.font = [UIFont systemFontOfSize:14.0];
    label3.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label3];
    
    UIImageView *xianImage = [[[UIImageView alloc] initWithFrame:CGRectMake(label3.frame.origin.x+label3.frame.size.width-1, 0, 1, 36+22*(num-1))] autorelease];
    [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage];

}
//cell第四列label
-(void)addCell4:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed{
    
    if(hangofCell != 1 && hangofCell != 0)
    {
        num = hangofCell;
    }

    label4 = [[[UILabel alloc] initWithFrame:CGRectMake(label3.frame.origin.x+label3.frame.size.width, 0, wed, 36+22*(num-1))] autorelease];
    label4.text = jiangji;
    label4.backgroundColor = [UIColor clearColor];
    label4.numberOfLines = 0;
    label4.font = [UIFont systemFontOfSize:14.0];
    label4.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label4];
    
    UIImageView *xianImage = [[[UIImageView alloc] initWithFrame:CGRectMake(295, 0, 1, 36+22*(num-1))] autorelease];
    [xianImage setImage:[UIImage imageNamed:@"wf_xian.png"]];
    [self.contentView addSubview:xianImage];
        
        
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