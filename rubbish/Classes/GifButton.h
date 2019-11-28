//
//  GifButton.h
//  caibo
//
//  Created by GongHe on 14-7-7.
//
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@class GifButton;

@protocol GifButtonDelegate <NSObject>

-(void)animationCompleted:(GifButton *)gifButton;

@end

@interface GifButton : UIButton
{
    CGImageSourceRef gif;
	NSDictionary *gifProperties;
    
    size_t index;
	size_t count;
    
    
    id delegate;
}

@property(nonatomic,assign)id <GifButtonDelegate> delegate;
@property(nonatomic,strong)UIView * gifView;

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath;

-(id)initTrashCanWithFrame:(CGRect)frame;

- (void)play;

@end
