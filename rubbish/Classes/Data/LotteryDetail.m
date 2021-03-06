//
//  LotteryDetails.m
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LotteryDetail.h"
#import "SBJSON.h"

@implementation LotteryDetail

@synthesize dicArray, picUrl, reList, awards, winningNote, single_Note_Bonus, reListArray;
@synthesize lotteryNumber, lotteryId, issue, buyamont, sales_rx9, sales_sfc, prizePool, ernie_date, lotteryName;
@synthesize againstName, againstNamesList, reAgainstList, screening, teams, score, results;
@synthesize name1, name2, name3, name4;
@synthesize msg;

- (id)initWithParse:(NSString *)jsonString 
{
    if(nil == jsonString){
		
		return nil;
	}
	self = [super init];
    SBJSON *json = [[SBJSON alloc] init];
	NSDictionary *dictArray = [json objectWithString: jsonString];
	self.dicArray = dictArray;
	if(dictArray)
	{
        self.picUrl = [dictArray valueForKey:@"picUrl"];

		NSArray *rArray = [dictArray valueForKey:@"reList"];
		if ([rArray count])
		{
			NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
			for (int i = 0; i < [rArray count]; i++)
			{
				NSDictionary *dicReList = [rArray objectAtIndex:i];
				LotteryDetail *lotteryDetail = [self paserWithDictionary: dicReList]; 
				[mutableArray insertObject: lotteryDetail atIndex: i];
			}
			self.reListArray = (NSArray *)mutableArray;
			[mutableArray release];
		}
		
		self.lotteryNumber = [dictArray valueForKey:@"lotteryNumber"];
		self.lotteryId = [dictArray valueForKey:@"lotteryId"];
		self.issue = [dictArray valueForKey:@"issue"];
		self.buyamont = [dictArray valueForKey:@"buyamont"];
		self.sales_rx9 = [dictArray valueForKey:@"sales_rx9"];
		self.sales_sfc = [dictArray valueForKey:@"sales_sfc"];
		self.ernie_date = [dictArray valueForKey:@"ernie_date"];
		self.lotteryName = [dictArray valueForKey:@"lotteryName"];
		
		self.msg = [dictArray valueForKey:@"msg"];
		
		self.againstName = [dictArray valueForKey:@"againstName"];
		
		NSDictionary *dicAgainstNameList = [dictArray valueForKey:@"againstNames"];
		if (dicAgainstNameList != nil)
		{NSLog(@"againstNames = %@\n", [dictArray valueForKey:@"againstNames"]);

			self.name1 = [dicAgainstNameList valueForKey:@"name1"];
			self.name2 = [dicAgainstNameList valueForKey:@"name2"];
			self.name3 = [dicAgainstNameList valueForKey:@"name3"];
			self.name4 = [dicAgainstNameList valueForKey:@"name4"];
			
			NSArray *array = [[NSArray alloc] initWithObjects:self.name1,self.name2,self.name3,self.name4,nil];
			self.againstNamesList = array;
			[array release];
		}
		
		NSArray *aArray = [dictArray valueForKey:@"againstList"];
		if ([aArray count])
		{
			NSMutableArray *mArray = [[NSMutableArray alloc] init];
			for (int k = 0; k < [aArray count]; k++)
			{
				NSDictionary *dicAgainstList = [aArray objectAtIndex:k];
				LotteryDetail *lotteryDetail = [self paserWithDic: dicAgainstList]; 
				[mArray insertObject: lotteryDetail atIndex: k];
			}
			self.reAgainstList = (NSArray *)mArray;
			[mArray release];
		}
	}
	
	[json release];
	
	return self;
}


- (id)paserWithDictionary:(NSDictionary *)dic 
{
	LotteryDetail *lDetail = [[[LotteryDetail alloc] init] autorelease];
    if(dic)
	{
        lDetail.awards = [dic valueForKey:@"awards"];
		lDetail.winningNote = [dic valueForKey:@"winningNote"];
		lDetail.single_Note_Bonus = [dic valueForKey:@"single_Note_Bonus"];
	}
    
    return lDetail;
}


- (id)paserWithDic:(NSDictionary *)dic 
{
	LotteryDetail *aDetail = [[[LotteryDetail alloc] init] autorelease];
    if(dic)
	{
        aDetail.screening = [dic valueForKey:@"screening"];
		aDetail.teams = [dic valueForKey:@"teams"];
		aDetail.score = [dic valueForKey:@"score"];
		aDetail.results = [dic valueForKey:@"results"];
	}
    
    return aDetail;
}


- (void)dealloc
{
	[dicArray release];
	[picUrl release];
	[reList release];
	[awards release];
	[winningNote release];
	[single_Note_Bonus release];
	[reListArray release];
	
	[lotteryNumber release];
	[lotteryId release];
	[issue release];
	[buyamont release];
	[sales_rx9 release];
	[sales_sfc release];
	[prizePool release];
	[ernie_date release];
	[lotteryName release];
	
	[name1 release];
	[name2 release];
	[name3 release];
	[name4 release];
	
	[againstName release];
	[againstNamesList release];
	[reAgainstList release];
	[screening release];
	[teams release];
	[score release];
	[results release];
	[msg release];

	[super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    