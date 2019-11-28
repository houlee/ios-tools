//
//  SharedMethod.m
//  caibo
//
//  Created by GongHe on 14-7-2.
//
//

#import "SharedMethod.h"
#import "GC_BetInfo.h"
#import "SharedDefine.h"
#import "MJRefresh.h"

@implementation SharedMethod

+(NSString *)changeDateToNoYearNoSecond:(NSString *)date
{
    if (date && [date length]) {
        NSString * dateString = [[date substringFromIndex:5] substringToIndex:[[date substringFromIndex:5] length] - 3];
        return dateString;
    }
    return @"";
}

+(NSString *)getLastStrByLength:(NSString *)str length:(int)length
{
    if ([str length] > length) {
        return [str substringFromIndex:str.length - length];
    }
    return str;
}

+(NSString *)getLastTwoStr:(NSString *)str
{
    return [self getLastStrByLength:str length:2];
}

+(NSString *)getLastThreeStr:(NSString *)str
{
    return [self getLastStrByLength:str length:3];
}

+(NSArray *)getSortedArrayByArray:(NSArray *)array
{
    sortSameCount = 0;
    sortSameNumber = 0;
    
    return [array sortedArrayUsingFunction:numSortType context:nil];
}

+(int)getSortSameCountByArray:(NSArray *)array
{
    sortSameCount = 0;
    sortSameNumber = 0;
    
    [array sortedArrayUsingFunction:numSortType context:nil];
    return sortSameCount;
}

+(int)getSortSameNumberByArray:(NSArray *)array
{
    sortSameCount = 0;
    sortSameNumber = 0;
    
    [array sortedArrayUsingFunction:numSortType context:nil];
    return sortSameNumber;
}

+(NSDictionary *)getSortedArrayInfoByArray:(NSArray *)array
{
    sortSameCount = 0;
    sortSameNumber = 0;
    NSLog(@"~~%@",array);
    NSArray * sortedArray = [array sortedArrayUsingFunction:numSortType context:nil];
    NSString * sameCount = [NSString stringWithFormat:@"%d",sortSameCount];
    NSString * sameNumber = [NSString stringWithFormat:@"%d",sortSameNumber];
    
    NSDictionary * dictionary = [[[NSDictionary alloc] initWithObjectsAndKeys:sortedArray,@"sortedArray",sameCount,@"sameCount",sameNumber,@"sameNumber", nil] autorelease];
    return dictionary;
}

static int sortSameCount;//同号数量
static int sortSameNumber;//相同号码
NSInteger numSortType(id s1,id s2,void *cha)
{
    if([s1 floatValue] < [s2 floatValue]){
        return NSOrderedAscending;
    }else if([s1 floatValue] > [s2 floatValue]){
        return NSOrderedDescending;
    }
    sortSameNumber = [s1 floatValue];
    sortSameCount++;
    return NSOrderedSame;
}

//0:公开,1:保密,2:截止后公开,3:仅对跟单者公开，4:隐藏
+(int)changeBaoMiTypeByTitle:(NSString *)title
{
    if ([title isEqualToString:@"公开"]) {
        return 0;
    }
    else if ([title isEqualToString:@"保密"]) {
        return 1;
    }
    else if ([title isEqualToString:@"截止后公开"]) {
        return 2;
    }
    else if ([title isEqualToString:@"仅对跟单者公开"]) {
        return 3;
    }
    else if ([title isEqualToString:@"隐藏"]) {
        return 4;
    }
    return 0;
}

+(NSString *)changeFontWithString:(NSString *)string
{
    NSString * changedString = @"";
    for (int i = 0; i < [string length]; i++) {
        NSString * str = [string substringWithRange:NSMakeRange(i, 1)];
        if (![str integerValue]) {
            if ([str isEqualToString:@"0"]) {
                str = @"⑽";
            }
            else if ([str isEqualToString:@"⒑"]) {
                str = @"1";
            }
            else if ([str isEqualToString:@"⑵"]) {
                str = @"2";
            }
            else if ([str isEqualToString:@"⑶"]) {
                str = @"3";
            }
            else if ([str isEqualToString:@"⑷"]) {
                str = @"4";
            }
            else if ([str isEqualToString:@"⑸"]) {
                str = @"5";
            }
            else if ([str isEqualToString:@"⑹"]) {
                str = @"6";
            }
            else if ([str isEqualToString:@"⑺"]) {
                str = @"7";
            }
            else if ([str isEqualToString:@"⑻"]) {
                str = @"8";
            }
            else if ([str isEqualToString:@"⑼"]) {
                str = @"9";
            }
            else if ([str isEqualToString:@"⑽"]) {
                str = @"0";
            }
//            else if ([str isEqualToString:@"⒎"]) {
//                str = @"全";
//            }
//            else if ([str isEqualToString:@"⒏"]) {
//                str = @"数";
//            }
//            else if ([str isEqualToString:@"⒐"]) {
//                str = @"个";
//            }
            else if ([str isEqualToString:@"全"]) {
                str = @"⒎";
            }
            else if ([str isEqualToString:@"数"]) {
                str = @"⒏";
            }
            else if ([str isEqualToString:@"个"]) {
                str = @"⒐";
            }
            else{
                
            }
        }else{
            switch ([str integerValue]) {
                case 1:
                {
                    str = @"⒑";
                }
                    break;
                case 2:
                {
                    str = @"⑵";
                }
                    break;
                case 3:
                {
                    str = @"⑶";
                }
                    break;
                case 4:
                {
                    str = @"⑷";
                }
                    break;
                case 5:
                {
                    str = @"⑸";
                }
                    break;
                case 6:
                {
                    str = @"⑹";
                }
                    break;
                case 7:
                {
                    str = @"⑺";
                }
                    break;
                case 8:
                {
                    str = @"⑻";
                }
                    break;
                case 9:
                {
                    str = @"⑼";
                }
                    break;
                default:
                    break;
            }
        }
        changedString = [changedString stringByAppendingString:str];
    }
    return changedString;
}

+(void)sanJiaoKai:(UIView *)sanJiao
{
    [UIView animateWithDuration:SANJIAO_DURATION animations:^{
        CGAffineTransform transForm = CGAffineTransformMakeRotation(M_PI*1);
        sanJiao.transform = transForm;
    }];
}

+(void)sanJiaoGuan:(UIView *)sanJiao
{
    [UIView animateWithDuration:SANJIAO_DURATION animations:^{
        CGAffineTransform transForm = CGAffineTransformMakeRotation(0);
        sanJiao.transform = transForm;
    }];
}

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIColor *)getColorByHexString:(NSString *)hexString
{
    if ([hexString length] == 6) {
        NSMutableArray * rgbArray = [[[NSMutableArray alloc] initWithCapacity:6] autorelease];
        for (int i = 0; i < 3; i++) {
            NSString * str = [hexString substringWithRange:NSMakeRange(i * 2, 2)];
            NSString * changedStr = [NSString stringWithFormat:@"%lu",strtoul([str UTF8String],0,16)];
            [rgbArray addObject:changedStr];
        }
        return [UIColor colorWithRed:[[rgbArray objectAtIndex:0] integerValue]/255.0 green:[[rgbArray objectAtIndex:1] integerValue]/255.0 blue:[[rgbArray objectAtIndex:2] integerValue]/255.0 alpha:1];
    }
    return nil;
}

+(CGSize)getSizeByWeiBoImage:(UIImage *)weiboImage
{
    
    float imageWidth = weiboImage.size.width;
    float imageHeight = weiboImage.size.height;
    
    CGSize imageSize = CGSizeZero;
    if (imageWidth && imageHeight) {
        if (imageWidth == imageHeight) {
            imageSize = CGSizeMake(WEIBO_IMAGE_MAX, WEIBO_IMAGE_MAX);
        }else{
            imageSize = (imageWidth > imageHeight)?CGSizeMake(WEIBO_IMAGE_MAX, imageHeight * (WEIBO_IMAGE_MAX/imageWidth)):CGSizeMake(imageWidth * (WEIBO_IMAGE_MAX/imageHeight), WEIBO_IMAGE_MAX);
        }
    }
    
    return imageSize;
}


+(NSString *)getWanFaIDWithServiceID:(NSString *)_wanfaID{

    
    
    
    return nil;
}

+(CGSize)getSizeByText:(NSString *)text font:(UIFont *)textFont constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if(IS_IOS7){
        CGRect rect = CGRectZero;
        if (text.length) {
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            
            NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = lineBreakMode;
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
            rect = [text boundingRectWithSize:size options:options attributes:dic context:nil];
        }
        
        return rect.size;
    }
    else{
        return [text sizeWithFont:textFont constrainedToSize:size lineBreakMode:lineBreakMode];
    }
}

+(CGSize)getSizeByAttributedString:(NSAttributedString *)text font:(UIFont *)textFont constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if(IS_IOS7){
        CGRect rect = CGRectZero;
        if (text.length) {
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            
            NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = lineBreakMode;
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
            rect = [text boundingRectWithSize:size options:options context:nil];
        }
        
        return rect.size;
    }
    else{
        return [text.string sizeWithFont:textFont constrainedToSize:size lineBreakMode:lineBreakMode];
    }
}

+(void)setRefreshByHeaderOrFooter:(id)object
{
    if ([object isKindOfClass:[MJRefreshNormalHeader class]]) {
        MJRefreshNormalHeader * header = object;
        
        // 设置文字
        [header setTitle:@"下拉即可刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
        
        // 设置字体
        header.stateLabel.font = [UIFont systemFontOfSize:14];
        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:9];
        
        // 设置颜色
        header.stateLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        header.lastUpdatedTimeLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        
    }else if ([object isKindOfClass:[MJRefreshBackNormalFooter class]]) {
        MJRefreshBackNormalFooter * footer = object;
        // 设置文字
        [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"没有更多" forState:MJRefreshStateNoMoreData];
        
        // 设置字体
        footer.stateLabel.font = [UIFont systemFontOfSize:17];
        
        // 设置颜色
        footer.stateLabel.textColor = [UIColor lightGrayColor];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    