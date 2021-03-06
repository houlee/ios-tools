//
//  YDUtil.m
//  caibo
//
//  Created by hu jian on 11-7-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#include <AudioToolbox/AudioToolbox.h>
#include <AudioToolbox/AudioServices.h>
#include <CoreFoundation/CoreFoundation.h>

#include <sys/sysctl.h>  
#include <mach/mach.h>


#import "YDUtil.h"

 
@implementation YDUtil

+(void)stopSound {
    UInt32 a = (unsigned int)[[[NSUserDefaults standardUserDefaults] valueForKey:@"soundId"] integerValue];
    if (a != 0) {
        AudioServicesDisposeSystemSoundID(a);
    }
    
}

+ (void)playSound:(NSString*)name
{
    SystemSoundID pmph;
    [YDUtil stopSound];
    UInt32 propertySize = sizeof(CFStringRef);
    CFStringRef state = nil;
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute
                            ,&propertySize,&state);
    //return @"Headphone" or @"Speaker" and so on.
    //根据状态判断是否为耳机状态
    if ([(NSString *)state rangeOfString:@"Headphone"].location != NSNotFound || [(NSString *)state rangeOfString:@"HeadsetInOut"].location != NSNotFound ) {
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_None;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    }
    else {
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    }

    id sndpath = [[NSBundle mainBundle]
                  pathForResource:name
                  ofType:@"wav" 
                  inDirectory:@"/"];
    if (sndpath) {
        NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:sndpath];
        AudioServicesCreateSystemSoundID ((CFURLRef)baseURL, &pmph);
        AudioServicesPlaySystemSound(pmph);
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",(unsigned int)pmph] forKey:@"soundId"];
        [baseURL release];
    }
}

+ (void)playSoundwithFullName:(NSString*)name {
    SystemSoundID pmph;
    UInt32 propertySize = sizeof(CFStringRef);
    CFStringRef state = nil;
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute
                            ,&propertySize,&state);
    //return @"Headphone" or @"Speaker" and so on.
    //根据状态判断是否为耳机状态
    if ([(NSString *)state rangeOfString:@"Headphone"].location != NSNotFound || [(NSString *)state rangeOfString:@"HeadsetInOut"].location != NSNotFound ) {
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_None;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    }
    else {
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    }    if (name) {
        NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:name];
        AudioServicesCreateSystemSoundID ((CFURLRef)baseURL, &pmph);
        AudioServicesPlaySystemSound(pmph);
        
        [baseURL release];
    }
}

+(void) setVolumn: (NSInteger) value
{
        
}

+(void) playVib
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}




+(double)availableMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    
    if(kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    