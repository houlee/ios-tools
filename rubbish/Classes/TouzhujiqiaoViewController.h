//
//  TouzhujiqiaoViewController.h
//  caibo
//
//  Created by zhang on 5/29/13.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"

typedef enum {

    shuangsheqiu,
    qixincai,
    shishicai,
    qilecai,
    daletou,
    fucai3d,
    bjdanchang,
    jincaizuqiu,
    jingcailanqiu,
    shiyixuan5,
    pai3,
    pai5,
    kuaileshifen,
    ererX5,
    k3,
    ticai

}Caizhong;

@interface TouzhujiqiaoViewController : CPViewController<UIWebViewDelegate> {

    UIScrollView *backScrollView;
    UIWebView *web;
    
    Caizhong mycaizhong;
}

- (void)Jiqiao:(Caizhong)caizhong;
@end
