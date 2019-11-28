//
//  n115yilouViewController.h
//  caibo
//
//  Created by houchenguang on 13-2-22.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "UpLoadView.h"
#import "CPViewController.h"

typedef enum {
    
    shiyixuanwutpye,
    kuaisantype,
    
}YiLouTuTwoType;

@interface n115yilouViewController : CPViewController<UIScrollViewDelegate>{


    UIScrollView * myScrollView;
    ASIHTTPRequest * httpRequest;
    NSMutableArray * issueArray;//期号数组
    NSMutableArray * drawArray;//开奖号码数组
    NSMutableArray * allNumArray;//遗漏数数组
    UpLoadView * loadView;
    YiLouTuTwoType yiloutwo;
}
@property (nonatomic, assign)YiLouTuTwoType yiloutwo;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@end
