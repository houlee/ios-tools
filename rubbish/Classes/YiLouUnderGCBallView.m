//
//  YiLouUnderGCBallView.m
//  caibo
//
//  Created by GongHe on 14-3-5.
//
//

#import "YiLouUnderGCBallView.h"
#import "GCBallView.h"
#import "SharedMethod.h"

#import "SharedDefine.h"

@implementation YiLouUnderGCBallView

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:num firstTag:nil segmentation:nil arrayTag:2 normalColor:normalColor maxColor:maxColor keyType:NoZero yiLouTag:0 reverse:NO keyArray:nil];
}


+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num segmentation:(int)seg arrayTag:(int)arrayTag
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:num firstTag:nil segmentation:seg arrayTag:arrayTag normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:NoZero yiLouTag:0 reverse:NO keyArray:nil];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:num firstTag:nil segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:NoZero yiLouTag:0 reverse:NO keyArray:nil];
}

////////////////////////////

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag keyType:(KeyType)keyType yiLouTag:(int)yiLouTag
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:tag segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:keyType yiLouTag:yiLouTag reverse:NO keyArray:nil];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag reverse:(BOOL)reverse
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:tag segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:NoZero yiLouTag:0 reverse:reverse keyArray:nil];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:tag segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:NoZero yiLouTag:0 reverse:NO keyArray:nil];
}

////////////////////////////

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr segmentation:(int)seg arrayTag:(int)arrayTag
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:nil segmentation:seg arrayTag:arrayTag normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:NoZero yiLouTag:0 reverse:NO keyArray:nil];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:nil segmentation:nil arrayTag:2 normalColor:normalColor maxColor:maxColor keyType:NoZero yiLouTag:0 reverse:NO keyArray:nil];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag keyArray:(NSArray *)keyArray normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:tag segmentation:nil arrayTag:2 normalColor:normalColor maxColor:maxColor keyType:NoZero yiLouTag:0 reverse:NO keyArray:keyArray];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr keyArray:(NSArray *)keyArray
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:nil segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:NoZero yiLouTag:0 reverse:NO keyArray:keyArray];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:nil segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:NoZero yiLouTag:0 reverse:NO keyArray:nil];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr keyType:(KeyType)keyType yiLouTag:(int)yiLouTag
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:nil firstTag:nil segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:keyType yiLouTag:yiLouTag reverse:NO keyArray:nil];
}

///////////////

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag yiLouTag:(int)yiLouTag normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:0 firstTag:tag segmentation:nil arrayTag:2 normalColor:normalColor maxColor:maxColor keyType:NoZero yiLouTag:yiLouTag reverse:NO keyArray:nil];
}

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num firstTag:(int)tag keyType:(KeyType)keyType yiLouTag:(int)yiLouTag
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:num firstTag:tag segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:keyType yiLouTag:yiLouTag reverse:NO keyArray:nil];
}


+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num firstTag:(int)tag
{
    [self addYiLouTextOnView:view dictionary:dic typeStr:typeStr firstAtIndex:num firstTag:tag segmentation:nil arrayTag:2 normalColor:YILOU_NORMALCOLOR maxColor:YILOU_MAXCOLOR keyType:NoZero yiLouTag:0 reverse:NO keyArray:nil];
}
///////////////

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num firstTag:(int)tag segmentation:(int)seg arrayTag:(int)arrayTag normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor keyType:(KeyType)keyType yiLouTag:(int)yiLouTag reverse:(BOOL)reverse keyArray:(NSArray *)keyArray
{
    NSMutableArray * sortArr;
    int arrayCount = 0;
    NSMutableDictionary * numberDic = nil;
    if ([[dic objectForKey:typeStr] isKindOfClass:[NSDictionary class]]) {
        numberDic = [[[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:typeStr]] autorelease];
        arrayCount = (int)numberDic.count;
        int count = arrayCount - seg * (1 - arrayTag) - (arrayCount - seg) * arrayTag;
        if (arrayTag < 2 && arrayCount) {
            for (int i = 0; i < count; i++) {
                [numberDic removeObjectForKey:[NSString stringWithFormat:@"%d",(seg + i) * (1 - arrayTag)]];
            }
        }

        sortArr = [NSMutableArray array];
        NSMutableDictionary * reverseDic;
        if (reverse) {
            reverseDic = [NSMutableDictionary dictionary];
            
            for (int i = num; i < numberDic.count; i++) {
                NSString * key = @"";
                NSString * reverseKey = @"";
                if (keyType != NoZero && (i + yiLouTag) < 10) {
                    key = [NSString stringWithFormat:@"0%d",i + yiLouTag];
                    reverseKey = [NSString stringWithFormat:@"0%ld",(long)numberDic.count - 1 - (i + yiLouTag)];
                }else{
                    key = [NSString stringWithFormat:@"%d",i + yiLouTag];
                    reverseKey = [NSString stringWithFormat:@"%ld",(long)numberDic.count - 1 - (i + yiLouTag)];
                }
                [sortArr addObject:[[numberDic objectForKey:key] valueForKey:@"yl"]];
                [reverseDic setValue:[numberDic objectForKey:key] forKey:reverseKey];
            }
            numberDic = reverseDic;
        }
        else if (keyArray.count) {
            for (int i = 0; i < keyArray.count; i++) {
                [sortArr addObject:[[numberDic valueForKey:[keyArray objectAtIndex:i]] valueForKey:@"yl"]];
            }
            if (sortArr.count == 1) {
                [sortArr addObject:@"0"];
            }
        }
        else{
            for (int i = num; i < numberDic.count; i++) {
                NSString * key = @"";
                if (keyType != NoZero && (i + yiLouTag) < 10) {
                    key = [NSString stringWithFormat:@"0%d",i + yiLouTag];
                }else{
                    key = [NSString stringWithFormat:@"%d",i + yiLouTag];
                }
                [sortArr addObject:[[numberDic objectForKey:key] valueForKey:@"yl"]];
            }
        }

        if (arrayTag < 2) {
            num += count * arrayTag;
        }
    }else{
        sortArr = [[[NSMutableArray alloc] initWithArray:[dic objectForKey:typeStr]] autorelease];
        
        arrayCount =(int) [[dic objectForKey:typeStr] count];
        
        int count = arrayCount - seg * (1 - arrayTag) - (arrayCount - seg) * arrayTag;
        
        if (arrayTag < 2 && sortArr.count) {
            for (int i = 0; i < count; i++) {
                [sortArr removeObjectAtIndex:seg * (1 - arrayTag)];
            }
        }
        
        int count1 = (int)sortArr.count;
        for (int i = 0; i < num; i++) {
            if (i < count1) {
                [sortArr removeObjectAtIndex:0];
            }
        }
        if (arrayTag < 2) {
            num += count * arrayTag;
        }
    }

    NSString * maxNum = [NSString stringWithFormat:@"%@",[[SharedMethod getSortedArrayByArray:sortArr] lastObject]];
    for (GCBallView *ball in view.subviews) {
        if ([ball isKindOfClass:[GCBallView class]] && ball.tag < 100) {
            ball.ylLable.text = @"-";
            ball.ylLable.textColor = normalColor;
            if (arrayCount != 0) {
                if (ball.tag - tag + num < arrayCount) {
                    if ([[dic objectForKey:typeStr] isKindOfClass:[NSDictionary class]]) {
                        if (keyArray.count) {
                            ball.ylLable.text = [[[numberDic valueForKey:[keyArray objectAtIndex:ball.tag - tag]] valueForKey:@"yl"] description];
                        }
                        else if (keyType != NoZero && (ball.tag - tag + num + yiLouTag) < 10) {
                            ball.ylLable.text = [NSString stringWithFormat:@"%@",[[numberDic objectForKey:[NSString stringWithFormat:@"0%d",(int)ball.tag - tag + num + yiLouTag]] valueForKey:@"yl"]];
                        }else{
                            ball.ylLable.text = [NSString stringWithFormat:@"%@",[[numberDic objectForKey:[NSString stringWithFormat:@"%d",(int)ball.tag - tag + num + yiLouTag]] valueForKey:@"yl"]];
                        }
                    }else{
                        ball.ylLable.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:typeStr] objectAtIndex:ball.tag - tag + num]];
                    }
                    if ([maxNum isEqualToString:ball.ylLable.text]) {
                        ball.ylLable.textColor = maxColor;
                    }
//                    else {
//                        ball.ylLable.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
//                    }
                }
            }
        }
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    