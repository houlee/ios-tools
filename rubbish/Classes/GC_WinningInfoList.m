//
//  ZhongJiangMingDan.m
//  WorldCup
//
//  Created by yaofuyu on 14-2-17.
//  Copyright (c) 2014年 Vodone. All rights reserved.
//

#import "GC_WinningInfoList.h"
#import "GC_RspError.h"
#import "JSON.h"
@implementation GC_WinningInfoList
@synthesize zhongjiangArray;
@synthesize curPage,curCount,returnId;
@synthesize systemTime;
@synthesize mouthHuoDePoint;
@synthesize mouthXiaoHaoPoint;
@synthesize JXCount;
@synthesize flagCode;
@synthesize flagMsg;
@synthesize zhongjiangArray1;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request andlistType:(WinningListType)listtype
{
    if ((self = [super init]))
    {
        if(listtype == POINT_WINNING_TYPE)
        {
            GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
            self.returnId = [drs readShort];
            NSLog(@"返回消息id %li", (long)self.returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                self.systemTime = [drs readComposString1];
                self.curPage = [drs readByte];
                self.curCount = [drs readByte];
                NSLog(@"当前页: %ld",(long)self.curPage);
                NSLog(@"返回人数: %ld",(long)self.curCount);
                if (self.curCount > 0) {
                    self.zhongjiangArray = [NSMutableArray arrayWithCapacity:self.curCount];
                    //积分抽奖获奖名单
                    if(listtype == POINT_WINNING_TYPE)
                    {
                        for (int i = 0; i<self.curCount; i++) {
                            ZhongJiangRen *ren = [[ZhongJiangRen alloc] init];
                            ren.name = [drs readComposString1];
                            ren.zhongJiangInfo = [drs readComposString1];
                            ren.ZhongJiangTime = [drs readComposString1];
                            NSLog(@"name: %@",ren.name);
                            NSLog(@"中奖: %@",ren.zhongJiangInfo);
                            NSLog(@"时间: %@",ren.ZhongJiangTime);
                            NSArray *array = [ren.ZhongJiangTime componentsSeparatedByString:@" "];
                            if ([array count] >= 2) {
                                ren.ZhongJiangTime = [array objectAtIndex:0];
                            }
                            [self.zhongjiangArray addObject:ren];
                            [ren release];
                        }
                    }
                    
                    
                }
            }
            [drs release];

        }

        if(listtype == CANEXCHANGE_CaiJin_TYPE)
        {
            GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
            self.returnId = [drs readShort];
            NSLog(@"返回消息id %li", (long)self.returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                self.systemTime = [drs readComposString1];
                self.JXCount= [drs readByte];
                if(self.JXCount > 0)
                {
                    self.zhongjiangArray = [NSMutableArray arrayWithCapacity:self.JXCount];
                    for(int i = 0;i<self.JXCount;i++)
                    {
                        CanExChangeCaiJinList *list=[[CanExChangeCaiJinList alloc] init];
                        list.caijinJE = [drs readComposString1];
                        list.needPoint = [drs readComposString1];
                        list.alreadyExchangePeople = [drs readComposString1];
                        NSLog(@"彩金金额 %@",list.caijinJE);
                        NSLog(@"所需积分 %@",list.needPoint);
                        NSLog(@"已兑换人数 %@",list.alreadyExchangePeople);
                        
                        [self.zhongjiangArray addObject:list];
                        [list release];
                    }
                }

            }

            [drs release];

        }
        if(listtype == CANEXCHANGE_YHM_TYPE)
        {
            GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
            self.returnId = [drs readShort];
            NSLog(@"返回消息id %li", (long)self.returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                self.systemTime = [drs readComposString1];
                self.JXCount= [drs readByte];
                if(self.JXCount > 0)
                {
                    self.zhongjiangArray1 = [NSMutableArray arrayWithCapacity:self.JXCount];
                    for(int i = 0;i<self.JXCount;i++)
                    {
                        CanExChangeYHMList *list=[[CanExChangeYHMList alloc] init];
                        NSString *yhmMes = [drs readComposString1];
                        NSArray *testArray = [yhmMes componentsSeparatedByString:@"|"];
                        if(testArray && testArray.count == 3){
                            
                            list.chong = [NSString stringWithFormat:@"%@",[testArray objectAtIndex:0]];
                            list.de = [NSString stringWithFormat:@"%@",[testArray objectAtIndex:1]];
                            list.code = [NSString stringWithFormat:@"%@",[testArray objectAtIndex:2]];
                            
                        }
                        list.needPoint = [drs readComposString1];
                        list.alreadyExchangePeople = [drs readComposString1];
                        NSLog(@"优惠码格式 充%@得%@",list.chong,list.de);
                        NSLog(@"优惠码code %@",list.code);
                        NSLog(@"所需积分 %@",list.needPoint);
                        NSLog(@"已兑换人数 %@",list.alreadyExchangePeople);
                        
                        [self.zhongjiangArray1 addObject:list];
                        [list release];
                    }
                }
                
            }
            
            [drs release];
            
        }
        if(listtype == MYPOINT_MES_TYPE)
        {
            GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
            self.returnId = [drs readShort];
            NSLog(@"返回消息id %li", (long)self.returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                self.systemTime = [drs readComposString1];
                self.mouthHuoDePoint = [drs readComposString1];
                self.mouthXiaoHaoPoint = [drs readComposString1];
                self.curCount = [drs readByte];
                self.curPage++;
                
                if (self.curCount > 0) {
                    self.zhongjiangArray = [NSMutableArray arrayWithCapacity:self.curCount];
                    //积分抽奖获奖名单

                    for (int i = 0; i<self.curCount; i++) {
                        
                        MyPointMessage *point = [[MyPointMessage alloc] init];
                        point.pointTime = [drs readComposString1];
                        point.pointType = [drs readComposString1];
                        
                        NSLog(@"积分详情时间 %@",point.pointTime);
                        NSLog(@"积分详情类型 %@",point.pointType);
                        NSString *mHuoQuPoint = [drs readComposString1];
                        NSString *pointMess = [drs readComposString1];
                        NSLog(@"积分详情多少  %@",pointMess);
                        
                        NSString *yuliu = [drs readComposString1];
                        NSLog(@"%@",yuliu);
                        if([mHuoQuPoint isEqualToString:@"1"])
                        {
                            point.getPoint = [NSString stringWithFormat:@"+%@",pointMess];
                            point.xiaohaoPoint = @"";
                        }
                        if([mHuoQuPoint isEqualToString:@"2"])
                        {
                            point.getPoint = @"";
                            point.xiaohaoPoint = [NSString stringWithFormat:@"-%@",pointMess];
                        }
                        
                        point.pointTime = [point.pointTime stringByReplacingOccurrencesOfString:@" " withString:@"\n"];

                        [self.zhongjiangArray addObject:point];
                        [point release];
                    }
                }
                
            }
            [drs release];
        }
    }
    return self;
}

- (id)initWithResponseString:(NSString *)_responseString WithRequest:(ASIHTTPRequest *)request
{
    if(self = [super init])
    {
        NSDictionary*result=[_responseString JSONValue];
        
        self.flagCode = [result objectForKey:@"code"];
        self.flagMsg = [result objectForKey:@"msg"];
        
        self.zhongjiangArray = [NSMutableArray arrayWithCapacity:0];

        
        NSArray *jsonArray = [result objectForKey:@"bonusUserList"];
        for(int i = 0;i<[jsonArray count];i++)
        {

            NSDictionary *dic = [jsonArray objectAtIndex:i];
            
            
            WorldCupWinningList *cup = [[WorldCupWinningList alloc] init];
            cup.name = [dic objectForKey:@"nickName"];
            //2014-06-19 09:09:09
            NSString *mutableTime = [dic objectForKey:@"date"];
            NSArray *array1= [mutableTime componentsSeparatedByString:@" "];
            NSString *mutableTime2 = [array1 objectAtIndex:0];
            NSArray *array2 = [mutableTime2 componentsSeparatedByString:@"-"];
            if ([array2 count] < 3) {
                array2 = [NSArray arrayWithObjects:@"",@"",@"", nil];
            }
            NSString *winMouth = [array2 objectAtIndex:1];
            NSString *winDay = [array2 objectAtIndex:2];
            cup.winningTime = [NSString stringWithFormat:@"%d月%d日",[winMouth intValue],[winDay intValue]];
            cup.flagCount = [dic objectForKey:@"flagNum"];
            NSString *cupType = [dic objectForKey:@"cupType"];
            if([cupType isEqualToString:@"1"])
                cup.caijin = @"21.4";
            if([cupType isEqualToString:@"2"])
                cup.caijin = @"214";
            if([cupType isEqualToString:@"3"])
                cup.caijin = @"2014";
            
            [self.zhongjiangArray addObject:cup];
            
            [cup release];
        }
        
    }
    return self;
    
}

- (void)dealloc
{
	[systemTime release];
	[zhongjiangArray release];
    [zhongjiangArray1 release];
	[super dealloc];
}


@end


@implementation ZhongJiangRen
@synthesize name,zhongJiangInfo,ZhongJiangTime;

- (void)dealloc {
    [name release];
    [zhongJiangInfo release];
    [ZhongJiangTime release];
    [super dealloc];
}

@end


@implementation WorldCupWinningList
@synthesize name,winningTime,flagCount,caijin;
-(void)dealloc
{
    name = nil;
    winningTime = nil;
    flagCount = nil;
    caijin = nil;
    [super dealloc];
}

@end


@implementation MyPointMessage
@synthesize pointTime,pointType,getPoint,xiaohaoPoint;
-(void)dealloc
{
    pointType = nil;
    pointTime = nil;
    getPoint = nil;
    xiaohaoPoint = nil;
    [super dealloc];
}
@end

@implementation CanExChangeCaiJinList

@synthesize caijinJE,needPoint,alreadyExchangePeople;
-(void)dealloc
{
    caijinJE = nil;
    needPoint = nil;
    alreadyExchangePeople = nil;
    [super dealloc];
}

@end

@implementation CanExChangeYHMList

@synthesize chong,de,code,needPoint,alreadyExchangePeople;
-(void)dealloc
{
    chong= nil;
    de = nil;
    code = nil;
    needPoint = nil;
    alreadyExchangePeople = nil;
    [super dealloc];
}

@end



int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    