//
//  CNetWorking.h
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/17.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CNetWorking : NSObject


/**
 获取某个地点的天气    (知心天气)

 @param location 经纬度的拼接    (lat:lon)
 */
+ (void)loadWeatherWithLocation:(NSString *)location
                        success:(void (^)(id response))success
                        failure:(void (^)(NSError *err))failure;


/**
 获取某个地点未来几天的天气(阿里云)

 @param location location : 地名    (深圳)

 */
+ (void)loadComingDayWeatherWithLocation:(NSString *)location
                                 success:(void (^)(id response))success
                                 failure:(void (^)(NSError *err))failure;


/**
 获取QQ音乐排行榜数据

 @param topid topid : 排行榜id    (3=欧美 5=内地 6=港台 16=韩国 17=日本 18=民谣 19=摇滚 23=销量 26=热歌)

 */
+ (void)loadMusicRankWithTopid:(NSString *)topid
                       success:(void (^)(id response))success
                       failure:(void (^)(NSError *err))failure;



/**
 根据关键字搜索歌曲

 @param word 关键字
 @param page 第几页
 
 默认返回第一页数据，共有20条歌曲信息
 
 */
+ (void)loadMusicWithSearchWord:(NSString *)word
                           page:(NSString *)page
                        success:(void (^)(id response))success
                        failure:(void (^)(NSError *err))failure;



/**
 中文翻译成英文

 @param word 中文
 
 */
+ (void)translateWithChineseWord:(NSString *)word
                         success:(void (^)(id response))success
                         failure:(void (^)(NSError *err))failure;



/**
 智能问答

 @param question 问题
 @param success  成功回调
 @param failure  失败回调
 */
+ (void)intelligentRobotWithQuestion:(NSString *)question
                             success:(void (^)(id response))success
                             failure:(void (^)(NSError *err))failure;



/**
 加载新闻头条列表

 @param type    类型 top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)loadNewsWithType:(NSString *)type
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *err))failure;



/**
 生产彩色二维码

 @param qrdata      文本或网址
 @param size        二维码尺寸 300-1000 px 之间
 @param xt          0液态 1直角 2圆圈
 @param level       纠错级别 ，[ L、M、Q、H ]
 @param p_color     码眼的边框颜色 （有无 # 号都可以，下同）
 @param i_color     码眼的颜色
 @param back_color  背景色
 @param fore_color  前景色
 @param logo logo   图片远程地址，图片格式 [ jpg、png ]，建议大小不超过 50 KB
 @param wlogo       logo的宽度，如果为0将自动计算logo大小，适应二维码大小
 @param hlogo       logo的高度，如果为0将自动计算logo大小，适应二维码大小
 @param version     当前接口版本号，特殊情况下才会启用
 @param success     成功回调
 @param failure     失败回调
 */
+ (void)creatColorCodeWithQrdata:(NSString *)qrdata
                            size:(NSInteger )size
                              xt:(NSInteger )xt
                           level:(NSString *)level
                         p_color:(NSString *)p_color
                         i_color:(NSString *)i_color
                      back_color:(NSString *)back_color
                      fore_color:(NSString *)fore_color
                            logo:(NSString *)logo
                           wlogo:(NSInteger )wlogo
                           hlogo:(NSInteger )hlogo
                         version:(NSInteger )version
                         success:(void (^)(id response))success
                         failure:(void (^)(NSError *err))failure;





















@end
