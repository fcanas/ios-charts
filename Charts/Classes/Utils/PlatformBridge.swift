//
//  PlatformBridge.swift
//  Charts
//
//  Created by Fabian Canas on 7/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics

public typealias UIColor = NSColor
public typealias UIFont = NSFont
public typealias UIView = NSView
public typealias UIImage = NSImage
public typealias UIScrollView = NSScrollView

public typealias UIGestureRecognizer = NSGestureRecognizer
public typealias UIGestureRecognizerState = NSGestureRecognizerState
public typealias UIGestureRecognizerDelegate = NSGestureRecognizerDelegate
public typealias UITapGestureRecognizer = NSClickGestureRecognizer
public typealias UIPinchGestureRecognizer = NSMagnificationGestureRecognizer
public typealias UIPanGestureRecognizer = NSPanGestureRecognizer
public typealias UIRotationGestureRecognizer = NSRotationGestureRecognizer

public typealias UIEvent = NSEvent
public typealias UITouch = NSTouch

// MARK: CoreGraphics Functions

func UIImagePNGRepresentation(image: NSImage!) -> NSData? {
    return NSBitmapImageRep(data: image.TIFFRepresentation!)?.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: [:])
}


func UIImageJPEGRepresentation(image: NSImage!, compressionQuality: CGFloat) -> NSData? {
    return NSBitmapImageRep(data: image.TIFFRepresentation!)?.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: [NSImageCompressionFactor:compressionQuality])
}

func UIGraphicsGetCurrentContext() -> CGContext {
    return NSGraphicsContext.currentContext()?.graphicsPort as! CGContext
}

// MARK: UIView Bridge

extension NSView {
    var backgroundColor :NSColor? {
        set(color) {
            wantsLayer = true
            layer?.backgroundColor = color?.CGColor
        }
        get {
            return flatMap(layer?.backgroundColor) { NSColor(CGColor: $0) }
        }
    }
}

// MARK: Gestures

extension NSClickGestureRecognizer {
    var numberOfTapsRequired :Int {
        set(newNumber) {
            self.numberOfClicksRequired = newNumber
        }
        get {
            return self.numberOfClicksRequired
        }
    }
}

extension NSGestureRecognizer {
    func locationOfTouch(touch: Int, inView: NSView) -> CGPoint {
        return locationInView(inView)
    }
}

extension NSView {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: NSGestureRecognizer) -> Bool {
        return true
    }
    
    public override func touchesBeganWithEvent(event: NSEvent) {
        touchesBegan(event.touchesMatchingPhase(.Began, inView: self), withEvent: event)
    }
    public func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    public override func touchesMovedWithEvent(event: NSEvent) {
        touchesMoved(event.touchesMatchingPhase(.Moved, inView: self), withEvent: event)
    }
    public func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    public override func touchesEndedWithEvent(event: NSEvent) {
        touchesEnded(event.touchesMatchingPhase(.Ended, inView: self), withEvent: event)
    }
    public func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    public override func touchesCancelledWithEvent(event: NSEvent) {
        touchesCancelled(event.touchesMatchingPhase(.Cancelled, inView: self), withEvent: event)
    }
    public func touchesCancelled(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
}

// MARK: Scrolling

extension NSScrollView {
    var scrollEnabled :Bool {
        set {}
        get { return true }
    }
}

// MARK: Text

extension NSFont {
    var lineHeight :CGFloat {
        get {
            return CTFontGetAscent(self) + CTFontGetDescent(self) + CTFontGetLeading(self)
        }
    }
}

extension NSTextAlignment {
    static var Left:NSTextAlignment {
        get {
            return LeftTextAlignment
        }
    }
    static var Right:NSTextAlignment {
        get {
            return RightTextAlignment
        }
    }
    static var Center:NSTextAlignment {
        get {
            return CenterTextAlignment
        }
    }
}
