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


+ (void)intelligentRobotWithQuestion:(NSString *)question
                             success:(void (^)(id response))success
                             failure:(void (^)(NSError *err))failure {

    NSString *urlStr = [NSString stringWithFormat:@"http://jisuznwd.market.alicloudapi.com/iqa/query"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"question" : question};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@", APPCODE] forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", [responseObject description]);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}



+ (void)loadNewsWithType:(NSString *)type
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *err))failure {

    NSString *urlStr = [NSString stringWithFormat:@"http://toutiao-ali.juheapi.com/toutiao/index"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"type" : type};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@", APPCODE] forHTTPHeaderField:@"Authorization"];
    [manager GET:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", [responseObject description]);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];


}



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
                         failure:(void (^)(NSError *err))failure {

//    NSString *urlStr = [NSString stringWithFormat:@"http://qrapi.market.alicloudapi.com/yunapi/qrencode.html"];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSDictionary *dic = @{@"qrdata" : string};
//    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@", APPCODE] forHTTPHeaderField:@"Authorization"];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    
//    
//    [manager POST:urlStr parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", [responseObject description]);
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure(error);
//    }];
    
    
    
    
    NSString *appcode = APPCODE;
    NSString *host = @"http://qrapi.market.alicloudapi.com";
    NSString *path = @"/yunapi/qrencode.html";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
//    NSString *bodys = [NSString stringWithFormat:@"qrdata=%@&size=%ld&xt=%ld&level=%@&p_color=%@&i_color=%@&back_color=%@&fore_color=%@&logo=%@&wlogo=%ld&hlogo=%ld&version=%ld", qrdata, size, xt, level, p_color, i_color, back_color, fore_color, logo, wlogo, hlogo, version];
    NSString *bodys = @"qrdata=http://www.1314.qq.com&xt=1&level=M&p_color=000000&i_color=000000&back_color=FFFFFF&fore_color=000000&logo=http://hprose.wwei.cn/uploads/api/2017/10/24/59eeabefc6b15kistSH.png&wlogo=0&hlogo=0&version=1.1";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    [request addValue: @"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       //打印应答中的body
                                                       NSLog(@"Response body: %@" , bodyString);
                                                       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:body
                                                                                                           options:NSJSONReadingMutableContainers
                                                                                                             error:nil];
                                                       NSLog(@"%@", dic);
                                                   }];
    
    [task resume];

}




















/*

 已丢弃
 

*/


@end
