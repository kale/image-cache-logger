# Image Cache Logger

A simple tool to see when other services/clients like Gmail open an image and test if they are storing it within their cache.

## Running Demo

Feel free to use this as a demo or in actual testing.

Image link (replace slug with anything):
http://cache-logger.herokuapp.com/change-me-to-anything

To check the logs without opening the image, append a /log to the end:
http://cache-logger.herokuapp.com/change-me-to-anything/log

You can also do */destroy* to delete all logs from an image and */remove* to delete the last log, but will have to make those calls using curl:

    curl -X DELETE http://cache-logger.herokuapp.com/change-me-to-anything/destroy
    curl -X DELETE http://cache-logger.herokuapp.com/change-me-to-anything/remove

## Setup your own instance

Assuming you have git, ruby, bundler, and heroku setup... you can simply do:

    git clone https://github.com/kale/image-cache-logger
    cd image-cache-logger
    bundle install
    heroku create
    git push heroku master

## License

Copyright (c) 2013 Kale Davis

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
