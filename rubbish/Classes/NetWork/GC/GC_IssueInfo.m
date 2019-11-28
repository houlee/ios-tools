//
//  IssueInfo.m
//  Lottery
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_IssueInfo.h"
#import "GC_RspError.h"

@implementation GC_IssueInfo

@synthesize returnId, systemTime, lotteryType, recordCount;
@synthesize issueRecordList;

- (void)dealloc 
{
    [systemTime release];
    [issueRecordList release];
	[super dealloc];
}

- (BOOL)isNewLotteryWithLotteryID:(NSString *)lotteryID
{
    if ([@"400" isEqualToString:lotteryID]) { // 400 ： 足球单场
        return NO;
    } else if ([@"009" isEqualToString:lotteryID]) { // 009 ： 北京3D
        return YES;
    } else if ([@"010" isEqualToString:lotteryID]) { // 010 ： 两步彩
        return YES;
    } else if ([@"119" isEqualToString:lotteryID]) { // 119 ： 山东11选5
        return NO;
    }
    return NO;
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %i", (int)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) 
        {
            self.systemTime = [drs readComposString1];
            self.lotteryType = [drs readByte];
            self.recordCount = [drs readByte];
            
            NSLog(@"系统时间 %@", systemTime);
            NSLog(@"彩种 %i", (int)lotteryType);
            NSLog(@"记录返回条数 %i", (int)recordCount);   
            if (self.recordCount > 0) {
                self.issueRecordList = [NSMutableArray arrayWithCapacity:(self.recordCount+1)];
                for (int i = 0; i < self.recordCount; i++) {
                    IssueRecord *record = [[IssueRecord alloc] init];
                    record.lotteryName = [drs readComposString1];
                    record.curIssue = [drs readComposString1];
                    record.lastLotteryNumber = [drs readComposString1];
                    record.curStartTime = [drs readComposString1];
                    record.curEndTime = [drs readComposString1];
                    record.remainingTime = [drs readComposString1];
                    record.lotteryTime = [drs readComposString1];
//                    record.lotteryType = [drs readComposString1];
                    record.lotteryId = [drs readComposString1];
                    record.lotteryStatus = [drs readComposString1];
                    record.zhouqi = [drs readComposString1];
                    record.huodongImage = [drs readComposString1];
                    record.activity = [drs readComposString1];
                    record.content = [drs readComposString1];
                    record.iconUrl = [drs readComposString1];
                    record.h5Url = [drs readComposString1];
                    record.other = [drs readComposString1];
                    
                    
                    
    
                    
                    NSLog(@"1彩种名称 %@", record.lotteryName);
                    NSLog(@"2当前期号 %@", record.curIssue);
                    NSLog(@"3上期开奖号码 %@", record.lastLotteryNumber);
                    NSLog(@"4当期开始时间 %@", record.curStartTime);
                    NSLog(@"5当期结束时间 %@", record.curEndTime);
                    NSLog(@"6当期剩余时间 %@", record.remainingTime);
                    
                    
                    NSLog(@"7开奖时间 %@", record.lotteryTime);
//                    NSLog(@"彩种类型 %@", record.lotteryType);
                    
                    NSLog(@"8彩种编号 %@", record.lotteryId);
                    NSLog(@"9彩期状态 %@", record.lotteryStatus);
                    NSLog(@"10彩种周期 %@", record.zhouqi);
                    NSLog(@"11活动图片地址 %@", record.huodongImage);
                    NSLog(@"12活动文字内容 %@", record.activity);
                    NSLog(@"13彩种宣传语 %@", record.content);
                    NSLog(@"14iconurl %@", record.iconUrl);
                    NSLog(@"15h5url %@", record.h5Url);
                    NSLog(@"16预留字段 %@", record.other);
                   
                   
                   
                    if (![self isNewLotteryWithLotteryID:record.lotteryId]) {
                        [self.issueRecordList addObject:record];
                    }
                    [record release];
                }
            }
//            if (self.issueRecordList.count > 0) { //假数据。。。。。。
//                IssueRecord *record = [[IssueRecord alloc] init];
//                record.lotteryType = @"2";
//                record.lotteryId = @"201bf";
//                [self.issueRecordList addObject:record];
//                [record release];
//            }
//            if (self.issueRecordList.count > 0) { //假数据。。。。。。
//                IssueRecord *record = [[IssueRecord alloc] init];
//                record.lotteryType = @"2";
//                record.lotteryId = @"201sf";
//                [self.issueRecordList addObject:record];
//                [record release];
//            }
        }
        [drs release];
    }
    return self;
}

@end

@implementation IssueRecord

@synthesize lotteryName, curIssue, lastLotteryNumber, curStartTime, curEndTime, remainingTime, lotteryTime, lotteryType, lotteryId, lotteryStatus,zhouqi,content,other,systemTime,returnId,huodongImage,luckyNumber, activity, iconUrl, h5Url;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
//            self.lotteryType = [drs readByte];
            self.lotteryName = [drs readComposString1];
            self.curIssue = [drs readComposString1];
            self.lastLotteryNumber = [drs readComposString1];
//            self.curStartTime = [drs readComposString1];
            self.curEndTime = [drs readComposString1];
            self.remainingTime = [drs readComposString1];
//            self.lotteryTime = [drs readComposString1];
//            self.lotteryType = [drs readByte];
            self.lotteryId = [drs readComposString1];
            self.lotteryStatus = [drs readComposString1];
//            self.zhouqi = [drs readComposString1];
//            self.content = [drs readComposString1];
//            self.other = [drs readComposString1];
            [drs readComposString1];
            self.luckyNumber = [drs readComposString1];
            
            NSLog(@"彩种名称 %@", self.lotteryName);
            NSLog(@"当前期号 %@", self.curIssue);
            NSLog(@"上期开奖号码 %@", self.lastLotteryNumber);
            NSLog(@"当期结束时间 %@", self.curEndTime);
            NSLog(@"当期剩余时间 %@", self.remainingTime);
            NSLog(@"彩种类型 %@", self.lotteryType);
            NSLog(@"彩种编号 %@", self.lotteryId);
            NSLog(@"彩期状态 %@", self.lotteryStatus);
            NSLog(@"幸运号码 %@", self.luckyNumber);

        }
        [drs release];
    }
    return self;
}

+ (void)changeOld:(IssueRecord *)old Tonew:(IssueRecord *)newIssue {
    old.returnId = newIssue.returnId;
    if (newIssue.systemTime && [newIssue.systemTime length] > 0) {
        old.systemTime = newIssue.systemTime;
    }
    
    if (newIssue.lotteryName && [newIssue.lotteryName length] > 0) {
        old.lotteryName = newIssue.lotteryName;
    }
    
    if (newIssue.curIssue && [newIssue.curIssue length] > 0) {
        old.curIssue = newIssue.curIssue;
    }
    if (newIssue.lastLotteryNumber && [newIssue.lastLotteryNumber length] > 0) {
        old.lastLotteryNumber = newIssue.lastLotteryNumber;
    }
    
    if (newIssue.curStartTime && [newIssue.curStartTime length] > 0) {
        old.curStartTime = newIssue.curStartTime;
    }
    
    if (newIssue.curEndTime && [newIssue.curEndTime length] > 0) {
        old.curEndTime = newIssue.curEndTime;
    }
    
    if (newIssue.remainingTime && [newIssue.remainingTime length] > 0) {
        old.remainingTime = newIssue.remainingTime;
    }
    
    if (newIssue.lotteryTime && [newIssue.lotteryTime length] > 0) {
        old.lotteryTime = newIssue.lotteryTime;
    }
    
    if (newIssue.lotteryType) {
        old.lotteryType = newIssue.lotteryType;
    }
    
    
    if (newIssue.lotteryId && [newIssue.lotteryId length] > 0) {
        old.lotteryId = newIssue.lotteryId;
    }
    
    if (newIssue.lotteryStatus && [newIssue.lotteryStatus length] > 0) {
        old.lotteryStatus = newIssue.lotteryStatus;
    }
    
    if (newIssue.zhouqi && [newIssue.zhouqi length] > 0) {
        old.zhouqi = newIssue.zhouqi;
    }
    if (newIssue.content && [newIssue.content length] > 0) {
        old.content = newIssue.content;
    }
    
    if (newIssue.other && [newIssue.other length] > 0) {
        old.other = newIssue.other;
    }
}

- (void)dealloc
{
    [lotteryType release];
    [h5Url release];
    [iconUrl release];
    [activity release];
    [lotteryName release];
    [curIssue release];
    [lastLotteryNumber release];
    [curStartTime release];
    [curEndTime release];
    [remainingTime release];
    [lotteryTime release];
    [lotteryId release];
    [lotteryStatus release];
    [zhouqi release];
    [content release];
    [other release];
    [systemTime release];
    self.huodongImage = nil;
    [luckyNumber release];
    
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    