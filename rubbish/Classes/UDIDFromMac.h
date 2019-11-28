//
//  UDIDFromMac.h
//  caibo
//
//  Created by yaofuyu on 13-4-1.
//
//

#import <Foundation/Foundation.h>

@interface UDIDFromMac : NSObject
+ (NSString *) uniqueGlobalDeviceIdentifier;
+ (NSString *)IDFA;

@end
