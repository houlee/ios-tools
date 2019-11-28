//
//  LotteryDetailViewController.h
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "caiboAppDelegate.h"
#import "ImageStoreReceiver.h"

@class LotteryDetail;
@class ASIHTTPRequest;

@interface LotteryDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	
	NSString *lotteryId;    //彩种
	NSString *issue;        //彩期
	NSString *status;       //0：当前期  1：上一期  2：下一期
	NSString *lotteryName;  //彩种名
	LotteryDetail *lotteryDetail;
	LotteryDetail *tempDetail;
	
	NSString *imageUrl;
    ImageStoreReceiver *receiver;
	UIImage *lotteryImage;
	
	NSInteger rowHeightWithAwards;
	
	IBOutlet UITableView *mTableView;
	UIImageView *bottomView;
	UIButton *preButton;
	UIButton *lateButton;
}

@property (nonatomic,retain) NSString *lotteryId, *issue, *status, *lotteryName;
@property (nonatomic, retain) UITableView *mTableView;
@property (nonatomic, retain) LotteryDetail *lotteryDetail, *tempDetail;
@property (nonatomic, retain) UIImage *lotteryImage;
@property (nonatomic, retain) UIImageView *bottomView;
@property (nonatomic, retain) UIButton *preButton, *lateButton;

- (void)initBottomButton;
- (void)back: (id)sender;
- (void)addBottomView;

//发送开奖详情请求
- (void)sendMatchDetailRequest:(NSString *)statu;
//开奖详情请求成功回调
-(void)LoadingTableViewData:(ASIHTTPRequest*)request;
//获取图片
- (UIImage *)LoadImageWithUrl:(NSString *) url;
//更新图片
- (void)updateImage:(UIImage*)image;

@end
