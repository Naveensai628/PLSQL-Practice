
-- table to store user trx data
create table test_file_export (
id number primary key,
user_id number,
email_address varchar2(30),
mobile_number varchar2(13),
creation_date date,
last_update_date date,
due_date date,
transaction_date date,
primary_flag varchar2(1),
constraint fkey_name 
foreign key (user_id) references fnd_user (user_id)
);

--table to store user data
create table fnd_user (
user_id number primary key,
user_name varchar2(30),
email varchar2(20),
mobile_number varchar2(15),
job_position varchar2(40),
creation_date date,
last_update_date date
);


grant all on test_file_export to public;
grant all on fnd_user to public;