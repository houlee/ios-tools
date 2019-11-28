//
//  LotteryNewsCell.m
//  caibo
//
//  Created by yao on 11-12-6.
//  Copyright 2011 第一视频. All rights reserved.
//

#import "LotteryNewsCell.h"
#import "DetailedViewController.h"
#import "CommentViewController.h"
#import "caiboAppDelegate.h"
#import "NewPostViewController.h"
#import "ColorUtils.h"
#import "RegexKitLite.h"
#import "SharedMethod.h"
#import "SharedDefine.h"

@implementation LotteryNewsCell

@synthesize timeLabel;
@synthesize newsLabel;
@synthesize infoImage;
@synthesize mStatus;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, (WEIBO_YUCE_CELL_HEIGHT - 46)/2, 62, 46)];
        self.infoImage = imageV;
        self.infoImage.backgroundColor = [UIColor clearColor];
        [imageV release];
    
        UILabel *label = [[UILabel alloc] init];
		label.frame = CGRectMake(ORIGIN_X(imageV) + 12, imageV.frame.origin.y, 320 - ORIGIN_X(imageV) - 12 - 12, 14);
		label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
		label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = [SharedMethod getColorByHexString:@"1a1a1a"];
		self.newsLabel = label;
		[label release];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(label.frame.origin.x, ORIGIN_Y(label) + 5, label.frame.size.width, 30);
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = [SharedMethod getColorByHexString:@"9c9c9c"];
        label2.font = [UIFont systemFontOfSize:10];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.numberOfLines = 2;
        self.timeLabel = label2;
        [label2 release];
        
        [self.contentView addSubview:newsLabel];
        [self.contentView addSubview:timeLabel];
        [self.contentView addSubview:infoImage];
        
        xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, WEIBO_YUCE_CELL_HEIGHT - 0.5, 320, 0.5)];
        xian.backgroundColor = [SharedMethod getColorByHexString:@"dddddd"];
        [self.contentView addSubview:xian];
        [xian release];
        
#ifdef isCaiPiaoForIPad
        label.frame = CGRectMake(102, 5, 220+30, 20);
        label2.frame = CGRectMake(107, 20, 195+30, 36);
        imageV.frame = CGRectMake(15, 6, 62, 46);
//        plshu.frame = CGRectMake(230, 40, 40, 20);
        xian.frame = CGRectMake(10, 57, 370, 2);
#endif
        

//		self.backgroundColor = [UIColor colorWithRed:235/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}



-(NSString*)flattenPartHTML:(NSString*)html{
    
    // 去除换行
    NSString *mTmp = [NSString stringWithFormat:@"%c",'\n'];
    html = [html stringByReplacingOccurrencesOfString:mTmp withString:@""];
    
    NSString* regexString=@"<a(.+?)>|</a>";
    NSString *regexImg = @"(<img(.+?)/faces/)|(.gif\"/>)";
    html = [html stringByReplacingOccurrencesOfRegex:regexString withString:@""];
    
    NSInteger len = [html length];
    html = [html stringByReplacingOccurrencesOfRegex:regexImg withString:@"|"];
    //NSLog(@"html-->%@",html );
    NSInteger len2 =[html length];
    
    if(len != len2)
    {       
        NSArray* arr =  [html componentsSeparatedByString:@"|"];
        NSInteger count = [arr count];
        //NSLog(@"html-->%@",arr );
        if( arr  )
        {
			// NSInteger len  = [arr count];
            NSInteger tmp = 0 ;
            BOOL isDv = FALSE;
            BOOL isDiv = FALSE;
            //NSMutableString *faceappen = [[NSMutableString alloc] init];
            NSMutableString* faceappen = [NSMutableString string];
            for (NSString *pic in arr) 
            {
				
                if ( [pic length] !=0 )
                {
					
                    if( isDv )
                    {
                        [faceappen appendString:@"["];
						//pic=[pic faceTestChange];
                        [faceappen appendString:pic];
                        [faceappen appendString:@"]"];
                        isDv = FALSE;
                    }else
                    {
                        if( tmp == 0 )
                        {
                            [faceappen appendString:pic];
                        }else
                        {
                            if( tmp == count-1 || isDiv )
                            {
                                [faceappen appendString:pic];
                                isDiv = FALSE;
                            }
                            else
                            {
                                [faceappen appendString:@"["];
                                //								pic=[pic faceTestChange];
                                [faceappen appendString:pic];
                                [faceappen appendString:@"]"];
                                isDiv = TRUE;
                            }
                        }
                    }
					
                }else{
                    
                    isDiv = FALSE;
                }
                
                if( tmp == 0)
                {
                    isDv = TRUE;
                }else
                {
                    
                }
				
                tmp = tmp + 1;
				//[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", path, filename] error:nil];
            }
			//NSLog(@"pic->%@ ", faceappen );
			
			//         html = [faceappen retain];
			//         [faceappen release];
            return faceappen;
        }
        
        return html;
    }
    
	
	return html;
}


//- (void)LoadData:(YtTopic *)_data {
//	UIView *v = [self.contentView viewWithTag:10001];
//	[v removeFromSuperview];
//	mStatus = _data;
//	self.newsLabel.text = [self flattenPartHTML:mStatus.content];
//	if ([self.newsLabel.text length] >15) {
//		self.newsLabel.text = [self.newsLabel.text substringToIndex:15];
//	}
//	self.timeLabel.text = mStatus.timeformate;
//
//    
//    infoImage.image = UIImageGetImageFromName(@"ay_morentupian.png");
//    
//	
//    //infoImage.image = UIImageGetImageFromName(@"diyicai.png");
//	if ([mStatus.attach_small length]) {
//		UIImage *image1 = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : mStatus.attach_small Delegate:receiver Big:YES];
//		//[self.infoImage setImageWithURL:[NSURL URLWithString:mStatus.attach_small]];
//		self.infoImage.image = image1;
//	}
//	UIView *mBtnCon = [[[UIView alloc] initWithFrame:CGRectMake(70, 45, 250, 14)] autorelease];
//	mBtnCon.backgroundColor = [UIColor clearColor];
//	mBtnCon.userInteractionEnabled = NO;
//	UIButton *mForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	[mForwardBtn setAdjustsImageWhenHighlighted:YES];
//	UIButton *mCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	mBtnCon.tag = 10001;
//	[mForwardBtn setImage:UIImageGetImageFromName(@"replysmall.png") forState:(UIControlStateNormal)];
//	[mCommentBtn setImage:UIImageGetImageFromName(@"commentsmall.png") forState:(UIControlStateNormal)];
//	// 按钮标题和颜色
//	[mForwardBtn setTitle:mStatus.count_zf forState:(UIControlStateNormal)];
//	[mCommentBtn setTitle:mStatus.count_pl forState:(UIControlStateNormal)];
//	[mForwardBtn setTitleColor:[UIColor replyAndCommentInHomeCellColor] forState:(UIControlStateNormal)];
//	[mCommentBtn setTitleColor:[UIColor replyAndCommentInHomeCellColor] forState:(UIControlStateNormal)];
//	[[mForwardBtn titleLabel] setFont:[UIFont systemFontOfSize:12]];
//	[[mCommentBtn titleLabel] setFont:[UIFont systemFontOfSize:12]];
//	// 按钮图片和文字内间距
//	[mForwardBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 0))];
//	[mCommentBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 0))];
//	mForwardBtn.frame = CGRectMake(165, 0, 50, 20);
//	mCommentBtn.frame = CGRectMake(203, 1, 50, 20);
//	[mForwardBtn addTarget:self action:@selector(actionOrignalForward:) forControlEvents:(UIControlEventTouchUpInside)];
//	[mCommentBtn addTarget:self action:@selector(actionOrignalComment:) forControlEvents:(UIControlEventTouchUpInside)];
//	[mBtnCon addSubview:mForwardBtn];
//	[mBtnCon addSubview:mCommentBtn];
//	[self.contentView addSubview:mBtnCon];
//}


- (void)LoadData:(YtTopic *)_data {
	self.mStatus = _data;

    newsLabel.text = mStatus.newstitle;

    timeLabel.text = mStatus.content;

    infoImage.image = UIImageGetImageFromName(@"ay_morentupian.png");
	
	if ([mStatus.attach_small length]) {
        if (!receiver){
            receiver = [[ImageStoreReceiver alloc] init];
            receiver.imageContainer = self;
        }
		UIImage *image1 = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : mStatus.attach_small Delegate:receiver Big:YES];
		self.infoImage.image = image1;
	}
    
    
       
}



// 响应转发/评论
- (void) actionOrignalForward:(UIButton *)sender {
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    YtTopic *mOrignal = [[YtTopic alloc] init];
//    mOrignal.nick_name = mStatus.nick_name_ref;
//    mOrignal.content = mStatus.content_ref;
//    mOrignal.topicid = mStatus.orignal_id;
//    mOrignal.orignal_id = @"0";
//    publishController.mStatus = mOrignal;
//    publishController.publishType = kForwardTopicController;// 转发
//	[mOrignal release];
//	[publishController release];
}

// 评论
- (void) actionOrignalComment : (UIButton *) sender {
//    YtTopic *mOrignal = [[YtTopic alloc] init];
//    mOrignal.nick_name = mStatus.nick_name_ref;
//    mOrignal.content = mStatus.content_ref;
//    mOrignal.topicid = mStatus.orignal_id;
//    mOrignal.orignal_id = @"0";
//    CommentViewController *commentController = [[CommentViewController alloc] initWithMessage:mOrignal];
//    [[DetailedViewController getShareDetailedView].navigationController pushViewController:commentController animated:YES];
//    [mOrignal release];
//    [commentController release];
}

- (void)updateImage:(UIImage*)image1 {
	if (image1) {
		self.infoImage.image = image1;
	}
}

- (void)xianHidden {

    xian.hidden = YES;
}

- (void)dealloc {
//    [plshu release];
	self.newsLabel = nil;
	self.timeLabel = nil;
	self.infoImage = nil;
	receiver.imageContainer = nil;
	[[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:mStatus.attach_small];
    self.mStatus = nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    