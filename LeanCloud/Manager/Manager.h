//
//  Manager.h
//  LeanCloud
//
//  Created by ilovedxracer on 2018/9/14.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject
//声明单例方法
+ (Manager *)sharedManager;

//MD5加密
+ (NSString *)md5:(NSString *)str;
//存数据
+ (void)writewenjianming:(NSString *)wenjianming content:(NSString *)content;
//取数据
+ (NSString *)redingwenjianming:(NSString *)wenjianming;
+ (void)remove:(NSString *)paths;
//为空判断
+ (BOOL)judgeWhetherIsEmptyAnyObject:(id)object;
+ (NSString*)iphoneType;

+ (CGFloat)getHeighWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font ;

//获取字符串的宽度
+(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;

//获得字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
@end







