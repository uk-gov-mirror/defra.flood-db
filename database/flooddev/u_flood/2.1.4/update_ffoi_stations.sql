-- FIS-138 (7172 removed from list)

delete
from u_flood.ffoi_station_threshold
where ffoi_Station_id in (select ffoi_station_id from u_flood.ffoi_station where rloi_id = 7172);

delete from u_flood.ffoi_station where rloi_id = 7172;

-- FIS-146

update u_flood.ffoi_station_threshold
set fwis_code = '034FWFTRATTNATRE'
where fwis_code = '034FWFTRATTNATRES';