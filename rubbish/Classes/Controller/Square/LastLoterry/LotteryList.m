//
//  LotteryList.m
//  caibo
//
//  Created by sulele on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LotteryList.h"
#import "SBJSON.h"


@implementation LotteryList
@synthesize maxPage,lotteryId,pageSize,currentPage;
@synthesize relist,lotteryNumber,issue,ernie_date,lotteryName, Luck_blueNumber;
@synthesize reListArray;


- (id)initWithParse:(NSString *)jsonString 
{
    if(nil == jsonString){
		
		return nil;
	}
	self = [super init];
    SBJSON *json = [[SBJSON alloc] init];
	NSDictionary *dictArray = [json objectWithString: jsonString];
	if(dictArray)
	{
        self.maxPage = [dictArray valueForKey:@"maxPage"];
		self.lotteryId = [dictArray valueForKey:@"lotteryId"];
		self.pageSize = [dictArray valueForKey:@"pageSize"];
		self.currentPage = [dictArray valueForKey:@"currentPage"];
		
		
		//彩票列表
		NSArray *rArray = [dictArray valueForKey:@"relist"];
		if ([rArray count])
		{
			NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
			for (int i = 0; i < [rArray count]; i++)
			{
				NSDictionary *dicReList = [rArray objectAtIndex:i];
				LotteryList *lotteryList = [self paserWithDictionary: dicReList]; 
				[mutableArray insertObject: lotteryList atIndex: i];
			}
			self.reListArray = mutableArray;
			[mutableArray release];
		}
		
		self.lotteryName = [dictArray valueForKey:@"lotteryName"];
	}
	
	[json release];
	
	return self;
}



- (id)paserWithDictionary:(NSDictionary *)dic 
{
	LotteryList *lList = [[[LotteryList alloc] init] autorelease];
    if(dic)
	{
        lList.lotteryNumber = [dic valueForKey:@"lotteryNumber"];
		lList.issue = [dic valueForKey:@"issue"];
		lList.ernie_date = [dic valueForKey:@"ernie_datestr"];
        lList.Luck_blueNumber = [dic  valueForKey:@"Luck_blueNumber"];
//        lList.Luck_blueNumber = @"13";
	}
    
    return lList;
}

- (UIImageView *)numViewWithStr:(NSString *)str inColor:(NSString*)color
{	
	UIImageView *iView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(color)] autorelease];
//	iView.frame = CGRectMake(0, 0, 24, 24);
    iView.frame = CGRectMake(0, 0, 25, 25);
//	UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 22, 22)];
    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 23, 23)];
	[nLabel setText:str];
	nLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	nLabel.textAlignment = NSTextAlignmentCenter;
	nLabel.highlightedTextColor = [UIColor whiteColor];
	nLabel.highlighted = YES;
	nLabel.backgroundColor = [UIColor clearColor];
	[iView addSubview:nLabel];
	[nLabel release];
	
	return iView;
	
}
- (UIImageView *)numViewWithStr2:(NSString *)str inColor:(NSString*)color
{
	UIImageView *iView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(color)] autorelease];
	iView.frame = CGRectMake(0, 0, 25, 25);
	UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 23, 23)];
	[nLabel setText:str];
	nLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	nLabel.textAlignment = NSTextAlignmentCenter;
	nLabel.highlightedTextColor = [UIColor colorWithRed:249/255.0 green:58/255.0 blue:48/255.0 alpha:1];
	nLabel.highlighted = YES;
	nLabel.backgroundColor = [UIColor clearColor];
	[iView addSubview:nLabel];
	[nLabel release];
	
	return iView;
	
}
- (UIImageView *)numViewWithStr3:(NSString *)str inColor:(NSString*)color
{
	UIImageView *iView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(color)] autorelease];
	iView.frame = CGRectMake(0, 0, 25, 25);
	UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 23, 23)];
	[nLabel setText:str];
	nLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	nLabel.textAlignment = NSTextAlignmentCenter;
	nLabel.highlightedTextColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
	nLabel.highlighted = YES;
	nLabel.backgroundColor = [UIColor clearColor];
	[iView addSubview:nLabel];
	[nLabel release];
	
	return iView;
	
}

-(NSArray*)imagesWithNumber:(NSString *)num{
	NSMutableArray* result = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
	NSArray* temp1 = [num componentsSeparatedByString:@"+"];
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
-(NSArray*)imagesWithNumber2:(NSString *)num{
	NSMutableArray* result = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
	NSArray* temp1 = [num componentsSeparatedByString:@"+"];
    if ([temp1 count] > 0) {
        NSArray* temp2 = [[temp1 objectAtIndex:0] componentsSeparatedByString:@","];
        for (NSString *str in temp2) {
            //		UIImageView *imageView = [self numViewWithStr:str inColor:@"ball_red.png"];
            UIImageView *imageView = [self numViewWithStr2:str inColor:@"lishihongqiu.png"];
            [result addObject:imageView];
        }
        if ([temp1 count]>1) {
            NSArray* temp3 = [[temp1 objectAtIndex:1] componentsSeparatedByString:@","];
            for (NSString *str in temp3) {
                //			UIImageView *imageView = [self numViewWithStr:str inColor:@"ball_blue.png"];
                //            UIImageView *imageView = [self numViewWithStr:str inColor:@"lishilanqiu.png"];
                UIImageView *imageView = [self numViewWithStr3:str inColor:@"lishilanqiu.png"];
                [result addObject:imageView];
            }
        }
    }
	
    
	return result;
	
}
-(NSArray*)imagesWithKuaiLeShiFen:(NSString *)num{
	NSMutableArray* result = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
	NSArray* temp1 = [num componentsSeparatedByString:@"+"];
    if ([temp1 count] > 0) {
        NSArray* temp2 = [[temp1 objectAtIndex:0] componentsSeparatedByString:@","];
        for (NSString *str in temp2) {
            UIImageView *imageView = nil;
            if ([str isEqualToString:@"19"] || [str isEqualToString:@"20"]) {
                //            imageView = [self numViewWithStr:str inColor:@"ball_red.png"];
                imageView = [self numViewWithStr:str inColor:@"kaijianghongqiu.png"];
            }else{
                //            imageView = [self numViewWithStr:str inColor:@"ball_blue.png"];
                imageView = [self numViewWithStr:str inColor:@"kaijianglanqiu.png"];
            }
            
            [result addObject:imageView];
        }
    }
	
	
    
	return result;
	
}
-(NSArray*)imagesWithKuaiLeShiFen2:(NSString *)num{
	NSMutableArray* result = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
	NSArray* temp1 = [num componentsSeparatedByString:@"+"];
    if ([temp1 count] > 0) {
        NSArray* temp2 = [[temp1 objectAtIndex:0] componentsSeparatedByString:@","];
        for (NSString *str in temp2) {
            UIImageView *imageView = nil;
            if ([str isEqualToString:@"19"] || [str isEqualToString:@"20"]) {
                //            imageView = [self numViewWithStr:str inColor:@"ball_red.png"];
                imageView = [self numViewWithStr2:str inColor:@"lishihongqiu.png"];
            }else{
                //            imageView = [self numViewWithStr:str inColor:@"ball_blue.png"];
                imageView = [self numViewWithStr3:str inColor:@"lishilanqiu.png"];
            }
            
            [result addObject:imageView];
        }
    }
	
	
    
	return result;
	
}

-(NSArray*)imagesWithKuaiSan:(NSString *)num
{
    NSString * num1 = [num stringByReplacingOccurrencesOfString:@"0" withString:@""];
    NSArray * numArr = [num1 componentsSeparatedByString:@","];
    NSMutableArray* resultArr = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
    for (int i = 0; i < numArr.count; i++) {
//        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"shaiz%@.png",[numArr objectAtIndex:i]]]];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"kaijiangshaizi%@.png",[numArr objectAtIndex:i]]]];
        [resultArr addObject:imageView];
        [imageView release];
    }
    return resultArr;
}

-(NSArray*)imagesWithHorseNumber:(NSString *)num{
    NSMutableArray* result = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
    NSArray* temp2 = [num componentsSeparatedByString:@","];
    for (NSString *str in temp2) {
        //		UIImageView *imageView = [self numViewWithStr:str inColor:@"ball_red.png"];
        UIImageView *imageView = [self numViewWithHorseStr:str inColor:@"HorseHead.png"];
        [result addObject:imageView];
    }
    return result;
}

- (UIImageView *)numViewWithHorseStr:(NSString *)str inColor:(NSString*)color
{
    UIImageView *iView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(color)] autorelease];
    //	iView.frame = CGRectMake(0, 0, 24, 24);
    iView.frame = CGRectMake(0, 0, 32.5, 32.5);
    //	UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 22, 22)];
    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 22, 23)];
    [nLabel setText:str];
    nLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    nLabel.textAlignment = NSTextAlignmentCenter;
    nLabel.highlightedTextColor = [UIColor whiteColor];
    nLabel.highlighted = YES;
    nLabel.backgroundColor = [UIColor clearColor];
    [iView addSubview:nLabel];
    [nLabel release];
    
    return iView;
    
}

- (void)dealloc
{
    [Luck_blueNumber release];
	[maxPage release];
	[lotteryId release];
	[pageSize release];
	[currentPage release];
	[relist release];
	[lotteryNumber release];
	[issue release];
	[ernie_date release];
	[lotteryName release];
	[reListArray release];
	
	[super dealloc];
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    