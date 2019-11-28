//
//  KFButton.h
//  caibo
//
//  Created by houchenguang on 12-11-20.
//
//

#import <UIKit/UIKit.h>
#import "KFMessageBoxView.h"
#import "KFMessageViewController.h"

@interface KFButton : UIImageView   < UITableViewDelegate,UISearchBarDelegate>{

    UIImageView * markImage;//客服标记
    BOOL show;//是否显示
    
    UIButton * kfbutton;//客服按钮
    UIButton * searchbutton;//搜索按钮
    UIImageView * newkfimage;//客服按钮新消息标志
    UIView * bgview;//黑色阴影
    BOOL markbool;//客服标记标记的bool
    BOOL newkfbool;//客服按钮新消息标志bool
    KFMessageBoxView * msgbox;//客服消息框
    UILabel * kefulabel;//客服label
    UILabel * searchlabel;//搜索label
    UIImageView * jiantouimage;
    
    KFMessageViewController *kfmBox;
   
}


@property (nonatomic, retain)UIImageView * markImage;
@property (nonatomic, assign)BOOL show, markbool,newkfbool;

- (void)tiaoxiaoshi;//消失 渐回
- (void)chulaitiao;//显示 渐出
- (void)calloff;//消失 渐隐
- (void)callShow;//显示渐隐
- (void)beginShow;//第一次进程序的时候显示
- (void)kfbuttonbig;
@end
