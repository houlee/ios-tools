//
//  Advertisement.m
//  Lottery
//
//  Created by Teng Kiefer on 12-2-23.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import "GC_Advertisement.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_Advertisement

@synthesize returnId, isUpdate, rollnumber, popnumber, marketingnumber, version;
@synthesize systemTime;

- (void)dealloc 
{
    [systemTime release];
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
            self.isUpdate = [drs readByte];
            
            if (self.isUpdate == 1) {
                self.version = [drs readInt];
                EntryAD *entryAD = [[EntryAD alloc] init];
                entryAD.adId = [drs readInt];
                entryAD.adText = [drs readComposString2];
                entryAD.adPicAddress = [drs readComposString1];
                entryAD.effectDate = [drs readComposString1];               
                entryAD.endDate = [drs readComposString1];     
                
                [entryAD release];
                
                self.rollnumber = [drs readByte];
                for (int i = 0; i < self.rollnumber; i++) {
                    RollAD *rollAD = [[RollAD alloc] init];
                    rollAD.adId = [drs readInt];
                    rollAD.adTitle = [drs readComposString1];
                    rollAD.adText = [drs readComposString2];
                    rollAD.effectDate = [drs readComposString1];
                    rollAD.endDate = [drs readComposString1];
                    
                    [rollAD release];
                }
                
                self.popnumber = [drs readByte];
                for (int i = 0; i < self.popnumber; i++) {
                    PopupAD *popupAD = [[PopupAD alloc] init];
                    popupAD.adId = [drs readInt];
                    popupAD.adPopupStyle = [drs readByte];
                    popupAD.adPicAddress = [drs readComposString1];
                    popupAD.effectDate = [drs readComposString1];
                    popupAD.endDate = [drs readComposString1];
                    popupAD.adLocation = [drs readComposString1];
                    popupAD.leftbutton = [drs readComposString1];
                    popupAD.leftgoal = [drs readShort];
                    popupAD.rightbutton = [drs readComposString1];
                    popupAD.rightgoal = [drs readShort];
                    
                    [popupAD release];
                }
                
                self.marketingnumber = [drs readByte];
                for (int i = 0; i < self.rollnumber; i++) {
                    RollAD *rollAD = [[RollAD alloc] init];
                    rollAD.adId = [drs readInt];
                    rollAD.adTitle = [drs readComposString1];
                    rollAD.adText = [drs readComposString2];
                    rollAD.effectDate = [drs readComposString1];
                    rollAD.endDate = [drs readComposString1];
                    
                    [rollAD release];
                }
            }
        }
        [drs release];
    }
    return self;
}
@end

@implementation EntryAD
@synthesize adId;
@synthesize adText, adPicAddress, effectDate, endDate;

- (void)dealloc 
{
    [adText release];
    [adPicAddress release];
    [effectDate release];
    [endDate release];
	[super dealloc];
}
@end

@implementation RollAD
@synthesize adId;
@synthesize adTitle, adText, effectDate, endDate;

- (void)dealloc 
{
    [adTitle release];
    [adText release];
    [effectDate release];
    [endDate release];
	[super dealloc];
}
@end

@implementation PopupAD
@synthesize adId, adPopupStyle, leftgoal, rightgoal;
@synthesize adPicAddress, effectDate, endDate, adLocation, leftbutton, rightbutton;

- (void)dealloc 
{
    [adPicAddress release];
    [effectDate release];
    [endDate release];
    [adLocation release];
    [leftbutton release];
    [rightbutton release];
	[super dealloc];
}
@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    