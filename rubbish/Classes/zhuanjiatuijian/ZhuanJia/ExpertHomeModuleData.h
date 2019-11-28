//
//  ExpertHomeModuleData.h
//  caibo
//
//  Created by GongHe on 16/8/14.
//
//

#import <Foundation/Foundation.h>

@interface ExpertHomeModuleData : NSObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * explain;
@property (nonatomic, retain) NSString * imgUrl;
@property (nonatomic, retain) NSString * linkUrl;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, assign) CGSize explainSize;
@property (nonatomic, retain) NSAttributedString * limitTitle;

@end
