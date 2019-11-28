//
//  UIDeviceHardware.m
//  caibo
//
//  Created by jacob on 11-7-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIDeviceHardware.h"

#import "UIDeviceHardware.h"

#include <sys/types.h>

#include <sys/sysctl.h>

@implementation UIDeviceHardware

- (NSString *) platform{
	
	size_t size;
	
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	
    char *machine = malloc(size);
	
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
	
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
	
    free(machine);
	
    return platform;


}

- (NSString *) platformString{
	
	NSString *platform = [self platform];
	
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
	
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
	
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
	
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
	
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
	
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
	
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
	
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
	
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
	
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])         return @"iPhone Simulator";
	
    return platform;


}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    