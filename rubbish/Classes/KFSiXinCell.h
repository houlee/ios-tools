//
//  KFSiXinCell.h
//  caibo
//
//  Created by houchenguang on 12-11-22.
//
//

#import <UIKit/UIKit.h>
#import "MailList.h"
#import "DownLoadImageView.h"
#import "MWPhotoBrowser.h"
#import "CP_PTButton.h"

@protocol  KFSiXinCellDelegate<NSObject>

@optional

- (void)returnHiddeView;

- (void)returnHiddeViewDisappear;

@end

@interface KFSiXinCell : UITableViewCell<MWPhotoBrowserDelegate>{

    MailList * mailList;
    UIImageView * chatbgimage;
    UIImageView * timeImage;
    UILabel * dateLabel;
    UIImageView * bgchat;
    UILabel * contentLabel;
    id<KFSiXinCellDelegate>delegate;
    CP_PTButton * imageButton;
    UIView * returnview;
    
    DownLoadImageView *touxiangIma;
    UILabel * dateLabel2;
    UIImageView *imageButtonBG;
    
    DownLoadImageView *tupianIma;
    
}

@property(nonatomic, retain)MailList* mailList;
@property (nonatomic, assign)id<KFSiXinCellDelegate>delegate;
@property (nonatomic, retain)UIView * returnview;
- (void)returnHiddeView;
- (void)returnHiddeViewDisappear;

@end
