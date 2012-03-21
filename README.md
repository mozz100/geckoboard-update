Credits
=======

Built on the hard work of:
* GeckoBoard (https://github.com/geckoboard/push-sinatra-example)
* Elliott Draper (https://github.com/kickcode/geckoboard-push)

What it does
============

Uses the Geckoboard push API and the geckoboard-push gem to provide a Sinatra server capable of updating your Geckoboard widgets.
Until Geckoboard provide a way to GET/query the current state of a widget, I've just used in-browser localStorage to save
whatever the user puts in.  (Rather than set up a full-blown database)

That means that if more than one person, or one person using more than one browser, uses this, they'll both be able to push
updates, but only by looking at the Geckoboard will they be able to see the other's changes.

Configuration
=============

See config.yml.  Currently only text widgets supported, could be easily expanded.

Licence
=======

geckoboard-push Copyright 2011 Elliott Draper <el@kickcode.com>
geckoboard-update copyright 2012 Richard Morrison <richard.morrison@owlstone.co.uk>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.