//
//  LoadCell.h
//  caibo
//
//  Created by jeff.pluto on 11-7-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MSG_TYPE_NO_COMMENT,
    MSG_TYPE_LOAD_COMMENT,
    MSG_TYPE_NO_USER,
    MSG_TYPE_LOADING
} cellType;

@interface LoadCell : UITableViewCell {
    UILabel*                    label;
    UIActivityIndicatorView*    spinner;
    cellType                    type;
}

@property(nonatomic, readonly) UIActivityIndicatorView* spinner;
@property(nonatomic, assign) cellType type;

- (void)setType:(cellType)type;

@end