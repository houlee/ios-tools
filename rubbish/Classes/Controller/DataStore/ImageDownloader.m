//
//  ImageDownloader.m
//  caibo
//
//  Created by jeff.pluto on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageDownloader.h"
#import "ASIHTTPRequest.h"
#import "DataBase.h"
#import "Statement.h"
#import "caiboAppDelegate.h"

@interface ImageDownloader ()
- (void)imageFetchFinish:(ASIHTTPRequest *)request;
- (void)imageFetchFailed:(ASIHTTPRequest *)request;

- (void)insertImage:(NSData*)buf forURL:(NSString*)url;
- (UIImage*)getImageFromDB:(NSString*)url;
@end

@implementation ImageDownloader

static UIImage *defaultImage = nil, *default_image_loading = nil;

- (id) init {
    if ((self = [super init])) {
        mNetworkQueue = [[ASINetworkQueue alloc] init];
        [mNetworkQueue setDelegate:self];
        [mNetworkQueue setShouldCancelAllRequestsOnFailure:NO];
        [mNetworkQueue setRequestDidFinishSelector:@selector(imageFetchFinish:)];
        [mNetworkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
        [mNetworkQueue go];
        
        mDelegates = [[NSMutableDictionary dictionary] retain];
        mImages = [[NSMutableDictionary dictionary] retain];
    }
    return self;
}

- (UIImage *) fetchImage:(NSString *)imageUrl Delegate:(id)delegate DefautImage:(UIImage *)defautImage {
	// 图片地址为空，返回默认图片
    if (!imageUrl || [imageUrl length] <= 0) {
        return defautImage;
    }
    
    // 图片已存在本地缓存，返回该图片
    UIImage *image = [mImages objectForKey:imageUrl];
    if (image) {
        return image;
    }
    
    // 数据库已存在该图片 直接返回
    image = [self getImageFromDB:imageUrl];
    if (image) {
        [mImages setObject:image forKey:imageUrl];
        return image;
    }
    
    // 判断同一地址的图片是否正在下载
    NSEnumerator *mKeys = [mDelegates keyEnumerator];
    for (NSString *key in mKeys) {
        if ([key isEqualToString:imageUrl]) {
            NSMutableArray *delegateArray = [mDelegates objectForKey:key];
            [delegateArray addObject:delegate];
            return defautImage;
        }
    }
    
    // 下载图片
    mFailed = NO;
    [mDelegates setObject:[NSMutableArray arrayWithObject:delegate] forKey:imageUrl];
    
    ASIHTTPRequest *mRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    [mNetworkQueue addOperation:mRequest];
    
    return defautImage;// return default image
}

// 开始下载图片
- (UIImage *) fetchImage:(NSString *)imageUrl Delegate:(id)delegate Big:(BOOL)big {
    
    // 图片地址为空，返回默认图片
    if (!imageUrl || [imageUrl length] <= 0) {
        return [ImageDownloader defaultProfileImage:big];
    }
    
    // 图片已存在本地缓存，返回该图片
    UIImage *image = [mImages objectForKey:imageUrl];
    if (image) {
        return image;
    }
    
    // 数据库已存在该图片 直接返回
    image = [self getImageFromDB:imageUrl];
    if (image) {
        [mImages setObject:image forKey:imageUrl];
        return image;
    }
    
    // 判断同一地址的图片是否正在下载
    NSEnumerator *mKeys = [mDelegates keyEnumerator];
    for (NSString *key in mKeys) {
        if ([key isEqualToString:imageUrl]) {
            NSMutableArray *delegateArray = [mDelegates objectForKey:key];
            [delegateArray addObject:delegate];
            return [ImageDownloader defaultProfileImage:big];
        }
    }
    
    // 下载图片
    mFailed = NO;
    [mDelegates setObject:[NSMutableArray arrayWithObject:delegate] forKey:imageUrl];
    
    ASIHTTPRequest *mRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    [mNetworkQueue addOperation:mRequest];
    
    return [ImageDownloader defaultProfileImage:big];// return default image
}

// 图片下载完成
- (void) imageFetchFinish:(ASIHTTPRequest *)request {
    
    if (!request.rawResponseData) {
        return;
    }
	if ([request.rawResponseData length] > GIFDATALength) {
		UIImage *image1 = UIImageGetImageFromName(@"home_more.png");
		if (image1) {
			NSString *url = [[NSString alloc] initWithFormat:@"%@", request.url];
			NSMutableArray *delegateArray = [mDelegates objectForKey:url];
			[self insertImage:request.rawResponseData forURL:url];
			if (delegateArray) {
				for (id delegate in delegateArray) {
					if ([delegate respondsToSelector:@selector(imageDidFetchSuccess:)]) {
						[delegate performSelector:@selector(imageDidFetchSuccess:) withObject:image1];
					}
				}
				// 移除delegate
				[mDelegates removeObjectForKey:url];
			}
			// 缓存图片
			[mImages setObject:image1 forKey:url];
			[url release];
		}
	}
    UIImage *image = [UIImage imageWithData:request.rawResponseData];
    if (image) {
        NSString *url = [[NSString alloc] initWithFormat:@"%@", request.url];
        NSMutableArray *delegateArray = [mDelegates objectForKey:url];
        [self insertImage:request.rawResponseData forURL:url];
        if (delegateArray) {
            for (id delegate in delegateArray) {
                if ([delegate respondsToSelector:@selector(imageDidFetchSuccess:)]) {
                    [delegate performSelector:@selector(imageDidFetchSuccess:) withObject:image];
                }
            }
            // 移除delegate
            [mDelegates removeObjectForKey:url];
        }
        // 缓存图片
        [mImages setObject:image forKey:url];
        [url release];
    }
}

- (void)removeDelegate:(id)delegate forURL: (NSString*) imageUrl {
    NSMutableArray *delegateArray = [mDelegates objectForKey:imageUrl];
    if (delegateArray) {
        [delegateArray removeObject:delegate];
        if ([delegateArray count] == 0) {
            [mDelegates removeObjectForKey:imageUrl];
        }
    }
}

// 图片下载失败
- (void) imageFetchFailed:(ASIHTTPRequest *)request {
    if (!mFailed) {
        if([[request error] domain] != NetworkRequestErrorDomain || [[request error]code] !=ASIRequestCancelledErrorType) {
            NSString *url = [[NSString alloc] initWithFormat:@"%@", request.url];
            NSMutableArray *delegateArray = [mDelegates objectForKey:url];
            if (delegateArray) {
                // 移除delegate
                [mDelegates removeObjectForKey:url];
            }
            [url release];
        }
        mFailed = YES;
    }
}

// 载入默认头像
+ (UIImage*) defaultProfileImage:(BOOL)big {
    if (big) {
        if (default_image_loading == nil) {
            default_image_loading = [UIImageGetImageFromName(@"default_image_loading.png") retain];
        }
        return default_image_loading;
    } else {
        if (defaultImage == nil) {
            defaultImage = [UIImageGetImageFromName(@"defaulUserImage.png") retain];
        }
        return defaultImage;
    }
    return nil;
}

// 将图片插入到数据库
- (void)insertImage:(NSData*)buf forURL:(NSString*)url {
    static Statement* stmt = nil;
    if (stmt == nil) {
        stmt = [DataBase statementWithQuery:"REPLACE INTO images VALUES(?, ?, DATETIME('now'))"];
        [stmt retain];
    }
    [stmt bindString:  url forIndex:1];
    [stmt bindData:    buf forIndex:2];
    
    // Ignore error
    [stmt step];
    [stmt reset];
}


// 从数据库获取图片
- (UIImage *)getImageFromDB:(NSString*)url {
    UIImage *image = nil;
    static Statement *stmt = nil;
    if (stmt == nil) {
        stmt = [DataBase statementWithQuery:"SELECT image FROM images WHERE url=?"];
        [stmt retain];
    }
    // SELECT image FROM images... ---> 返回的表中image排第一位(0),url(1)排第二位;没有DATA_TIME
    [stmt bindString:url forIndex:1];
    if ([stmt step] == SQLITE_ROW) {
        NSData *data = [stmt getData:0];
        image = [UIImage imageWithData:data];
    }
    [stmt reset];
    static Statement* stmt2 = nil;
    if (stmt2 == nil) {
        stmt2 = [DataBase statementWithQuery:"REPLACE INTO images VALUES(?, ?, DATETIME('now'))"];
        [stmt2 retain];
    }    
    // Ignore error
    [stmt2 step];
    [stmt2 reset];
	return image;
}

- (void)dealloc {
    
    [mNetworkQueue setDelegate:nil];

    [mNetworkQueue cancelAllOperations];
    [mNetworkQueue release];
    mNetworkQueue = nil;
    
    [mImages release];
    [mDelegates release];
    
    [defaultImage release];
    [default_image_loading release];
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    