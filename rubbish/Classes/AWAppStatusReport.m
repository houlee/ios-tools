//
//  AWAppStatusReport.m
//  appStatusReportSample
//
//  Created by yun.chen on 10/29/13.
//  Copyright (c) 2013 AppTao. All rights reserved.
//

#if __has_feature(objc_arc)

#else

#error Need ARC. please set complie flag '-fobjc-arc' to this file in build phases

#endif

#import "AWAppStatusReport.h"
#import "OpenUDID.h"
#import <sys/utsname.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/AdSupport.h>

@implementation AWAppStatusReport

+ (AWAppStatusReport *)sharedStatusReport {
    static AWAppStatusReport *_sharedStatusReport = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStatusReport = [[AWAppStatusReport alloc] init];
    });
    
    return _sharedStatusReport;
}

- (id)init
{
    self = [super init];
    if (self) {
        _appStoreID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppStoreID"];
    }
    
    return self;
}

- (void)setAppID:(NSString *)appID
{
    _appStoreID = appID;
}

- (void)report
{
    if (!_appStoreID) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static BOOL isReporting = NO;
        if (!isReporting) {
            isReporting = YES;
            
            NSString* service_url = [NSString stringWithFormat:@"http://sa.appwill.com/1/openlog/?%@",[self customHTTPGETParams]];
            NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:service_url]];
            NSHTTPURLResponse *response = nil;
            NSError *error = nil;
            [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
            
            
            static NSUInteger retryReportCount = 5;
            if (!([response statusCode] == 200 && !error) && retryReportCount--) {
                double delayInSeconds = 10.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                    [self report];
                });
            }
            else {
                retryReportCount = 5;
            }
            
            isReporting = NO;
        }
    });
}


- (NSString*)customHTTPGETParams {
    static NSString* httpGETParams = nil;
	if (httpGETParams==nil) {
		UIDevice *device = [UIDevice currentDevice];
		NSBundle *bundle = [NSBundle mainBundle];
		NSLocale *locale = [self currentLocale];
		NSString *model = [[self specificMachineModel] lowercaseString];
        
		NSString* deviceid = @"NA";
        NSString *macaddr = [[self macaddress] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSInteger timezone = [[NSTimeZone systemTimeZone] secondsFromGMT];
        NSString *phonetype = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"ipad" : @"iphone";
		httpGETParams = [NSString stringWithFormat:@"appid=%@&app=%@&v=%@&lang=%@&jb=%d&as=%d&mobclix=0&deviceid=%@&macaddr=%@&openudid=%@&ida=%@&tz=%d&phonetype=%@&model=%@&osn=%@&osv=%@",
                         _appStoreID,
						 [[self appName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
						 [[bundle objectForInfoDictionaryKey:@"CFBundleVersion"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
						 [[locale localeIdentifier] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
						 [self isJailBroken],
						 0,
						 deviceid,
                         macaddr,
                         [OpenUDID value],
                         [self idA],
                         timezone/3600,
                         phonetype,
						 //[[device model] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
						 [model stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
						 [[device systemName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
						 [[device systemVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	}
	return httpGETParams;
}

- (NSLocale*)currentLocale
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
	if (languages.count > 0) {
		NSString *currentLanguage = [languages objectAtIndex:0];
		return [[NSLocale alloc] initWithLocaleIdentifier:currentLanguage];
	} else {
		return [NSLocale currentLocale];
	}
}

- (NSString*)specificMachineModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
	
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (NSString *)appName
{
    static NSString *APPNAME = nil;
    if (!APPNAME) {
        APPNAME = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }

    return APPNAME;
}

- (BOOL)isJailBroken {
	NSString *filePath = @"/Applications/Cydia.app";
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		return YES;
	}
	
	filePath = @"/private/var/lib/apt";
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		return YES;
	}
	
	return NO;
}

- (NSString *)idA
{
    UIDevice *device = [UIDevice currentDevice];
    if ([self isVersionSupport:@"6.0"] && [device respondsToSelector:@selector(identifierForVendor)]) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return @"NA";
}

- (BOOL)isVersionSupport:(NSString *)reqSysVer {
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	return osVersionSupported;
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    