//
//  OMSet.m
//  OstModernApp
//
//  Created by Guowei Mo on 10/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import "OMSet.h"

@interface OMSet ()

@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *episodes;

@end

@implementation OMSet

- (instancetype)initWithData:(NSDictionary *)data
{
  self = [super init];
  if(self != nil)
  {
    self.imageURLString = ((NSArray *) data[@"image_urls"]).firstObject;
    self.title = data[@"title"];
    NSArray *items = data[@"items"];
    NSMutableArray *episodes = [NSMutableArray new];
    for (NSDictionary *item in items)
    {
      if([item[@"content_type"] isEqualToString:@"episode"])
      {
        [episodes addObject:item];
      }
    }
    self.episodes = episodes;
  }
  return self;
}

- (NSString *)coverImageURLString
{
  return self.imageURLString;
}

- (NSString *)coverTitle
{
  return self.title;
}

- (NSInteger)numberOfEpisodes
{
  return self.episodes.count;
}

- (NSString *)episodeURLAtIndex:(NSInteger)index
{
  return self.episodes[index][@"content_url"];
}

@end
