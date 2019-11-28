//
//  JJYHChaiCell.h
//  caibo
//
//  Created by yaofuyu on 13-7-11.
//
//

#import <UIKit/UIKit.h>
#import "ColorView.h"
#import "JiangJinYouHuaJX.h"

@class JJYHChaiCell;

@protocol JJYHChaiCellDelegate

@optional
- (void)delegateUpdate:(JJYHChaiCell *)cell;
@end


@interface JJYHChaiCell : UITableViewCell <UITextFieldDelegate> {
    UIImageView *backImageView;
    UILabel *infoLabel;
    UIImageView *lineImageV;
    UIImageView *backUpImageView;
    UIImageView *backdownImageView;
    
    UIImageView *numImageV;
    UILabel *numLabel;
    ColorView *jiangJiLable;
    
    UIImageView *line2;
    UIButton *ZhuBtn;
    UITextField *ZhuText;
    UIButton *lilunJiangBtn;
    UITextField *lilunText;
    GC_YHChaiInfo *myinfo;
    NSInteger Index;
    id jJYHChaiCellDelegate;
    BOOL isGenggai;
    UIImageView *xiaImageV;
    BOOL zuihouBool;
}

@property (nonatomic)NSInteger Index;

@property (nonatomic,retain)GC_YHChaiInfo *myinfo;
@property (nonatomic,assign)id jJYHChaiCellDelegate;
@property (nonatomic) BOOL isGenggai, zuihouBool;

@end
