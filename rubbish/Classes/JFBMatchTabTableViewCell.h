//
//  JFBMatchTabTableViewCell.h
//  caibo
//
//  Created by houchenguang on 14-5-26.
//
//

#import <UIKit/UIKit.h>

@interface JFBMatchTabTableViewCell : UITableViewCell{
    
    NSDictionary * dataDictionary;
    NSIndexPath * jfIndexPath;
    NSString * interalString;
    NSInteger cellType;
}

@property (nonatomic, retain)NSDictionary * dataDictionary;
@property (nonatomic, retain)NSIndexPath * jfIndexPath;
@property (nonatomic, retain)NSString * interalString;
@property (nonatomic, assign)NSInteger cellType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type;

@end
