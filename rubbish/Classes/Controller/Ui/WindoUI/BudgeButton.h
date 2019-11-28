//
//  BudgeButton.h
//  caibo
//
//  Created by jacob on 11-8-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**
 *自定义 budgevalue button
 *
 *用于广场和 粉丝 提醒
 **/

#import <UIKit/UIKit.h>


@interface BudgeButton : UIButton {
	
	
	NSString *budegeValue;
	
	CGFloat textWith;

}

@property(nonatomic,retain)NSString *budegeValue;

-(CGRect)budegeBounds;

@end
