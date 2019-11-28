//
//  UIynopsisView.h
//  caibo
//
//  Created by houchenguang on 14-8-10.
//
//

#import <UIKit/UIKit.h>
#import "ColorLabel.h"
@protocol UIynopsisViewDelegate <NSObject>

@optional
- (void)clikeOrderIdURLReturnString:(NSString *)strUrl;
@end

@interface UIynopsisView : UIView <ColorLabelDelegate>{
    
    id<UIynopsisViewDelegate>delegate;
    NSDictionary * dataDictionary;
}

@property (nonatomic, assign)id<UIynopsisViewDelegate>delegate;
@property (nonatomic, retain)NSDictionary * dataDictionary;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
