//
//  XWTool.m
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "XWTool.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTCellularData.h>

static const char base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2,  -1,  -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62,  -2,  -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2,  -2,  -2, -2, -2,
    -2, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2,  -2,  -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2
};

@implementation XWTool

#pragma mark - NSUserdefault 偏好设置

+(NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.8f;
    CGFloat maxCompression = 0.2f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    //    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return imageData;
}

// 将信息写入本地
+ (void)setObject:(id)object ForKey:(NSString *)key {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+ (id)getObjectForKey:(NSString *)key {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)removeAllNSUserdefaultObject {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

//将信息写入本地
+(void)setString:(NSString *)str WithTag:(NSString *)name{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:name];
    [defaults synchronize];
}

//从本地获取信息
+(NSString *)getString:(NSString *)name{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:name];
}

//删除对应关键字内容
+(void)deleteString:(NSString *)keyName{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"删除前的内容：%@",[defaults objectForKey:keyName]);
    [defaults removeObjectForKey:keyName];
    [defaults synchronize];
    
    NSLog(@"删除后：%@",[defaults objectForKey:keyName]);
}

#pragma mark - NSKeyedArchiver 归档

+ (void)archiveObject:(id)object ForKey:(NSString *)key {
    //获取文件路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.achiver",[key description]]];
    //NSLog(@"path=%@",path);
    
    //将数据保存到文件中
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}

+ (id)archiveObjectForKey:(NSString *)key {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.achiver",[key description]]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

#pragma mark - 清理url cookies

+ (void)clearCookiesForURL:(NSURL *)url {
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            //NSLog(@"cookie---->%@",cookie);
            //NSLog(@"cookieArray   before------>%@",cookies);
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            //NSLog(@"cookieArray   later ------>%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
        }
    }
}

+ (void)clearCookieWithCookieName:(NSString *)name ForURL:(NSURL *)url {
    if (url) {
        NSArray * cookArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        
        for (NSHTTPCookie *cookie in cookArray) {
            if ([cookie.name isEqualToString:name]) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            }
        }
    }
}

+ (void)removeCacheForURL:(NSURL *)url {
    if (url) {
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:[NSURLRequest requestWithURL:url]];
    }
}

+ (void)removeAllCachedResponses {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


#pragma mark - 正则判断条件

+ (BOOL)isStringLegal:(NSString *)string ByJudgeString:(NSString *)judgeString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeString];
    
    if ([predicate evaluateWithObject:string] == YES) {
        //implement
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - md5

+ (NSString *)md5String:(NSString *)sourceString {
    if(!sourceString){
        return nil;//判断sourceString如果为空则直接返回nil。
    }
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = sourceString.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    //遍历所有的result数组，取出所有的字符来拼接
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString  appendFormat:@"%02x",result[i]];
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }
    //打印最终需要的字符
    //NSLog(@"resultString----->%@",resultString);
    return resultString;
}

+ (NSString *)MD5String:(NSString *)sourceString {
    if(!sourceString){
        return nil;//判断sourceString如果为空则直接返回nil。
    }
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = sourceString.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    //遍历所有的result数组，取出所有的字符来拼接
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString  appendFormat:@"%02X",result[i]];
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }
    //打印最终需要的字符
    //NSLog(@"resultString----->%@",resultString);
    return resultString;
}

#pragma mark - base64

// 编码
+ (NSString *)base64EncodedStringWithData:(NSData *)data {
    NSUInteger length = data.length;
    if (length == 0)
        return @"";
    
    NSUInteger out_length = ((length + 2) / 3) * 4;
    uint8_t *output = malloc(((out_length + 2) / 3) * 4);
    if (output == NULL)
        return nil;
    
    const char *input = data.bytes;
    NSInteger i, value;
    for (i = 0; i < length; i += 3) {
        value = 0;
        for (NSInteger j = i; j < i + 3; j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = ((i + 1) < length)
        ? base64EncodingTable[(value >> 6) & 0x3F]
        : '=';
        output[index + 3] = ((i + 2) < length)
        ? base64EncodingTable[(value >> 0) & 0x3F]
        : '=';
    }
    
    NSString *base64 = [[NSString alloc] initWithBytes:output length:out_length encoding:NSASCIIStringEncoding];
    free(output);
    return base64;
}

+ (NSString *)base64EncodedStringWithString:(NSString *)str {
    NSData *data = [XWTool getDataFromString:str];
    return [XWTool base64EncodedStringWithData:data];
}

// 解码
+ (NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString {
    NSInteger length = base64EncodedString.length;
    const char *string = [base64EncodedString cStringUsingEncoding:NSASCIIStringEncoding];
    if (string  == NULL)
        return nil;
    
    while (length > 0 && string[length - 1] == '=')
        length--;
    
    NSInteger outputLength = length * 3 / 4;
    NSMutableData *data = [NSMutableData dataWithLength:outputLength];
    if (data == nil)
        return nil;
    if (length == 0)
        return data;
    
    uint8_t *output = data.mutableBytes;
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < length) {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < length ? string[inputPoint++] : 'A';
        char i3 = inputPoint < length ? string[inputPoint++] : 'A';
        
        output[outputPoint++] = (base64DecodingTable[i0] << 2)
        | (base64DecodingTable[i1] >> 4);
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((base64DecodingTable[i1] & 0xf) << 4)
            | (base64DecodingTable[i2] >> 2);
        }
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((base64DecodingTable[i2] & 0x3) << 6)
            | base64DecodingTable[i3];
        }
    }
    
    return data;
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [XWTool dataWithBase64EncodedString:base64EncodedString];
    return [XWTool getNTF8StringFromData:data];
}

+ (NSString *)getNTF8StringFromData:(NSData *)data {
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)getDataFromString:(NSString *)string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}


+ (NSDictionary *)urlEncodeWithParas:(NSDictionary *)params
{
    NSMutableDictionary *resultParas = [NSMutableDictionary dictionary];
    
    for (NSString *key in params.allKeys)
    {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSString class]])
        {
            NSString* stringValue = (NSString *)value;
            
            NSString* encodeString = [XWTool encodeString:stringValue];
            
            [resultParas setValue:encodeString forKeyPath:key];
        }
        else
        {
            [resultParas setValue:value forKey:key];
        }
    }
    
    return resultParas;
}

+(NSString *)encodeString:(NSString *)unencodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)unencodedString,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    
    return encodedString;
}

+ (NSString *)transformToJsonString:(id)object {
    
    BOOL isYes = [NSJSONSerialization isValidJSONObject:object];
    NSString *JsonDataStr;
    
    if (isYes) {
        //NSLog(@"可以转换");
        
        /* JSON data for obj, or nil if an internal error occurs. The resulting data is a encoded in UTF-8.
         */
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:NULL];
        
        /*
         Writes the bytes in the receiver to the file specified by a given path.
         YES if the operation succeeds, otherwise NO
         */
        // 将JSON数据写成文件
        // 文件添加后缀名: 告诉别人当前文件的类型.
        // 注意: AFN是通过文件类型来确定数据类型的!如果不添加类型,有可能识别不了! 自己最好添加文件类型.
        [jsonData writeToFile:[NSString stringWithFormat:@"/Users/%@.json",[object description]] atomically:YES];
        
        //NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        JsonDataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return JsonDataStr;
        
    } else {
        
        //NSLog(@"JSON数据生成失败，请检查数据格式");
        
    }
    return nil;
}

//将 &lt 等类似的字符转化为HTML中的“<”等
+ (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}


+(float)getRealPriceWithPrice:(float)price {
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",price];
    if ([priceStr floatValue]<price && price-priceStr.floatValue >= 0.005) {
        return [priceStr floatValue]+0.01;
    }
    if ([priceStr floatValue]>price && priceStr.floatValue-price >0.005) {
        return [priceStr floatValue]-0.01;
    }
    return [priceStr floatValue];
}

/** 根据图片二进制流获取图片格式 */
+ (NSString *)imageTypeWithData:(NSData *)data {
    uint8_t type;
    [data getBytes:&type length:1];
    switch (type) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            return nil;
    }
    return nil;
}

@end
