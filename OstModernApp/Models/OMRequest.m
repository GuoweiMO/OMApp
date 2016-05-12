//
//  OMRequest.m
//  OstModernApp
//
//  Created by Guowei Mo on 06/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import "OMRequest.h"

@implementation OMRequest

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [self setHTTPShouldHandleCookies:NO];
    [self setTimeoutInterval:30];
  }
  return self;
}

- (void)configRequestWithAPIURL:(NSString *)urlString
{
  NSString *fullUrlString = [SERVER_API_URL stringByAppendingString:urlString];
  self.URL = [NSURL URLWithString:fullUrlString];
//  [self setHTTPMethod:@"POST"];
//  [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

@end
