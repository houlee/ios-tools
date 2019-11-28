//
//  listYtThemeGz.h
//  caibo
//
//  Created by jacob on 11-6-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ListYtThemeGz : NSObject 
{
	NSMutableArray *arryList;
	NSString *result;
	NSString *msg;
    
    NSString *themeId;
    NSString *name;
}

@property (nonatomic, retain) NSMutableArray *arryList;
@property (nonatomic, retain) NSString *result;
@property (nonatomic, retain) NSString *msg;
@property (nonatomic, retain) NSString *themeId;
@property (nonatomic, retain) NSString *name;


- (id)initWithParse:(NSString*)responseString;
- (id)paserWithDictionary:(NSDictionary*)dic;

@end
