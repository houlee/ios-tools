//
//  MyProfileTableViewCell.h
//  caibo
//
//  Created by GongHe on 14-5-29.
//
//

#import <UIKit/UIKit.h>

@interface MyProfileTableViewCell : UITableViewCell
{
    UIImageView * iconImageView;
    UILabel * titleLabel;
    UIView * bottomLine;
}

@property(nonatomic, retain)UIImageView * iconImageView;
@property(nonatomic, retain)UILabel * titleLabel;
@property(nonatomic, retain)UIView * bottomLine;


@end
