//
//  GC_UIkeyView.h
//  caibo
//
//  Created by houchenguang on 14-9-11.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    
    upShowKey,
    downShowKey,
    blankShowKey,
}GC_UIkeyType;

@interface GC_UIkeyView : UIView{

    id delegate;
    GC_UIkeyType keyType;
    CGRect mainFrame;
    CGFloat hightFloat;
    UIButton * bgButton;
    UIButton * upButton;
}

@property (nonatomic, assign)id delegate;
@property (nonatomic, assign)GC_UIkeyType keyType;
@property (nonatomic, assign)CGFloat hightFloat;


- (void)showKeyFunc;

- (void)dissKeyFunc;

- (id)initWithFrame:(CGRect)frame withType:(GC_UIkeyType)uikeyType;

@end

@protocol GC_UIkeyViewDelegate <NSObject>

- (void)keyViewDelegateView:(GC_UIkeyView *)keyView jianPanClicke:(NSInteger)sender;

- (void)buttonRemovButton:(GC_UIkeyView *)keyView;

@end