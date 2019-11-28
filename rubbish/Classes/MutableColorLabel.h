//
//  MutableColorLable.h
//  Walker
//
//  Created by yao on 11-5-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MutableDelegate
- (void)touchLabel:(UILabel *)lable;
@end

@interface MutableColorLabel : UILabel {
	BOOL type; //是否变色开始
	id<MutableDelegate> delegate;
	UIColor *myColor;
}

@property (nonatomic)BOOL type;
@property (nonatomic, assign)id<MutableDelegate> delegate;
@property (nonatomic,retain)UIColor *myColor;

- (void)setSubColor:(UIColor *)color;// 字符串内部变色
@end

