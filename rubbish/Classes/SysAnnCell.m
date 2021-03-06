//
//  SysAnnCell.m
//  caibo
//
//  Created by GongHe on 14-1-16.
//
//

#import "SysAnnCell.h"
#import "LotteryNewsCell.h"
#import "DetailedViewController.h"
#import "CommentViewController.h"
#import "caiboAppDelegate.h"
#import "NewPostViewController.h"
#import "ColorUtils.h"
#import "RegexKitLite.h"
@implementation SysAnnCell
@synthesize timeLabel;
@synthesize newsLabel;
@synthesize infoImage;
@synthesize mStatus;
@synthesize xian;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		UILabel *label = [[UILabel alloc] init];
		label.frame = CGRectMake(78.5, 7, 228, 14);
		label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
		label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
		self.newsLabel = label;
		[label release];
		
		UILabel *label2 = [[UILabel alloc] init];
		label2.frame = CGRectMake(78.5, 22, 228, 30);
		label2.backgroundColor = [UIColor clearColor];
		label2.textColor = [UIColor colorWithRed:132/255.0 green:130/255.0 blue:124/255.0 alpha:1];
		label2.font = [UIFont systemFontOfSize:10];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.numberOfLines = 2;
		self.timeLabel = label2;
		[label2 release];
		
		UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 6, 62, 46)];
		self.infoImage = imageV;
		self.infoImage.backgroundColor = [UIColor clearColor];
		[imageV release];
		[self.contentView addSubview:newsLabel];
		[self.contentView addSubview:timeLabel];
		[self.contentView addSubview:infoImage];
        
        xian = [[UIImageView alloc] initWithFrame:CGRectMake(10, 57, 300, 0.5)];
        xian.backgroundColor  = [UIColor clearColor];
        [self.contentView addSubview:xian];
        
		self.backgroundColor = [UIColor clearColor];
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
            }
            return faceappen;
        }
        
        return html;
    }
    
	
	return html;
}

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
		//[self.infoImage setImageWithURL:[NSURL URLWithString:mStatus.attach_small]];
		self.infoImage.image = image1;
	}
    
    
    
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
    [xian release];
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