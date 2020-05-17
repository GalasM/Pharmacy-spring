insert into user (id,username,password) values (1,'admin123','$2a$10$g09DwEO7fAOPUWJfJRekIuJov8m1tIWbC7HODMMJK9d8qNarsgdCy');
insert into user (id,username,password) values (2,'user123','$2a$10$BOt39Rnda0f0lSGPzR7y7.VOvVXC6Tyt.TFPXtVpKuxdB2G1BDqtS');

insert into role (id,name) values (1,'ROLE_ADMIN');
insert into role (id,name) values (2,'ROLE_USER');

insert into user_roles (users_id,roles_id) values (1,1);
insert into user_roles (users_id,roles_id) values (2,2);

insert into medicament (id, name, price, type, photo) values (1, 'Ibuprom', '15', 'Przeciwbólowy', FILE_READ('classpath:static/ibuprom.jpg'));
insert into medicament (id, name, price, type, photo) values (2, 'Apap', '20', 'Przeciwbólowy', FILE_READ('classpath:static/apap.jpg'));
insert into medicament (id, name, price, type, photo) values (3, 'Polopiryna', '15', 'Przeciwbólowy', FILE_READ('classpath:static/polopiryna.jpg'));
insert into medicament (id, name, price, type, photo) values (4, 'Ketonal', '15', 'Przeciwbólowy', FILE_READ('classpath:static/ketonal.jpg'));
insert into medicament (id, name, price, type, photo) values (5, 'Theraflue', '5', 'Przeziębienie', FILE_READ('classpath:static/theraflu.jpg'));
insert into medicament (id, name, price, type, photo) values (6, 'Altacet', '10', 'Urazy', FILE_READ('classpath:static/altacet.jpg'));
insert into medicament (id, name, price, type, photo) values (7, 'Essentiale', '12', 'Problemy trawienne', FILE_READ('classpath:static/essentiale.jpg'));
insert into medicament (id, name, price, type, photo) values (8, 'Icemix', '8', 'Urazy', FILE_READ('classpath:static/icemix.jpg'));
insert into medicament (id, name, price, type, photo) values (9, 'Strepsils', '12', 'Przeziębienie', FILE_READ('classpath:static/strepsils.jpg'));
insert into medicament (id, name, price, type, photo) values (10, 'Sudafed', '20', 'Przeziębienie', FILE_READ('classpath:static/sudafed.jpg'));

insert into product_in_stock (id,quantity,product_id) values (1,10,1);
insert into product_in_stock (id,quantity,product_id) values (2,20,2);
insert into product_in_stock (id,quantity,product_id) values (3,15,3);
insert into product_in_stock (id,quantity,product_id) values (4,15,4);
insert into product_in_stock (id,quantity,product_id) values (5,50,5);
insert into product_in_stock (id,quantity,product_id) values (6,35,6);
insert into product_in_stock (id,quantity,product_id) values (7,40,7);
insert into product_in_stock (id,quantity,product_id) values (8,15,8);
insert into product_in_stock (id,quantity,product_id) values (9,5,9);
insert into product_in_stock (id,quantity,product_id) values (10,100,10);
