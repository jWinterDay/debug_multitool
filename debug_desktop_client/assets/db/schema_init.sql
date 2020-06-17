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