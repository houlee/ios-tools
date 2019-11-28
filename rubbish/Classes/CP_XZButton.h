//
//  CP_XZButton.h
//  iphone_control
//
//  Created by zhang on 12/5/12.
//  Copyright (c) 2012 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CP_XZButton : UIButton{

    UILabel *buttonName;
    UIImageView *buttonImage;
}
@property (nonatomic,retain)UILabel *buttonName;
@property (nonatomic,retain)UIImageView *buttonImage;

@property (nonatomic, assign) BOOL iskuailepuke;

- (void)loadButtonName:(NSString *)labeName;

@end
