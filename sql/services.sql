# noinspection SqlNoDataSourceInspectionForFile

delete
from `t_adapter_conf`
where `application` = 'TestUnits'
   or `application` = 'TarsTestToolKit';
delete
from `t_server_conf`
where `application` = 'TestUnits'
   or `application` = 'TarsTestToolKit';

### TestUnits.CppTars
replace into `t_adapter_conf` (`application`, `server_name`, `node_name`, `adapter_name`, `registry_timestamp`,
                               `thread_num`, `endpoint`, `max_connections`, `allow_ip`, `servant`, `queuecap`,
                               `queuetimeout`, `posttime`, `lastuser`, `protocol`, `handlegroup`)
VALUES ('TestUnits', 'CppTars', 'localip.tars.com', 'TestUnits.CppTars.testObjAdapter', now(), 5,
        'tcp -h localip.tars.com -t 60000 -p 22001', 2000, '', 'TestUnits.CppTars.testObj', 10000, 60000, now(), 'admin',
        'tars', '');
replace into `t_server_conf` (`application`, `server_name`, `node_group`, `node_name`, `registry_timestamp`,
                              `base_path`, `exe_path`, `template_name`, `bak_flag`, `setting_state`, `present_state`,
                              `process_id`, `patch_version`, `patch_time`, `patch_user`, `tars_version`, `posttime`,
                              `lastuser`, `server_type`, `profile`)
VALUES ('TestUnits', 'CppTars', '', 'localip.tars.com', now(), '', '', 'tars.cpp.default', 0, 'active', 'active', 0,
        '2.1.0', now(), '', '2.1.0', now(), 'admin', 'tars_cpp', '');

### TestUnits.JavaTars
replace into `t_adapter_conf` (`application`, `server_name`, `node_name`, `adapter_name`, `registry_timestamp`,
                               `thread_num`, `endpoint`, `max_connections`, `allow_ip`, `servant`, `queuecap`,
                               `queuetimeout`, `posttime`, `lastuser`, `protocol`, `handlegroup`)
VALUES ('TestUnits', 'JavaTars', 'localip.tars.com', 'TestUnits.JavaTars.testObjAdapter', now(), 5,
        'tcp -h localip.tars.com -t 60000 -p 22002', 2000, '', 'TestUnits.JavaTars.testObj', 10000, 60000, now(), 'admin',
        'tars', '');
replace into `t_server_conf` (`application`, `server_name`, `node_group`, `node_name`, `registry_timestamp`,
                              `base_path`, `exe_path`, `template_name`, `bak_flag`, `setting_state`, `present_state`,
                              `process_id`, `patch_version`, `patch_time`, `patch_user`, `tars_version`, `posttime`,
                              `lastuser`, `server_type`, `profile`)
VALUES ('TestUnits', 'JavaTars', '', 'localip.tars.com', now(), '', '', 'tars.springboot', 0, 'active', 'active', 0,
        '2.1.0', now(), '', '2.1.0', now(), 'admin', 'tars_java', '');


### TestUnits.NodejsTars
replace into `t_adapter_conf` (`application`, `server_name`, `node_name`, `adapter_name`, `registry_timestamp`,
                               `thread_num`, `endpoint`, `max_connections`, `allow_ip`, `servant`, `queuecap`,
                               `queuetimeout`, `posttime`, `lastuser`, `protocol`, `handlegroup`)
VALUES ('TestUnits', 'NodejsTars', 'localip.tars.com', 'TestUnits.NodejsTars.testObjAdapter', now(), 5,
        'tcp -h localip.tars.com -t 60000 -p 22003', 2000, '', 'TestUnits.NodejsTars.testObj', 10000, 60000, now(), 'admin',
        'tars', '');
replace into `t_server_conf` (`application`, `server_name`, `node_group`, `node_name`, `registry_timestamp`,
                              `base_path`, `exe_path`, `template_name`, `bak_flag`, `setting_state`, `present_state`,
                              `process_id`, `patch_version`, `patch_time`, `patch_user`, `tars_version`, `posttime`,
                              `lastuser`, `server_type`, `profile`)
VALUES ('TestUnits', 'NodejsTars', '', 'localip.tars.com', now(), '', '', 'tars.NodejsTars.default', 0, 'active', 'active', 0,
        '2.1.0', now(), '', '2.1.0', now(), 'admin', 'tars_nodejs', '');


### TestUnits.GolangTars
replace into `t_adapter_conf` (`application`, `server_name`, `node_name`, `adapter_name`, `registry_timestamp`,
                               `thread_num`, `endpoint`, `max_connections`, `allow_ip`, `servant`, `queuecap`,
                               `queuetimeout`, `posttime`, `lastuser`, `protocol`, `handlegroup`)
VALUES ('TestUnits', 'GolangTars', 'localip.tars.com', 'TestUnits.GolangTars.testObjAdapter', now(), 5,
        'tcp -h localip.tars.com -t 60000 -p 22004', 2000, '', 'TestUnits.GolangTars.testObj', 10000, 60000, now(), 'admin',
        'tars', '');
replace into `t_server_conf` (`application`, `server_name`, `node_group`, `node_name`, `registry_timestamp`,
                              `base_path`, `exe_path`, `template_name`, `bak_flag`, `setting_state`, `present_state`,
                              `process_id`, `patch_version`, `patch_time`, `patch_user`, `tars_version`, `posttime`,
                              `lastuser`, `server_type`, `profile`)
VALUES ('TestUnits', 'GolangTars', '', 'localip.tars.com', now(), '', '', 'tars.default', 0, 'active', 'active', 0, '2.1.0',
        now(), '', '2.1.0', now(), 'admin', 'tars_go', '');


### TestUnits.PhpTars
replace into `t_adapter_conf` (`application`, `server_name`, `node_name`, `adapter_name`, `registry_timestamp`,
                               `thread_num`, `endpoint`, `max_connections`, `allow_ip`, `servant`, `queuecap`,
                               `queuetimeout`, `posttime`, `lastuser`, `protocol`, `handlegroup`)
VALUES ('TestUnits', 'PhpTars', 'localip.tars.com', 'TestUnits.PhpTars.testObjAdapter', now(), 5,
        'tcp -h localip.tars.com -t 60000 -p 22005', 2000, '', 'TestUnits.PhpTars.testObj', 10000, 60000, now(), 'admin',
        'tars', '');
replace into `t_server_conf` (`application`, `server_name`, `node_group`, `node_name`, `registry_timestamp`,
                              `base_path`, `exe_path`, `template_name`, `bak_flag`, `setting_state`, `present_state`,
                              `process_id`, `patch_version`, `patch_time`, `patch_user`, `tars_version`, `posttime`,
                              `lastuser`, `server_type`, `profile`)
VALUES ('TestUnits', 'PhpTars', '', 'localip.tars.com', now(), '', '', 'tars.tarsphp.default', 0, 'active', 'active', 0,
        '2.1.0', now(), '', '2.1.0', now(), 'admin', 'tars_php', '');

###ResFetcher
replace into `t_adapter_conf` (`application`, `server_name`, `node_name`, `adapter_name`, `registry_timestamp`,
                               `thread_num`, `endpoint`, `max_connections`, `allow_ip`, `servant`, `queuecap`,
                               `queuetimeout`, `posttime`, `lastuser`, `protocol`, `handlegroup`)
VALUES ('TarsTestToolKit', 'ResFetcher', 'localip.tars.com', 'TarsTestToolKit.ResFetcher.fetcherObjAdapter', now(), 5,
        'tcp -h localip.tars.com -t 60000 -p 22006', 2000, '', 'TarsTestToolKit.ResFetcher.fetcherObj', 10000, 60000,
        now(), 'admin', 'tars', '');
replace into `t_server_conf` (`application`, `server_name`, `node_group`, `node_name`, `registry_timestamp`,
                              `base_path`, `exe_path`, `template_name`, `bak_flag`, `setting_state`, `present_state`,
                              `process_id`, `patch_version`, `patch_time`, `patch_user`, `tars_version`, `posttime`,
                              `lastuser`, `server_type`, `profile`)
VALUES ('TarsTestToolKit', 'ResFetcher', '', 'localip.tars.com', now(), '', '', 'tars.default', 0, 'active', 'active',
        0, '2.1.0', now(), '', '2.1.0', now(), 'admin', 'tars_go', '');

###BackendApi
replace into `t_adapter_conf` (`application`, `server_name`, `node_name`, `adapter_name`, `registry_timestamp`,
                               `thread_num`, `endpoint`, `max_connections`, `allow_ip`, `servant`, `queuecap`,
                               `queuetimeout`, `posttime`, `lastuser`, `protocol`, `handlegroup`)
VALUES ('TarsTestToolKit', 'BackendApi', 'localip.tarsadmin.com', 'TarsTestToolKit.BackendApi.apiObjAdapter', now(), 5,
        'tcp -h localip.tars.com -t 60000 -p 9001', 2000, '', 'TarsTestToolKit.BackendApi.apiObj', 10000, 60000, now(),
        'admin', 'tars', '');
replace into `t_server_conf` (`application`, `server_name`, `node_group`, `node_name`, `registry_timestamp`,
                              `base_path`, `exe_path`, `template_name`, `bak_flag`, `setting_state`, `present_state`,
                              `process_id`, `patch_version`, `patch_time`, `patch_user`, `tars_version`, `posttime`,
                              `lastuser`, `server_type`, `profile`)
VALUES ('TarsTestToolKit', 'BackendApi', '', 'localip.tarsadmin.com', now(), '', '', 'tars.default', 0, 'active', 'active',
        0, '2.1.0', now(), '', '2.1.0', now(), 'admin', 'tars_go', '');
