//
//  IssueList.m
//  Lottery
//
//  Created by Teng Kiefer on 12-1-14.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import "GC_IssueList.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_IssueList

@synthesize returnId, systemTime, defaultIssue, lotteryId, issueCount, details, sfDetails, sfIssueCount;

- (void)dealloc
{
    [sfDetails release];
    [systemTime release];
    [defaultIssue release];
    [details release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) 
        {
            self.systemTime = [drs readComposString1];
            self.lotteryId = [drs readByte];
            self.issueCount = [drs readByte];
            if (self.issueCount > 0) {
                self.details = [NSMutableArray arrayWithCapacity:self.issueCount];
                NSMutableArray *presellIssues = [NSMutableArray arrayWithCapacity:self.issueCount];
                BOOL issueOneBool = NO;
                for (NSUInteger i = 0; i < self.issueCount; i++) {
                    IssueDetail *detail = [[IssueDetail alloc] init];
                    detail.issue = [drs readComposString1];
                    detail.stopTime = [drs readComposString1];
                    detail.status = [drs readComposString1];
                    detail.danTuoTime = [drs readComposString1];
                    NSLog(@"dantuo = %@", detail.danTuoTime);
                    NSLog(@"issue = %@", detail.issue);
                    if ([detail.status isEqualToString:@"1"]) {
                        if (issueOneBool == NO) {
                            self.defaultIssue = detail.issue;
                            issueOneBool = YES;
                        }
                       
                    }
                    
                    if ([detail.status isEqualToString:@"0"]) [presellIssues addObject:detail];
					[self.details addObject:detail];
                    [detail release];
                }
                
                
                if (!self.defaultIssue && presellIssues.count > 0) {
                    self.defaultIssue = [(IssueDetail*)[presellIssues objectAtIndex:presellIssues.count - 1] issue];
                }
            }
            self.sfIssueCount = [drs readByte]; // 北单胜负期号
            if (self.sfIssueCount > 0) {
                self.sfDetails = [NSMutableArray arrayWithCapacity:self.sfIssueCount];
                
                for (int i = 0; i < self.sfIssueCount; i++) {
                    IssueDetail *detail = [[IssueDetail alloc] init];
                    detail.issue = [drs readComposString1];
                    detail.stopTime = [drs readComposString1];
                    detail.status = [drs readComposString1];
                    detail.danTuoTime = [drs readComposString1];
                    
                    NSLog(@"sftype = %@", detail.status);
                    NSLog(@"issuesf = %@", detail.issue);
                    [self.sfDetails addObject:detail];
                    [detail release];
                }
                
            }
        }
        [drs release];
    }
    return self;
}

@end

@implementation IssueDetail

@synthesize issue, stopTime, status, danTuoTime;

- (void)dealloc 
{
    [danTuoTime release];
    [issue release];
    [stopTime release];
    [status release];
	[super dealloc];
}

@end



int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    