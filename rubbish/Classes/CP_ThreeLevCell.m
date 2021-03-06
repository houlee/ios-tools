//
//  CP_ThreeLevCell.m
//  kongjiantabbat
//
//  Created by houchenguang on 12-12-3.
//
//

#import "CP_ThreeLevCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CP_ThreeLevCell
@synthesize titleLabel;
@synthesize headImage;
@synthesize delegate;
@synthesize row;
@synthesize line;

- (void)dealloc{
    [super dealloc];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(MenuType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        menuType = type;
        
        UIButton * zongButton = [UIButton buttonWithType:UIButtonTypeCustom];
        zongButton.frame = CGRectMake(0, 0, 150, 45);
        zongButton.tag = row;
        zongButton.backgroundColor = [UIColor clearColor];
        
        [zongButton addTarget:self action:@selector(pressZongButton:) forControlEvents:UIControlEventTouchUpInside];
		[zongButton addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
		[zongButton addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
		[zongButton addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
        
        zhezhaoimage = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, zongButton.frame.size.width - 5, zongButton.frame.size.height - 5)];
        zhezhaoimage.backgroundColor = [UIColor clearColor];
        [zongButton addSubview:zhezhaoimage];
        [zhezhaoimage release];
        
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 24, 24)];
        headImage.backgroundColor = [UIColor clearColor];
        [zongButton addSubview:headImage];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImage.frame.origin.x + headImage.frame.size.width + 10, 0, 90, zongButton.frame.size.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.tag = 10;
        [zongButton addSubview:titleLabel];
        [titleLabel release];
        [headImage release];
        
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(7.5, zongButton.frame.size.height - 1, zongButton.frame.size.width - 15, 1)];
        if (menuType == KuaiSanMenu) {
            line.backgroundColor = [UIColor colorWithRed:89/255.0 green:116/255.0 blue:129/255.0 alpha:1];
        }
        else if (menuType == PuKeMenu) {
            line.backgroundColor = [UIColor colorWithRed:54/255.0 green:65/255.0 blue:83/255.0 alpha:1];
        }
        else{
            line.backgroundColor = [UIColor colorWithRed:92/255.0 green:92/255.0 blue:92/255.0 alpha:1];
        }
        //        line.image = [UIImage imageNamed:@"HX960.png"];
        [zongButton addSubview:line];
        [line release];
        
        [self.contentView addSubview:zongButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;

}

- (void)threeLevelSelectIndex:(NSInteger)index{

    if ([delegate respondsToSelector:@selector(threeLevelSelectIndex:) ]){
        [delegate threeLevelSelectIndex:index];
    }
}
- (void)threeLevelSelectButton:(UIButton *)sender{
    if ([delegate respondsToSelector:@selector(threeLevelSelectButton:) ]){
        [delegate threeLevelSelectButton:sender];
    }
}

- (void)pressZongButton:(UIButton *)sender{
    titleLabel.textColor = [UIColor whiteColor];
    zhezhaoimage.backgroundColor = [UIColor clearColor];
    [self threeLevelSelectButton:sender];
    [self threeLevelSelectIndex:row];
    
}

- (void)TouchDown{
//    titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:138/255.0 blue:255/255.0 alpha:1];
    if (menuType == KuaiSanMenu) {
        zhezhaoimage.backgroundColor = [UIColor colorWithRed:73/255.0 green:103/255.0 blue:122/255.0 alpha:1];
    }
    else if (menuType == PuKeMenu) {
        zhezhaoimage.backgroundColor = [UIColor colorWithRed:54/255.0 green:65/255.0 blue:83/255.0 alpha:1];
    }
    else{
        zhezhaoimage.backgroundColor = [UIColor colorWithRed:39/255.0 green:39/255.0 blue:39/255.0 alpha:1];
    }
}
- (void)TouchCancel{
//    titleLabel.textColor = [UIColor whiteColor];
    zhezhaoimage.backgroundColor = [UIColor clearColor];
}
- (void)TouchDragExit{
//    titleLabel.textColor = [UIColor whiteColor];
   zhezhaoimage.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    