//
//  EveryDayCellModel.m
//  caibo
//
//  Created by GongHe on 14-1-13.
//
//

#import "EveryDayCellModel.h"

@implementation EveryDayCellModel
@synthesize contentArr;
@synthesize titleStr;
@synthesize is_title;

- (void)dealloc
{
    [titleStr release];
    [contentArr release];
    [super dealloc];
}

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        NSArray * mainArr = [string componentsSeparatedByString:@":"];
        self.titleStr = [mainArr objectAtIndex:0];
        self.contentArr = [[[NSMutableArray alloc] init] autorelease];
        for (NSString * str in [[mainArr objectAtIndex:1] componentsSeparatedByString:@"/"]) {
            if (![str isEqualToString:@""]) {//&& [[str componentsSeparatedByString:@"^"] count] > 4
                [contentArr addObject:[str componentsSeparatedByString:@"^"]];
            }
        }
        self.is_title = NO;
    }
    return self;
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    