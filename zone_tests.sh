#!/bin/sh
TZ=GMT mocha --compilers coffee:coffee-script --require should
TZ=Japan mocha --compilers coffee:coffee-script --require should