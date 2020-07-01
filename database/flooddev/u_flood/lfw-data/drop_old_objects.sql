-- Script to drop database objects to do with old telemetry process

DROP TABLE u_flood.telemetry_file CASCADE;

DROP TABLE u_flood.telemetry_file_bkp CASCADE;

DROP TABLE u_flood.telemetry_value_parent CASCADE;

DROP TABLE u_flood.telemetry_value_parent_bkp CASCADE;

DROP TABLE u_flood.telemetry_value CASCADE;

DROP TABLE u_flood.telemetry_value_bkp CASCADE;

DROP TABLE u_flood.telemetry_context_bkp CASCADE;

DROP TABLE u_flood.tmp_telemetry_value CASCADE;

DROP TABLE u_flood.tmp_telemetry_value_parent CASCADE;

DROP FUNCTION u_flood.load_telemetry_value();

DROP FUNCTION u_flood.load_telemetry_value_parent();

DROP SEQUENCE telemetry_context_bkp_telemetry_context_id_seq;

DROP SEQUENCE telemetry_file_bkp_telemetry_file_id_seq;

DROP SEQUENCE telemetry_file_telemetry_file_id_seq;

DROP SEQUENCE telemetry_value_bkp_telemetry_value_id_seq;

DROP SEQUENCE telemetry_value_parent_bkp_telemetry_value_parent_id_seq;

DROP SEQUENCE telemetry_value_parent_telemetry_value_parent_id_seq;

DROP SEQUENCE telemetry_value_telemetry_value_id_seq;

DROP SEQUENCE tmp_telemetry_value_parent_tmp_telemetry_value_parent_id_seq;

DROP SEQUENCE tmp_telemetry_value_tmp_telemetry_value_id_seq;

DROP FUNCTION restore_context_and_telemetry_data();

DROP FUNCTION load_telemetry_data();

DROP FUNCTION load_telemetry_context_data();

DROP FUNCTION load_flood_warning_data();

DROP FUNCTION get_telemetry_with_context(integer, character);

DROP FUNCTION delete_context_and_telemetry_data_backup();

DROP FUNCTION delete_context_and_telemetry_data();

DROP FUNCTION backup_context_and_telemetry_data();
