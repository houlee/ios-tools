//
//  GC_ZhuCeChengGongViewCotroller.h
//  caibo
//
//  Created by houchenguang on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatePopupView.h"
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "CP_PrizeView.h"
#import "UpLoadView.h"
@interface GC_ZhuCeChengGongViewCotroller : CPViewController<UITextFieldDelegate,CP_PrizeViewDelegate>{
    StatePopupView * statepop;
    
    UITextField *textF;
    ASIHTTPRequest *requestUserInfo;
    BOOL isTixian;
    NSString * passWord;
    NSString *hongbaoMes;
    
    UpLoadView *loadview;
    
    NSString *hongbao_returntype;
    NSString *hongbao_topicid;
    NSString *hongbao_lotteryid;
}
@property (nonatomic,retain)ASIHTTPRequest *requestUserInfo;
@property (nonatomic, retain)NSString* passWord;
@property (nonatomic,copy) NSString *hongbaoMes,*hongbao_returntype,*hongbao_topicid,*hongbao_lotteryid;

@end
