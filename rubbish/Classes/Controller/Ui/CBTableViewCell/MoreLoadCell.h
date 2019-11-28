//
//  MoreLoadCell.h
//  caibo
//
//  Created by jacob on 11-6-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeCell.h"

/**
 * 公用 “更多” －－－下拉 刷新 cell 
 ****/
 

typedef enum {
    MSG_TYPE_LOAD_MORE,
	MSG_TYPE_LOAD_NODATA,
	MSG_TYPE_LOAD_LOADING,
} loadCellType;

typedef enum
{
    StyleNormal,
    StyleOne
}CellStyle;
@interface MoreLoadCell : UITableViewCell 
{
	UILabel *label;
	UIActivityIndicatorView *spinner;
	loadCellType type;
    CellStyle cellStyle;
    
//    UIImageView *_activityView;
}

@property(nonatomic,readonly) UIActivityIndicatorView *spinner;
@property (nonatomic, assign)loadCellType type;

- (void)setCellStyle:(CellStyle)style;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rect:(CGRect)_rect;
// 开始旋转
-(void)spinnerStartAnimating;
// 停止旋转
-(void)spinnerStopAnimating;
// 开始旋转
-(void)spinnerStartAnimating2;
-(void)spinnerStopAnimating2:(BOOL)isDataNone;
//
- (void)setInfoText:(NSString *)text;

@end




