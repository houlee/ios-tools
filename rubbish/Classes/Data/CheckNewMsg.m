//
//  CheckNewMsg.m
//  caibo
//
//  Created by jacob on 11-7-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckNewMsg.h"

#import "SBJSON.h"


@implementation CheckNewMsg

@synthesize zxdt,zxkj,zjsc,gfzz,mrcb,atme,pl,sx,gzrft,gz,xttz,dlttj,tx,zj, kefucountstr;


-(id)initWithParse:(NSString*)responseString{
	
	if(responseString ==nil)
		return NULL;
	
	if((self =[super init])){
		
		SBJSON *jsonParse = [[SBJSON alloc]init];
		
		NSDictionary *dic = [jsonParse objectWithString:responseString];
        NSLog(@"dic = %@",dic);
		
//		self.zxdt = [[dic valueForKey:@"zxdt"] stringValue];

		self.mrcb = [[dic valueForKey:@"mrcb"] stringValue];
		
		self.dlttj = [[dic valueForKey:@"dlt"] stringValue];
		
		// fans
		self.gz =[[dic valueForKey:@"gz"] stringValue];
		
		self.zjsc = [[dic valueForKey:@"zjsc"] stringValue];
		
		self.pl = [[dic valueForKey:@"pl"] stringValue];
		
		self.gfzz = [[dic valueForKey:@"gfzz"] stringValue];
		
		self.atme = [[dic valueForKey:@"atme"] stringValue];
	
		self.zxkj = [[dic valueForKey:@"zxkj"] stringValue];
		
		self.gzrft = [[dic valueForKey:@"gzrft"] stringValue];
		
		self.sx = [[dic valueForKey:@"sx"] stringValue];
	
		self.xttz  = [[dic valueForKey:@"xttz"]stringValue];
		self.zj= [[dic valueForKey:@"zj"] stringValue];
        self.kefucountstr = [[dic valueForKey:@"kfsx"] stringValue];
	    [jsonParse release];
	}
	
	return self;
	
}

-(void)dealloc{
	[kefucountstr release];
	
	[zxdt release];
	
	[zxkj release];
	[zjsc release];
	
	[gfzz release];
	[mrcb release];
	
	[atme release];
	
	[pl release];
	[tx release];
	[sx release];
	
	[gzrft release];
	
	[gz  release];
	[xttz release];
	
	[dlttj release];

	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    