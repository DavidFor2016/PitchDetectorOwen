//
//  ListenerViewController.m
//  SafeSound
//
//  Created by Demetri Miller on 10/25/10.
//  Copyright 2010 Demetri Miller. All rights reserved.
//

#import "ListenerViewController.h"
#import "RIOInterface.h"

@implementation ListenerViewController

@synthesize currentPitchLabel;
@synthesize listenButton;
@synthesize key;
@synthesize prevChar;
@synthesize isListening;
@synthesize	rioRef;
@synthesize currentFrequency;

#pragma mark -
#pragma mark Listener Controls
- (IBAction)toggleListening:(id)sender {
	if (isListening) {
		[self stopListener];
		[listenButton setTitle:@"Begin Listening" forState:UIControlStateNormal];
	} else {
		[self startListener];
		[listenButton setTitle:@"Stop Listening" forState:UIControlStateNormal];
	}
	
	isListening = !isListening;
}

- (void)startListener {
	[rioRef startListening:self];
}

- (void)stopListener {
	[rioRef stopListening];
}



#pragma mark -
#pragma mark Lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	rioRef = [RIOInterface sharedInstance];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	currentPitchLabel = nil;
    listenButton = nil;
    [super viewDidUnload];
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark -
#pragma mark Key Management
// This method gets called by the rendering function. Update the UI with
// the character type and store it in our string.
- (void)frequencyChangedWithValue:(float)newFrequency{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	self.currentFrequency = newFrequency;
	[self performSelectorInBackground:@selector(updateFrequencyLabel) withObject:nil];
	[pool drain];
	pool = nil;
	
}
		 
- (void)updateFrequencyLabel {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	self.currentPitchLabel.text = [NSString stringWithFormat:@"%f", self.currentFrequency];
	[self.currentPitchLabel setNeedsDisplay];
	[pool drain];
	pool = nil;
}


@end
