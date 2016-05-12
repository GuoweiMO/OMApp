//
//  OMEpisodeCell.m
//  OstModernApp
//
//  Created by Guowei Mo on 11/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import "OMEpisodeCell.h"

@implementation OMEpisodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)updateCellWithEpisodeInfo:(OMEpisode *)episode
{
  self.episodeTitleLabel.text = [episode episodeTitle];
  self.episodeSubtitleLabel.text = [episode episodeSubtitle];
}

@end
