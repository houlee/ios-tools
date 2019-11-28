//
//  ReYiCell.h
//  caibo
//
//  Created by  on 12-5-25.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorLabel.h"
#import "ASIHTTPRequest.h"

@interface ReYiCell : UITableViewCell<ColorLabelDelegate,ASIHTTPRequestDelegate>{
    UILabel * namelabel;
    UILabel * datelabel;
    UIImageView * tubiaoimage;
    NSString * cstr;
    NSString * huatistring;
    UILabel * hautiLabel;
    NSString * namestr;
    UIImageView * xian ;
    UIView * returnview;
    ASIHTTPRequest *request;
}
@property (nonatomic, retain)UIView * returnview;
@property (nonatomic, retain)UIImageView * xian;
@property (nonatomic, retain)NSString * huatistring;
@property (nonatomic, retain)UILabel * hautiLabel;
@property (nonatomic, retain)NSString * cstr;
@property (nonatomic, retain)UILabel * namelabel;
@property (nonatomic, retain)UILabel * datelabel;
@property (nonatomic, retain)UIImageView * tubiaoimage;
@property (nonatomic, retain)ASIHTTPRequest *request;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier str:(NSString *)str huati:(NSString *)ht name:(NSString *)names;
- (UIView *)returnTabelViewCell;
@end
