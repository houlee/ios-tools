//
//  FootballHintView.h
//  caibo
//
//  Created by houchenguang on 14-10-13.
//
//

#import <UIKit/UIKit.h>

typedef enum{

    oneShowType,
    betShowType,
    danShowType,

} ShowType;

@interface FootballHintView : UIView

- (void)show;
- (id)initType:(ShowType)type;

@end
