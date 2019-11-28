//
//  HongBaoInfo.m
//  caibo
//
//  Created by cp365dev on 15/2/2.
//
//

#import "HongBaoInfo.h"
#import "JSON.h"
@implementation HongBaoInfo
@synthesize topicID;
@synthesize type;
@synthesize showType;
@synthesize state;
@synthesize awardInfo;
@synthesize function;
@synthesize code;
@synthesize lotteryID;
@synthesize returnType;
@synthesize buttonInfo;


-(void)dealloc{

    self.type = nil;
    self.topicID = nil;
    self.showType = nil;
    self.awardInfo = nil;
    self.function = nil;
    self.code = nil;
    self.lotteryID = nil;
    self.returnType = nil;
    self.state = nil;
    self.buttonInfo = nil;
    [super dealloc];
}
-(id)initWithResponseString:(NSString *)responseString{

    self = [super init];
    if(self){
    
        NSDictionary *dic = [responseString JSONValue];
        
        self.type = [dic objectForKey:@"type"];
        self.showType = [dic objectForKey:@"showtype"];
        self.awardInfo = [dic objectForKey:@"awardInfo"];
        self.buttonInfo = [dic objectForKey:@"buttonInfo"];
        self.state = [dic objectForKey:@"state"];
        self.code = [dic objectForKey:@"code"];
        self.function = [dic objectForKey:@"function"];
        
        NSDictionary *functionDic = [self.function JSONValue];
        
        self.returnType = [functionDic objectForKey:@"returnType"];
        self.topicID = [functionDic objectForKey:@"topicID"];
        self.lotteryID = [functionDic objectForKey:@"lotteryID"];
        
        NSLog(@"红包类型 :%@",self.type);
        NSLog(@"展示方式 :%@",self.showType);
        NSLog(@"红包信息 :%@",self.awardInfo);
        NSLog(@"按钮信息 :%@",self.buttonInfo);
        NSLog(@"红包状态 :%@",self.state);
        NSLog(@"红包code :%@",self.code);
        NSLog(@"跳转方式 :%@",self.returnType);
        NSLog(@"微博id :%@",self.topicID);
        NSLog(@"彩种id :%@",self.lotteryID);
        
        
    }
    return self;
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    