//
//  EveryDayCellModel.h
//  caibo
//
//  Created by GongHe on 14-1-13.
//
//

#import <Foundation/Foundation.h>

@interface EveryDayCellModel : NSObject
{
    NSString * titleStr;
    NSMutableArray * contentArr;
    BOOL is_title;
}

@property(nonatomic,retain)NSString * titleStr;//标题
@property(nonatomic,retain)NSMutableArray * contentArr;//内容
@property(nonatomic,assign)BOOL is_title;

- (id)initWithString:(NSString *)string;

@end
