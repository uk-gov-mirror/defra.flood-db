Insert into u_flood.ffoi_station (rloi_id)
values (1087), (9006), (8275), (8248), (8028), (5132), (5150), (5021), (2130), (2102), (2081), (2046), (7176), (7246);


INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value)
Values 
--1087
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 1087), '064WAF8LowTeise', 1.78),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 1087), '064FWF8Teise', 2.38),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 1087), '064FWF8CollStreet', 2.38),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 1087), '064FWF8PaddWood', 2.38),

--9006
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 9006), '121WAF910', 33.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 9006), '121FWF213', 34.30),

--8275
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8275), '121WAF925', 1.65),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8275), '121FWF077', 2.85),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8275), '121FWF088', 2.85),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8275), '121FWF089', 2.85),

--8248
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8248), '123WAF971', 2.92),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8248), '123FWF620', 3.35),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8248), '123FWF621', 3.35),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8248), '123FWF624', 3.35),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8248), '123FWF622', 3.35),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8248), '123FWF623', 3.35),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8248), '123FWF625', 3.35),

--8028
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8028), '122WAF934', 13.50),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8028), '122FWF347', 13.80),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8028), '122FWF344', 13.80),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8028), '122FWF348', 13.80),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8028), '122FWF345', 13.80),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8028), '122FWF340', 13.80),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8028), '122FWF352', 13.80),

--5132
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5132), '012WAFLW', 4.72),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5132), '012FWFL3', 5.25),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5132), '012FWFL3C', 5.25),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5132), '012FWFL3A', 5.25),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5132), '012FWFL3B', 5.25),

--5150
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5150), '012WAFEL', 3.33),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5150), '012FWFL21A', 3.70),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5150), '012FWFL21B', 3.70),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5150), '012FWFL21C', 3.70),

--5021
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5021), '013WAFMM', 1.80),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5021), '013FWFGM31', 5.20),

--2130
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2130), '034WAF409', 1.60),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2130), '034FWFDECHURCHW', 2.16),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2130), '034FWFDEAMBASTON', 2.16),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2130), '034FWFDEDRAYCOTT', 2.16),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2130), '034FWFTRSHARDLW', 2.16),

--2102
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034WAF415', 3.60),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034WAB424', 3.60),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRLNTPRKRD', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRHPWATER', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRTOLNEY', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRFARNWYK', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRFISKMILL', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRSUGARNWK', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRATTNATRES', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRTRENTLK', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRTHRMPTN', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRGUNTHRP', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRGIBSMERE', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRNEWRIVER', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRBSTNMNA', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRSHLFDMNR', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRHOVNGHM', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRCAYTHOR', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRGUNRD', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRHLMPIER', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRSTKEBAR', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRHOLME', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRNTHMUSKHM', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRRADCARA', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRAVRSTAY', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRCOLWICKR', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRROLLSTN', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRNEWCAT', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRSTMUSKHM', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRFARNDON', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRSAWLEY', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRNEWSAWLY', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRATTVILL', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRATTBRGH', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRBEESTON', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRNOTTCITY', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFLEDUNK', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFLEOLDLENTN', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRCOLWICK', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRSHELFRD', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRBURTJOYC', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRBLEASBY', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRNEWARK', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRBRTNFAB', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRRADTRNT', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRWILFORD', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRWESTBRG', 4.30),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2102), '034FWFTRFISKERTN', 4.30),

--2081
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2081), '031WAF108', 5.00),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2081), '031WAF201', 5.00),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2081), '031FWFSE465', 6.00),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2081), '031FWFSE470', 6.00),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2081), '031FWFTE130', 6.00),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2081), '031FWFTE120', 6.00),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2081), '031FWFSE460', 6.00),

--2046
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2046), '033WAF204', 1.20),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2046), '033FWF3AVON014', 1.69),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2046), '033FWF3AVON013', 1.69),

--7176
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 7176), '062WAF28Mimmshal', 1.80),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 7176), '062FWF28Warrengt', 3.60),

--7246
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 7246), '061WAB23DitIslnd', 5.70),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 7246), '061FWB23DitIslnd', 6.35),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 7246), '061FWF23ThDitton', 6.35);

