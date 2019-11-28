//
//  GuangChangTopNewsCell.h
//  caibo
//
//  Created by GongHe on 14-10-30.
//
//

#import <UIKit/UIKit.h>
@class ColorView;

@interface GuangChangTopNewsCell : UITableViewCell
{
    UILabel * titleLabel;
    UILabel * contentLabel;
}

@property (nonatomic, retain)UILabel * titleLabel;

-(void)setContentString:(NSString *)contentStr;


@end
