//
//  UDIDFromMac.m
//  caibo
//
//  Created by yaofuyu on 13-4-1.
//
//

#import "UDIDFromMac.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "OpenUDID.h"
#import "NSStringExtra.h"
#import "SSKeychain.h"
#import <AdSupport/ASIdentifierManager.h>


@implementation UDIDFromMac
+ (NSString *) macaddress
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        return [OpenUDID value];
    }
	int                    mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error/n");
		return [OpenUDID value];
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1/n");
		return [OpenUDID value];
	}
	
	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. error!/n");
		return [OpenUDID value];
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return [OpenUDID value];
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	// NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
	
}

+ (NSString *)Realmacadress {
    int                    mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error/n");
		return nil;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1/n");
		return nil;
	}
	
	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. error!/n");
		return nil;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return nil;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
}

+ (NSString *)IDFA {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6) {
        return  [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else {
        return [UDIDFromMac macaddress];
    }
    return nil;
}

+ (NSString *) uniqueGlobalDeviceIdentifier{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        
        
   
        //从keychain里取出帐号密码
        NSString *password = [SSKeychain passwordForService:@"com.caibo365.v1"account:@"user"];
        if ([password length]) {
            //SSKeychain 有时候判断错误
            [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"caipiao365mac"];
            NSLog(@"%@",password);
            return password;
        }
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"caipiao365mac"] length] > 10) {
            return [[NSUserDefaults standardUserDefaults] valueForKey:@"caipiao365mac"];
        }
        NSString *macaddress = [UDIDFromMac macaddress];
        NSString *uniqueIdentifier = [NSString stringWithFormat:@"%@^_^%@",macaddress,[[NSString stringWithFormat:@"%@+e58129d3ec7e4110b974a67b049ad9e3",macaddress] stringFromMD5]];
        [SSKeychain setPassword: uniqueIdentifier
                     forService:@"com.caibo365.v1"account:@"user"];

       return uniqueIdentifier;
    }
    
    NSString *macaddress = [UDIDFromMac macaddress];
    NSString *uniqueIdentifier = [macaddress stringFromMD5];
    
    return uniqueIdentifier;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    