//
//  LastLotteryParser.m
//  caibo
//
//  Created by user on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LastLotteryParser.h"
#import "SBJSON.h"
#import "LastLottery.h"
@implementation LastLotteryParser
@synthesize welfareLottery,highfrequencyLottery,sportsLottery,
footballLottery,typeLottery,lotteries;

-(void)dealloc{
	[lotteries release];
	[typeLottery release];
	[welfareLottery release];
	[highfrequencyLottery release];
	[sportsLottery release];
	[footballLottery release];
	[super dealloc];
}

+(NSArray*)parseWithResponseString:(NSString*)response{
	
	
	SBJSON *jsonParser = [[SBJSON alloc] init];
	NSArray* arr = [jsonParser objectWithString:response];
	
	NSMutableArray *lotts = [[[NSMutableArray alloc] init] autorelease];
	if (arr) {
		for (NSDictionary *dic in arr) {
			
			NSString *type = [dic objectForKey:@"lotteryType"];
			
			NSArray *list = [dic objectForKey:@"list"];
            NSLog(@"%@",list);
			NSMutableArray *mArray = [[NSMutableArray alloc] init];
			for (NSDictionary *lottery in list) {
				LastLottery *lot = [[LastLottery alloc] init];
				lot.lotteryNo = [lottery objectForKey:@"lotteryNo"];
				lot.issue = [lottery objectForKey:@"issue"];
				lot.picurl = [lottery objectForKey:@"picUrl"];
				//NSLog(@"picurlpicurlpicurl%@",[lottery objectForKey:@"picUrl"]);
				lot.ernieDate = [lottery objectForKey:@"ernieDate"];
				lot.openNumber = [lottery objectForKey:@"openNumber"];
				lot.lotteryName = [lottery objectForKey:@"lotteryName"];
                lot.ernieDateNew = [lottery objectForKey:@"ernieDateStr"];
                lot.region =  [lottery objectForKey:@"region"];
                //3D试机号
                lot.tryoutNumber=[lottery objectForKey:@"tryoutNumber"];
                lot.Luck_blueNumber = [lottery objectForKey:@"Luck_blueNumber"];
//                lot.Luck_blueNumber = @"7";//假数据
                 NSLog(@"%@",lot.tryoutNumber);
                NSLog(@"Luck_blueNumber ======  %@",lot.Luck_blueNumber);
				[mArray addObject:lot];
				[lot release];
			}
            ////////////////////////////////////////////////
//            LastLottery *lot1 = [[LastLottery alloc] init];
//            lot1.lotteryName = @"竞彩足球";
//            lot1.issue = [dic objectForKey:@"jcIssue"];
//            [mArray addObject:lot1];
//            [lot1 release];
//            
//            LastLottery *lot2 = [[LastLottery alloc] init];
//            lot2.lotteryName = @"竞彩篮球";
//            lot2.issue = [dic objectForKey:@"jcIssue"];
//            [mArray addObject:lot2];
//            [lot2 release];
//            
//            
//            LastLottery *lot3 = [[LastLottery alloc] init];
//            lot3.lotteryName = @"北京单场";
//            lot3.issue = [dic objectForKey:@"bdIssue"];
//            [mArray addObject:lot3];
//            [lot3 release];
            ///////////////////////////////////////////////
            
            
			if([mArray count]>0){
				NSMutableDictionary *lDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:type,@"lotteryType",mArray,@"list",nil];
				[lotts addObject:lDic];
			}
			
			[mArray release];
			
		}
	}
	//NSLog(@"count::::%d",[lotts count]);
	[jsonParser release];
	return lotts;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    