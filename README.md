bbet
====

The required conversion is from @fuzzy in Request to @deadline in RequestPeriod, with @deadline undefined for "whenever". 
How this is represented in the database is left for others to grapple with ...

Modules used: coffee-script@1.4.0, mocha@1.8.1, should@1.2.1 now held locally in this repo

zone_tests.sh runs mocha twice, once for GMT and once for Japan's time zone

Ignored: leap seconds, being outside boundary values for milliseconds for dates