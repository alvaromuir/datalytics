# run `make app/data/counties.json`

app/data/gz_2010_us_050_00_20m.zip:
	mkdir -p $(dir $@)
	curl -o $@ http://www2.census.gov/geo/tiger/GENZ2010/$(notdir $@)

app/data/gz_2010_us_050_00_20m.shp: app/data/gz_2010_us_050_00_20m.zip
	unzip -od $(dir $@) $<
	touch $@

app/data/counties.json: app/data/gz_2010_us_050_00_20m.shp app/data/ACS_12_5YR_B01003_with_ann.csv
	node_modules/.bin/topojson \
		-o $@ \
		--id-property='STATE+COUNTY,Id2' \
		--external-properties=app/data/ACS_12_5YR_B01003_with_ann.csv \
		--properties='name=Geography' \
		--properties='population=+d.properties["Estimate; Total"]' \
		--projection='width = 960, height = 600, d3.geo.albersUsa() \
			.scale(1280) \
			.translate([width / 2, height / 2])' \
		--simplify=.5 \
		--filter=none \
		-- counties=$<

app/data/states.json: app/data/counties.json
	node_modules/.bin/topojson-merge \
		-o $@ \
		--in-object=counties \
		--out-object=states \
		--key='d.id.substring(0, 2)' \
		-- $<


app/data/us.json: app/data/states.json
	node_modules/.bin/topojson-merge \
		-o $@ \
		--in-object=states \
		--out-object=nation \
		-- $<
