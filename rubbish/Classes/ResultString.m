//
//  ResultString.m
//  caibo
//
//  Created by user on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultString.h"
#import "SBJSON.h"

@implementation ResultString

+ (NSString*)resultStringByParsing:(NSString*)responseString
{
    NSString* result = nil;
    if (responseString) 
    {
        SBJSON *jsonParse = [SBJSON new];
        NSDictionary *dic = [jsonParse objectWithString:responseString];
        result = [dic objectForKey:@"result"];
        [jsonParse release];
    }
	return result;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    