//
//  CPPhotoView.m
//  caibo
//
//  Created by houchenguang on 14-11-13.
//
//

#import "CPPhotoView.h"
#import "caiboAppDelegate.h"

@implementation CPPhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithUrl:(NSURL *)photoURL {

    if ((self = [super init])) {
       
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        self.frame = app.window.bounds;
        self.backgroundColor = [UIColor blackColor];
        
        myScrollerView=[[UIScrollView alloc]initWithFrame:self.bounds];
        myScrollerView.delegate=self;
        myScrollerView.minimumZoomScale=0.5f;
        myScrollerView.maximumZoomScale=2.0f;
        
        myImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        myImageView.backgroundColor = [UIColor clearColor];
        [myScrollerView addSubview:myImageView];
        [self addSubview:myScrollerView];
        
        
        NSString *url = [NSString stringWithFormat:@"%@",photoURL];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GIFImageURL" object:url];
        UIImage *image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : [NSString stringWithFormat:@"%@",photoURL] Delegate:self DefautImage:nil];
        if (!image) {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:photoURL];
            NSError *error = nil;
            NSURLResponse *response = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            [request release];
            if (data) {
               UIImage * img = [[UIImage alloc] initWithData:data];
                myImageView.image = img;
                [img release];
            } else {
                NSLog(@"Photo from URL error: %@", error);
            }
        }
        else {
            UIImage * img = [image retain];
            myImageView.image = img;
            [img release];
        }
        
    }
    return self;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (id view in [myScrollerView subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            return view;
        }
    }
    return  nil;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    