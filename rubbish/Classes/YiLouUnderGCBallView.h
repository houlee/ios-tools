//
//  YiLouUnderGCBallView.h
//  caibo
//
//  Created by GongHe on 14-3-5.
//
//

typedef enum {
    NoZero,//遗漏key没有0
    HasZero,
}KeyType;

#import <Foundation/Foundation.h>

@interface YiLouUnderGCBallView : NSObject

//view:GCBallView父视图   dic:遗漏值  typeStr:遗漏值字段  num:从第几个开始取  tag:tag值从多少开始
//segmentation:从seg开始截取数组   arrayTag:取截取后的哪个数组 normalColor普通遗漏颜色
//maxColor最大遗漏颜色    keyType key有没有0    yiLouTag取遗漏值时需要加的数   reverse是否倒着取
//keyArray 特殊的key 非数字的key
+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num firstTag:(int)tag segmentation:(int)seg arrayTag:(int)arrayTag normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor keyType:(KeyType)keyType yiLouTag:(int)yiLouTag reverse:(BOOL)reverse keyArray:(NSArray *)keyArray;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr keyArray:(NSArray *)keyArray;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag keyArray:(NSArray *)keyArray normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr keyType:(KeyType)keyType yiLouTag:(int)yiLouTag;

////////////////////////////
+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag keyType:(KeyType)keyType yiLouTag:(int)yiLouTag;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag reverse:(BOOL)reverse;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag;

////////////////////////////

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num segmentation:(int)seg arrayTag:(int)arrayTag;

////////////////////////////
+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstTag:(int)tag yiLouTag:(int)yiLouTag normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num firstTag:(int)tag keyType:(KeyType)keyType yiLouTag:(int)yiLouTag;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num firstTag:(int)tag;
////////////////////////////

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr segmentation:(int)seg arrayTag:(int)arrayTag;

+(void)addYiLouTextOnView:(UIView *)view dictionary:(NSDictionary *)dic typeStr:(NSString *)typeStr firstAtIndex:(int)num normalColor:(UIColor *)normalColor maxColor:(UIColor *)maxColor;

@end
