
INSERT INTO u_flood.ffoi_station(rloi_id) VALUES
(2001),
(2002),
(2036),
(2041),
(2051),
(2067),
(2100),
(2103),
(2108),
(2118),
(2131),
(2132),
(2138),
(2152),
(2063),
(2217),
(5047),
(7170),
(7172),
(8044),
(8059),
(8067),
(8070),
(8173),
(8187),
(8196),
(8208),
(8223),
(8251),
(8261),
(8272);

INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value) VALUES
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2001), '031WAF108', 3.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2001), '031FWFSE400', 4.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2001), '031FWFSE390', 4.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2001), '031FWFSE350', 4.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2001), '031FWFSE340', 4.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2001), '031FWFSE370', 4.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2001), '031FWFSE360', 4.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2002), '031WAF209', 1.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2002), '031FWFAV40', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2002), '031FWFAV70', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2002), '031FWFAV20', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2002), '031FWFAV60', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2002), '031FWFAV30', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2002), '031FWFAV50', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2002), '031FWFAV55', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2036), '031WAF103', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2036), '031FWFSE220', 3.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2036), '031FWFSE200', 3.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2036), '031FWFSE230', 3.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2036), '031FWFSE210', 3.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2041), '031WAF214', 2.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2041), '031FWFSE525', 3.6),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2041), '031FWFSE520', 3.6),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2041), '031FWFSE510', 3.6),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2051), '031WAT217', 5.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2051), '031FWBSE620', 6.1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2051), '031FWTSE630', 6.1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2067), '031WAF103', 5.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2067), '031FWFVY60', 6.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2067), '031FWFSE180', 6.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034WAF414', 1.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRCAVBRDG', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRSWARKST', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRRPTING', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRBARROW', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRCASDONKM', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRTRENTLK', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRTWYFORD', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRSHARDLW', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRTHRMPTN', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRWLLNGTN', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRSAWLEY', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2100), '034FWFTRNEWSAWLY', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034WAF409', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDEAMBERGT', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDENTHCHRCH', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDEWHATSTAN', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDEBELPER', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDEDUFFHALL', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDEMATBATH', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDEMATLOCK', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDEMILFORD', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFECDUFFIELD', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDELITEATON', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2103), '034FWFDEDARLDALE', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2108), '033WAF314', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2108), '033FWF3TRENT14', 3.09),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2108), '033FWF3TRENT16', 3.09),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2108), '033FWF3TRENT15', 3.09),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034WAF407', 3.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDEDARLDALE', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDEGRINDLE', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDECALVER', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDECHATSWTH', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFWYROWSLEY', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDENTHCHRCH', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDEHATHERSA', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDEBASLOW', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDEBAMFORD', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2118), '034FWFDEDARLBRDG', 3.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2131), '033WAF304', 1.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2131), '033FWF3TAME017', 2.68),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2131), '033FWF3TAME018', 2.68),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2131), '033FWF3TAME019', 2.68),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2131), '033FWF3TAME020', 2.68),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2132), '034WAF428', 1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2132), '034FWFSOZOUCH', 1.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2132), '034FWFSOREDKEG', 1.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2132), '034FWFSONORMOOR', 1.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2132), '034FWFSONORMSOAR', 1.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2132), '034FWFSOSUTTBONN', 1.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2132), '034FWFSORATSOAR', 1.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2132), '034FWFSOKEGWORTH', 1.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034WAF409', 2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEALLSTREE', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEAMBASLNE', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDERAYNES', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEBELPER', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEDUFFHALL', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEELVASTON', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDELITTLECH', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEDERWATER', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFECDUFFIELD', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEMILFORD', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDELITEATON', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEDARLFOLL', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEAMBASTON', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEDRAYCOTT', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFTRSHARDLW', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDERACEPARK', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEDERCITY', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEPRIDEPRK', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDECHADD', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2138), '034FWFDEALVASTON', 2.19),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2152), '034WAF414', 2.35),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2152), '034FWFTRRPTING', 3.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2152), '034FWFTRBARROW', 3.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2152), '034FWFTRSWARKST', 3.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2152), '034FWFTRCASDONKM', 3.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2152), '034FWFTRTWYFORD', 3.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2152), '034FWFTRWLLNGTN', 3.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2063), '031WAF214', 3.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2063), '031FWBSE570', 3.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2063), '031FWBSE610', 3.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2063), '031FWBSE620', 3.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2063), '031FWFSE580', 3.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2063), '031FWBSE590', 3.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2063), '031FWBSE600', 3.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2217), '034WAF415', 2.9),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2217), '034FWFTRNOTTCITY', 6.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2217), '034FWFLEOLDLENTN', 6.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2217), '034FWFTRWESTBRG', 6.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 2217), '034FWFTRWILFORD', 6.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 5047), '011WAFED', 1.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 5047), '011FWFNC8A', 2.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 5047), '011FWFNC15', 2.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 5047), '011FWFNC8B', 2.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7170), '061WAF23Datchet', 4.25),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7170), '061FWF23XDatcht', 5.068),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7170), '061FWF23Datchet', 5.068),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7172), '061FWF23XOldWnd', 4.534),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7172), '061FWF23XWrysbry', 4.534),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8044), '122WAF944', 6.1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8044), '122WAT964', 6.1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8044), '122FWB758', 7.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8044), '122FWF728', 7.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8044), '122FWF756', 7.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8044), '122FWF757', 7.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8059), '122WAF937', 4.25),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8059), '122FWF227', 4.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8059), '122FWF234', 4.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8059), '122FWF236', 4.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123WAF972', 3.6),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWB650', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWF552', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWF553', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWF642', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWF643', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWF644', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWF646', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWF648', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8067), '123FWF649', 6.13),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8070), '123WAF980', 0.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8070), '123FWF156', 1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8173), '121WAF904', 2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8173), '121FWF110', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8173), '121FWF128', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8173), '121FWF107', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8173), '121FWF108', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8173), '121FWF129', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8173), '121FWF109', 2.7),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8187), '123WAF960', 1.4),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8187), '123FWF090', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8187), '123FWF103', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8187), '123FWF105', 2.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8196), '121WAF914', 2.15),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8196), '121FWF223', 3.1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8196), '121FWF219', 3.1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8196), '121FWF218', 3.1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8196), '121FWF217', 3.1),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122WAF946', 2.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122WAF947', 2.2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF710', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF712', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF715', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF716', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF720', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF721', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF722', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF723', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF724', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF725', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF730', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF734', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF752', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8208), '122FWF755', 3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8223), '121WAF925', 1.8),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8223), '121FWF050', 5.37),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8251), '123WAF982', 0.5),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8251), '123FWF189', 1.52),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8251), '123FWF190', 1.52),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8251), '123FWF191', 1.52),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8251), '123FWF192', 1.52),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8251), '123FWF744', 1.52),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8251), '123FWF745', 1.52),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8261), '123WAF987', 1.45),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8261), '123FWF692', 2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8261), '123FWF693', 2),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8272), '121WAF912', 1.24),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8272), '121FWF323', 2.36),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8272), '121FWF321', 2.36),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 8272), '121FWF324', 2.36);
