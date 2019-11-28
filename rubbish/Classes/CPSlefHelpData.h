//
//  CPSlefHelpData.h
//  caibo
//
//  Created by houchenguang on 14-5-6.
//
//

#import <Foundation/Foundation.h>

@interface CPSlefHelpData : NSObject{

    NSString * bgImageName;
    NSString * headImageName;
    NSString * labelName;
    NSString * lineName;
    BOOL imageHidder;
    NSString * headSelectedImage;
}
@property (nonatomic, retain)NSString * headImageName, * labelName, * bgImageName, *lineName,*headSelectedImage;

@property (nonatomic, assign)BOOL imageHidder;
@end
