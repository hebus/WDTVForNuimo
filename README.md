Class to Remote control a WD TV with Nuimo controller

Add only the class WDTVRemote.swift to use it on your Nuimo project

How to use:
First declare a shared Instance...

private let wdtv = WDTVRemote.sharedInstance

...Then send Nuimo Gesture event

wdtv.sendNuimoGestureEvent(event)
