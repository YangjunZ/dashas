/*
 * Copyright (c) 2014 castLabs GmbH
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

package com.castlabs.dash.loaders {
import com.castlabs.dash.descriptors.segments.DataSegment;
import com.castlabs.dash.descriptors.segments.Segment;
import com.castlabs.dash.events.SegmentEvent;
import com.castlabs.dash.utils.BandwidthMonitor;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

public class DataSegmentLoader extends SegmentLoader {
    private var http:URLLoader = new URLLoader();

    public function DataSegmentLoader(segment:Segment, monitor:BandwidthMonitor) {
        super(segment, monitor)
    }

    override public function load():void {
        http.dataFormat = URLLoaderDataFormat.BINARY;
        http.addEventListener(Event.COMPLETE, onComplete);
        http.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void {
            trace("Connection was interrupted:" + event.toString());
        });

        _monitor.appendListeners(http);

        http.load(new URLRequest(buildUrl()));
    }

    override public function close():void {
        http.close();
    }

    protected function buildUrl():String {
        return DataSegment(_segment).url;
    }

    protected function onComplete(event:Event):void {
        var bytes:ByteArray = URLLoader(event.target).data;
        dispatchEvent(new SegmentEvent(SegmentEvent.LOADED, false, false, _segment, bytes));
    }
}
}
