# get-pluto
# Copyright 2016 Neil Freeman
# contact@fakeisthenewreal.org

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
# Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR
# A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

shell = bash

DATA = http://www1.nyc.gov/assets/planning/download/zip/data-maps/open-data

area_summary = SUM(LotArea) BlockArea, \
	SUM(BldgArea) BldgArea, \
	SUM(ResArea) ResArea, \
	SUM(ComArea) ComArea, \
	SUM(RetailArea) RetailArea, \
	SUM(OfficeArea) OfficeArea, \
	SUM(FactryArea) FactryArea

area_summary_limited = SUM(LotArea) BlockArea, \
	SUM(floorArea) BldgArea, \
	SUM(resArea) ResArea, \
	SUM(comArea) ComArea

Units_summary = COUNT(*) Lots, \
	SUM(UnitsRes) unitsRes, \
	SUM(UnitsTotal) UnitsTotal

UnitsRes_summary = SUM(CASE WHEN UnitsRes = 1 THEN 1 ELSE 0 END) unit_1_cnt, \
	SUM(CASE WHEN UnitsRes = 2 THEN 2 ELSE 0 END) unit_2_cnt, \
	SUM(CASE WHEN UnitsRes = 3 THEN 3 ELSE 0 END) unit_3_cnt, \
	SUM(CASE WHEN UnitsRes = 4 THEN 4 ELSE 0 END) unit_4_cnt, \
	SUM(CASE WHEN UnitsRes = 5 THEN 5 ELSE 0 END) unit_5_cnt, \
	SUM(CASE WHEN UnitsRes = 6 THEN 6 ELSE 0 END) unit_6_cnt, \
	SUM(CASE WHEN UnitsRes > 6 AND UnitsRes <= 10 THEN UnitsRes ELSE 0 END) unt6_10cnt, \
	SUM(CASE WHEN UnitsRes > 10 THEN UnitsRes ELSE 0 END) unit11_cnt

BuildingClass_summary = COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'A' THEN 1 END) cls_A_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'B' THEN 1 END) clas_B_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'C' THEN 1 END) clas_C_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'D' THEN 1 END) clas_D_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'E' THEN 1 END) clas_E_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'F' THEN 1 WHEN SUBSTR(BldgClass, 1, 1) = 'L' THEN 1 END) clas_FL_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'H' THEN 1 END) clas_H_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'R' THEN 1 END) clas_R_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'S' THEN 1 END) clas_S_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'T' THEN 1 WHEN SUBSTR(BldgClass, 1, 1) = 'U' THEN 1 END) clas_TU_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'V' THEN 1 END) clas_V_cnt, \
	COUNT(CASE WHEN SUBSTR(BldgClass, 1, 1) = 'W' THEN 1 END) clas_W_cnt

LandUse_summary = COUNT(CASE WHEN LandUse = 1 THEN 1 END) lu_1_cnt, \
	COUNT(CASE WHEN LandUse = 2 THEN 1 END) lu_2_cnt, \
	COUNT(CASE WHEN LandUse = 3 THEN 1 END) lu_3_cnt, \
	COUNT(CASE WHEN LandUse = 4 THEN 1 END) lu_4_cnt, \
	COUNT(CASE WHEN LandUse = 5 THEN 1 END) lu_5_cnt, \
	COUNT(CASE WHEN LandUse = 6 THEN 1 END) lu_6_cnt, \
	COUNT(CASE WHEN LandUse = 7 THEN 1 END) lu_7_cnt, \
	COUNT(CASE WHEN LandUse = 8 THEN 1 END) lu_8_cnt, \
	COUNT(CASE WHEN LandUse = 9 THEN 1 END) lu_9_cnt, \
	COUNT(CASE WHEN LandUse = 10 THEN 1 END) lu_10_cnt, \
	COUNT(CASE WHEN LandUse = 11 THEN 1 END) lu_11_cnt

# DCP changed the method potential FAR fields circa 2010
FAR_summary = SUM(BuiltFAR * LotArea) / SUM(LotArea) BuiltFAR, \
	SUM(ResidFAR * LotArea) / SUM(LotArea) ResidFAR, \
	SUM(CommFAR * LotArea) / SUM(LotArea) CommFAR, \
	SUM(FacilFAR * LotArea) / SUM(LotArea) FacilFAR

BsmtCode_summary = COUNT(CASE BsmtCode WHEN 0 THEN 1 END) Bsmt_0_cnt, \
	COUNT(CASE BsmtCode WHEN 1 THEN 1 END) Bsmt_1_cnt, \
	COUNT(CASE BsmtCode WHEN 2 THEN 1 END) Bsmt_2_cnt, \
	COUNT(CASE BsmtCode WHEN 3 THEN 1 END) Bsmt_3_cnt, \
	COUNT(CASE BsmtCode WHEN 4 THEN 1 END) Bsmt_4_cnt

ProxCode_summary = COUNT(CASE ProxCode WHEN 1 THEN 1 END) DetacPCcnt, \
	COUNT(CASE ProxCode WHEN 2 THEN 1 END) SemAtPCcnt, \
	COUNT(CASE ProxCode WHEN 3 THEN 1 END) AttatPCcnt

YearBuilt_summary = SUM(CASE WHEN LENGTH(TRIM(HistDist)) > 0 THEN LotArea ELSE 0 END) / SUM(LotArea) HistDstPct, \
	MIN(CASE WHEN YearBuilt = 0 THEN NULL ELSE YearBuilt END) MinYearBlt, \
	MAX(CASE WHEN 2016 < YearBuilt THEN NULL \
		WHEN YearBuilt = 0 THEN NULL ELSE YearBuilt END) MaxYrBlt, \
	ROUND(AVG(CASE WHEN YearBuilt = 0 THEN NULL ELSE YearBuilt END), 0) AvgYearBlt

Dims_summary = 	ROUND(AVG(LotDepth), 3) AvgLotDpth, \
	ROUND(AVG(LotFront), 3) AvgLotFrnt

pluto_summary = CD,\
	$(Units_summary), \
	$(area_summary), \
	$(ProxCode_summary), \
	$(BsmtCode_summary), \
	$(FAR_summary), \
	$(UnitsRes_summary), \
	$(LandUse_summary), \
	$(BuildingClass_summary), \
	$(YearBuilt_summary), \
	$(Dims_summary)

pluto_summary_limited_far = CD,\
	$(Units_summary), \
	$(area_summary), \
	$(ProxCode_summary), \
	$(BsmtCode_summary), \
	SUM(BuiltFAR * LotArea) / SUM(LotArea) BuiltFAR, \
	SUM(MaxAllwFAR * LotArea) / SUM(LotArea) MaxAllwFAR, \
	$(UnitsRes_summary), \
	$(LandUse_summary), \
	$(BuildingClass_summary), \
	$(YearBuilt_summary), \
	$(Dims_summary)

pluto_summary_03 = CD,\
	$(Units_summary), \
	$(area_summary_limited), \
	SUM(BLDGAREA) / SUM(LotArea) BuiltFAR, \
	SUM(MaxAllwFAR * LotArea) / SUM(LotArea) MaxAllwFAR, \
	$(UnitsRes_summary), \
	$(BuildingClass_summary), \
	$(YearBuilt_summary), \
	$(Dims_summary)

pluto_summary_02 = CAST(CAST(BoroCode as INTEGER) AS TEXT) || substr('00' || CAST(ccDist as TEXT), -2, 2) as CD, \
	$(Units_summary), \
	$(area_summary_limited), \
	SUM(floorArea) / SUM(LotArea) BuiltFAR, \
	SUM(MaxAllwFAR * LotArea) / SUM(LotArea) MaxAllwFAR, \
	$(UnitsRes_summary), \
	$(BuildingClass_summary), \
	$(YearBuilt_summary), \
	$(Dims_summary)

versions = 16v1 \
	15v1 \
	14v2 14v1 \
	13v2 13v1 \
	12v2 12v1 \
	11v2 11v1 \
	10v2 10v1 \
	09v2 09v1 \
	07c \
	06c \
	05d \
	04c \
	03c \
	02b

PLUTO = $(foreach x,$1,pluto_$x/mappluto_$x)

mapplutos = $(call PLUTO,$(versions))

.PHONY: all zips mappluto cds blocks mysql mysql-%
mappluto all: $(addsuffix .ind,$(mapplutos)) $(addsuffix .shp,$(mapplutos))
cds: $(addsuffix _community_district.dbf,$(mapplutos))
blocks: $(addsuffix _blocks.ind,$(mapplutos)) $(addsuffix _blocks.shp,$(mapplutos))
changes: summaries/pluto_05_15_change.dbf summaries/pluto_05_10_change.dbf
mysql: $(addprefix mysql-,$(versions))
zips: $(addsuffix .zip,$(mapplutos))

# summaries
limited_far = 12v2 12v1 11v2 11v1 10v2 10v1 \
	09v2 09v1 \
	07c 06c 05d 04c
area_03 = 03c
area_02 = 02b
standard = $(filter-out $(limited_far) $(area_03) $(area_02),$(versions))

CD = ogr2ogr $@ $< -f 'ESRI Shapefile' -overwrite -dialect sqlite \
		-sql "SELECT $(1) \
		FROM $(basename $(<F)) WHERE Borocode != 0 GROUP BY CD"

%_community_district.ind: %_community_district.dbf
	-@rm $(basename $@).{ind,idm}
	-ogrinfo $@ -sql 'CREATE INDEX ON "$(basename $(@F))" USING CD'

$(addsuffix _community_district.dbf,$(call PLUTO,$(area_02))): %_community_district.dbf: %.shp
	$(call CD,$(pluto_summary_02))

$(addsuffix _community_district.dbf,$(call PLUTO,$(area_03))): %_community_district.dbf: %.shp
	$(call CD,$(pluto_summary_03))

$(addsuffix _community_district.dbf,$(call PLUTO,$(limited_far))): %_community_district.dbf: %.shp
	$(call CD,$(pluto_summary_limited_far))

$(addsuffix _community_district.dbf,$(call PLUTO,$(standard))): %_community_district.dbf: %.shp
	$(call CD,$(pluto_summary))

SAFE_BB = CAST(BoroCode as INTEGER) || substr('00000' || CAST(Block as INTEGER), -5, 5)

BLOCKS = ogr2ogr $@ $< -f 'ESRI Shapefile' -overwrite -dialect sqlite \
	-sql "SELECT ST_Union(Geometry) Geometry, $(SAFE_BB) BB, BoroCode, Zipcode, $(1) \
	FROM $(basename $(<F)) WHERE Borocode != 0 GROUP BY borough, block"

%_blocks.ind: %_blocks.shp
	-@rm $(basename $@).{ind,idm}
	-ogrinfo $< -sql 'CREATE INDEX ON "$(basename $(<F))" USING BB'

$(addsuffix _blocks.shp,$(call PLUTO,$(area_02))): %_blocks.shp: %.shp
	$(call BLOCKS,$(pluto_summary_02))

$(addsuffix _blocks.shp,$(call PLUTO,$(area_03))): %_blocks.shp: %.shp
	$(call BLOCKS,$(pluto_summary_03))

$(addsuffix _blocks.shp,$(call PLUTO,$(limited_far))): %_blocks.shp: %.shp
	$(call BLOCKS,$(pluto_summary_limited_far))

$(addsuffix _blocks.shp,$(call PLUTO,$(standard))): %_blocks.shp: %.shp
	$(call BLOCKS,$(pluto_summary))

## MYSQL

.SECONDEXPANSION:
$(addprefix mysql-,$(versions)): mysql-%: pluto_$$*/mappluto_$$*.shp
	ogr2ogr "MySQL:pluto,user=$(USER),password=$(PASS)" $< \
		-f MySQL -nlt NONE -overwrite -gt 65536 -nln pluto$*

## SHP

upper = $(subst c,C,$(subst d,D,$(subst b,B,$1)))
PARENT = MapPLUTO_$(call upper,$(subst mappluto_,,$(basename $(@F))))

# interior folders in the ZIP files
folders = Brooklyn/BKMapPLUTO.shp \
	Queens/QNMapPLUTO.shp \
	Bronx/BXMapPLUTO.shp \
	Manhattan/MNMapPLUTO.shp \
	Staten_Island/SIMapPLUTO.shp

lowercase_folders = Bronx/bxmappluto.shp \
	Manhattan/mnmappluto.shp \
	Brooklyn/bkmappluto.shp \
	Queens/qnmappluto.shp \
	Staten_Island/simappluto.shp

no_space_folders = $(subst Staten_Island,Staten Island,$(lowercase_folders))

no_parent = 09v1 10v1 12v1 14v1 14v2 15v1 16v1

lowercases = 06c 05d 03c

specials = 02b 04c

MERGE = @rm -f $(basename $@).{dbf,shp}; \
	$(foreach shp,$(1),\
		ogr2ogr -f 'ESRI Shapefile' -update -append $@ /vsizip/$</$(2)$(shp); \
	)

$(addsuffix .ind,$(call PLUTO,$(versions))): %.ind: %.shp
	@rm -f $(basename $@).{ind,idm}
	-ogrinfo $< -sql 'CREATE INDEX ON "$(basename $(<F))" USING BoroCode'
	-ogrinfo $< -sql 'CREATE INDEX ON "$(basename $(<F))" USING Block'
	-ogrinfo $< -sql 'CREATE INDEX ON "$(basename $(<F))" USING Lot'

$(addsuffix .shp,$(call PLUTO,$(filter-out $(specials) $(lowercases) $(no_parent),$(versions)))): %.shp: %.zip
	$(call MERGE,$(folders),$(PARENT)/)

$(addsuffix .shp,$(call PLUTO,$(no_parent))): %.shp: %.zip
	$(call MERGE,$(folders))

$(addsuffix .shp,$(call PLUTO,$(lowercases))): %.shp: %.zip
	$(call MERGE,$(lowercase_folders),$(PARENT)/)

$(addsuffix .shp,$(call PLUTO,04c)): %.shp: %.zip
	$(call MERGE,$(no_space_folders),$(PARENT)/)

# 02b has NULL borocode for SI. WTF
$(addsuffix .shp,$(call PLUTO,02b)): %.shp: %.zip
	$(call MERGE,$(lowercase_folders),$(PARENT)/,)
	ogrinfo -dialect sqlite -sql "UPDATE $(basename $(@F)) SET BoroCode = 5 WHERE borough = 'SI'"

$(addsuffix .zip,$(mapplutos)): | $$(@D)
	curl -L -o $@ $(DATA)/$(@F)

$(dir $(mapplutos)): ; mkdir -p $@
