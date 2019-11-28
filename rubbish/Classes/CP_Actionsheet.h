//
//  CP_Actionsheet.h
//  caibo
//
//  Created by cp365dev on 14-5-20.
//
//

#import <UIKit/UIKit.h>

typedef enum{

    ordinaryActionsheetType,
    writeMicroblogActionsheetType,

} ActionsheetType;

@interface CP_Actionsheet : UIView
{
    UIView *grayView;
    ActionsheetType  showType;
    id delegate;
    
    
}
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign)ActionsheetType showType;

- (id)initWithType:(ActionsheetType)type Title:(NSString *)title delegate:(id)delegates cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end

@protocol CP_ActionsheetDelegate

- (void)CP_Actionsheet:(CP_Actionsheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;


@end