#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>  
#import "iCarousel.h"

@interface PCViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnlink;
- (IBAction)goweb:(id)sender;

@property (nonatomic, retain) IBOutlet iCarousel *carousel;

@property (weak, nonatomic) IBOutlet UIButton *btnprev;
@property (weak, nonatomic) IBOutlet UIButton *btnnext;

@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;

- (IBAction)goprev:(id)sender;
- (IBAction)gonext:(id)sender;


@property (strong, nonatomic, retain) MPMoviePlayerController *moviePlayer;



@end
