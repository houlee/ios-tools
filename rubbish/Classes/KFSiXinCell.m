//
//  KFSiXinCell.m
//  caibo
//
//  Created by houchenguang on 12-11-22.
//
//

#import "KFSiXinCell.h"
#import "Info.h"

#import "caiboAppDelegate.h"


@implementation KFSiXinCell
@synthesize delegate;
@synthesize returnview;

- (void)setMailList:(MailList *)_mailList{

    if (mailList != _mailList) {
        [mailList release];
        mailList = [_mailList retain];
    }
     returnview.frame = self.bounds;
    
    NSString * str = _mailList.content;
    NSLog(@"str = %@", str);
    CGSize  size = CGSizeMake(136+60-15, 1000);
    UIFont * font = [UIFont systemFontOfSize:14];
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    if (![str length]) {
        labelSize = CGSizeMake(0, 0);
    }
    
    dateLabel.text = _mailList.date;
    NSLog(@"%@",_mailList.date);
    dateLabel2.text = _mailList.date;
    
    CGSize timesize1 = CGSizeMake(320, 11);
    UIFont * timefont = [UIFont systemFontOfSize:9];
    CGSize timeSize = [dateLabel.text sizeWithFont:timefont constrainedToSize:timesize1];
    
     NSLog(@"userid = %@",[[Info getInstance]userId]);
    
    if ([_mailList.senderId isEqualToString:[[Info getInstance]userId] ]) {
#ifdef isCaiPiaoForIPad
        chatbgimage.frame = CGRectMake(129+176, 0, 150, labelSize.height+12);
        bgchat.backgroundColor = [UIColor colorWithRed:194/255.0 green:237/255.0 blue:252/255.0 alpha:1];
        timeImage.frame = CGRectMake(129+176, chatbgimage.frame.size.height+3, 11, 11);
        dateLabel.frame = CGRectMake(10 + 5 + 3, chatbgimage.frame.size.height+5, 150, 11);
#else
        chatbgimage.frame = CGRectMake(290-labelSize.width+14-10, 0, labelSize.width+14, labelSize.height+12);
        if (![str length]) {
            chatbgimage.frame = CGRectMake(0, 0, 0, 0);
        }
        bgchat.backgroundColor=[UIColor clearColor];
        timeImage.frame = CGRectMake(129, chatbgimage.frame.size.height+3, 11, 11);
        dateLabel.frame = CGRectMake(chatbgimage.frame.origin.x-12-timeSize.width, chatbgimage.frame.size.height+5-15, timeSize.width, 9);
        dateLabel2.hidden = YES;
        imageButton.hidden = YES;
        
        if ([mailList.img_url length] > 0) {
            imageButton.frame = CGRectMake((150 - 65)/2+129+60, chatbgimage.frame.size.height+5+20, 65, 65);
            
            imageButtonBG.frame=CGRectMake(0, 0, 75, 90);
            imageButtonBG.image=[[UIImage imageNamed:@"yonghuqipao.png"] stretchableImageWithLeftCapWidth:40 topCapHeight:20];
            tupianIma.frame=CGRectMake(5, 5, 60, 80);
            [tupianIma setImageWithURL:mailList.img_url];
            
            timeImage.frame = CGRectMake(129, chatbgimage.frame.size.height+3+75, 11, 11);
            dateLabel.frame = CGRectMake(290-65-6-timeSize.width, chatbgimage.frame.size.height+5+75+25, timeSize.width, 11);
            if ([str length]) {
                dateLabel2.frame=CGRectMake(chatbgimage.frame.origin.x-12-timeSize.width, chatbgimage.frame.size.height+5-15, timeSize.width, 9);
                dateLabel2.hidden=NO;
            }
            else {
                dateLabel2.hidden = YES;
            }
            imageButton.hidden = NO;
        }
        //用户
        bgchat.frame = CGRectMake(7, 6, labelSize.width+14, labelSize.height+12);
        bgchat.image=[[UIImage imageNamed:@"yonghuqipao.png"] stretchableImageWithLeftCapWidth:60 topCapHeight:20];
        contentLabel.textColor=[UIColor whiteColor];
        contentLabel.frame = CGRectMake(7, 5, labelSize.width, labelSize.height);
        touxiangIma.frame=CGRectMake(0, 0, 0, 0);
        NSLog(@"img_url==%@",mailList.img_url);
#endif
        
        
    }else{
        chatbgimage.frame = CGRectMake(10+55, 0, labelSize.width+14, labelSize.height+12);
        bgchat.backgroundColor=[UIColor clearColor];
        timeImage.frame = CGRectMake(10, chatbgimage.frame.size.height+3, 11, 11);
        dateLabel.frame = CGRectMake(ORIGIN_X(chatbgimage)-timeSize.width, chatbgimage.frame.size.height+5, timeSize.width, 11);
        dateLabel2.hidden=YES;

         imageButton.hidden = YES;
        if ([mailList.img_url length]> 0) {
            imageButton.frame = CGRectMake((150 - 65)/2+10, chatbgimage.frame.size.height+5+20, 65, 65);
            
            imageButtonBG.frame=CGRectMake(0, 0, 75, 90);
            imageButtonBG.image=[[UIImage imageNamed:@"kefuqipao.png"] stretchableImageWithLeftCapWidth:40 topCapHeight:20];
            tupianIma.frame=CGRectMake(10, 5, 60, 80);
            [tupianIma setImageWithURL:mailList.img_url];
            dateLabel2.frame=CGRectMake(ORIGIN_X(chatbgimage)-timeSize.width, chatbgimage.frame.size.height+5, timeSize.width, 11);
            dateLabel2.hidden=NO;
            timeImage.frame = CGRectMake(129, chatbgimage.frame.size.height+3+75, 11, 11);
            dateLabel.frame = CGRectMake(10 + 5 + 3+60, chatbgimage.frame.size.height+5+75+25+15, 150, 11);
            imageButton.hidden = NO;
        }
        //客服
        bgchat.image=[[UIImage imageNamed:@"kefuqipao.png"] stretchableImageWithLeftCapWidth:60 topCapHeight:20];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.frame = CGRectMake(12, 5, labelSize.width, labelSize.height);
        touxiangIma.frame=CGRectMake(15, 0, 40, 40);
    }
   
    bgchat.frame = CGRectMake(-5, 0, chatbgimage.frame.size.width+5, chatbgimage.frame.size.height);
    
   
    
    
    contentLabel.font = font;
    contentLabel.text = str;
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    
    
    self.contentView.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];

}

- (MailList *)mailList{
    return mailList;
}

- (void)tableViewCell{

    chatbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    chatbgimage.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:chatbgimage];

    
    bgchat = [[UIImageView alloc] initWithFrame:chatbgimage.bounds];
    bgchat.backgroundColor = [UIColor clearColor];
    [chatbgimage addSubview:bgchat];
    
    
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [bgchat addSubview:contentLabel];
    
    touxiangIma=[[DownLoadImageView alloc]init];
    touxiangIma.backgroundColor=[UIColor clearColor];
    touxiangIma.image=[UIImage imageNamed:@"kefutouxiang.png"];
    [self.contentView addSubview:touxiangIma];
    
    
    timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
    timeImage.backgroundColor = [UIColor clearColor];
    [self.contentView  addSubview:timeImage];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor colorWithRed:149/255.0 green:147/255.0 blue:147/255.0 alpha:1];
    dateLabel.font = [UIFont systemFontOfSize:9];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:dateLabel];
    
    dateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    dateLabel2.backgroundColor = [UIColor clearColor];
    dateLabel2.textColor = [UIColor colorWithRed:149/255.0 green:147/255.0 blue:147/255.0 alpha:1];
    dateLabel2.font = [UIFont systemFontOfSize:9];
    dateLabel2.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:dateLabel2];

    imageButton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(0,0, 0, 0);
    imageButton.hidden = YES;
    [imageButton addTarget:self action:@selector(pressImageButton:) forControlEvents:UIControlEventTouchUpInside];
    imageButton.backgroundColor=[UIColor clearColor];
    [self.contentView  addSubview:imageButton];
    
    imageButtonBG=[[UIImageView alloc]init];
    imageButtonBG.frame=CGRectMake(0, 0, 0, 0);
    imageButtonBG.backgroundColor=[UIColor clearColor];
    [imageButton addSubview:imageButtonBG];
    
    tupianIma=[[DownLoadImageView alloc]init];
    tupianIma.frame=CGRectMake(0, 0, 0, 0);
    tupianIma.layer.masksToBounds=YES;
    tupianIma.layer.cornerRadius=5;
    tupianIma.backgroundColor=[UIColor clearColor];
    [imageButtonBG addSubview:tupianIma];
    
    
}

- (void)pressImageButton:(UIButton *)sender{
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:mailList.img_url]]];
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    photoBrowser.delegate = self;
    photoBrowser.kefubool = YES;
    [photoBrowser setPhotoType : kTypeWithURL];
    [photos release];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] >= 6) {
#ifdef isCaiPiaoForIPad
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
        
#else

        navController.navigationBar.backgroundColor=[UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
        
#endif

    }
    
    navController.navigationBarHidden = NO;
    [photoBrowser release];
    if (navController) {
        
        caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
        [(UINavigationController *)caiboapp.window.rootViewController presentViewController:navController animated: YES completion:nil];

        [self returnHiddeViewDisappear];

    }
    [navController release];


    
}

- (void)returnHiddeViewDisappear{

    if ([delegate respondsToSelector:@selector(returnHiddeViewDisappear)]) {
        [delegate returnHiddeViewDisappear];
    }
}

- (void)returnHiddeView{

    if ([delegate respondsToSelector:@selector(returnHiddeView)]) {
        [delegate returnHiddeView];
    }
    
}

- (void)returnMWPhotoBrowserDelegate{
   
    [self returnHiddeView];
    
}

- (void)dealloc{
    [dateLabel2 release];
    [contentLabel release];
    [bgchat release];
    [chatbgimage release];
    [dateLabel release];
    [timeImage release];
    
    [touxiangIma release];
    [tupianIma release];
    [imageButtonBG release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor  clearColor];
//        [self.contentView addSubview:[self tableViewCell]];
        [self   tableViewCell];
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
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