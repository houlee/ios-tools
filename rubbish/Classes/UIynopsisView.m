//
//  UIynopsisView.m
//  caibo
//
//  Created by houchenguang on 14-8-10.
//
//

#import "UIynopsisView.h"


@implementation UIynopsisView
@synthesize delegate;


- (void)dealloc{
    [dataDictionary release];
    [super dealloc];
}

- (NSDictionary *)dataDictionary{
    return dataDictionary;
}

- (void)setDataDictionary:(NSDictionary *)_dataDictionary{

    if (dataDictionary != _dataDictionary) {
        [dataDictionary release];
        dataDictionary = [_dataDictionary retain];
    }
    
//    if (_dataDictionary == nil || [_dataDictionary count] == 0) {
//        
//        return;
//    }
    
    
    
    
}


- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.dataDictionary = dict;
        
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
        
        
        if ([[dict objectForKey:@"code"] intValue] == 0) {
            
            UIImageView * zaiwuImage = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 178)/2, 20, 178, 15)];
            zaiwuImage.image = UIImageGetImageFromName(@"zanwubfyc.png");
            zaiwuImage.backgroundColor = [UIColor clearColor];
            [self addSubview:zaiwuImage];
            self.frame= CGRectMake(0, 0, 320, 100);
            return self ;
        }
        
        
        NSArray * conetitleArray = [NSArray arrayWithObjects:@"赛前简报", @"赛事简析", @"中足看点", @"关小刀预测", @"陆慧明预测", @"相关分析",  nil];
        
        self.userInteractionEnabled = YES;
        CGFloat hight = 0;
        
        for (int i = 0; i < 6; i++) {//内容
            
            
            
            
            UIImageView *  headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
            headImage.backgroundColor = [UIColor clearColor];
            [self addSubview:headImage];
            [headImage release];
            
            
            UIImageView * dianImage = [[UIImageView alloc] initWithFrame:CGRectMake(13, (headImage.frame.size.height - 3.5)/2.0f, 3.5, 3.5)];
            dianImage.backgroundColor = [UIColor clearColor];
            dianImage.image = UIImageGetImageFromName(@"jianjiedian.png");
            [headImage addSubview:dianImage];
            [dianImage release];
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            titleLabel.font = [UIFont systemFontOfSize:17];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:68/255.0 alpha:1];
            [headImage addSubview:titleLabel];
            [titleLabel release];
//            titleLabel.text = @"撒的房间里";

            UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
            lineImage.backgroundColor =  [UIColor colorWithRed:70/255.0 green:70/255.0 blue:68/255.0 alpha:1];
            [headImage addSubview:lineImage];
            [lineImage release];
            
            
            NSString * keyStr = @"0";
            if ( i == 0) {
                keyStr = @"sqjb";
            }else if (i == 1){
                keyStr = @"ssjx";
            }else if (i == 2){
                keyStr = @"zzkd";
            }else if (i == 3){
                keyStr = @"gxdyc";
            }else if (i == 4){
                keyStr = @"lhmyc";
            }
            

            
            if (i < 5) {//显示的内容
                NSLog(@"dd = %@  ddddd", [dict objectForKey:keyStr]);
                if ([dict objectForKey:keyStr] && [[dict objectForKey:keyStr] length] > 0 && ![[dict objectForKey:keyStr] isEqualToString:@""] && ![[dict objectForKey:keyStr] isEqualToString:@"(null)"] && ![[dict objectForKey:keyStr] isKindOfClass:[NSNull class]]) {
                    if (i == 0) {
                        headImage.frame = CGRectMake(0, 20, 320, 20);
                        hight = hight + (headImage.frame.size.height + 20);
                    }else{
                        if (hight == 0) {
                            headImage.frame = CGRectMake(0, 20, 320, 20);
                        }else{
                            headImage.frame = CGRectMake(0, hight, 320, 20);
                        }
                        
                        hight += headImage.frame.size.height;
                        
                    }
                    hight += 20;
                    titleLabel.text = [conetitleArray objectAtIndex:i];
                    CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(300, 20) lineBreakMode:NSLineBreakByWordWrapping];
                    titleLabel.frame = CGRectMake(20, 0, titleSize.width, 20);
                    lineImage.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 10, 280 - titleLabel.frame.size.width - 3, 0.5);
                    headImage.hidden = NO;
                }else{
                    if (i == 0) {
                        headImage.frame = CGRectMake(0, 20, 320, 0);
//                        hight = hight + (headImage.frame.size.height + 20);
                    }else{
                        if (hight == 0) {
                            headImage.frame = CGRectMake(0, 20, 320, 20);
                        }else{
                            headImage.frame = CGRectMake(0, hight, 320, 20);
                        }
//                        hight += headImage.frame.size.height;
                        
                    }
                    headImage.hidden = YES;
                }
                
                UILabel * contLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, hight, 280, 0)];
                contLabel.font = [UIFont systemFontOfSize:15];
                contLabel.backgroundColor = [UIColor clearColor];
                contLabel.lineBreakMode = NSLineBreakByWordWrapping;
                contLabel.numberOfLines = 0;
                contLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:68/255.0 alpha:1];
                [self addSubview:contLabel];
                [contLabel release];
                if ([[dict objectForKey:keyStr] length] > 0) {
                    contLabel.text = [dict objectForKey:keyStr];
                    CGSize contSize = [contLabel.text sizeWithFont:contLabel.font constrainedToSize:CGSizeMake(280, 10000) lineBreakMode:NSLineBreakByWordWrapping];
                    contLabel.frame = CGRectMake(20, hight, contSize.width, contSize.height);
                    
                    hight = hight + contLabel.frame.size.height + 42;
                }else{
                    contLabel.text = @"";
                }
                NSLog(@"hightdaaaaa = %f", hight);
                
            }else{//显示的超链接
                
                
                if ([[dict objectForKey:@"xgfxGuest"] count] > 0 || [[dict objectForKey:@"xgfxHost"] count] > 0) {
                    
                    NSLog(@"hightdd = %f", hight);
                    if (hight == 0) {
                        headImage.frame = CGRectMake(0, 20, 320, 20);
                        hight += 20;
                    }else{
                        headImage.frame = CGRectMake(0, hight, 320, 20);
                    }
                    hight += headImage.frame.size.height;
                    hight += 20;
                    titleLabel.text = [conetitleArray objectAtIndex:i];
                    CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(300, 20) lineBreakMode:NSLineBreakByWordWrapping];
                    titleLabel.frame = CGRectMake(20, 0, titleSize.width, 20);
                    lineImage.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 3, 10, 280 - titleLabel.frame.size.width - 3, 0.5);
                    headImage.hidden = NO;
                }else{
                    headImage.hidden = YES;
                }
                
                for (int i = 0; i < 2; i++){
                    
                    NSArray * xgfxArray = nil;
                    if (i == 0) {
                        xgfxArray = [dict objectForKey:@"xgfxHost"];
                    }else{
                        xgfxArray = [dict objectForKey:@"xgfxGuest"];
                    }
                    
                    for (int j = 0; j < [xgfxArray count]; j++) {
                        
                        NSDictionary * xgdict = [xgfxArray objectAtIndex:j];
                        
                        
                        NSString * urlString = [xgdict objectForKey:@"href"];
                        
                        NSString * msg = [xgdict objectForKey:@"title"];
                        
                        
                        ColorLabel *mLabel = [[[ColorLabel alloc] initWithText:[NSString stringWithFormat:@"<a href=\"%@\">%@</a>",urlString, msg]] autorelease ] ;
                        mLabel.userInteractionEnabled = YES;
                        mLabel.colorLabeldelegate = self;
                        mLabel.scrollView.scrollEnabled = NO;
                        [mLabel setMaxWidth:280];
                        mLabel.backgroundColor = [UIColor clearColor];
                        
                        CGSize mSize = [msg sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(280, 10000) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        mLabel.frame = CGRectMake(20, hight - 10, 280, mSize.height+10);
                        [self addSubview:mLabel];
                        
                        
                        hight += mLabel.frame.size.height;
                    }
                }
                
                
                
                


            
            }
            
           
            
            
            
            
            
            
            
            
        }
        
        self.frame = CGRectMake(0, 0, 320, hight+30);
        
        
        
        
    }
    return self;
}



- (void)clikeOrderIdURL:(NSURLRequest *)request1 {
    NSString *url = [NSString stringWithFormat:@"%@",[request1 URL]];

    NSLog(@"url = %@", url);
    
    
    if (delegate && [delegate respondsToSelector:@selector(clikeOrderIdURLReturnString:)]) {
        [delegate clikeOrderIdURLReturnString:url];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    