if db_id('Food_And_Stuff') is not null
begin
    alter database Food_And_Stuff set single_user with rollback immediate
    drop database Food_And_Stuff
end
create database Food_And_Stuff