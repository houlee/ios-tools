//
//  LastLottery.m
//  caibo
//
//  Created by user on 11-10-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LastLottery.h"


@implementation LastLottery
@synthesize lotteryNo,issue,picurl,ernieDate,openNumber,lotteryName,ernieDateNew,weekday;
@synthesize tryoutNumber, region, Luck_blueNumber;

- (id)init{
    self = [super init];
    if (self) {
        self.Luck_blueNumber = @"";
    }
    return self;
}

- (UIImageView *)numViewWithStr:(NSString *)str inColor:(NSString*)color
{	
	UIImageView *iView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(color)] autorelease];
	iView.frame = CGRectMake(0, 0, 24, 24);
    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 22, 22)];
	[nLabel setText:str];
    nLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
	nLabel.textAlignment = NSTextAlignmentCenter;
	nLabel.highlightedTextColor = [UIColor whiteColor];
	nLabel.highlighted = YES;
	nLabel.backgroundColor = [UIColor clearColor];
	[iView addSubview:nLabel];
	[nLabel release];
	
	return iView;
}

-(NSArray*)imagesWithNumber{
	NSMutableArray* result = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
	NSArray* temp1 = [self.openNumber componentsSeparatedByString:@"+"];
    if ([temp1 count] > 0) {
        NSArray* temp2 = [[temp1 objectAtIndex:0] componentsSeparatedByString:@","];
        for (NSString *str in temp2) {
            //		UIImageView *imageView = [self numViewWithStr:str inColor:@"ball_red.png"];
            UIImageView *imageView = [self numViewWithStr:str inColor:@"kaijianghongqiu.png"];
            [result addObject:imageView];
        }
        if ([temp1 count]>1) {
            NSArray* temp3 = [[temp1 objectAtIndex:1] componentsSeparatedByString:@","];
            for (NSString *str in temp3) {
                //			UIImageView *imageView = [self numViewWithStr:str inColor:@"ball_blue.png"];
                UIImageView *imageView = [self numViewWithStr:str inColor:@"kaijianglanqiu.png"];
                [result addObject:imageView];
            }
        }
    }
	
	return result;
}
-(NSArray*)imagesWithKuaiLeShiFen{
	NSMutableArray* result = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
	NSArray* temp1 = [self.openNumber componentsSeparatedByString:@"+"];
    if ([temp1 count] > 0) {
        NSArray* temp2 = [[temp1 objectAtIndex:0] componentsSeparatedByString:@","];
        for (NSString *str in temp2) {
            UIImageView *imageView = nil;
            if ([str isEqualToString:@"19"]||[str isEqualToString:@"20"]) {
                //          imageView = [self numViewWithStr:str inColor:@"ball_red.png"];
                imageView = [self numViewWithStr:str inColor:@"kaijianghongqiu.png"];
            }else{
                //            imageView = [self numViewWithStr:str inColor:@"ball_blue.png"];
                imageView = [self numViewWithStr:str inColor:@"kaijianglanqiu.png"];
            }
            
            [result addObject:imageView];
        }
        if ([temp1 count]>1) {
            NSArray* temp3 = [[temp1 objectAtIndex:1] componentsSeparatedByString:@","];
            for (NSString *str in temp3) {
                //			UIImageView *imageView = [self numViewWithStr:str inColor:@"ball_blue.png"];
                UIImageView *imageView = [self numViewWithStr:str inColor:@"kaijianglanqiu.png"];
                [result addObject:imageView];
            }
        }
    }
	
	return result;
}

-(void)dealloc{
    [Luck_blueNumber release];
    [region release];
    [ernieDateNew release];
	[lotteryNo release];
	[issue release];
	[picurl release];
	[ernieDate release];
	[openNumber release];
	[lotteryName release];
    [tryoutNumber release];
    self.weekday = nil;
	[super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    