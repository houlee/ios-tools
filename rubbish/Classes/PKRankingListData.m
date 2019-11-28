//
//  PKRankingListData.m
//  caibo
//
//  Created by GongHe on 15-1-19.
//
//

#import "PKRankingListData.h"

@implementation PKRankingListData
@synthesize rank;
@synthesize userName;
@synthesize earnings;
@synthesize winnings;

- (void)dealloc
{
    [rank release];
    [userName release];
    [earnings release];
    [winnings release];
    
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.rank = [dictionary valueForKey:@"rank"];
        self.userName = [dictionary valueForKey:@"userName"];
        self.earnings = [dictionary valueForKey:@"earnings"];
        self.winnings = [dictionary valueForKey:@"winnings"];
        
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    