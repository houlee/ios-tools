//
//  NSArray+custom.h
//  Lottery
//
//  Created by Jacob Chiang on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (custom)

-(NSArray*)afterInOder;

NSInteger compareWithInteger(id num1, id num2, void *context);
@end
