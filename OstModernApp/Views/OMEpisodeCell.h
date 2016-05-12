//
//  OMEpisodeCell.h
//  OstModernApp
//
//  Created by Guowei Mo on 11/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMEpisode.h"

@interface OMEpisodeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *episodeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *episodeSubtitleLabel;

- (void)updateCellWithEpisodeInfo:(OMEpisode *)episode;

@end
