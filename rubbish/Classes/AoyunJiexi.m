//
//  AoyunJiexi.m
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-7-24.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import "AoyunJiexi.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation AoyunJiexi

@synthesize returnId,reRecordNum;
@synthesize systemTime;
@synthesize MatchInfoArray;

- (id)initWithResponseData:(NSData *)_responseData {
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:nil])
		{
			self.systemTime = [drs readComposString1];
			
			self.reRecordNum = [drs readByte];
            if (self.reRecordNum > 0) {
                self.MatchInfoArray = [NSMutableArray arrayWithCapacity:self.reRecordNum];
                for (int i = 0; i<self.reRecordNum; i++) {
                    AoyunMatchInfo *aoyunMatchinfo = [[AoyunMatchInfo alloc] init];
                    aoyunMatchinfo.matchName = [drs readComposString1];
                    aoyunMatchinfo.matchImageURL = [drs readComposString1];
                    aoyunMatchinfo.matchTime = [drs readComposString1];
                    aoyunMatchinfo.matchNum = [drs readByte];
                    aoyunMatchinfo.playerNum = [drs readByte];
                    if (aoyunMatchinfo.playerNum >0) {
                        aoyunMatchinfo.playerArray = [NSMutableArray arrayWithCapacity:aoyunMatchinfo.playerNum ];
                        for (int b= 0; b<aoyunMatchinfo.playerNum; b ++) {
                            AoyunPlayer *player = [[AoyunPlayer alloc] init];
                            player.name = [drs readComposString1];
                            player.country = [drs readComposString1];
                            player.imageName = [drs readComposString1];
                            player.playerId = [drs readByte];
                            player.peilv = [drs readComposString1];
                            [aoyunMatchinfo.playerArray addObject:player];
                            [player release];
                        }
                    }
                    [self.MatchInfoArray addObject:aoyunMatchinfo];
                    [aoyunMatchinfo release];
                }
            }
        }
        [drs release];
    }
    return self;
}

- (void)dealloc
{
	[systemTime release];
	[MatchInfoArray release];
	[super dealloc];
}

@end

@implementation AoyunMatchInfo

@synthesize matchName,matchImageURL,matchTime,matchNum,playerNum,selectNum;
@synthesize playerArray;
@synthesize  isZhankai;

- (id)init {
    self = [super init];
    if (self) {
        isZhankai = NO;
        
    }
    return  self;
}

- (void)dealloc
{
	[matchName release];
    [matchImageURL release];
    [matchTime release];
    [selectNum release];
	[playerArray release];
	[super dealloc];
}


@end

@implementation AoyunPlayer

@synthesize name,country,imageName,playerId,peilv;
@synthesize isJin,isYin,isTong;

- (id) init{
    self = [super init];
    if (self) {
        isJIn = NO;
        isYin = NO;
        isTong = NO;
        
    }
    return  self;
}

- (void)dealloc {
    [name release];
    [country release];
    [imageName release];
    [peilv release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    