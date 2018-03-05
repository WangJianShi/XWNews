//
//  XWTool.h
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XWTool : NSObject


+(NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
#pragma mark - NSUserdefault 存储

+(void)setString:(NSString *)str WithTag:(NSString *)name;//将信息写入本地

+(NSString *)getString:(NSString *)name;//从本地获取信息

+(void)deleteString:(NSString *)keyName;//删除对应关键字内容

/**
 *  写入本地
 *
 *  @param object object
 *  @param key key
 */
+ (void)setObject:(id)object ForKey:(NSString *)key;

/**
 *  取出信息
 *
 *  @param key key
 *
 *  @return id
 */
+ (id)getObjectForKey:(NSString *)key;

/**
 *  清空Userdefault
 */
+ (void)removeAllNSUserdefaultObject;

#pragma mark - NSKeyedArchiver 归档

/**
 *  存储数据
 *
 *  @param object object
 *  @param key    key
 */
+ (void)archiveObject:(id)object ForKey:(NSString *)key;

/**
 *  取出数据
 *
 *  @param key key
 *
 *  @return id
 */
+ (id)archiveObjectForKey:(NSString *)key;

#pragma mark - 清理url cookies

/**
 *  清除某个url的所有cookies
 *
 *  @param url url
 */
+ (void)clearCookiesForURL:(NSURL *)url;

/**
 *  清除某个url的某个cookie
 *
 *  @param name name
 *  @param url  url
 */
+ (void)clearCookieWithCookieName:(NSString *)name ForURL:(NSURL *)url;

/**
 *  清理某个url缓存
 *
 *  @param url url
 */
+ (void)removeCacheForURL:(NSURL *)url;

/**
 *  清空所有缓存
 */
+ (void)removeAllCachedResponses;

#pragma mark - MD5加密

/**
 *  MD5加密（小写）
 *
 *  @param sourceString sourceString
 *
 *  @return string
 */
+ (NSString *)md5String:(NSString *)sourceString;

/**
 *  MD5加密（大写）
 *
 *  @param sourceString sourceString description
 *
 *  @return return value description
 */
+ (NSString *)MD5String:(NSString *)sourceString;

#pragma mark - base64 编码

/**
 *  base64编码data
 *
 *  @param data data description
 *
 *  @return return value description
 */
+ (NSString *)base64EncodedStringWithData:(NSData *)data;

/**
 *  base64编码string
 *
 *  @param str str description
 *
 *  @return return value description
 */
+ (NSString *)base64EncodedStringWithString:(NSString *)str;

#pragma mark - base64 解码

/**
 *  base64解码data
 *
 *  @param base64EncodedString base64EncodedString description
 *
 *  @return return value description
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 *  base64解码string
 *
 *  @param base64EncodedString base64EncodedString description
 *
 *  @return return value description
 */
+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 *  转换成jsonstring
 *
 *  @param object object description
 *
 *  @return return value description
 */
+ (NSString *)transformToJsonString:(id)object;

+ (NSDictionary *)urlEncodeWithParas:(NSDictionary *)params;

+(NSString *)encodeString:(NSString *)unencodedString;


#pragma mark - 正则表达式判断

/**
 *  正则表达式判断
 *
 *  @param string      string
 *  @param judgeString 正则表达式
 *
 *  @return BOOL
 */
+ (BOOL)isStringLegal:(NSString *)string
        ByJudgeString:(NSString *)judgeString;

/*
 1.验证用户名和密码：                                         ”^[a-zA-Z]\w{5,15}$”
 
 　　2.验证电话号码：                                            ”^(\\d{3,4}-)\\d{7,8}$”     //eg：021-68686868  0511-6868686；
 
 　　3.验证手机号码：                                            ”^1[3|4|5|7|8][0-9]\\d{8}$”；
 
 　　4.验证身份证号（15位或18位数字）：                             ”\\d{14}[[0-9],0-9xX]”；
 
 　　5.验证Email地址：                                           “^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\.\\w+([-.]\\w+)*$”
 
 　　6.只能输入由数字和26个英文字母组成的字符串：
 
 “^[A-Za-z0-9]+$”
 
 　　7.整数或者小数：                                             “^[0-9]+([.]{0,1}[0-9]+){0,1}$”
 
 　　8.只能输入数字：                                             ”^[0-9]*$”。
 
 　　9.只能输入n位的数字：                                        ”^\\d{n}$”。
 
 　　10.只能输入至少n位的数字：                                    ”^\\d{n,}$”。
 
 　　11.只能输入m~n位的数字：                                     ”^\\d{m,n}$”。
 
 　　12.只能输入零和非零开头的数字：                                ”^(0|[1-9][0-9]*)$”。
 
 　　13.只能输入有两位小数的正实数：                                ”^[0-9]+(.[0-9]{2})?$”。
 
 　　14.只能输入有1~3位小数的正实数：                               ”^[0-9]+(\.[0-9]{1,3})?$”。
 
 　　15.只能输入非零的正整数：                                     ”^\+?[1-9][0-9]*$”。
 
 　　16.只能输入非零的负整数：                                     ”^\-[1-9][]0-9″*$。
 
 　　17.只能输入长度为3的字符：                                    ”^.{3}$”。
 
 　　18.只能输入由26个英文字母组成的字符串：                         ”^[A-Za-z]+$”。
 
 　　19.只能输入由26个大写英文字母组成的字符串：                      ”^[A-Z]+$”。
 
 　　20.只能输入由26个小写英文字母组成的字符串：                      ”^[a-z]+$”。
 
 　　21.验证是否含有^%&’,;=?$\”等字符：                            ”[^%&',;=?$\x22]+”。
 
 　　22.只能输入汉字：                                            ”^[\u4e00-\u9fa5]{0,}$”。
 
 　　23.验证URL：                                               ”^http://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$”。
 
 　　24.验证一年的12个月：                                        ”^(0?[1-9]|1[0-2])$”正确格式为：”01″～”09″和”10″～”12″。
 
 　　25.验证一个月的31天：                                        ”^((0?[1-9])|((1|2)[0-9])|30|31)$”
 
 //正确格式为；”01″～”09″、”10″～”29″和“30”~“31”。
 
 　　26.获取日期正则表达式：                                       \\d{4}[年|\-|\.]\\d{\1-\12}[月|\-|\.]\\d{\1-\31}日?
 
 　　                                              评注：可用来匹配大多数年月日信息。
 
 　　27.匹配双字节字符(包括汉字在内)：                               [^\x00-\xff]
 
 　　                                              评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
 
 　　28.匹配空白行的正则表达式：                                    \n\s*\r
 
 　　                                              评注：可以用来删除空白行
 
 　　29.匹配HTML标记的正则表达式：                                  <(\S*?)[^>]*>.*?</>|<.*? />
 
 　　                                              评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力
 
 　　30.匹配首尾空白字符的正则表达式：                                ^\s*|\s*$
 
 　　                                              评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
 
 　　31.匹配网址URL的正则表达式：                                   [a-zA-z]+://[^\s]*
 
 　　                                              评注：网上流传的版本功能很有限，上面这个基本可以满足需求
 
 　　32.匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：    ^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 
 　　                                              评注：表单验证时很实用
 
 　　33.匹配腾讯QQ号：                                             [1-9][0-9]\{4,\}
 
 　　                                              评注：腾讯QQ号从10 000 开始
 
 　　34.匹配中国邮政编码：                                          [1-9]\\d{5}(?!\d)
 
 　　                                              评注：中国邮政编码为6位数字
 
 　　35.匹配ip地址：                                ((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)。
 
 36.匹配空格:                                                ^(\\s|\\n|\\r)*$
 
 评注：可以监测当前字符串是否为纯空格或为空
 
 */


//将 &lt 等类似的字符转化为HTML中的“<”等
+ (NSString *)htmlEntityDecode:(NSString *)string;

+(float)getRealPriceWithPrice:(float)price;

+(NSString *)imageTypeWithData:(NSData *)data;


@end
