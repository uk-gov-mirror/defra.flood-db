# Station to target area 8km relationship data

This dataset was added in as part of the performance testing agsinst the service refresh environment post mvp beta release.

The data set generates a cached dataset of all the river level stations and the target areas that fall within 8km of them.

The data set needs to be updated at the same time as the target area data load is performed quarterly.


# instructions

1.  Using a psql connection to the service refresh development database execute the script ./generate_station_ta_8km.sql
	a. This step can be sped up by requesting webops to scale the development database to a faster instance
	b. It will take roughly 5 hours to generate the new dataset

2.  Once the dataset has been generated check the service refresh development front end that the auto tests are completing correctly, and that stations are showing the relevant warnings.

3.  Once tested now export the data so that it can be stored in github and loaded into other environments.
	a.  Run ./dump_station_ta_8km.sql in terminal
	b.  Check that $FLOOD_SERVICE_CONNECTION_STRING is correctly set to database
	c.  Exports file to this directory called station_ta_8km.sql

4.  Commit and push the new station_ta_8km.sql file to github repository

5.  Execute jenkins job LFW_DEV_99_LOAD_FLOOD_ALERT_AREAS
	a.  This reloads the data into dev, so is a step to confirm the exported data and load is all good
	b.  Run auto tests
	c.  Check stations for linked warnings

6.  Merge flood-db dev branch into tst

7.  Execute jenkins job LFW_TST_99_LOAD_FLOOD_ALERT_AREAS
	a.  Run auto tests on test
	b.  Check stations for linked warnings

8.  Once tested and signed off flood-db will need merging into master ready for release into production as part of the target area quarterly load.
