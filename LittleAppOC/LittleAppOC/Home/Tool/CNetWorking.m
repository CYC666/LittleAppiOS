//
//  CNetWorking.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/17.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CNetWorking.h"
#import "AFNetworking.h"



#define APPCODE @"0c9b5b03701a473c833deaeef4ca46d5"     // 阿里云appcode

@implementation CNetWorking

+ (void)loadWeatherWithLocation:(NSString *)location
                        success:(void (^)(id response))success
                        failure:(void (^)(NSError *err))failure{

    // 知心天气
    NSString *urlStr = [NSString stringWithFormat:@"https://api.thinkpage.cn/v3/weather/now.json?key=eukjfvabkmt88bww&location=%@&language=zh-Hans&unit=c", location];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    


}

+ (void)loadComingDayWeatherWithLocation:(NSString *)location
                                 success:(void (^)(id response))success
                                 failure:(void (^)(NSError *err))failure {
    
    // 阿里云
    NSString *urlStr = [NSString stringWithFormat:@"http://jisutianqi.market.alicloudapi.com/weather/query"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"city" : location};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@", APPCODE] forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}

+ (void)loadMusicRankWithTopid:(NSString *)topid
                       success:(void (^)(id response))success
                       failure:(void (^)(NSError *err))failure {

    NSString *urlStr = [NSString stringWithFormat:@"http://ali-qqmusic.showapi.com/top"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"topid" : topid};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@", APPCODE] forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}

+ (void)loadMusicWithSearchWord:(NSString *)keyword
                           page:(NSString *)page
                        success:(void (^)(id response))success
                        failure:(void (^)(NSError *err))failure {

    NSString *urlStr = [NSString stringWithFormat:@"http://ali-qqmusic.showapi.com/search"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"keyword" : keyword,
                          @"page" : page};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@", APPCODE] forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}


+ (void)translateWithChineseWord:(NSString *)word success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    NSString *urlStr = [NSString stringWithFormat:@"http://jisuzxfy.market.alicloudapi.com/translate/translate"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"text" : word,
                          @"from" : @"zh-CN",
                          @"to" : @"en",
                          @"type" : @"baidu"};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@", APPCODE] forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", [responseObject description]);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}































/*

 已丢弃
 

*/


@end
