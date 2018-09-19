//
//  Manager.m
//  LeanCloud
//
//  Created by ilovedxracer on 2018/9/14.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "Manager.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
static Manager *manager = nil;

@implementation Manager


+ (Manager *)sharedManager {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[Manager alloc] init];
    });
    return manager;
}


//MD5加密
+ (NSString *)md5:(NSString *)str
{
    if (str == nil) {
        return nil;
    }else{
        const char *cStr = [str UTF8String];
        unsigned char result[16];
        CC_MD5(cStr, strlen(cStr), result);
        return [NSString stringWithFormat:
                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ];
    }
}
//存数据
+ (void)writewenjianming:(NSString *)wenjianming content:(NSString *)content {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:wenjianming];
    NSString *str = content;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
//取数据
+ (NSString *)redingwenjianming:(NSString *)wenjianming {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:wenjianming];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return str;
}

+ (void)remove:(NSString *)paths{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:paths];
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
}



//为空判断
+ (BOOL)judgeWhetherIsEmptyAnyObject:(id)object {
    
    if(object == nil)
    {
        return NO;
    }
    
    if([object isKindOfClass:[NSDictionary class]])
    {
        
    }
    else if([object isKindOfClass:[NSArray class]])
    {
        
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        if([(NSString *)object isEqualToString:@""])
            return NO;
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        return NO;
    }
    else if ([object isKindOfClass:[NSSet class]])
    {
        
    }
    else if((NSNull *)object == [NSNull null])
    {
        return NO;
    }
    else if ([object isEqualToString:@"<null>"])
    {
        return NO;
    }
    
    return YES;
}


//获取设备类型
+ (NSString*)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])
        return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])
        return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])
        return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])
        return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])
        return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])
        return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])
        return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])
        return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])
        return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])
        return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])
        return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])
        return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])
        return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])
        return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])
        return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])
        return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])
        return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"])
        return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"])
        return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"])
        return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"])
        return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"])
        return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"])
        return@"iPhone X";
    
    if([platform isEqualToString:@"i386"])
        return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])
        return@"iPhone Simulator";
    
    return platform;
    
}
+ (CGFloat)getHeighWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:8];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}

//获取字符串的宽度
+(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    
    return sizeToFit.width;
    
}

//获得字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
@end
