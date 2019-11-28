//
//  StartGuideView.h
//  caibo
//
//  Created by cp365dev on 14-6-5.
//
//

#import <UIKit/UIKit.h>
#import "New_PageControl.h"
@interface StartGuideView : UIView<UIScrollViewDelegate>
{
    New_PageControl *myPageControl;
    UIScrollView *myScrollView;
    
    id delegate;
    
    BOOL isArePerform;//是否已执行过Delegate
}
@property (nonatomic, assign) id delegate;
@end


@protocol StartGuideViewDelegate

-(void)disMissGuideViewFromSuperView;

@end