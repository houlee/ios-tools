//
//  cp_LieBiaoView.h
//  iphone_control
//
//  Created by zhang on 11/29/12.
//  Copyright (c) 2012 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CP_LieBiaoView : UIView<UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>{

//    UITableView *myTableView;
    NSMutableArray *dataArray;
    UIImageView *backImage;
    UIImageView *btnImage;
    UIButton *btn;
    id delegate;
    BOOL isSelcetType;
    BOOL weixinBool;
    NSMutableArray * arrayType;
    BOOL danXuanBool;
    
    NSInteger selectedTag;
    UIScrollView *myScrollView;
}
@property (nonatomic, retain)NSMutableArray * arrayType;
@property (nonatomic, assign)BOOL danXuanBool;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,assign)id delegate;
@property (nonatomic,assign)BOOL isSelcetType, weixinBool;


- (id)initWithFrame:(CGRect)frame danXuan:(BOOL)yesOrNo type:(NSMutableArray *)typeArray;//bool 传yes  数组传状态

- (void)LoadButtonName:(NSArray *)butArray;
- (void)show;
- (void)showAgain;
- (void)showFenxiang;
- (void)shareDetail;
- (void)showFenxiangWithoutSina;

@end



//代理
@protocol CP_lieBiaoDelegate

@optional

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex type:(NSMutableArray *)typearr;

- (void)quxiaobutton;

@end
