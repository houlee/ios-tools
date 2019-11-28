//
//  NewsCell.h
//  caibo
//
//  Created by  on 12-7-3.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell{
    UILabel * titleLable;
    UILabel * timeLable;
    UILabel * laiziLabel;

}

- (UIView *)returnTabelviewCell;

@end
