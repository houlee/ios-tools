//
//  ssqyiloutuViewController.h
//  caibo
//
//  Created by houchenguang on 13-2-21.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "YiLouTuScrollView.h"
#import "UpLoadView.h"
#import "CPViewController.h"

typedef enum {
    shuangSeQiuYiLouType,
    kuaiLeShiFenYiLouType,
    kuai3FenxiYiLouType,
    
}YiLouTuType;


@interface ssqyiloutuViewController : CPViewController<UIScrollViewDelegate, YiLouTuScrollViewDelegate>{


    ASIHTTPRequest * httpRequest;
    NSMutableArray * issueArray;
    NSMutableArray * allNumArray;
    YiLouTuScrollView * myScrollView;
    UIImageView * leftimage;
    UIImageView * rightimage;
    UpLoadView * loadview;
    YiLouTuType yiloutu;
}
@property (nonatomic, assign)YiLouTuType yiloutu;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;

@end
