#import "PCViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PCViewController ()

@property (nonatomic, retain) NSMutableArray *items;

@end

int curr = 0;


@implementation PCViewController

@synthesize carousel;
@synthesize items;



- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    
    
    self.items = [NSMutableArray array];
    
    
    for (int i = 0; i < 8; i++)
    {
        [items addObject:[NSNumber numberWithInt:i]];
    }
    
    [_btnprev setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateHighlighted];
    [_btnnext setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateHighlighted];
    
    
    [_btnprev setBackgroundImage:[UIImage imageNamed:@"previous-unselected.png"] forState:UIControlStateNormal];
    [_btnnext setBackgroundImage:[UIImage imageNamed:@"next-unselected.png"] forState:UIControlStateNormal];

    
}



- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle


- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    
    UILabel *label = nil;
    NSMutableString *fname = [NSMutableString new];
    [fname setString:@""];
    
    [fname appendString:@"0"];
    [fname appendString:[[items objectAtIndex:index] stringValue]];
    [fname appendString:@".png"];
    
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        //label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 920.0f, 480.0f)];
    ((UIImageView *)view).image = [UIImage imageNamed:fname];
    view.contentMode = UIViewContentModeCenter;
    
    
    label.text = fname;
    
    return view;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(void)_keepAtLinkTime{
};



- (IBAction)goprev:(id)sender {
    
    if (curr > 0){
        curr--;
    }
    else{
        curr = 7;
    }
        [_pagecontrol setCurrentPage:(curr - 1)];
    [carousel scrollToItemAtIndex:curr animated:YES];
}

- (IBAction)gonext:(id)sender {
    
    if (curr < 7){
        curr++;
    }
    else{
        curr = 1;
    }
    
    [_pagecontrol setCurrentPage:(curr - 1)];
    
    [carousel scrollToItemAtIndex:curr animated:YES];
}
- (IBAction)goweb:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://spaldingeurope.com"]];

}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    int i = index;
    NSMutableString *s= [NSMutableString new];
    
    [s setString:@"0"];
    [s appendString:[@(i) stringValue]];

    
    
    
    if (i == 1 || i == 2 || i == 3 ) {
        
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"mp4"]];

        _moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:url];
         


        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_moviePlayer];
        
        

        _moviePlayer.controlStyle = MPMovieControlStyleDefault;
        _moviePlayer.shouldAutoplay = YES;
        [self.view addSubview:_moviePlayer.view];
        [_moviePlayer setFullscreen:YES animated:YES];
        [_moviePlayer prepareToPlay];
        [_moviePlayer play];
        

        
    }
    else{
    
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://spaldingeurope.com"]];

    }
    
  
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
}
    

@end
