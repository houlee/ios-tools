//
//  SearchInfo.h
//  LeTV.com
//
//  Created by QQ on 10-9-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface CustomMoviePlayerViewController : MPMoviePlayerViewController {

	//MPMoviePlayerController *mp;
	NSURL *movieURL;
	UIImageView *naView;
	UIView *mpbackView;
	BOOL isFull;
	BOOL canChange;
	UILabel *infoLable;
	UIImageView *loadingImage;
	NSString *content;
	UIImageView *BackimageView;
	UIImageView *introBack;
	UILabel *introLable;
}
  

- (id)initWithPath:(NSString *)movieurl;
@property (nonatomic,copy)NSString *content;

//@property (nonatomic,retain)MPMoviePlayerController *mp;

@end
