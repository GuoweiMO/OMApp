//
//  OMConnectionManager.m
//  OstModernApp
//
//  Created by Guowei Mo on 06/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import "OMConnectionManager.h"
#import "OMRequest.h"

const NSString *kBaseURL = @"http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000";

@interface OMConnectionManager ()

@end

@implementation OMConnectionManager

- (instancetype)init
{
  self = [super init];
  return self;
}

+ (instancetype)sharedManager
{
  static OMConnectionManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      instance = [[self alloc] init];
  });
  return instance;
}

- (void)makeRetrieveDataTaskWithURLString:(NSString *)urlString completion:(completionBlock)completion
{
  NSURL *url = [NSURL URLWithString:[kBaseURL stringByAppendingString:urlString]];
  NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:completion];
  [task resume];
}

- (void)makeRetrieveSetsTaskWithCompletion:(completionBlock)completion
{
  [self makeRetrieveDataTaskWithURLString:@"/api/sets/" completion:completion];
}

- (void)makeRetrieveEpisodeTaskWithURLString:(NSString *)urlString completion:(completionBlock)completion
{
  [self makeRetrieveDataTaskWithURLString:urlString completion:completion];
}

@end
