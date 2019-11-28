//
//  ForecastData.h
//  caibo
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastData : NSObject{
    NSString * name;
    NSString * num;
    NSString * code;
}
@property (nonatomic, retain)NSString * code;
@property (nonatomic, retain)NSString * name;
@property (nonatomic, retain)NSString * num;
@end
