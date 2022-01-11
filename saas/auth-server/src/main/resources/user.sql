create table acl_class
(
    id bigint unsigned auto_increment
        primary key,
    class varchar(100) not null,
    constraint uk_acl_class
        unique (class)
);

create table acl_sid
(
    id bigint unsigned auto_increment
        primary key,
    principal tinyint(1) not null,
    sid varchar(100) not null,
    constraint unique_acl_sid
        unique (sid, principal)
);

create table acl_object_identity
(
    id bigint unsigned auto_increment
        primary key,
    object_id_class bigint unsigned not null,
    object_id_identity varchar(36) not null,
    parent_object bigint unsigned null,
    owner_sid bigint unsigned null,
    entries_inheriting tinyint(1) not null,
    constraint uk_acl_object_identity
        unique (object_id_class, object_id_identity),
    constraint fk_acl_object_identity_class
        foreign key (object_id_class) references acl_class (id),
    constraint fk_acl_object_identity_owner
        foreign key (owner_sid) references acl_sid (id),
    constraint fk_acl_object_identity_parent
        foreign key (parent_object) references acl_object_identity (id)
);

create table acl_entry
(
    id bigint unsigned auto_increment
        primary key,
    acl_object_identity bigint unsigned not null,
    ace_order int not null,
    sid bigint unsigned not null,
    mask int unsigned not null,
    granting tinyint(1) not null,
    audit_success tinyint(1) not null,
    audit_failure tinyint(1) not null,
    constraint unique_acl_entry
        unique (acl_object_identity, ace_order),
    constraint fk_acl_entry_acl
        foreign key (sid) references acl_sid (id),
    constraint fk_acl_entry_object
        foreign key (acl_object_identity) references acl_object_identity (id)
);

create table `groups`
(
    id bigint unsigned auto_increment
        primary key,
    group_name varchar(50) not null
);

create table group_authorities
(
    group_id bigint unsigned not null,
    authority varchar(50) not null,
    constraint fk_group_authorities_group
        foreign key (group_id) references `groups` (id)
);

create table group_members
(
    id bigint unsigned auto_increment
        primary key,
    username varchar(50) not null,
    group_id bigint unsigned not null,
    constraint fk_group_members_group
        foreign key (group_id) references `groups` (id)
);

create table oauth2_authorization
(
    id varchar(100) not null
        primary key,
    registered_client_id varchar(100) not null,
    principal_name varchar(200) not null,
    authorization_grant_type varchar(100) not null,
    attributes text null,
    state varchar(500) null,
    authorization_code_value blob null,
    authorization_code_issued_at timestamp null,
    authorization_code_expires_at timestamp null,
    authorization_code_metadata varchar(2000) null,
    access_token_value blob null,
    access_token_issued_at timestamp null,
    access_token_expires_at timestamp null,
    access_token_metadata varchar(2000) null,
    access_token_type varchar(100) null,
    access_token_scopes varchar(1000) null,
    oidc_id_token_value blob null,
    oidc_id_token_issued_at timestamp null,
    oidc_id_token_expires_at timestamp null,
    oidc_id_token_metadata varchar(2000) null,
    refresh_token_value blob null,
    refresh_token_issued_at timestamp null,
    refresh_token_expires_at timestamp null,
    refresh_token_metadata varchar(2000) null
);

create table oauth2_authorization_consent
(
    registered_client_id varchar(100) not null,
    principal_name varchar(200) not null,
    authorities varchar(1000) not null,
    primary key (registered_client_id, principal_name)
);

create table oauth2_registered_client
(
    id varchar(100) not null
        primary key,
    client_id varchar(100) not null,
    client_id_issued_at timestamp default (CURRENT_TIMESTAMP) not null,
    client_secret varchar(200) null,
    client_secret_expires_at timestamp null,
    client_name varchar(200) not null,
    client_authentication_methods varchar(1000) not null,
    authorization_grant_types varchar(1000) not null,
    redirect_uris varchar(1000) null,
    scopes varchar(1000) not null,
    client_settings varchar(2000) not null,
    token_settings varchar(2000) not null
);

create table persistent_logins
(
    username varchar(64) not null,
    series varchar(64) not null
        primary key,
    token varchar(64) not null,
    last_used timestamp not null
);

create table users
(
    username varchar(50) not null
        primary key,
    password varchar(128) not null,
    enabled tinyint(1) not null
);

create table authorities
(
    username varchar(50) not null,
    authority varchar(50) not null,
    constraint ix_auth_username
        unique (username, authority),
    constraint fk_authorities_users
        foreign key (username) references users (username)
);

