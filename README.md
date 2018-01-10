get-pluto
---------

This `Makefile` contains tasks to download and create block-level summaries of New York City cadastral data.

The NYC Department of City Planning has released the [PLUTO](http://www1.nyc.gov/site/planning/data-maps/open-data/dwn-pluto-mappluto.page) dataset going back to 2002, which is a great. Unfortunately, the data is released in five borough-level files, which means doing city-level analysis requires doing some merging off the bat.

This Makefile solves that problem, and deals with some annoying features of changed formatting and missing data along with way.

Save this Makefile to the folder into which you want to download PLUTO data, open up the command line and run `make`. All ~19 releases will (slowly) download and be merged into one citywide file.

Also included are tasks to create block- and community-district-level summaries.

## Requires

* `curl` (downloading data)
* [GDAL](http://www.gdal.org) v 2.2+ (creating citywide files and block-level summaries)

## Basics
```
make
```
This will download the PLUTO data and merge borough files into citywide files. It put each release into a separate folder (e.g. `pluto_15v1`).

To download only some releases, use the `versions` variable, e.g:
```
make versions=16v1
make versions="12v2 02b"
```

Available versions on the DCP website: 16v1, 15v1, 14v2, 14v1, 13v2, 13v1, 12v2, 12v1, 11v2, 11v1, 10v2, 10v1, 09v2, 09v1, 07c, 06c, 05d, 04c, 02b.     

## Summaries

The following data fields is summarized:
* Sums of area fields (e.g. `BldgArea`)
* Counts of properties by residential unit, building class, proximity code and land use code
* Minimum and maximum year built
* Average lot depth and width

Not all data fields are available in all releases.

### Block summaries
````
make blocks
````

This will join and summarize lots by tax block, which almost always matches the city block.

### Community district summaries
````
make cds
````

This will join and summarize lots by [community district](http://www1.nyc.gov/site/planning/community/jias-sources.page).

## License

Copyright 2016 Neil Freeman, published under the MIT License.
