//
//  NSString+AESCrypt.h
//
//  Created by Michael Sedlaczek, Gone Coding on 2011-02-22
//

#import <Foundation/Foundation.h>
#import "GC_NSData+AESCrypt.h"
#define NON_NUM '0'

//char * Char2Num(char ch){
//    if(ch>='0' && ch<='9')return (char)(ch-'0');
//    if(ch>='a' && ch<='f')return (char)(ch-'a'+10);
//    if(ch>='A' && ch<='F')return (char)(ch-'A'+10);
//    return NON_NUM;
//}

@interface NSString (GC_AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;

- (NSString *)encodeStringchar;
- (NSString*)encodeURL:(NSString *)string;
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

@end