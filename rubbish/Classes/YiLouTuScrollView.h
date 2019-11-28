//
//  YiLouTuScrollView.h
//  caibo
//
//  Created by houchenguang on 13-2-26.
//
//

#import <UIKit/UIKit.h>


@protocol YiLouTuScrollViewDelegate <NSObject>

- (void)returnScrollViewTouch:(BOOL)touchbool;

@end


@interface YiLouTuScrollView : UIScrollView{
    
    id<YiLouTuScrollViewDelegate>mdelegate;
}

@property (nonatomic, assign)id<YiLouTuScrollViewDelegate>mdelegate;

- (void)returnScrollViewTouch:(BOOL)touchbool;

@end
