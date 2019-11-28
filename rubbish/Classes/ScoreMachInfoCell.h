//
//  ScoreMachInfoCell.h
//  caibo
//
//  Created by yaofuyu on 13-7-4.
//
//

#import <UIKit/UIKit.h>
#import "ScoreMacthInfo.h"

@interface ScoreMachInfoCell : UITableViewCell {
    MacthEvent *Myevent;
    UIImageView *backImageV;
    UIImageView *leftImageV;
    UIImageView *rightImageV;
    UIImageView *midImageV;
    UILabel *leftLabel;
    UILabel *rightLabel;
    UILabel *midLabel;
    BOOL isLanqiu;//篮球cell；
    
}
@property (nonatomic,retain)MacthEvent *Myevent;
@property (nonatomic)BOOL isLanqiu;
+ (UIImage *)returnImageByType: (NSInteger)type;

- (void)LoadMacthInfo:(MacthEvent *)event Row:(NSInteger) row;

@end
