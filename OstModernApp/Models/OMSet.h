//
//  OMSet.h
//  OstModernApp
//
//  Created by Guowei Mo on 10/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMSet : NSObject

- (instancetype)initWithData:(NSDictionary *)data;

- (NSString *)coverImageURLString;
- (NSString *)coverTitle;
- (NSInteger)numberOfEpisodes;
- (NSString *)episodeURLAtIndex:(NSInteger)index;

@end
