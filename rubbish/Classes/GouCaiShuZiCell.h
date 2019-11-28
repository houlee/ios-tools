//
//  GouCaiShuZiCell.h
//  caibo
//
//  Created by yao on 12-5-24.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GouCaiShuZiCell : UITableViewCell {
	UIImageView *backImage;
    UIImageView *backImage1;
	NSArray *myredArray;
	NSArray *myblueArray;
	NSString *mylotteryId;
    NSString *wanfa;
    NSString *zhongjiang;
    BOOL isHeZhi;
    BOOL isFirst;
    
    UIView *backLine;
    NSString *luckyBall;
    BOOL  isDanshi;//单式上传只显示文字，
    
    BOOL isHorseCell;
    BOOL isHorseDuoWanFa;
}


@property (nonatomic,retain)NSArray *myredArray;
@property (nonatomic,retain)NSArray *myblueArray;
@property (nonatomic,copy)NSString *mylotteryId,*wanfa,*zhongjiang,*luckyBall;
@property (nonatomic,retain)UIImageView *backImage1,*backImage;
@property (nonatomic)BOOL isHeZhi;
@property (nonatomic)BOOL isFirst;
@property (nonatomic)BOOL isDanshi;

@property (nonatomic, assign)BOOL isHorseCell;
@property (nonatomic, assign)BOOL isHorseDuoWanFa;



- (void)LoadRedArray:(NSArray *)redArray BlueArray:(NSArray *)blueArray FenGeArrag:(NSArray *)fengeArray;

- (void)LoadNum:(NSString *)lottoryNum LottoryID:(NSString *)lottoryid WithBall:(BOOL) withBall;
- (void)changeNum:(NSString *) strBall;

@end
