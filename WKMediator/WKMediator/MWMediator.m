//
//  MWMediator.m
//  WKMediator
//
//  Created by ma wei on 2018/12/30.
//  Copyright © 2018年 ma wei. All rights reserved.
//

#import "MWMediator.h"

@implementation MWMediator

+ (instancetype)sharedInstance {
    static MWMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[MWMediator alloc] init];
    });
    return mediator;
}

/*
 scheme://[target]/[action]?[params]
 
 url sample:
 wkScheme://targetA/actionB?id=1234
 
 第一个找的是类。第二个找的是这个类中的方法。
 
 */

- (id)performActionWithUrl:(NSURL *)url
                completion:(void (^)(NSDictionary *))completion {
    if (url == nil) {
        return @(NO);
    }
    if (![url.scheme isEqualToString:@"wkScheme"]) {
        // 这里就是针对远程app调用404的简单处理了
        return @(NO);
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if ([elts count] < 2)
            continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    NSString *actionName =
    [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:url.host action:actionName params:params];
    if (completion) {
        if (result) {
            completion(@{@"result" : result });
        } else {
            completion(nil);
        }
    }
    return result;
}

- (id)performActionWithUrl:(NSURL *)url withParams:(NSDictionary *)params completion:(void(^)(NSDictionary *info))completion
{
    if (url == nil) {
        return @(NO);
    }
    if (![url.scheme isEqualToString:@"wkScheme"]) {
        // 这里就是针对远程app调用404的简单处理了
        return @(NO);
    }
    
    NSMutableDictionary *routeparamsa = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if ([elts count] < 2)
            continue;
        [routeparamsa setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    if (params && [params isKindOfClass:[NSDictionary class]]) {
        [routeparamsa addEntriesFromDictionary:params];
    }
    NSString *actionName =
    [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:url.host action:actionName params:routeparamsa];
    if (completion) {
        if (result) {
            completion(@{@"result" : result });
        } else {
            completion(nil);
        }
    }
    return result;
}


- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params {
    
    NSString *targetClassString =
    [NSString stringWithFormat:@"Target_%@", targetName];
    NSString *actionString =
    [NSString stringWithFormat:@"Action_%@:", actionName];
    
    Class targetClass = NSClassFromString(targetClassString);
    id target = [[targetClass alloc] init];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) {
        // 这里是处理无响应请求的地方之一，这个demo做得比较简单，如果没有可以响应的target，就直接return了。实际开发过程中是可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求的
        return nil;
    }
    
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    } else {
        // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
        SEL action = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
        } else {
            // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
            return nil;
        }
    }
}

@end
