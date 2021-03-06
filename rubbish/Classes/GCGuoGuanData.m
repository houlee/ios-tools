//
//  GCGuoGuanData.m
//  caibo
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCGuoGuanData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GCGuoGuanData

@synthesize systime, sysid, jilushu;
@synthesize allArray;

- (void)dealloc{
    [allArray release];
    [systime release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.sysid = [drs readShort];
        if (![GC_RspError parserError:drs returnId:sysid WithRequest:request]) 
            {
            self.systime = [drs readComposString1];
            self.jilushu = [drs readByte];
          
            if (self.jilushu > 0) {
                self.allArray = [NSMutableArray arrayWithCapacity:self.jilushu];
                for (int i = 0; i < self.jilushu; i++) {
                    GCGuoGuanDataDetail * guoguanis = [[GCGuoGuanDataDetail alloc] init];
                    guoguanis.mzchangci = [[drs readComposString1] intValue];
                    guoguanis.allright = [[drs readComposString1] intValue];
                    guoguanis.fazzs = [[drs readComposString1] intValue];
                    guoguanis.cyzs = [[drs readComposString1] intValue];
                    guoguanis.zhanji = [drs readComposString1];
                    guoguanis.fanganbianh = [drs readComposString1];
                    guoguanis.username = [drs readComposString1];
                    guoguanis.nickName = [drs readComposString1];
                    guoguanis.baomi = [drs readComposString1]; 
                    
                    NSArray * arrstr = [guoguanis.username componentsSeparatedByString:@"&"];
                    if ([arrstr count] >= 2) {
                        guoguanis.username = [arrstr objectAtIndex:0];
                        guoguanis.userid = [arrstr objectAtIndex:1];
                    }else{
                        guoguanis.username = guoguanis.username;
                        guoguanis.userid = @"";
                    }
                   
                    
                    [self.allArray addObject:guoguanis];
                    
                    
                    
                    [guoguanis release];
                }
            }
            
            
            }
        
        [drs release];
    }
    return self;
}

@end


@implementation GCGuoGuanDataDetail

@synthesize mzchangci, allright, fazzs, cyzs, zhanji, fanganbianh, baomi, username, nickName, userid;

- (void)dealloc 
{
    [baomi release];
    [username release];
    [nickName release];
    [zhanji release];
    [fanganbianh release];
    [userid  release];
	[super dealloc];
}

@end



int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    