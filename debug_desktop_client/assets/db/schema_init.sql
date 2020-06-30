create table channel (
    channel_id integer primary key autoincrement,
    name text not null unique,
    ws_url text,
    description text,
    is_white_list_used integer not null default (0),
    is_black_list_used integer not null default (0),
    filter_white_list text default (''),
    filter_black_list text default ('')
);

create index channel_name_idx on channel (name);

create table used_url (
    used_url_id integer primary key autoincrement,
    name text unique not null,
    is_permanent integer not null default (0)
);

insert into used_url (name, is_permanent)
values
    ('ws://localhost:8001/connection/websocket?format=protobuf', 1),
    ('ws://172.16.55.141:8001/connection/websocket?format=protobuf', 1);

create table app_settings (
    app_settings_id integer primary key,
    name text unique not null,
    value text
);

insert into app_settings (app_settings_id, name, value)
values
    (1, 'scroll_to_end', 1);
