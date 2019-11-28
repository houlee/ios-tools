//
//  JCalgorithm.m
//  Lottery
//
//  Created by Jacob Chiang on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_JCalgorithm.h"
#import "NSArray+custom.h"
#import "GC_JCDiGuiInfo.h"

@implementation GC_JCalgorithm

static GC_JCalgorithm *shareJCManager = nil;
long long totalZhuShu = 0;

-(void)dealloc{
    [passTypeRuleDic release];
    [diguiDic  release];
    [secondDiguiDic release];
    [super dealloc];
}


+(GC_JCalgorithm*)shareJCalgorithmManager{
    
    @synchronized(self) {
        if (shareJCManager == nil) {
            shareJCManager = [[GC_JCalgorithm alloc] init]; // assignment not done here
            
        }
    }
    return shareJCManager;
    
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (shareJCManager==nil) {
            shareJCManager = [super allocWithZone:zone];
            return shareJCManager;
        }
    
    }
    return nil;

}
- (id)copyWithZone:(NSZone *)zone
{
 return self;
}
- (id)retain
{
return self;
}
//- (unsigned)retainCount
//{
//return UINT_MAX; //denotes an object that cannot be released
//}

- (oneway void)release{
}

- (id)autorelease
{
return self;
}


//在放置分解的数组里添加一场新比赛
//将一场比赛投注多场玩法的M场拆解成单一玩法的M场 仅限胜平负让球胜平负 递归分解
//hunArray放置投注的内容比如[让球球选中数,非让球选中数],
//fangArray放置，拆分好的部分[[让球，让球，非让球],[让球，非让球，非让球],[非让球，让球，非让球],[非让球，非让球，非让球]],
- (void)addFangzhiArray:(NSMutableArray *)fangArray WithArray:(NSMutableArray *)hunArray {
    if ([fangArray count]== 0) {
            for (int i = 0; i < [hunArray count]; i ++) {
                //如果选中数不为0，添加进入
                if ([[hunArray objectAtIndex:i] integerValue] == 0) {
                    
                }
                else {
                    NSMutableArray *newItemArray = [NSMutableArray array];
                    [newItemArray addObject:[hunArray objectAtIndex:i]];
                    [fangArray addObject:newItemArray];
                }
            }
        
    }
    else {
        NSMutableArray *newMutableArray = [NSMutableArray array];
        for (NSMutableArray *itemArray in fangArray) {
                for (int i = 0; i < [hunArray count]; i ++) {
                    //如果选中数不为0，添加进入
                    if ([[hunArray objectAtIndex:i] integerValue] == 0) {
                        
                    }
                    else {
                        NSMutableArray *newItemArray = [itemArray mutableCopy];
                        [newItemArray addObject:[hunArray objectAtIndex:i]];
                        [newMutableArray addObject:newItemArray];
                    }
                }
            
        }
        [fangArray removeAllObjects];
        [fangArray addObjectsFromArray:newMutableArray];
    }
}

//_chuan串法，
- (void) chaiHunArray:(NSMutableArray *)hunArray chuan:(NSString *)_chuan{
        newFangZhiArray = [NSMutableArray array];
    totalZhuShu = 0;
    for (int i = 0; i < [hunArray count]; i ++) {
        [self addFangzhiArray:newFangZhiArray WithArray:[hunArray objectAtIndex:i]];
    }
    for (int i = 0; i < [newFangZhiArray count]; i ++) {
        totalZhuShu = [self functionselectCoutArray:[newFangZhiArray objectAtIndex:i] chuan:_chuan] + totalZhuShu;
    }
    
}

- (long long)functionselectCoutArray:(NSArray *)selectArray chuan:(NSString *)_chuan{//
    long long re = 0;
    long long a = 0;
    long long b = 0;
    long long c = 0;
    long long d = 0;
    long long e = 0;
    long long f = 0;
    long long g = 0;
    long long h = 0;
    long long i = 0;
    long long j = 0;
    long long k = 0;
    long long l = 0;
    long long m = 0;
    long long n = 0;
    long long o = 0;
    if ([selectArray count] > 0) {
        a = [[selectArray objectAtIndex:0] longLongValue];
    }
    if ([selectArray count] > 1) {
        b = [[selectArray objectAtIndex:1] longLongValue];
    }
    if ([selectArray count] > 2) {
        c = [[selectArray objectAtIndex:2] longLongValue];
    }
    if ([selectArray count] > 3) {
        d = [[selectArray objectAtIndex:3] longLongValue];
    }
    if ([selectArray count] > 4) {
        e = [[selectArray objectAtIndex:4] longLongValue];
    }
    if ([selectArray count] > 5) {
        f = [[selectArray objectAtIndex:5] longLongValue];
    }
    if ([selectArray count] > 6) {
        g = [[selectArray objectAtIndex:6] longLongValue];
    }
    if ([selectArray count] > 7) {
        h = [[selectArray objectAtIndex:7] longLongValue];
    }
    if ([selectArray count] > 8) {
        i = [[selectArray objectAtIndex:8] longLongValue];
    }
    if ([selectArray count] > 9) {
        j = [[selectArray objectAtIndex:9] longLongValue];
    }
    if ([selectArray count] > 10) {
        k = [[selectArray objectAtIndex:10] longLongValue];
    }
    if ([selectArray count] > 11) {
        l = [[selectArray objectAtIndex:11] longLongValue];
    }
    if ([selectArray count] > 12) {
        m = [[selectArray objectAtIndex:12] longLongValue];
    }
    if ([selectArray count] > 13) {
        n = [[selectArray objectAtIndex:13] longLongValue];
    }
    if ([selectArray count] > 14) {
        o = [[selectArray objectAtIndex:14] longLongValue];
    }
    
    if ([_chuan isEqualToString:@"1串1"]) {
        re = a;
    }
    else if ([_chuan isEqualToString:@"2串1"]){
        re = a * b;
    }
    else if ([_chuan isEqualToString:@"2串3"]){
        re = (a + 1) * (b + 1) - 1;
    }
    else if ([_chuan isEqualToString:@"3串1"]){
        re = a * b * c;
    }
    else if ([_chuan isEqualToString:@"3串3"]){
        re = a * b + a * c + b * c;
    }
    else if ([_chuan isEqualToString:@"3串4"]){
        re = a * b * c + a * b + a * c + b * c;
    }
    else if ([_chuan isEqualToString:@"3串7"]){
        re = (a + 1) * (b + 1) * (c + 1) - 1;
    }
    else if ([_chuan isEqualToString:@"4串1"]){
        re = a * b * c * d;
    }
    else if ([_chuan isEqualToString:@"4串4"]){
        re = a * b * c + a * b * d + a * c * d + b * c * d;
    }
    else if ([_chuan isEqualToString:@"4串5"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) - (a * (b + c + d + 1) + b * (c + d + 1) + (c + 1) * (d + 1));
    }
    else if ([_chuan isEqualToString:@"4串6"]){
        re = a * b + a * c + a * d + b * c + b * d + c * d;
    }
    else if ([_chuan isEqualToString:@"4串11"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) - (a + b + c + d + 1);
    }
    else if ([_chuan isEqualToString:@"4串15"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) - 1;
    }
    else if ([_chuan isEqualToString:@"5串1"]){
        re = a * b * c * d * e;
    }
    else if ([_chuan isEqualToString:@"5串5"]){
        re = a * b * c * d + a * b * c * e + a * b * d * e + a * c * d * e + b * c * d * e;
    }
    else if ([_chuan isEqualToString:@"5串6"]){
        re = a * b * c * d * e + a * b * c * d + a * b * c * e + a * b * d * e + a * c * d * e + b * c * d * e;
    }
    else if ([_chuan isEqualToString:@"5串10"]){
        re = a * b + a * c + a * d + a * e + b * c + b * d + b * e + c * d + c * e + d * e;
    }
    else if ([_chuan isEqualToString:@"5串16"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) - (a * (b + c + d + e + 1) + b * (c + d + e + 1) + c * (d + e + 1) + (d + 1) * (e + 1));
    }
    else if ([_chuan isEqualToString:@"5串20"]){
        re = a * b * c + a * b * d + a * b * e + a * c * d + a * c * e + a * d * e + b * c * d + b * c * e + b * d * e + c * d * e + a * b + a * c + a * d + a * e + b * c + b * d + b * e + c * d + c * e + d * e;
    }
    else if ([_chuan isEqualToString:@"5串26"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) - (a + b + c + d + e + 1);
    }
    else if ([_chuan isEqualToString:@"5串31"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) - 1;
    }
    else if ([_chuan isEqualToString:@"6串1"]){
        re = a * b * c * d * e * f;
    }
    else if ([_chuan isEqualToString:@"6串6"]){
        re = a * b * c * d * e + a * b * c * d * f + a * b * c * e * f + a * b * d * e * f + a * c * d * e * f + b * c * d * e * f;
    }
    else if ([_chuan isEqualToString:@"6串7"]){
        re = a * b * c * d * e * f + a * b * c * d * e + a * b * c * d * f + a * b * c * e * f + a * b * d * e * f + a * c * d * e * f + b * c * d * e * f;
    }
    else if ([_chuan isEqualToString:@"6串15"]){
        re = a * b + a * c + a * d + a * e + a * f + b * c + b * d + b * e + b * f + c * d + c * e + c * f + d * e + d * f + e * f;
    }
    else if ([_chuan isEqualToString:@"6串20"]){
        re = a * b * c + a * b * d + a * b * e + a * b * f + a * c * d + a * c * e + a * c * f + a * d * e + a * d * f + a * e * f + b * c * d + b * c * e + b * c * f + b * d * e + b * d * f + b * e * f + c * d * e + c * d * f + c * e * f + d * e * f;
    }
    else if ([_chuan isEqualToString:@"6串22"]){
        re = a * b * c * d * e * f + a * b * c * d * e + a * b * c * d * f + a * b * c * e * f + a * b * d * e * f + a * c * d * e * f + b * c * d * e * f + a * b * c * d + a * b * c * e + a * b * c * f + a * b * d * e + a * b * d * f + a * b * e * f + a * c * d * e + a * c * d * f + a * c * e * f + a * d * e * f + b * c * d * e + b * c * d * f + b * c * e * f + b * d * e * f + c * d * e * f;
    }
    else if ([_chuan isEqualToString:@"6串35"]){
        re = a * b * c + a * b * d + a * b * e + a * b * f + a * c * d + a * c * e + a * c * f + a * d * e + a * d * f + a * e * f + b * c * d + b * c * e + b * c * f + b * d * e + b * d * f + b * e * f + c * d * e + c * d * f + c * e * f + d * e * f + a * b + a * c + a * d + a * e + a * f + b * c + b * d + b * e + b * f + c * d + c * e + c * f + d * e + d * f + e * f;
    }
    else if ([_chuan isEqualToString:@"6串42"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) - (a * (b + c + d + e + f + 1) + b * (c + d + e + f + 1) + c * (d + e + f + 1) + d * (e + f + 1) + (e + 1) * (f + 1));
    }
    else if ([_chuan isEqualToString:@"6串50"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) - (a + b + c + d + e + f + 1) - (a * b * c * d * e + a * b * c * d * f + a * b * c * e * f + a * b * d * e * f + a * c * d * e * f + b * c * d * e * f + a * b * c * d * e * f);
    }
    else if ([_chuan isEqualToString:@"6串57"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) - (a + b + c + d + e + f + 1);
    }
    else if ([_chuan isEqualToString:@"6串63"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) - 1;
    }
    else if ([_chuan isEqualToString:@"7串1"]){
        re = a * b * c * d * e * f * g;
    }
    else if ([_chuan isEqualToString:@"7串7"]){
        re = a * b * c * d * e * f + a * b * c * d * e * g + a * b * c * d * f * g + a * b * c * e * f * g + a * b * d * e * f * g + a * c * d * e * f * g + b * c * d * e * f * g;
    }
    else if ([_chuan isEqualToString:@"7串8"]){
        re = a * b * c * d * e * f * g + a * b * c * d * e * f + a * b * c * d * e * g + a * b * c * d * f * g + a * b * c * e * f * g + a * b * d * e * f * g + a * c * d * e * f * g + b * c * d * e * f * g;
    }
    else if ([_chuan isEqualToString:@"7串21"]){
        re = a * b * c * d * e + a * b * c * d * f + a * b * c * d * g + a * b * c * e * f + a * b * c * e * g + a * b * c * f * g + a * b * d * e * f + a * b * d * e * g + a * b * d * f * g + a * b * e * f * g + a * c * d * e * f + a * c * d * e * g + a * c * d * f * g + a * c * e * f * g + a * d * e * f * g + b * c * d * e * f + b * c * d * e * g + b * c * d * f * g + b * c * e * f * g + b * d * e * f * g + c * d * e * f * g;
    }
    else if ([_chuan isEqualToString:@"7串35"]){
         re = a * b * c * d + a * b * c * e + a * b * c * f + a * b * c * g + a * b * d * e + a * b * d * f + a * b * d * g + a * b * e * f + a * b * e * g + a * b * f * g + a * c * d * e + a * c * d * f + a * c * d * g + a * c * e * f + a * c * e * g + a * c * f * g + a * d * e * f + a * d * e * g + a * d * f * g + a * e * f * g + b * c * d * e + b * c * d * f + b * c * d * g + b * c * e * f + b * c * e * g + b * c * f * g + b * d * e * f + b * d * e * g + b * d * f * g + b * e * f * g + c * d * e * f + c * d * e * g + c * d * f * g + c * e * f * g + d * e * f * g;
    }
    else if ([_chuan isEqualToString:@"7串120"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) * (g + 1) - (a + b + c + d + e + f + g + 1);
    }
    else if ([_chuan isEqualToString:@"8串1"]){
        re = a * b * c * d * e * f * g * h;
    }
    else if ([_chuan isEqualToString:@"8串8"]){
        re = a * b * c * d * e * f * g + a * b * c * d * e * f * h + a * b * c * d * e * g * h + a * b * c * d * f * g * h + a * b * c * e * f * g * h + a * b * d * e * f * g * h + a * c * d * e * f * g * h + b * c * d * e * f * g * h;
    }
    else if ([_chuan isEqualToString:@"8串9"]){
        re = a * b * c * d * e * f * g * h + a * b * c * d * e * f * g + a * b * c * d * e * f * h + a * b * c * d * e * g * h + a * b * c * d * f * g * h + a * b * c * e * f * g * h + a * b * d * e * f * g * h + a * c * d * e * f * g * h + b * c * d * e * f * g * h;
    }
    else if ([_chuan isEqualToString:@"8串28"]){
         re = a * b * c * d * e * f + a * b * c * d * e * g + a * b * c * d * e * h + a * b * c * d * f * g + a * b * c * d * f * h + a * b * c * d * g * h + a * b * c * e * f * g + a * b * c * e * f * h + a * b * c * e * g * h + a * b * c * f * g * h + a * b * d * e * f * g + a * b * d * e * f * h + a * b * d * e * g * h + a * b * d * f * g * h + a * b * e * f * g * h + a * c * d * e * f * g + a * c * d * e * f * h + a * c * d * e * g * h + a * c * d * f * g * h + a * c * e * f * g * h + a * d * e * f * g * h + b * c * d * e * f * g + b * c * d * e * f * h + b * c * d * e * g * h + b * c * d * f * g * h + b * c * e * f * g * h + b * d * e * f * g * h + c * d * e * f * g * h;
    }
    else if ([_chuan isEqualToString:@"8串56"]){
        re = a * b * c * d * e + a * b * c * d * f + a * b * c * d * g + a * b * c * d * h + a * b * c * e * f + a * b * c * e * g + a * b * c * e * h + a * b * c * f * g + a * b * c * f * h + a * b * c * g * h + a * b * d * e * f + a * b * d * e * g + a * b * d * e * h + a * b * d * f * g + a * b * d * f * h + a * b * d * g * h + a * b * e * f * g + a * b * e * f * h + a * b * e * g * h + a * b * f * g * h + a * c * d * e * f + a * c * d * e * g + a * c * d * e * h + a * c * d * f * g + a * c * d * f * h + a * c * d * g * h + a * c * e * f * g + a * c * e * f * h + a * c * e * g * h + a * c * f * g * h + a * d * e * f * g + a * d * e * f * h + a * d * e * g * h + a * d * f * g * h + a * e * f * g * h + b * c * d * e * f + b * c * d * e * g + b * c * d * e * h + b * c * d * f * g + b * c * d * f * h + b * c * d * g * h + b * c * e * f * g + b * c * e * f * h + b * c * e * g * h + b * c * f * g * h + b * d * e * f * g + b * d * e * f * h + b * d * e * g * h + b * d * f * g * h + b * e * f * g * h + c * d * e * f * g + c * d * e * f * h + c * d * e * g * h + c * d * f * g * h + c * e * f * g * h + d * e * f * g * h;
    }
    else if ([_chuan isEqualToString:@"8串70"]){
        re = a * b * c * d + a * b * c * e + a * b * c * f + a * b * c * g + a * b * c * h + a * b * d * e + a * b * d * f + a * b * d * g + a * b * d * h + a * b * e * f + a * b * e * g + a * b * e * h + a * b * f * g + a * b * f * h + a * b * g * h + a * c * d * e + a * c * d * f + a * c * d * g + a * c * d * h + a * c * e * f + a * c * e * g + a * c * e * h + a * c * f * g + a * c * f * h + a * c * g * h + a * d * e * f + a * d * e * g + a * d * e * h + a * d * f * g + a * d * f * h + a * d * g * h + a * e * f * g + a * e * f * h + a * e * g * h + a * f * g * h + b * c * d * e + b * c * d * f + b * c * d * g + b * c * d * h + b * c * e * f + b * c * e * g + b * c * e * h + b * c * f * g + b * c * f * h + b * c * g * h + b * d * e * f + b * d * e * g + b * d * e * h + b * d * f * g + b * d * f * h + b * d * g * h + b * e * f * g + b * e * f * h + b * e * g * h + b * f * g * h + c * d * e * f + c * d * e * g + c * d * e * h + c * d * f * g + c * d * f * h + c * d * g * h + c * e * f * g + c * e * f * h + c * e * g * h + c * f * g * h + d * e * f * g + d * e * f * h + d * e * g * h + d * f * g * h + e * f * g * h;
    }
    else if ([_chuan isEqualToString:@"8串247"]){
        re = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) * (g + 1) * (h + 1) - (a + b + c + d + e + f + g + h + 1);
    }
    else if ([_chuan isEqualToString:@"9串1"]){
        re = a * b * c * d * e * f * g * h * i;
    }
    else if ([_chuan isEqualToString:@"10串1"]){
        re = a * b * c * d * e * f * g * h * i * j;
    }
    else if ([_chuan isEqualToString:@"11串1"]){
        re = a * b * c * d * e * f * g * h * i * j * k;
    }
    else if ([_chuan isEqualToString:@"12串1"]){
        re = a * b * c * d * e * f * g * h * i * j * k * l;
    }
    else if ([_chuan isEqualToString:@"13串1"]){
        re = a * b * c * d * e * f * g * h * i * j * k * l * m;
    }
    else if ([_chuan isEqualToString:@"14串1"]){
        re = a * b * c * d * e * f * g * h * i * j * k * l * m * n;
    }
    else if ([_chuan isEqualToString:@"15串1"]){
        re = a * b * c * d * e * f * g * h * i * j * k * l * m * n * o;
    }
    
    return re;
}


-(NSMutableDictionary*)dicWithPassType{
    if (passTypeRuleDic==nil) {
        passTypeRuleDic = [[NSMutableDictionary alloc] init];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"1", nil] forKey:@"1串1"];
        
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"2", nil] forKey:@"2串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"2",@"1", nil] forKey:@"2串3"];
        
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"3", nil] forKey:@"3串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"2", nil] forKey:@"3串3"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"3",@"2", nil] forKey:@"3串4"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"3",@"2",@"1", nil] forKey:@"3串7"];
        
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"4", nil] forKey:@"4串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"3", nil] forKey:@"4串4"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"4",@"3", nil] forKey:@"4串5"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"2", nil] forKey:@"4串6"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"4",@"3",@"2", nil] forKey:@"4串11"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"4",@"3",@"2",@"1" ,nil] forKey:@"4串15"];
        
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"5",nil] forKey:@"5串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"4",nil] forKey:@"5串5"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"5",@"4",nil] forKey:@"5串6"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"2",nil] forKey:@"5串10"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"5",@"4",@"3",nil] forKey:@"5串16"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"3",@"2",nil] forKey:@"5串20"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"5",@"4",@"3",@"2",nil] forKey:@"5串26"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"5",@"4",@"3",@"2",@"1",nil] forKey:@"5串31"];
        
        
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"6",nil] forKey:@"6串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"5",nil] forKey:@"6串6"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"6",@"5",nil] forKey:@"6串7"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"2",nil] forKey:@"6串15"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"3",nil] forKey:@"6串20"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"6",@"5",@"4",nil] forKey:@"6串22"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"3",@"2",nil] forKey:@"6串35"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"6",@"5",@"4",@"3",nil] forKey:@"6串42"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"4",@"3",@"2",nil] forKey:@"6串50"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"6",@"5",@"4",@"3",@"2",nil] forKey:@"6串57"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"6",@"5",@"4",@"3",@"2",@"1",nil] forKey:@"6串63"];
        
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"7",nil] forKey:@"7串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"6",nil] forKey:@"7串7"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"7",@"6",nil] forKey:@"7串8"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"5",nil] forKey:@"7串21"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"4",nil] forKey:@"7串35"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"7",@"6",@"5",@"4",@"3",@"2",nil] forKey:@"7串120"];
        
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"8",nil] forKey:@"8串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"7",nil] forKey:@"8串8"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"8",@"7",nil] forKey:@"8串9"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"6",nil] forKey:@"8串28"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"5",nil] forKey:@"8串56"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"4",nil] forKey:@"8串70"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"8",@"7",@"6",@"5",@"4",@"3",@"2",nil] forKey:@"8串247"];
        
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"9",nil] forKey:@"9串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"10",nil] forKey:@"10串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"11",nil] forKey:@"11串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"12",nil] forKey:@"12串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"13",nil] forKey:@"13串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"14",nil] forKey:@"14串1"];
        [passTypeRuleDic setObject:[NSArray arrayWithObjects:@"15",nil] forKey:@"15串1"];
        
    }
    return passTypeRuleDic;

}


// 根据key 获取 过关场次 规则
-(NSArray*)passTypeRuleArry:(NSString*)key{
    if (key&&passTypeRuleDic) {
        return [passTypeRuleDic objectForKey:key];
    }
    return nil;
}


// 判断 所选的 过关数 头 数值
-(int)passTypeHeaderNum:(NSString*)chuan{

    if (chuan&&![chuan isEqualToString:@"单关"]) {
        if ([chuan intValue]>9) {
            return [[chuan substringWithRange:NSMakeRange(0,2)] intValue];
        }else{
         return [[chuan substringWithRange:NSMakeRange(0,1)] intValue]; 
        }
       
    }
    
    
    return -1;
}

-(long long)totalZhuShuNum{
    return totalZhuShu;
}

// 将需要 处理的 数据 传入 
-(void)passData:(NSMutableDictionary*)selectedItems gameCount:(NSInteger)count chuan:(NSString*)chuan{
    
    [self dicWithPassType];
    
    if (diguiDic||secondDiguiDic) {
        [diguiDic removeAllObjects];
        [secondDiguiDic removeAllObjects];
    }
    totalZhuShu = 0;
    NSArray *keys = [selectedItems allKeys];
    NSLog(@"keys = %@", keys);
    // 排序之后 的 keys   key = 选择元素 个数， value = 场次数；
    keys = [keys afterInOder];
    [self diGuiRule:selectedItems keys:keys key:nil value:nil index:0 k:0 gameCount:count chuan:chuan];
    
}

// 递归算法，将 场次数 分解
-(void)diGuiRule:(NSMutableDictionary*)selectedItems keys:(NSArray*)keys  key:(NSNumber*)key value:(NSNumber*)value index:(NSInteger)index k:(NSInteger)k gameCount:(NSInteger)count chuan:(NSString*)chuan{
    
    if (index>0&&index<[keys count]) {
       // NSLog(@"================index=%d,k = %d, key = %@ value = %@",index,k,key,value);
    [self putDiguiInfoToDic:index currentVaule:k oldValue:[value integerValue] itemsCount:[key integerValue]];
        
    }
    if (index ==[keys count]) {
         //NSLog(@"index=%d,k = %d, key = %@ value = %@",index,k,key,value);
        [self putDiguiInfoToList:index currentVaule:k oldValue:[value integerValue] itemsCount:[key integerValue]gameCount:count chuan:chuan]; 
    }else {
        if (index< [keys count]) {
            NSNumber *keyNum =(NSNumber*)[keys objectAtIndex:index];
            NSNumber *valueNum = [selectedItems objectForKey:keyNum];
            NSInteger selectedItemsCount = [valueNum integerValue];
            for (int k =0; k<=selectedItemsCount; k++) {
                [self diGuiRule:selectedItems keys:keys key:keyNum value:valueNum index:index+1 k:k gameCount:count chuan:chuan];
            }
            
        }

    }
}


// 二次 递归
-(void)secondDiguiRule:(NSMutableDictionary*)secondItemsDic keys:(NSArray*)keys key:(NSNumber*)key  value:(NSInteger)value index:(NSInteger)index k:(NSInteger)k oldCanChooseCount:(NSInteger)oldCanChooseCount chuan:(NSString*)chuan itemsCount:(NSInteger)itemsCount{

    if (index>0&&index<[keys count]) {
       // NSLog(@"================index=%d,k = %d, key = %@ value = %d oldCanChooseCount = %d itemsCount=%d",index,k,key,value,oldCanChooseCount,itemsCount);
        [self secondPutDiguiInfoToDic:index currentValue:k oldValue:value fristCanChooseCount:oldCanChooseCount itemsCount:itemsCount];
    }
    if (index==[keys count]) {
         // NSLog(@"index=%d,k = %d, key = %@ value = %d oldCanChooseCount = %d itemsCount =%d",index,k,key,value,oldCanChooseCount,itemsCount);
        [self secondPutdiguiInfoTolist:index currentValue:k oldValue:value fristCanChooseCount:oldCanChooseCount itemsCount:itemsCount chuan:chuan];
        
    }else{
        if (index<[keys count]) {
            NSNumber *keyNum = (NSNumber*)[keys objectAtIndex:index];
             GC_JCDiGuiInfo *_info = [secondItemsDic objectForKey:keyNum];
            if (_info) {
                NSInteger count =_info.currentValue;
                for (int k = 0; k<=count; k++) {
                    [self secondDiguiRule:secondItemsDic keys:keys key:keyNum value:_info.currentValue index:index+1 k:k oldCanChooseCount:_info.canChooseCount chuan:chuan itemsCount:_info.itemsCount];
                }
            }
        }
    }


}


-(void)putDiguiInfoToDic:(NSInteger)key currentVaule:(NSInteger)currentVaule oldValue:(NSInteger)oldValue itemsCount:(NSInteger)itemsCount{
    if (diguiDic==nil) {
        diguiDic = [[NSMutableDictionary alloc] init];
    }
    GC_JCDiGuiInfo *info = [[GC_JCDiGuiInfo alloc] init];
    info.currentValue = currentVaule;
    info.oldValue = oldValue;
    info.itemsCount = itemsCount;
    info.canChooseCount = [info canChooseCount:oldValue currentValue:currentVaule];
    
    NSNumber *keyNum = [[NSNumber alloc] initWithInteger:key];
    [diguiDic setObject:info forKey:keyNum];
    [info release];
    [keyNum release];
}


-(void)secondPutDiguiInfoToDic:(NSInteger)key currentValue:(NSInteger)currentValue  oldValue:(NSInteger)oldValue fristCanChooseCount:(NSInteger)fristCanChooseCount 

                    itemsCount:(NSInteger)itemsCount{
    
    if (secondDiguiDic==nil) {
        secondDiguiDic = [[NSMutableDictionary alloc] init];
    }
    
    GC_JCDiGuiInfo *info = [[GC_JCDiGuiInfo alloc] init];
    info.currentValue = currentValue;
    info.oldValue = oldValue;
    info.itemsCount = itemsCount;
    info.canChooseCount = [info canChooseCount:oldValue currentValue:currentValue];
    info.fristCanChooseCount = fristCanChooseCount;
    
    NSNumber *keyNum = [[NSNumber alloc] initWithInteger:key];
    [secondDiguiDic setObject:info forKey:keyNum];
    [info release];
    [keyNum release];
    
}
-(void)secondPutdiguiInfoTolist:(NSInteger)key currentValue:(NSInteger)currentValue oldValue:(NSInteger)oldValue fristCanChooseCount:(NSInteger)fristCanChooseCount itemsCount:(NSInteger)itemsCount chuan:(NSString*)chuan{
    
    //if (secondDiguiDic) {
        
        NSMutableDictionary *_diguiDic = [[NSMutableDictionary alloc] init];
        if (secondDiguiDic)
        [_diguiDic setDictionary:secondDiguiDic];
        GC_JCDiGuiInfo *info = [[GC_JCDiGuiInfo alloc] init];
        info.currentValue = currentValue;
        info.oldValue = oldValue;
        info.itemsCount = itemsCount;
        info.canChooseCount = [info canChooseCount:oldValue currentValue:currentValue];
        info.fristCanChooseCount = fristCanChooseCount;
        
        NSNumber *keyNum = [[NSNumber alloc] initWithInteger:key];
        [_diguiDic setObject:info forKey:keyNum];
        [info release];
        [keyNum release];
        
        NSArray *keys = [_diguiDic allKeys];
        keys = [keys afterInOder];
        
        long long total =0;
        for(id diguiKey in keys){
            NSNumber *diguiKeyNum = (NSNumber*)diguiKey;
            GC_JCDiGuiInfo *_info = [_diguiDic objectForKey:diguiKeyNum];
            if (_info) {
                total+= _info.currentValue;
            }
        }
        NSArray *passTypeRuleList = [self  passTypeRuleArry:chuan];
        if (passTypeRuleList&&passTypeRuleList>0) {
            for(id valueList  in passTypeRuleList){
                NSString *passTypeRuleStr = (NSString*)valueList;
                long long passTypeRuleInt = [passTypeRuleStr integerValue];
                if (total == passTypeRuleInt) {
                 totalZhuShu += [self secondtotalZhuShu:_diguiDic keysAfterOder:keys]; 
                    NSLog(@"totalzhushu = %lld", totalZhuShu);
                }
            }
        }
    [_diguiDic release];
    //}


}
         


-(void)putDiguiInfoToList:(NSInteger)key currentVaule:(NSInteger)currentVaule oldValue:(NSInteger)oldValue itemsCount:(NSInteger)itemsCount  gameCount:(NSInteger)count chuan:(NSString*)chuan{
   // if (diguiDic) {
        NSMutableDictionary *_diguiDic = [[NSMutableDictionary alloc] init];
        if (diguiDic)
        [_diguiDic setDictionary:diguiDic];
        GC_JCDiGuiInfo *info = [[GC_JCDiGuiInfo alloc] init];
        info.currentValue = currentVaule;
        info.oldValue = oldValue;
        info.itemsCount = itemsCount;
        info.canChooseCount = [info canChooseCount:oldValue currentValue:currentVaule];
        
        NSNumber *keyNum = [[NSNumber alloc] initWithInteger:key];
        [_diguiDic setObject:info forKey:keyNum];
        [info release];
        [keyNum release];
        
        NSInteger headerNum = [self passTypeHeaderNum:chuan];
        NSArray *keys = [_diguiDic allKeys];
        keys = [keys afterInOder];
        
        NSInteger total =0;
        for(id diguiKey in keys){
            NSNumber *diguiKeyNum = (NSNumber*)diguiKey;
            GC_JCDiGuiInfo *_info = [_diguiDic objectForKey:diguiKeyNum];
            if (_info) {
                total+= _info.currentValue;
            }
        }
        if (headerNum<count) {// 选择 小于场次 数的串 
            if (total== headerNum) {
                // 开始二次 递归
                [self secondDiguiRule:_diguiDic keys:keys key:nil value:0 index:0 k:0 oldCanChooseCount:0 chuan:chuan itemsCount:0];
            }
            
        }else{// 串数 和 场次数相同 
            
            NSArray *passTypeRuleList = [self  passTypeRuleArry:chuan];
            if (passTypeRuleList&&passTypeRuleList.count>0) {
                for(id valueList  in passTypeRuleList){
                    NSString *passTypeRuleStr = (NSString*)valueList;
                    NSInteger passTypeRuleInt = [passTypeRuleStr integerValue];
                    if (total == passTypeRuleInt) {
                        totalZhuShu += [self totalZhuShu:_diguiDic keysAfterOder:keys]; 
                        NSLog(@"totalzhushu = %lld", totalZhuShu);
                    }
                }
            }
        }
        [_diguiDic release];
    //}
    
}

-(long long)totalZhuShu:(NSMutableDictionary*)dic keysAfterOder:(NSArray*)keys{
    long long totalCanChoseCount = 1;
    long long totalItemChoseCont =1;
    if(dic&&keys) {
        for(id key in keys){
            NSNumber *diguiKeyNum = (NSNumber*)key;
            GC_JCDiGuiInfo *_info = [dic objectForKey:diguiKeyNum];
            if (_info) {
               totalCanChoseCount *=_info.canChooseCount;
               totalItemChoseCont*=[_info itemsReslut:_info.itemsCount currentValue:_info.currentValue];
            }
        }
    }
    return totalCanChoseCount*totalItemChoseCont;
}

// second totalZhushu
-(long long)secondtotalZhuShu:(NSMutableDictionary*)dic keysAfterOder:(NSArray*)keys{
    long long totalCanChoseCount =1;
    long long totalItemChoseCont =1;
    long long fisrtCanChoseCount= 1;
    if(dic&&keys) {
        for(id key in keys){
            NSNumber *diguiKeyNum = (NSNumber*)key;
            GC_JCDiGuiInfo *_info = [dic objectForKey:diguiKeyNum];
            if (_info) {
                totalCanChoseCount *=_info.canChooseCount;
                totalItemChoseCont*=[_info itemsReslut:_info.itemsCount currentValue:_info.currentValue];
                fisrtCanChoseCount*=_info.fristCanChooseCount;
            }
        }
    }
    return fisrtCanChoseCount*totalCanChoseCount*totalItemChoseCont;
}




@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    