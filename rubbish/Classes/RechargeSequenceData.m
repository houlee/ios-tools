//
//  RechargeSequenceData.m
//  caibo
//
//  Created by GongHe on 13-10-25.
//
//

#import "RechargeSequenceData.h"
#import "GC_DataReadStream.h"

@implementation RechargeSequenceData
@synthesize ID;
@synthesize time,sequence,description;
@synthesize changeContent,kaigguan,changeContent2,methodYHM,H5Type;
@synthesize chongzhiTypeList;

- (id)initWithResponseData:(NSData *)responseData
{
    self = [super init];
    if (self) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:responseData];
        self.ID = [drs readShort];
        self.time = [drs readComposString1];
        self.sequence = [drs readComposString1];
        self.description = [drs readComposString1];
        self.changeContent = [drs readComposString2];
        self.kaigguan = [drs readComposString1];
        self.changeContent2 = [drs readComposString2];
        self.methodYHM = [drs readComposString1];
        self.H5Type = [drs readComposString4];
        int chongzhicount = [drs readShort];
        if (chongzhicount > 0) {
            self.chongzhiTypeList = [NSMutableArray arrayWithCapacity:chongzhicount];
            for (int i = 0; i < chongzhicount; i++) {
                RechargeTypeData *data = [[RechargeTypeData alloc] init];
                data.code = [drs readComposString1];
                data.logourl = [drs readComposString1];
                data.name = [drs readComposString1];
                data.huodong = [drs readComposString1];
                data.feeInfo = [drs readComposString1];
                data.Youhuima = [drs readComposString1];
                data.wapurl = [drs readComposString1];
                data.other1 = [drs readComposString1];
                data.other1 = [drs readComposString1];
                [self.chongzhiTypeList addObject:data];
                //    1	充值code
                //    2	充值logo
                //    3	充值名称
                //    4	充值活动内容
                //    5	免手续费内容
                //    6	是否使用优惠码
                //    7	是否跳转wap
                NSLog(@"充值code %@",data.code);
                NSLog(@"充值logo %@",data.logourl);
                NSLog(@"充值名称 %@",data.name);
                NSLog(@"充值活动内容 %@",data.huodong);
                NSLog(@"免手续费内容 %@",data.feeInfo);
                NSLog(@"是否允许优惠码 %@",data.Youhuima);
                NSLog(@"wap地址 %@",data.wapurl);
                [data release];
            }
        }
        [drs release];
    }
    return self;
}

- (void)dealloc
{
    [time release];
    [sequence release];
    [description release];
    [changeContent release];
    self.changeContent2 = nil;
    self.kaigguan = nil;
    self.methodYHM = nil;
    self.H5Type = nil;
    self.chongzhiTypeList = nil;
    [super dealloc];
}

@end


@implementation RechargeTypeData

@synthesize code,logourl, name, huodong, feeInfo,Youhuima,wapurl, other1, other2;

-(void)dealloc
{
    self.code = nil;
    self.logourl = nil;
    self.name = nil;
    self.huodong = nil;
    self.feeInfo = nil;
    self.Youhuima = nil;
    self.wapurl = nil;
    self.other1 = nil;
    self.other2 = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    