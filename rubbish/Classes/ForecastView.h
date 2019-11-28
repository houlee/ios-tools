//
//  ForecastView.h
//  caibo
//
//  Created by GongHe on 13-12-27.
//
//

#import <UIKit/UIKit.h>

enum{
    WhiteRed,
    Red,
    WhiteBlue,
    Blue
}displayColor;

@interface ForecastView : UIView

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array;

@end
