//
//  UISortView.h
//  caibo
//
//  Created by houchenguang on 14-1-7.
//
//

#import <UIKit/UIKit.h>



@interface UISortView : UIView{

    id delegate;
    UILabel * oneLabel;
    UILabel * twoLabel;
    UILabel * threeLabel;
}

@property (nonatomic, assign)id delegate;


@end

@protocol UISortViewDelegate

- (void)sortViewDidData:(UISortView *)sortView select:(NSInteger)index;

@end
