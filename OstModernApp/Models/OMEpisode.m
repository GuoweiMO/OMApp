//
//  OMEpisode.m
//  OstModernApp
//
//  Created by Guowei Mo on 11/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import "OMEpisode.h"

@interface OMEpisode ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

@end

@implementation OMEpisode

- (instancetype)initWithData:(NSDictionary *)data
{
  self = [super init];
  if(self != nil)
  {
    self.title = data[@"title"] == [NSNull null]? @"" : data[@"title"];
    self.subtitle = data[@"subtitle"] == [NSNull null]? @"" : data[@"subtitle"];
  }
  return self;
}

- (NSString *)episodeTitle
{
  return self.title;
}

- (NSString *)episodeSubtitle
{
  return self.subtitle;
}


@end
