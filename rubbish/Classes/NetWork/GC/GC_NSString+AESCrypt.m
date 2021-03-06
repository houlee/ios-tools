//
//  NSString+AESCrypt.m
//
//  Created by Michael Sedlaczek, Gone Coding on 2011-02-22
//

#import "GC_NSString+AESCrypt.h"

@implementation NSString (GC_AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key
{
   NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
   NSData *encryptedData = [plainData AES256EncryptCaiPiao365WithKey:key];
   
   NSString *encryptedString = [encryptedData base64Encoding];

    
   return encryptedString;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input

{
    
    // Encode all the reserved characters, per RFC 3986
    
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    
    NSString *outputStr = (NSString *)
    
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            
                                            (CFStringRef)input,
                                            
                                            NULL,
                                            
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            
                                            kCFStringEncodingUTF8); 
    
    return [outputStr autorelease];
    
}
- (NSString *)AES256DecryptWithKey:(NSString *)key
{
   NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
   NSData *plainData = [encryptedData AES256DecryptCaiPiao365WithKey:key];
   
   NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
   
   return [plainString autorelease];
}

- (NSString*)encodeURL:(NSString *)string
{
	NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR("="), CFStringConvertNSStringEncodingToEncoding(self )) autorelease]);
	if (newString) {
		return newString;
	}
	return @"";
}


char * URLEncode(const char* str, const int strSize, char* result, const int resultSize) {
    int i;
    int j = 0; /* for result index */
    char ch;
    
    if ((str == NULL) || (result == NULL) || (strSize <= 0) || (resultSize <= 0)) {
        return 0;
    }
    
    for (i=0; (i<strSize) && (j<resultSize); i++) {
        ch = str[i];
        if ((ch >= 'A') && (ch <= 'Z')) {
            result[j++] = ch;
        } else if ((ch >= 'a') && (ch <= 'z')) {
            result[j++] = ch;
        } else if ((ch >= '0') && (ch <= '9')) {
            result[j++] = ch;
        } else if(ch == ' '){
            result[j++] = '+';
        } else {
            if (j + 3 < resultSize) {
//                sprintf(result+j, "%%%02X", (unsigned char)ch);
                NSLog(@"%%%02X", (unsigned char)ch);
                j += 3;
            } else { 
                return 0; 
            } 
        } 
    } 
    
    result[j] = '\0';
    NSLog(@"%s", result);
    return result;
}

- (NSString *)encodeStringchar{
    
    char a[100] = {0};
//    char b = [self UTF8String];
    const char * b =[self UTF8String];
    char * result = URLEncode(b, (int)[self length], a, 100);

    return [NSString stringWithCString:result encoding:NSUTF8StringEncoding];
    
}



@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    