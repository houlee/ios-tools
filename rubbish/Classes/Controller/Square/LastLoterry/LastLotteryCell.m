//
//  LastLotteryCell.m
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LastLotteryCell.h"
#import "ImageDownloader.h"
#import "Info.h"
#import "caiboAppDelegate.h"

@implementation LastLotteryCell
@synthesize headImageBtn,name,issue,ballsView,receiver;
@synthesize labaimage;
@synthesize xuanzhebut;
@synthesize songbool;
@synthesize row;
@synthesize buttxuan;
@synthesize delegate;
@synthesize tuisongtongzhi;
@synthesize bgmonery;
@synthesize dilabel;
@synthesize qilabel;
@synthesize cellbgimage;
@synthesize caiimage;
@synthesize difangLab;
@synthesize guanfangIma,tryLab;

// 图片下载完成后回调更新图片
- (void)updateImage:(UIImage*)image 
{
    [self.headImageBtn setImage:image forState:UIControlStateNormal];
}
- (KJButtdata *)buttdata{
    return buttdata;
}

- (void)setButtdata:(KJButtdata *)_buttdata{
    if (_buttdata.yincang) {
        buttxuan.hidden = NO;
    }else{
        buttxuan.hidden = YES;
    }
    
    
    
    
}


- (kjButtCellTuiSong *)tuisongtongzhi{
    return tuisongtongzhi;
}

- (void)setTuisongtongzhi:(kjButtCellTuiSong *)_tuisongtongzhi{
    dangqianzhuangtai = _tuisongtongzhi.tuisongshezhi;
  
    
    
    
    if (dangqianzhuangtai) {
        if (_tuisongtongzhi.tuisongxuan) {
            [buttxuan setImage:UIImageGetImageFromName(@"login_right.png") forState:UIControlStateNormal];
             buttxuan.tag = 1;
        }else{
           
            [buttxuan setImage:nil forState:UIControlStateNormal];
             
        }
//        labaimage.image = UIImageGetImageFromName(@"gc_notice_0.png");
        labaimage.image = UIImageGetImageFromName(@"labalan.png");
        labaimage.backgroundColor = [UIColor clearColor];
       
    }else{
      
        if (_tuisongtongzhi.tuisongxuan) {
            [buttxuan setImage:UIImageGetImageFromName(@"login_right_0.png") forState:UIControlStateNormal];
            buttxuan.tag = 0;
        }else{
            [buttxuan setImage:nil forState:UIControlStateNormal];
           
        }
        
     //   [buttxuan setImage:UIImageGetImageFromName(@"") forState:UIControlStateNormal];
//        labaimage.image = UIImageGetImageFromName(@"gc_notice_04.png");
//        labaimage.image = UIImageGetImageFromName(@"labahui.png");
        labaimage.image=[UIImage imageNamed:@""];
        labaimage.backgroundColor = [UIColor clearColor];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        xuanzhebut = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 40, 50)];
      
            xuanzhebut.hidden = YES;
        xuanzhebut.backgroundColor = [UIColor yellowColor];
        
        
//        UIImageView *lineIma=[[UIImageView alloc]initWithFrame:CGRectMake(15, 61.5, 320, 0.5)];
//        lineIma.image=[UIImage imageNamed:@"SZTG960.png"];
//        [self addSubview:lineIma];
//        [lineIma release];
        
        
        [self.contentView addSubview:xuanzhebut];
        
    }
    return self;
}
- (IBAction)pressbuttonxuan:(UIButton *)sender{
    
    if (sender.tag == 0) {
        sender.tag = 1;
        queding = YES;
        [buttxuan setImage:UIImageGetImageFromName(@"login_right.png") forState:UIControlStateNormal];
    }else {
        sender.tag = 0;
        queding = NO;
        [buttxuan setImage:UIImageGetImageFromName(@"login_right_0.png") forState:UIControlStateNormal];
    }
    
    [self returncellrownum:row quedingbool:queding];
}

- (void)returncellrownum:(NSInteger)num quedingbool:(BOOL)quebool{
    if ([delegate respondsToSelector:@selector(returncellrownum:quedingbool:)]) {
        [delegate returncellrownum:num quedingbool:quebool];
    }
}

- (void)setImageUrl:(NSString*)url
{	
	if (!receiver) {
		receiver = [[ImageStoreReceiver alloc] init];
	}
    if (imageUrl != url) {
        [imageUrl release];
    }
    imageUrl = [url copy];
    
    UIImage *headImage = [[caiboAppDelegate getAppDelegate].imageDownloader  fetchImage:imageUrl Delegate:receiver Big:NO];
    [self.headImageBtn setImage:headImage forState:UIControlStateNormal];
    receiver.imageContainer = self; // 保存该接收器回调更新图片
}

-(void)dealloc{
    [caiimage release];
    [cellbgimage release];
    [dilabel release];
    [qilabel release];
    [bgmonery release];
    [xuanzhebut release];
    [labaimage release];
	receiver.imageContainer = nil;
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:imageUrl];
    [imageUrl release];
    [receiver release];
	[headImageBtn release];
	[name release];
	[issue release];
	[ballsView release];
    
    [difangLab release];
    [guanfangIma release];
    
	[super dealloc];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
    if(highlighted){
        
        cellbgimage.image = UIImageGetImageFromName(@"goucaiHighLighted_cellbg.png");
    }
    else{
        
        cellbgimage.image = UIImageGetImageFromName(@"goucai_cellbg.png");
        
    }
}

-(void)awakeFromNib
{
    UIImageView *lineIma=[[UIImageView alloc]initWithFrame:CGRectMake(15, 92.5, 320, 0.5)];
//    lineIma.image=[UIImage imageNamed:@"SZTG960.png"];
    lineIma.tag=123;
    [self addSubview:lineIma];
    [lineIma release];
    
    cellbgimage.image=[UIImage imageNamed:@"goucai_cellbg.png"];
    
    difangLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    difangLab.backgroundColor=[UIColor clearColor];
    difangLab.font=[UIFont systemFontOfSize:12];
//    difangLab.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:difangLab];
    
    guanfangIma=[[UIImageView alloc]init];
    guanfangIma.frame=CGRectMake(20, 45, 84, 26);
    guanfangIma.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:guanfangIma];
    
    tryLab=[[UILabel alloc]init];
    tryLab.backgroundColor=[UIColor clearColor];
    tryLab.textColor=[UIColor colorWithRed:89/255.0 green:88/255.0 blue:88/255.0 alpha:1];
    tryLab.frame=CGRectMake(0, 0, 0, 0);
    tryLab.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:tryLab];
    
    name.frame=CGRectMake(15+5, 10, 100, 20);
    name.backgroundColor=[UIColor clearColor];
    labaimage.frame=CGRectMake(280, 20, 10, 12);
//    ballsView.frame=CGRectMake(15, 30, 320, 30);
    ballsView.backgroundColor=[UIColor clearColor];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    