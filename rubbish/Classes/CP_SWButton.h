//
//  CP_SWButton.h
//  iphone_control
//
//  Created by zhang on 12/5/12.
//  Copyright (c) 2012 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CP_SWButton : UIButton{

    UIImageView *buttonImage;
    
    NSString *onImageName;   //开
    NSString *offImageName;   //关
    
    BOOL on;
}

@property (nonatomic)BOOL on;
@property (nonatomic,retain)UIImageView *buttonImage;

@property (nonatomic, copy) NSString *onImageName;
@property (nonatomic, copy) NSString *offImageName;



@end
