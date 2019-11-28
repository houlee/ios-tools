//
//  CP_UISegement.h
//  caibo
//
//  Created by yaofuyu on 13-1-20.
//
//

#import <UIKit/UIKit.h>
#import "CP_PTButton.h"

@class CP_UISegement;
@protocol CP_UISegementDelegate

@optional
- (void)selectIndexChangde:(CP_UISegement *)cpsegement;

@end

@interface CP_UISegement : UIView {
    UIImageView *_backgroudImageView;
    UIColor *_titleColor;
    CP_PTButton *_selectBtn;
    NSMutableArray *_titleArray;
    NSInteger _selectIndex;
    id delegate;
}

@property (nonatomic,retain)UIImageView *backgroudImageView;
@property (nonatomic,retain)UIColor *titleColor;
@property (nonatomic,readonly)NSMutableArray *titleArray;
@property (nonatomic)NSInteger selectIndex;
@property (nonatomic,retain)CP_PTButton *selectBtn;
@property (nonatomic,assign)id<CP_UISegementDelegate> delegate;

- (void)setBackgroudImage:(UIImage *)image;
- (id)initWithItems:(NSArray *)items;

@end
