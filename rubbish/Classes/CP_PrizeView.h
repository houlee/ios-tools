//
//  CP_PrizeView.h
//  caibo
//
//  Created by cp365dev on 15/1/24.
//
//

#import <UIKit/UIKit.h>
typedef enum {

    CP_PrizeViewTextType,
    CP_PrizeViewHongBaoType,
    
}CP_PrizeViewType;


@interface CP_PrizeView : UIView{

    CP_PrizeViewType prizeType;
    
    UIImageView *bgImg;
    
    NSString *title;
    NSString *btnName;
    NSString *returnType;
    NSString *topicID;
    NSString *lotteryID;
    
    UIImageView *closeImg;
    
    id delegate;
    UIView *backgroundView;
}

@property (nonatomic,copy) NSString *title,*btnName,*returnType,*topicID,*lotteryID;
@property (nonatomic) CP_PrizeViewType prizeType;
@property (nonatomic, assign) id delegate;

-(id)initWithtitle:(NSString *)_title andBtnName:(NSString *)_btnName returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid;

-(void)show;
@end


@protocol CP_PrizeViewDelegate

@optional
-(void)CP_PrizeViewGetPressDelegate:(CP_PrizeView *)prizeview returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid;

- (void)disMissFromSuperView:(CP_PrizeView *)chooseView;


@end
