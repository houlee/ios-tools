//
//  DACircularProgressView.h
//  DACircularProgress
//
//  Created by Daniel Amitay on 2/6/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CircularProgressNormal,
    CircularProgressHorse,
}CircularProgressType;

@interface DACircularProgressView : UIView{
    UIImageView * imageviewd2;
    UIImageView * imageviewd;
    
    CircularProgressType circularProgressType;
}
@property (nonatomic, assign)CircularProgressType circularProgressType;

@property (nonatomic, retain)UIImageView * imageviewd2, * imageviewd;

@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, strong) UIColor *progressTintColor;
@property (nonatomic) float progress;

@end
