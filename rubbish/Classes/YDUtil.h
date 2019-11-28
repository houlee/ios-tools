//
//  YDUtil.h
//  caibo
//
//  Created by hu jian on 11-7-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YDUtil : NSObject {
    
}

+(void)stopSound ;
+(void) playSound: (NSString*) name;
+ (void)playSoundwithFullName:(NSString*)name;
+(void) setVolumn: (NSInteger) value;
+(void) playVib;
+(double)availableMemory ;
@end
