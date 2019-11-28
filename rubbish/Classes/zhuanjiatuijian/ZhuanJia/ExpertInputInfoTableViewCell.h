//
//  ExpertInputInfoTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import <UIKit/UIKit.h>

typedef void(^TextFieldEndEdit)(NSString *text);

@interface ExpertInputInfoTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
{
    CGSize size;
}
@property (nonatomic, strong) UILabel *leftLab;//
@property (nonatomic, strong) UITextField *mesText;//
@property (nonatomic, strong) UIImageView *lineIma;

@property (nonatomic, copy) TextFieldEndEdit textDidEndEditing;

-(void)loadAppointInfo:(NSDictionary *)dict;
@end
