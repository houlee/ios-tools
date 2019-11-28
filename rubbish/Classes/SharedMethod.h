//
//  SharedMethod.h
//  caibo
//
//  Created by GongHe on 14-7-2.
//
//

#import <Foundation/Foundation.h>

@interface SharedMethod : NSObject

//时间去掉年和秒
+(NSString *)changeDateToNoYearNoSecond:(NSString *)date;

//截取期数最后两位
+(NSString *)getLastTwoStr:(NSString *)str;

//截取期数最后三位
+(NSString *)getLastThreeStr:(NSString *)str;

//截取期数最后"length"位
+(NSString *)getLastStrByLength:(NSString *)str length:(int)length;

//获得排序数组
+(NSArray *)getSortedArrayByArray:(NSArray *)array;

//获得同号数量
+(int)getSortSameCountByArray:(NSArray *)array;

//获得相同号码
+(int)getSortSameNumberByArray:(NSArray *)array;

//获得排序后的所有信息 @"sortedArray" 排序数组  @"sameCount" 同号数量 @"sameNumber"相同号码
+(NSDictionary *)getSortedArrayInfoByArray:(NSArray *)array;

//0:公开,1:保密,2:截止后公开,3:仅对跟单者公开，4:隐藏
+(int)changeBaoMiTypeByTitle:(NSString *)title;

//转换成自己字体需要的字符串（快三）
+(NSString *)changeFontWithString:(NSString *)string;

+(void)sanJiaoKai:(UIView *)sanJiao;//标题三角打开动画
+(void)sanJiaoGuan:(UIView *)sanJiao;//标题三角关闭动画

+ (UIColor *)getColorByHexString:(NSString *)hexString;//十六进制转成十进制设color RGB

+(CGSize)getSizeByWeiBoImage:(UIImage *)weiboImage;//微博广场图片尺寸

+(CGSize)getSizeByText:(NSString *)text font:(UIFont *)textFont constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
+(CGSize)getSizeByAttributedString:(NSAttributedString *)text font:(UIFont *)textFont constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

+(void)setRefreshByHeaderOrFooter:(id)object;
+ (UIImage*) createImageWithColor: (UIColor*) color;//颜色变图片

@end
