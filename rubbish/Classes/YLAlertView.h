//
//  YLAlertView.h
//  caibo
//
//  Created by cp365dev on 15/3/9.
//
//

#import <UIKit/UIKit.h>

@interface YLAlertView : UIView
{
    UIButton *saishiBtn;
    UIButton *glBtn;
    UIButton *weiboBtn;
    UIButton *ylBtn;

}
-(id)initYLAlertView;

-(void)show;

@end
